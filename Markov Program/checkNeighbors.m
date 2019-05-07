function[transitionMatrix,binaryGrid]=checkNeighbors(rows,columns,binary3,riverWeight,transitionMatrix)
%this is going to be the grid containing the state values for every node on
%the river
binaryGrid=zeros(size(riverWeight,1),size(riverWeight,2));

%create a grid with each node labeled with it's binary string relative to
%the original binary vector
for i=1:size(rows,1)
    for j=1:size(binary3,1)
        if isequal(riverWeight{rows(i),columns(i)}(3,:),binary3(j,1:9))
            binaryGrid(rows(i),columns(i))=binary3(j,10);
        end
    end
end

neighbors=zeros(256,1);

a=1:2;
b=2:3;
c=4:5;
d=5:6;
e=7:8;
f=8:9;

aa=1:3;
bb=4:6;
cc=7:9;
aaa=[1;4;7];
bbb=[2;5;8];
ccc=[3;6;9];

%generate a list of allowed neighbors for binaryGrid individual nodes, for
%quick calculation 
for i=1:size(binary3,1)
    neighbor=1;
    for j=1:size(binary3,1)
        
        %upperleft/bottomright
        if isequal(binary3(i,a),binary3(j,d))&&isequal(binary3(i,c),binary3(j,f))
            neighbors(binary3(i,10),neighbor)=binary3(j,10);
            neighbor=neighbor+1;
        elseif isequal(binary3(i,d),binary3(j,a))&&isequal(binary3(i,f),binary3(j,c))
            neighbors(binary3(i,10),neighbor)=binary3(j,10);
            neighbor=neighbor+1;
            
            %lowerleft/upperright
        elseif isequal(binary3(i,b),binary3(j,c))&&isequal(binary3(i,d),binary3(j,e))
            neighbors(binary3(i,10),neighbor)=binary3(j,10);
            neighbor=neighbor+1;
        elseif isequal(binary3(i,c),binary3(j,b))&&isequal(binary3(i,e),binary3(j,d))
            neighbors(binary3(i,10),neighbor)=binary3(j,10);
            neighbor=neighbor+1;
            
            %left\right
        elseif isequal(binary3(i,aa),binary3(j,bb))&&isequal(binary3(i,bb),binary3(j,cc))
            neighbors(binary3(i,10),neighbor)=binary3(j,10);
            neighbor=neighbor+1;
        elseif isequal(binary3(i,bb),binary3(j,aa))&&isequal(binary3(i,cc),binary3(j,bb))
            neighbors(binary3(i,10),neighbor)=binary3(j,10);
            neighbor=neighbor+1;
            
            %up/down
        elseif isequal(binary3(i,aaa),binary3(j,bbb))&&isequal(binary3(i,bbb),binary3(j,ccc))
            neighbors(binary3(i,10),neighbor)=binary3(j,10);
            neighbor=neighbor+1;
        elseif isequal(binary3(i,bbb),binary3(j,aaa))&&isequal(binary3(i,ccc),binary3(j,bbb))
            neighbors(binary3(i,10),neighbor)=binary3(j,10);
            neighbor=neighbor+1;
        elseif isequal(binary3(i,:),binary3(j,:))
            neighbors(binary3(i,10),neighbor)=binary3(j,10);
            neighbor=neighbor+1;
        end
    end
end

%uses the values from the binaryGrid against the values of neighbors to
%check quickly, counting the number of transitions that occur on the river
%for each possible pair of states
for node=1:size(rows,1)
    for leftRight=-1:1
        for upDown=-1:1
            if (binaryGrid(rows(node)+leftRight,columns(node)+upDown))~=0
                if sum(ismember(neighbors(binaryGrid(rows(node),columns(node)),:),binaryGrid(rows(node)+leftRight,columns(node)+upDown)))==1
                    transitionMatrix(binaryGrid(rows(node)+leftRight,columns(node)+upDown),binaryGrid(rows(node),columns(node)))=transitionMatrix(binaryGrid(rows(node),columns(node)),binaryGrid(rows(node)+leftRight,columns(node)+upDown))+1;
                end
            end
        end
    end   
end