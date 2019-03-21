n=9;

binary2=binaryChainCreator(n);
binary=zeros(1,9);
j=1;
for i=1:2^n
    if binary2(i,ceil(n/2))==1
        binary(j,:)=binary2(i,:);
        j=j+1;
    end
end

riverHolder=readshape2('SanDimasSubset',10,3);
river=zeros(size(riverHolder,1)+2,size(riverHolder,2)+2);
for level=1:2
    for i=1:size(riverHolder,1)
        for j=1:size(riverHolder,2)
            river(i+1,j+1)=riverHolder(i,j);
        end
    end
end
[riverWeight,rows,columns]=weight2(river);

[a,b]=size(riverWeight);
placeMaster=zeros(a,b);
for i=1:size(riverWeight,1)
    for j=1:size(riverWeight,2)
        placeMaster(i,j)=riverWeight{i,j}(3,5);
    end
end

%Counts number of vectors from the river that match with the binary vector%
count=zeros(1,size(binary,1));
for j=1:size(riverWeight,1)*size(riverWeight,2)
    if riverWeight{j}(3,5)==1
        for i=1:2^(n-1)
            if isequal(riverWeight{j}(3,:),binary(i,:))
                count(i)=count(i)+1;
            end
        end
    else
    end
end


binary3=zeros(1,9);

a=1;
for i=1:size(binary,1)
    if count(i)~=0
        binary3(a,:)=binary(i,:);
        a=a+1;
    else
    end
end

markovChain=zeros(size(binary3,1),size(binary3,1));

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
bbb=[2,5,8];
ccc=[3,6,9];


for i=2:size(binary3,1)
    for j=1:size(binary3,1)
        if isequal(binary3(i,a),binary(j,a))&&isequal(binary3(i,c),binary3(j,c))
            markovChain(i,j)=1;
        elseif isequal(binary3(i,e),binary3(j,e))&&isequal(binary3(i,c),binary3(j,c))
            markovChain(i,j)=1;
        elseif isequal(binary3(i,b),binary3(j,b))&&isequal(binary3(i,d),binary3(j,d))
            markovChain(i,j)=1;
        elseif isequal(binary3(i,f),binary3(j,f))&&isequal(binary3(i,d),binary3(j,d))
            markovChain(i,j)=1;
        elseif isequal(binary3(i,aa),binary3(j,aa))&&isequal(binary3(i,bb),binary3(j,bb))
            markovChain(i,j)=1;
        elseif isequal(binary3(i,cc),binary3(j,cc))&&isequal(binary3(i,bb),binary3(j,bb))
            markovChain(i,j)=1;
        elseif isequal(binary3(i,aaa),binary3(j,aaa))&&isequal(binary3(i,bbb),binary3(j,bbb))
            markovChain(i,j)=1;
        elseif isequal(binary3(i,ccc),binary3(j,ccc))&&isequal(binary3(i,bbb),binary3(j,bbb))
            markovChain(i,j)=1;
        else
            markovChain(i,j)=0;
        end
    end
end

final=markovChain;

sumCols=sum(markovChain,1);
for j=1:size(markovChain,1)
    for i=1:size(markovChain,1)
        if sumCols(j)==0
            break
        else
            final(i,j)=markovChain(i,j)/sumCols(j);
        end
    end
end

% for i=1:10000
%     pause(1/60)
    finale=final^100;
    scatter(finale(:,1),finale(:,2))
%     pause(1/60)
% end
