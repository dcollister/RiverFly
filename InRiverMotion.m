%Starting Variables
eggs=50;
bottomWeight=2;
numberOfSplits=4;
widthOfRiver=4;
flowValue=50;
eggTime=10;
larvaeTime=90;
riverChoice='fractal';%'satellite';%
state='eggs';
bufferZone=50;
larvaeMovement=20;
run=1;
time=0;
cyclesDesired=4;
% profile on -history
%create the river
[riverPlaceholder,riverRegionPlaceholder]=riverCreation(numberOfSplits,widthOfRiver);
regionRadiusFromCentralRiver=2;
depth=[1,1];
if isequal(riverChoice,'fractal')
    riverHolder=riverRegionPlaceholder.*reshape(depth, 1, 1, []);
else
    riverHolder=readshape2('SanDimasSubset',3,1);
end

river=zeros(size(riverHolder,1)+bufferZone,size(riverHolder,2)+bufferZone);
for level=1:2
    for i=1:size(riverHolder,1)
        for j=1:size(riverHolder,2)
            river(i+bufferZone/2,j+bufferZone/2)=riverHolder(i,j);
        end
    end
end

river;
%generate non-flow prob values of movement
[riverWeight,rows,columns]=weight(river);
%moderate the values for flow(current)
[riverWeight,rows,columns]=lateralWeightMod(riverWeight,rows,columns,flowValue,larvaeMovement);
% riverHead=river(rows(1:10),columns);
%
movers=zeros(eggs,3,1);
ii=randi(size(rows,1),size(movers,1),1);

%randomizes position for the first step
for i=1:size(movers,1)
    movers(i,1:3)=[columns(ii(i)) rows(ii(i))  1];
    %     movers(i,[1:3])=[10 5 1];
end
timeSlice={cyclesDesired*(eggTime+larvaeTime),zeros(eggs,2)};
histo={cyclesDesired*(eggTime+larvaeTime),zeros(size(riverWeight,2),size(riverWeight,1))};

%Eggs movement
%tic
cycleCounter=1;
while(run)
    if isequal(state,'eggs')
        [movers,timeSlice,histo,state,time]=eggMotion(movers,eggTime,riverWeight,histo,timeSlice,time);
        time
        state
    else%if isequal(state,'larvae')
        [movers,timeSlice,histo,state,cycleCounter,run,time]=larvaeMotion(movers,larvaeTime,riverWeight,histo,timeSlice,cycleCounter,run,time,cyclesDesired);       
        time
        state
        cycleCounter
    %else
        %toc
    end
end
% tic
for i=1:time
    M=size(histo{i},1);
    N=size(histo{i},2);
    clf
    hold on
    
    %     axis([0 10 0 10]);
    
    %      subplot(1,2,1);
    contour(river(:,:));
    axis([0 size(riverWeight,2) 0 size(riverWeight,1)]);
    scatter(timeSlice{i}(:,1),timeSlice{i}(:,2))
    grid on
    
    
    %     subplot(1,2,2);
    %     HMobj = contour(histo{i});
    %     mesh([0:1:N-1],[0:1:M-1],histo{i}); % Three dimensional plot
    %     xlabel('State'); ylabel('Time,n');zlabel('Probability');
    %     view(M,N)
    pause(1/600)
    hold off
end
% profsave
% p = profile('info')