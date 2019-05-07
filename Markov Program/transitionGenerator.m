function[transitionMatrix,binary3,binaryGrid]=transitionGenerator(n,river,riverWeight,binary,rows,columns)


count=zeros(1,size(binary,1));
nodeCounter=1;

%counts the number of binary states that occur on the river
for rowElement=1:size(river,1)
    for columnElement=1:size(river,2)
        if river(rowElement,columnElement)==1
            for i=1:2^(n-1)
                if isequal(riverWeight{rowElement,columnElement}(3,:),binary(i,:))
                    count(i)=count(i)+1;
                    nodeCounter=nodeCounter+1;
                end
            end
        else
        end
    end
end

binary3=zeros(1,10);
a=1;

%binary3 contains the shortened list of states that appear in the river,
%with the 10th coordinate keeping track of the position relative to the
%original binary vector
for i=1:size(binary,1)
    if count(i)~=0
        binary3(a,1:9)=binary(i,:);
        binary3(a,10)=i;
        a=a+1;
    else
    end
end

transitionMatrix=zeros(2^(n-1),2^(n-1));

%transitionMatrix contains the counts of how many times each possible
%transition occurs across the entire river, creating the Markov Chain.  The
%BinaryGrid has been updated with each node now assigned its state value
%relative to the original allowed states
[transitionMatrix,binaryGrid]=checkNeighbors(rows,columns,binary3,riverWeight,transitionMatrix);
            