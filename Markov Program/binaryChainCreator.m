function[binaryMatrix]=binaryChainCreator(n)
binaryMatrix=zeros(2^n,n);
level=1;



for i=2:2^n
flip=0;
place=1;

while flip==0
    binaryMatrix(i,place)=mod(binaryMatrix(i,place)+1,2);
    if binaryMatrix(i,place)==1
        binaryMatrix(i+1,:)=binaryMatrix(i,:);
       flip=1; 
    else
       place=place+1;
    end
end
end
binaryMatrix(2^n+1,:)=[];