function[movers]=deathCycle(movers,river)

size(movers,1)
deathAgents=zeros(1);
liveAgents=zeros(1);
deathCounter=1;
liveCounter=1;

for i=1:size(movers,1)
    if river(movers(i,2),movers(i,1))~=1
        deathAgents(deathCounter)=i;
        deathCounter=deathCounter+1;
    else
        liveAgents(liveCounter)=i;
        liveCounter=liveCounter+1;
    end
end

replacement=size(movers,1);

for live=1:liveCounter-1
    for extra=1:10
        movers(replacement+10*(live-1)+extra,:)=movers(liveAgents(live),:);
        live
        size(movers,1)
    end
end

for death=deathCounter-1:-1:1
    movers(deathAgents(death),:)=[];
end



size(movers,1)
