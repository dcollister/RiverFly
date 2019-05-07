function[movers,timeSlice,histo,state,time]=eggMotion(movers,eggTime,riverWeight,histo,timeSlice,time)

for t=time+1:time+eggTime
    movingIndices=rand(size(movers,1),2);
    for i=1:size(movers,1)
        for j=1:9
            if movingIndices(i,2)<riverWeight{movers(i,2),movers(i,1)}(2,j)
                movers(i,2)=movers(i,2)-1+mod(j-1,3);
                movers(i,1)=movers(i,1)-1+floor((j-1)./3);
                break;
            end
        end
    end
    timeSlice{t}=movers(:,1:2);
    gridholder=zeros(size(riverWeight,2),size(riverWeight,1));
    for j=1:size(movers,1)
        gridholder(movers(j,2),movers(j,1))=gridholder(movers(j,1),movers(j,2))+1;
    end
    histo{t}=gridholder;
end
state='larvae';
time=time+eggTime;