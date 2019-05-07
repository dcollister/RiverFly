function[riverWeight,rowsTop,columnsTop]=markovWeight(river)
[rowsTop,columnsTop] = ind2sub(size(river),find(river == 1));
riverWeight=cell(size(river,1),size(river,2));
%landGridWeight=cell(size(landGrid,1),size(landGrid,2));

%creates placeholders for the binary chains on each node
for i=1:size(riverWeight,1)
    for j=1:size(riverWeight,2)
        riverWeight{i,j}=zeros(3,9);
    end
end

%translates 3x3 grid into a 1x9 vector in the third vector position per
%node
for i=1:size(rowsTop,1)
    for jj=1:3
        for ii=1:3
            riverWeight{rowsTop(i),columnsTop(i)}(3,(ii+3*(jj-1)))=river(rowsTop(i)-2+ii,columnsTop(i)-2+jj);
        end
    end
end

%calculates normalized weights vector and inserts as 1x9 vector in 1st
%vector position per node
for i=1:size(rowsTop,1)
    levelWeight=sum(sum(river((rowsTop(i)-1):(rowsTop(i)+1),(columnsTop(i)-1):(columnsTop(i)+1))));
    for jj=1:3
        for ii=1:3
            riverWeight{rowsTop(i),columnsTop(i)}(1,(ii+3*(jj-1)))=river(rowsTop(i)-2+ii,columnsTop(i)-2+jj)/levelWeight;
        end
    end
    
    %calculates the cumulative probability for the 1x9 vector and places
    %1x9 vector into 2nd vector spot per node
    for iii=1:9
        riverWeight{rowsTop(i),columnsTop(i)}(2,iii)=sum(riverWeight{rowsTop(i),columnsTop(i)}(1,1:iii));
    end
end
