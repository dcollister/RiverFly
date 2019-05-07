function[distGrid,distGrid2]=calcDist(columns,rows,columns2,rows2,river)

distGrid=zeros(size(river,1),size(river,2),size(rows,1));
distGrid2=zeros(size(river,1),size(river,2),size(rows2,1));

for count=1:size(rows,1)
for rowsI=1:size(river,1)
    for colsJ=1:size(river,2)
        holder=sqrt((rowsI-rows(count)).^2+(colsJ-columns(count)).^2);
%         if holder<5
            distGrid(rowsI,colsJ,count)=holder;
%         else
%             distGrid(rowsI,colsJ,count)=0;
%         end
    end
end
end

for count=1:size(rows2,1)
for rowsII=1:size(river,1)
    for colsJJ=1:size(river,2)
        holder=sqrt((rowsII-rows2(count)).^2+(colsJJ-columns2(count)).^2);
%         if holder<5
            distGrid2(rowsII,colsJJ,count)=holder;
%         else
%             distGrid(rowsI,colsJ,count)=0;
%         end
    end
end
end

