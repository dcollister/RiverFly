function[riverWeight,rowsTop,columnsTop,landGridWeight]=weight(river,landGrid)
[rowsTop,columnsTop] = ind2sub(size(river),find(river == 1));
riverWeight=cell(size(river,1),size(river,2));
landGridWeight=cell(size(landGrid,1),size(landGrid,2));

for i=1:size(riverWeight,1)
    for j=1:size(riverWeight,2)
        riverWeight{i,j}=zeros(4,9);
    end
end

for width=1:size(landGrid,1)
    for breadth=1:size(landGrid,2)
        landGridWeight{width,breadth}=zeros(4,9);
    end
end

for i=1:size(rowsTop,1)
    levelWeight=sum(sum(river((rowsTop(i)-1):(rowsTop(i)+1),(columnsTop(i)-1):(columnsTop(i)+1))));
    for jj=1:3
        for ii=1:3
            riverWeight{rowsTop(i),columnsTop(i)}(1,(ii+3*(jj-1)))=river(rowsTop(i)-2+ii,columnsTop(i)-2+jj)/levelWeight;
            riverWeight{rowsTop(i),columnsTop(i)}(3,(ii+3*(jj-1)))=river(rowsTop(i)-2+ii,columnsTop(i)-2+jj)/levelWeight;
        end
    end
    
    for iii=1:9
       riverWeight{rowsTop(i),columnsTop(i)}(2,iii)=sum(riverWeight{rowsTop(i),columnsTop(i)}(1,1:iii));
       riverWeight{rowsTop(i),columnsTop(i)}(4,iii)=sum(riverWeight{rowsTop(i),columnsTop(i)}(3,1:iii));
    end
end

for i=2:size(landGrid,1)-1
   for j=2:size(landGrid,2)-1 
    levelWeight2=sum(sum(landGrid((i-1):(i+1),(j-1):(j+1))));
    for jj=1:3
        for ii=1:3
       %probability without external forces
            landGridWeight{i,j}(1,(ii+3*(jj-1)))=landGrid(i-2+ii,j-2+jj)/levelWeight2;
       %vector ready to be modified with river flow/etc. forces
            landGridWeight{i,j}(3,(ii+3*(jj-1)))=landGrid(i-2+ii,j-2+jj)/levelWeight2;
        end
    end
    
    for iii=1:9
       %probability sum without external forces
       landGridWeight{i,j}(2,iii)=sum(landGridWeight{i,j}(1,1:iii));
       %vector ready to be modified with wind/etc. forces
       landGridWeight{i,j}(4,iii)=sum(landGridWeight{i,j}(3,1:iii));
    end
   end
end
