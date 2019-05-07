function[riverWeight,rows,columns]=lateralWeightMod(riverWeight,rows,columns,flowValue,larvaeMovement)

for i=1:size(rows,1)
    
    %     multiply by flow weight (this is for just the river without the
    %     motility of the agents, where the flow has a standin at the moment of
    %     the exponential, the first column of the 4x9 matrix).  The combined
    %     values with larvae movement incoorporated falls into the third row.
    for nodeCount=1:9
        riverWeight{rows(i),columns(i)}(1,nodeCount)=mod(nodeCount-1,3)*exp(flowValue)*riverWeight{rows(i),columns(i)}(1,nodeCount);
        riverWeight{rows(i),columns(i)}(3,nodeCount)=exp(larvaeMovement)*riverWeight{rows(i),columns(i)}(3,nodeCount)+mod(nodeCount-1,3)*exp(flowValue)*riverWeight{rows(i),columns(i)}(3,nodeCount)/8;
    end

%normalize the values to gain probability distributions
totalRiver=sum(riverWeight{rows(i),columns(i)}(1,:));
totalCombined=sum(riverWeight{rows(i),columns(i)}(3,:));
for ii=1:9
    riverWeight{rows(i),columns(i)}(1,ii)=riverWeight{rows(i),columns(i)}(1,ii)/totalRiver;
    riverWeight{rows(i),columns(i)}(3,ii)=riverWeight{rows(i),columns(i)}(3,ii)/totalCombined;
end

%sum of the values for the checked movement
for iii=1:9
    riverWeight{rows(i),columns(i)}(2,iii)=sum(riverWeight{rows(i),columns(i)}(1,1:iii));
    riverWeight{rows(i),columns(i)}(4,iii)=sum(riverWeight{rows(i),columns(i)}(3,1:iii));
end
end