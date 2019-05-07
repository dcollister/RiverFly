function[movers,timeSlice,histo,state,cycleCounter,run,time]=adultMotion(movers,adultTime,landGridWeight,histo,timeSlice,cycleCounter,run,time,cyclesDesired,river)

for t=time+1:time+adultTime
    movingIndices=rand(size(movers,1),2);
    for i=1:size(movers,1)
        for j=1:9
            if movingIndices(i,2)<landGridWeight{movers(i,2),movers(i,1)}(4,j)
                movers(i,2)=movers(i,2)-1+mod(j-1,3);
                movers(i,1)=movers(i,1)-1+floor((j-1)./3);
                break;
            end
        end
    end
    timeSlice{t}=movers(:,1:2);
    gridholder=zeros(size(landGridWeight,2),size(landGridWeight,1));
    for j=1:size(movers,1)
        gridholder(movers(j,2),movers(j,1))=gridholder(movers(j,1),movers(j,2))+1;
    end
    histo{t}=gridholder;
end
state='eggs';
cycleCounter=cycleCounter+1;
time=time+adultTime;
if cycleCounter==cyclesDesired
    run=0;
end

[movers]=deathCycle(movers,river);