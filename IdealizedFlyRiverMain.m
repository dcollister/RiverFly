% gridType={1,numberOfSplits,widthOfRiver,waterc,landc} (random),{2,numberOfSplits,widthOfRiver,waterc,landc} (fractal), or
% {3,shapefile,res,buffer,waterc,landc} (shapefile)
% {4,shapefile,altfile} (shapefile+altfile)
% {5,shapefile,altfile} (shapefile+altfile+orderstream)
% {6,shapefile,altfile,eggtime} (shapefile+altfile+orderstream+eggs)
% all females probability of release on water pb=0.5, probability of death (pd=0.0089
% 2 week 95%+ are dead, pd=0.0177)
% 1 square=1 m^2
% biggest domain length a few kms (a few thousand square edges)
% density from tens to a few hundreds per m^2 (10 to 1000)
% time step=1 hour max time 2 weeks(=336 time steps)
% number of moves per time steps go from 1 to a few tens
% birth per egg laying from 12 to 1000
function FlyRiverMain(gridType,pb,pd,numberOfKids,simulationTimeLength,flyPopulationSize,nmoves,altprobcoeff,cutoffpop, profileswitch, timingswitch,strengthFactor,riverCurrent,eggsPopulationSize,probtype,bias,Coords,filename)
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
    %numberOfSplits=gridType{2};
    %widthOfRiver=gridType{3};
    %create the river
    %[~,riverRegionPlaceholder]=riverCreation(numberOfSplits,widthOfRiver);%???
    
    %create the space
    %landGrid=zeros(2*size(riverRegionPlaceholder,1),2*size(riverRegionPlaceholder,2));
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
    %         for i=1:size(riverRegionPlaceholder,1)
    %             for j=1:size(riverRegionPlaceholder,2)
    %                 landGrid((size(riverRegionPlaceholder,1)-1)/2+i,(size(riverRegionPlaceholder,2)-1)/2+j)=riverRegionPlaceholder(i,j);
    %             end
    %         end
    landGrid=gridType{2};
    altGrid=gridType{3};
    %         load('Tilted Trough_size_1001x1001_width_5_buffer_50','Coordinates');
    
elseif gridType{1}==3
    res=gridType{3};
    buffer=gridType{4};
    landGrid=readshape2(gridType{2},res,buffer);
elseif gridType{1}==4
    [landGrid,altGrid]=readshapealt(gridType{2},gridType{3});
elseif gridType{1}==5
    [landGrid,altGrid]=readshapealtord(gridType{2},gridType{3});
elseif gridType{1}==6 || gridType{1}==7
    [landGrid,altGrid]=readshapealtord(gridType{2},gridType{3});
    eggtime=gridType{4};
    [landGridWeight,~,~]=weight(landGrid,strengthFactor,riverCurrent);
end

simdata=cell(1,Tf+1);


[rows,columns]=find(landGrid==1);
coordinates=[columns rows];
if gridType{1}==2
    coordinates=Coords;
end
%creates the fly matrix
flies=zeros(flyPopulationSize,8);
%death info matrix
deathInformation=zeros(1,8);
%birth info matrix
birthInformation=zeros(1,8);


simeggdata=cell(1,Tf+1);
%creates the eggs matrix
eggs=zeros(eggsPopulationSize,7);%row egg index column 1:3 spatial coord current, 4:6 spatial coord final, 7 eggtime
%death info matrix
hatchInformation=zeros(1,7);


ndeath=1;
nbirth=1;
neggs=1;
%adult initial positions
[flies(:,1), flies(:,2), flies(:,3), flies(:,4)]=flyPositioning(flyPopulationSize,coordinates);
flies(:,6)=flies(:,1);
flies(:,7)=flies(:,2);

%eggs initial positions
[eggs(:,1), eggs(:,2), ~, ~]=flyPositioning(eggsPopulationSize,coordinates);%current position
eggs(:,3)=1;
eggs(:,4)=eggs(:,1);%initial position
eggs(:,5)=eggs(:,2);
eggs(:,6)=1;
eggs(:,7)=0;%eggtime


