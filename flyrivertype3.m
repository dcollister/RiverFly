% gridType={1,numberOfSplits,widthOfRiver,waterc,landc} (random),{2,numberOfSplits,widthOfRiver,waterc,landc} (fractal), or
    % {3,shapefile,res,buffer,waterc,landc} (shapefile)
    % {4,shapefile,altfile} (shapefile+altfile)
	% {5,shapefile,altfile} (shapefile+altfile+orderstream)
    % all females probability of release on water pb=0.5, probability of death (pd=0.0089
    % 2 week 95%+ are dead, pd=0.0177)
    % 1 square=1 m^2
    % biggest domain length a few kms (a few thousand square edges)
    % density from tens to a few hundreds per m^2 (10 to 1000)
    % time step=1 hour max time 2 weeks(=336 time steps)
    % number of moves per time steps go from 1 to a few tens
    % birth per egg laying from 12 to 1000
function flyrivertype3(gridType,pb,pd,numberOfKids,simulationTimeLength,flyPopulationSize,nmoves,altprobcoeff,cuttoffpop, profileswitch, timingswitch)
	if timingswitch==1    
		tic
	end
    Tf=simulationTimeLength;%Final Time
	%profile switch
	if profileswitch==1
		profile on -history
	end
	
    %Fly Model
    if gridType{1}==1 || gridType{1}==2
        numberOfSplits=gridType{2};
        widthOfRiver=gridType{3};
        %create the river
        [~,riverRegionPlaceholder]=riverCreation(numberOfSplits,widthOfRiver);%???

        %create the space
        landGrid=zeros(2*size(riverRegionPlaceholder,1),2*size(riverRegionPlaceholder,2));
    end
    
    if gridType{1}==1
        %random
        landGrid=randi([0 1], size(landGrid,1),size(landGrid,2));
        n = size(landGrid,1) ; m = size(landGrid,2) ;
        N0 = ceil(8*n*m/9) ; % specify some exact number of zeros
        A3 = ones(n,m) ; A3(1:N0) = 0 ; A3(randperm(numel(A3))) = A3;
        landGrid=A3;
    elseif gridType{1}==2
        %fractal
        for i=1:size(riverRegionPlaceholder,1)
            for j=1:size(riverRegionPlaceholder,2)
                landGrid((size(riverRegionPlaceholder,1)-1)/2+i,(size(riverRegionPlaceholder,2)-1)/2+j)=riverRegionPlaceholder(i,j);
            end
        end
    elseif gridType{1}==3
        res=gridType{3};
        buffer=gridType{4};
        landGrid=readshape2(gridType{2},res,buffer);
    elseif gridType{1}==4
        [landGrid,altGrid]=readshapealt(gridType{2},gridType{3});
	elseif gridType{1}==5
		[landGrid,altGrid]=readshapealtord(gridType{2},gridType{3});
    end

    simdata=cell(1,Tf+1);

    [rows,columns]=find(landGrid==1);
    coordinates=[columns rows];

    %creates the fly matrix
    flies=zeros(flyPopulationSize,8);
    %death info matrix
    deathInformation=zeros(1,8);
    n=1;

    [flies(:,1), flies(:,2), flies(:,3), flies(:,4)]=flyPositioning(flyPopulationSize,coordinates);
    flies(:,6)=flies(:,1);
    flies(:,7)=flies(:,2);


    %for gridprob need weights of water and land type 1 to 3
    if gridType{1}~=4 && gridType{1}~=5
        waterc=gridType{end-1};
        landc=gridType{end};
        [landGrid_prob]=gridprob(landGrid,landc,waterc);
    else %type 4 and 5
        %[landGrid_prob,~]=Alt_gridprob(altGrid);
		%[landGrid_prob,~]=Alt_gridprob2(altGrid);%needs debugging
		[landGrid_prob,~]=Alt_gridprob3(altGrid,altprobcoeff);
    end
    
    for t=1:Tf
        for mv=1:nmoves
            %%%%%%%% movement %%%%%%%%%%%
            [fliesHolder]=move_v3(flies,landGrid,landGrid_prob,size(flies,1),coordinates,t);

            deathidx=[];
            for i=1:size(flies,1)


                xBeta=fliesHolder(i,1);
                yBeta=fliesHolder(i,2);

                if xBeta==-Inf || xBeta==Inf%out of bound
                    deathidx=[deathidx i];

                    %gathers information of dying agent

                    %death counter
                    deathInformation(n,1)=flies(i,5);

                    %genetics
                    deathInformation(n,2)=flies(i,4);

                    %gender
                    deathInformation(n,3)=flies(i,3);

                    %original position
                    deathInformation(n,4)=flies(i,6);
                    deathInformation(n,5)=flies(i,7);

                    %final position
                    deathInformation(n,6)=flies(i,1);
                    deathInformation(n,7)=flies(i,2);

                    %when it died
                    deathInformation(n,8)=t-1;

                    %there is not a respawn of a new agent back on grid with new
                    %information because the agent died of motion, not
                    %reproduction.  Therefore they are collected out of bounds to
                    %be removed from the population
                    flies(i,1)=-11;
                    flies(i,2)=-11;
                    flies(i,4)=Inf;
                    flies(i,5)=fliesHolder(i,5);
                    flies(i,8)=t;
                    n=n+1;
                else
                    flies(i,1)=xBeta;%update positions
                    flies(i,2)=yBeta;
                    flies(i,5)=fliesHolder(i,5);%update movement
                    flies(i,8)=t;%update time step
                end
            end
            flies(deathidx,:)=[];
        end

        Flies=zeros(size(flies,1),8);

        %placeholder for graphing
        Flies(:,1:8)=flies(:,1:8);

        aliveBegin=1;

        [holder,counter]=sorting(flies,aliveBegin);
        flies=holder;
        aliveBegin=counter;

        %%%%%%%% reproduction %%%%%%%%%%%
        deathidx=[];
        for i=aliveBegin:size(Flies,1)
            if rand<pb && landGrid(flies(i,2),flies(i,1))==1 %birth and death if on water
                deathidx=[deathidx i];
                %death counter
                deathInformation(n,1)=flies(i,5);

                %genetics
                deathInformation(n,2)=flies(i,4);

                %gender
                deathInformation(n,3)=flies(i,3);

                %original position
                deathInformation(n,4)=flies(i,6);
                deathInformation(n,5)=flies(i,7);

                %final position
                deathInformation(n,6)=flies(i,1);
                deathInformation(n,7)=flies(i,2);
                %reproduction
                addOn=size(flies,1);
                for ii=1:numberOfKids
                    flies(addOn+ii,1)=flies(i,1);
                    flies(addOn+ii,2)=flies(i,2);
                    flies(addOn+ii,3)=flies(i,3);
                    flies(addOn+ii,4)=flies(i,4);
                    flies(addOn+ii,6)=flies(addOn+ii,1);
                    flies(addOn+ii,7)=flies(addOn+ii,2);
                    %resize matrix
                end

                %when it died
                deathInformation(n,8)=t;

                %They are collected out of bounds to
                %be removed from the population
                flies(i,1)=-11;
                flies(i,2)=-11;
                flies(i,4)=inf;
                flies(i,5)=-1;
                n=n+1;
            elseif rand<pd %probability of death
                deathidx=[deathidx i];
                %death counter
                deathInformation(n,1)=flies(i,5);

                %genetics
                deathInformation(n,2)=flies(i,4);

                %gender
                deathInformation(n,3)=flies(i,3);

                %original position
                deathInformation(n,4)=flies(i,6);
                deathInformation(n,5)=flies(i,7);

                %final position
                deathInformation(n,6)=flies(i,1);
                deathInformation(n,7)=flies(i,2);

                %when it died
                deathInformation(n,8)=t;

                %They are collected out of bounds to
                %be removed from the population
                flies(i,1)=-11;
                flies(i,2)=-11;
                flies(i,4)=inf;
                flies(i,5)=-1;
                n=n+1;
            end

        end
        %resize
        flies(deathidx,:)=[];


        %Data
        simdata{t}=Flies;
        if size(flies,1)>=cutoffpop || size(flies,1)==0
            simulationTimeLength=t;
            break;
        end
    end
    simdata{t+1}=flies;
	
	%profile switch
	if profileswitch==1
		profsave;
		p=profile('info');
	end
    save(datestr(now,'mmmm_dd_yyyy_HH_MM_SS_FFF_AM'),'simulationTimeLength','Tf','landGrid','altGrid','deathInformation','simdata','flyPopulationSize','gridType','pb','pd','numberOfKids','nmoves','altprobcoeff','cuttoffpop', 'profileswitch', 'timingswitch','-v7.3');
    
	if timingswitch==1
		toc
	end
end