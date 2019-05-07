%function()=markovTest[]

n=9;
numberOfSplits=4;
widthOfRiver=4;
boundary=10;
bufferZone=1;
% profile on -history
%[riverPlaceholder,riverRegionPlaceholder]=riverCreation(numberOfSplits,widthOfRiver);
binaryBegin=binaryChainCreator(n);
binary=zeros(1,9);
j=1;%
map='SF2';
onOffRiverSwitch=0;%1 means just river, 0 means river and land 
flip=3;%0=1dayby3hourinterval, 1=1weekbyday, 2=7weeksbyweek





if onOffRiverSwitch==0
    where='offRiver';
else
    where='onRiver';
end

if flip==0
    interval='1dayby3hourinterval';    
    timeStandardDeviation = [3:3:24];
elseif flip==1
    interval='1weekbyday';    
    timeStandardDeviation = [24:24:168];
elseif flip==2
    interval='7weeksbyweek';    
    timeStandardDeviation = [168:168:7*168];
else
    interval='standardTime';
    timeStandardDeviation=24;
end

riverRegionPlaceholder=readshape2(map,10,3);

graphName{1}=sprintf('%s_%d_%s_%s',map,flip,where,interval);



for i=1:2^n
    %only counts the states that have a '1' in the center node, creating a
    %reduced matrix
    if binaryBegin(i,ceil(n/2))==1
        binary(j,1:9)=binaryBegin(i,:);
        j=j+1;
    end
end

river=zeros(size(riverRegionPlaceholder,1)+boundary,size(riverRegionPlaceholder,2)+boundary);
landGrid=ones(size(river,1)+bufferZone,size(river,2)+bufferZone);

for level=1:2
    for i=1:size(riverRegionPlaceholder,1)
        for j=1:size(riverRegionPlaceholder,2)
            river(i+boundary/2,j+boundary/2)=riverRegionPlaceholder(i,j);
        end
    end
end

[riverWeight,rows,columns]=markovWeight(river);
[a,b]=size(riverWeight);
placeMaster=zeros(a,b);
coords=zeros(1,3);



[transition,binary3,binaryGrid]=transitionGenerator(n,river,riverWeight,binary,rows,columns);
relevantColumns(1,:)=binary3(:,10);
relevantRows(:,1)=binary3(:,10);
reducedTransition(:,:)=transition(relevantRows,relevantColumns);

sums=sum(reducedTransition);
Sums=sum(transition);
transitionProbs=zeros(size(reducedTransition,1),size(reducedTransition,2));
TransitionProbs=zeros(size(transition,1),size(transition,2));

sumCols=sum(reducedTransition,1);
SumCols=sum(transition,1);

for j=1:size(transition,1)
    for i=1:size(transition,1)
        if SumCols(j)==0
            break
        else
            TransitionProbs(i,j)=transition(i,j)/SumCols(j);
        end
    end
end

for j=1:size(reducedTransition,1)
    for i=1:size(reducedTransition,1)
        if sumCols(j)==0
            break
        else
            transitionProbs(i,j)=reducedTransition(i,j)/sumCols(j);
        end
    end
end

Transition=TransitionProbs^1000;
TransitionShift=TransitionProbs^100000;
thousand=transitionProbs^1000;
thousandShift=transitionProbs^10000000;

A=max(Transition,[],1);
B=max(A,[],2);
[a,b]=find(Transition==B);


probVals=Transition(:,a(1));
count=1;

flatBinaryGrid=binaryGrid(:);

for i=1:size(Transition,2)
    stateCount(i)=sum(flatBinaryGrid==i);
end

probValHolder=zeros(size(probVals,1),1);
probs=sort(probVals(:),'descend');

[aaa,bbb]=find(probVals==probs(1));
[Y, X]=ind2sub(size(binaryGrid),find(binaryGrid==aaa));
stateY2=Y;
stateX2=X;

for i=1:size(probVals,1)
    if probVals(i)~=0
        probValHolder(i,1)=probVals(i)/stateCount(i);
    else
        probValHolder(i)=0;
    end
end

holder=sort(probValHolder(:),'descend');

aa=zeros(10,1);
nodeCounter=0;
stateY1=zeros(1,1);
stateX1=zeros(1,1);
stateValue=zeros(1,1);

for i=1:size(reducedTransition,1)%10
    [aa(i),bb(i)]=find(probValHolder==holder(i));
    [Y, X]=ind2sub(size(binaryGrid),find(binaryGrid==aa(i)));
    stateY1=[stateY1;Y];
    stateX1=[stateX1;X];
    stateValue(nodeCounter+1:nodeCounter+size(Y,1),1)=holder(i);
    nodeCounter=nodeCounter+size(Y,1);
end
stateY1(1)=[];
stateX1(1)=[];

csvwrite('binaryGrid.csv',binaryGrid)

% [highRows,highCols]

[distGrid,distGrid2]=calcDist(stateX1,stateY1,stateX2,stateY2,river);

[gaussian,gaussian2]=calcGaussian(distGrid,distGrid2,stateX1,stateX2,river,stateValue,probs,timeStandardDeviation,onOffRiverSwitch);

GaussProbSumGrid1=zeros(size(gaussian,1),size(gaussian,2),size(timeStandardDeviation,2));
GaussProbSumGrid2=zeros(size(gaussian2,1),size(gaussian2,2),size(timeStandardDeviation,2));

for time=1:size(timeStandardDeviation,2)
    for i=1:size(gaussian,1)
        for j=1:size(gaussian,2)
            GaussProbSumGrid(i,j,time)=sum(gaussian(i,j,:,time));
        end
    end
end

for time=1:size(timeStandardDeviation,2)
    for i=1:size(gaussian2,1)
        for j=1:size(gaussian2,2)
            GaussProbSumGrid2(i,j,time)=sum(gaussian2(i,j,:,time))/size(gaussian2,3);
        end
    end
end

graphing(graphName,river,stateX1,stateY1,stateX2,stateY2,GaussProbSumGrid,GaussProbSumGrid2,timeStandardDeviation)
%     


save(graphName{1},'stateX1','stateX2','stateY1','stateY2','river','GaussProbSumGrid','GaussProbSumGrid2');