%for gridprob need weights of water and land type 1 to 3
if gridType{1}~=2 && gridType{1}~=4 && gridType{1}~=5 && gridType{1}~=6 && gridType{1}~=7
    waterc=gridType{end-1};
    landc=gridType{end};
    [landGrid_prob]=gridprob(landGrid,landc,waterc);
elseif gridType{1}==2
    upcoeff=gridType{5};
    [landGrid_prob,~]=Alt_gridprob4(altGrid,altprobcoeff,landGrid,upcoeff,probtype,bias);
elseif gridType{1}==7 %up river adults movement
    upcoeff=gridType{5};
    [landGrid_prob,~]=Alt_gridprob4(altGrid,altprobcoeff,landGrid,upcoeff,probtype,bias);
else %type 4 and 5 and 6
    %[landGrid_prob,~]=Alt_gridprob(altGrid);
    %[landGrid_prob,~]=Alt_gridprob2(altGrid);%needs debugging
    [landGrid_prob,~]=Alt_gridprob3(altGrid,altprobcoeff,probtype);
end

for t=1:Tf
    Eggs=eggs;
    Flies=zeros(size(flies,1),8);
    
    %placeholder for graphing
    Flies(:,1:8)=flies(:,1:8);
    
    
    if gridType{1}==6
        hatchidx=[];
        %%%%%%%% hatching %%%%%%%%%%%
        for i=1:size(eggs,1)
            if eggs(i,7)==eggtime
                addOn=size(flies,1);
                flies(addOn+1,1)=eggs(i,1);
                flies(addOn+1,2)=eggs(i,2);
                % flies(addOn+1,3)=0;
                % flies(addOn+1,4)=0;
                % flies(addOn+1,5)=0;
                flies(addOn+1,6)=flies(addOn+1,1);
                flies(addOn+1,7)=flies(addOn+1,2);
                %resize matrix
                hatchidx=[hatchidx i];
                hatchInformation(neggs,1:6)=eggs(i,1:6);
                hatchInformation(neggs,7)=t-1;%hatch time
                neggs=neggs+1;
            end
        end
        eggs(hatchidx,:)=[];
        %%%%%%%% movement %%%%%%%%%%%
        if size(eggs,1)>0
            % 					[eggs]=eggsmotion(eggs,landGridWeight);
            [eggs]=eggMovementmod(size(eggs,1),eggs,landGridWeight);
        end
    end
    
    %%%%%%%% movement %%%%%%%%%%%
    for mv=1:nmoves
        [fliesHolder]=move_v3(flies,landGrid,landGrid_prob,size(flies,1),coordinates,t);
        
        deathidx=[];
        for i=1:size(flies,1)
            
            
            xBeta=fliesHolder(i,1);
            yBeta=fliesHolder(i,2);
            
            if xBeta==-Inf || xBeta==Inf%out of bound
                %                     deathidx=[deathidx i];
                
                %gathers information of dying agent
                
                %death counter
                deathInformation(ndeath,1)=flies(i,5);
                
                %genetics
                deathInformation(ndeath,2)=flies(i,4);
                
                %gender
                deathInformation(ndeath,3)=flies(i,3);
                
                %original position
                deathInformation(ndeath,4)=flies(i,6);
                deathInformation(ndeath,5)=flies(i,7);
                
                %final position
                deathInformation(ndeath,6)=flies(i,1);
                deathInformation(ndeath,7)=flies(i,2);
                
                %when it died
                deathInformation(ndeath,8)=t-1;
                
                %there is not a respawn of a new agent back on grid with new
                %information because the agent died of motion, not
                %reproduction.  Therefore they are collected out of bounds to
                %be removed from the population
                flies(i,1)=-11;
                flies(i,2)=-11;
                flies(i,4)=Inf;
                flies(i,5)=fliesHolder(i,5);
                flies(i,8)=t;
                ndeath=ndeath+1;
            else
                flies(i,1)=xBeta;%update positions
                flies(i,2)=yBeta;
                flies(i,5)=fliesHolder(i,5);%update movement
                flies(i,8)=t;%update time step
            end
        end
        flies(deathidx,:)=[];
    end
    
    aliveBegin=1;
    
    [holder,counter]=sorting(flies,aliveBegin);
    flies=holder;
    aliveBegin=counter;
    
    %%%%%%%% reproduction %%%%%%%%%%%
    deathidx=[];
    for i=aliveBegin:size(flies,1)
%         if i<=0
%             pause
%         end
%         if deathidx<=0
%             pause
%         end
%         if flies(i,2)<=0 || flies(i,1)<=0
%             pause
%         end
       
        if rand<pb && landGrid(flies(i,2),flies(i,1))==1 %birth and death if on water
            deathidx=[deathidx i];
            %death counter
            birthInformation(nbirth,1)=flies(i,5);
            
            %genetics
            birthInformation(nbirth,2)=flies(i,4);
            
            %gender
            birthInformation(nbirth,3)=flies(i,3);
            
            %original position
            birthInformation(nbirth,4)=flies(i,6);
            birthInformation(nbirth,5)=flies(i,7);
            
            %final position
            birthInformation(nbirth,6)=flies(i,1);
            birthInformation(nbirth,7)=flies(i,2);
            %reproduction
            if gridType{1}~=6
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
            else
                addOn=size(eggs,1);
                for ii=1:numberOfKids
                    eggs(addOn+ii,1)=flies(i,1);
                    eggs(addOn+ii,2)=flies(i,2);
                    eggs(addOn+ii,3)=1;
                    eggs(addOn+ii,4)=flies(i,1);
                    eggs(addOn+ii,5)=flies(i,2);
                    eggs(addOn+ii,6)=1;
                    eggs(addOn+ii,7)=0;
                    %resize matrix
                end
            end
            
            %when it gave birth
            birthInformation(nbirth,8)=t;
            
            %They are collected out of bounds to
            %be removed from the population
            flies(i,1)=-11;
            flies(i,2)=-11;
            flies(i,4)=inf;
            flies(i,5)=-1;
            nbirth=nbirth+1;
        elseif rand<pd %probability of death
            deathidx=[deathidx i];
            %death counter
            deathInformation(ndeath,1)=flies(i,5);
            
            %genetics
            deathInformation(ndeath,2)=flies(i,4);
            
            %gender
            deathInformation(ndeath,3)=flies(i,3);
            
            %original position
            deathInformation(ndeath,4)=flies(i,6);
            deathInformation(ndeath,5)=flies(i,7);
            
            %final position
            deathInformation(ndeath,6)=flies(i,1);
            deathInformation(ndeath,7)=flies(i,2);
            
            %when it died
            deathInformation(ndeath,8)=t;
            
            %They are collected out of bounds to
            %be removed from the population
            flies(i,1)=-11;
            flies(i,2)=-11;
            flies(i,4)=inf;
            flies(i,5)=-1;
            ndeath=ndeath+1;
        end
        
    end
    %resize
    flies(deathidx,:)=[];
    
    
    %Data
    simdata{t}=Flies;
    simeggdata{t}=Eggs;
    if size(flies,1)>=cutoffpop || (size(flies,1)==0 && size(eggs,1)==0)
        simulationTimeLength=t;
        break;
    end
end
simdata{t+1}=flies;
simeggdata{t+1}=eggs;

%profile switch
if profileswitch==1
    profsave;
    p=profile('info');
    save([datestr(now,'mmmm_dd_yyyy_HH_MM_SS_FFF_AM') '_profile'],p);
end
filenameholder=strcat(filename,'_upcoeff_',num2str(gridType{5}),'_bias_',num2str(bias),'.mat');
save(filenameholder,'simulationTimeLength','Tf','landGrid','altGrid','deathInformation','birthInformation','hatchInformation','simdata','simeggdata','flyPopulationSize','gridType','pb','pd','numberOfKids','nmoves','altprobcoeff','cutoffpop', 'profileswitch', 'timingswitch','strengthFactor','riverCurrent','eggsPopulationSize','-v7.3','bias','probtype','Elevation','River');


if timingswitch==1
    toc
end
end