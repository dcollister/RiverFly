lattitude=1001;
longitude=1001;
width=51;
buffer=100;
River=zeros(lattitude, longitude);
River((ceil(size(River,2)/2)-width):(ceil(size(River,2)/2)+width),:)=1;
Elevation=zeros(lattitude, longitude);
riverChoice=3;

if riverChoice==1
    % %%%%%%%%%%Making a Wedge%%%%%%%%%%%%%%
    choice='Wedge';
    Elevation=longitude+Elevation;
    
    for i=2:size(Elevation,1)
        Elevation(:,i)=Elevation(:,i)-i;
    end
    
elseif riverChoice==2
    %%%%%%%%%Making a Trough%%%%%%%%%%%%%%%%%%%%%
    Elevation=longitude+Elevation;
    choice="Trough";
    
    for i=1:ceil(size(Elevation,1)/2)
        Elevation(i,:)=ceil(Elevation(i,:)/2)-i+1;
    end
    
    for i=1:ceil(size(Elevation,1)/2)-1
        Elevation(end-i+1,:)=ceil(Elevation(end-i+1,:)/2)-i+1;
    end
    
    
    
else
    % %%%%%%%%%%%Making a tilted trough%%%%%%
    Elevation=longitude+Elevation+longitude-1;
    choice="Tilted Trough";
    
    for i=1:size(Elevation,1)
        Elevation(:,i)=Elevation(:,i)-i;
    end
    
    for i=1:ceil(size(Elevation,1)/2)
        Elevation(i,:)=Elevation(i,:)-i+1;
    end
    
    for i=1:ceil(size(Elevation,1)/2)-1
        Elevation(end-i+1,:)=Elevation(end-i+1,:)-i+1;
    end
    
end
%%%%%%%%%%%%%%%%Graphing%%%%%%%%%%%%%%%%%%%%%%

River(ceil(size(River,2)/2)-width:ceil(size(River,2)/2)+width,:)=Elevation(ceil(size(River,2)/2)-width:ceil(size(River,2)/2)+width,:);
riverElevation=zeros(size(River,1),size(River,2));
[riverY, riverX]=find(River~=0);
for i=1:size(riverY,1)
    riverElevation(riverY(i),riverX(i))=Elevation(riverY(i),riverX(i));
end
[riverY,riverX]=find(riverElevation~=0);
riverZ=zeros(size(riverX));
for i=1:length(riverX)
    riverZ(i)=Elevation(riverY(i),riverX(i));
end
riverElevation=[riverX riverY riverZ];
hold on
scatter3(riverX,riverY,riverZ,'filled','green')
surf(Elevation)

% %%%%%%%%%%%%%%%Fly Postion%%%%%%%%%%%%

positions=zeros(longitude, lattitude);
fZ=zeros(1);
k=1;
for i=ceil(longitude/2)-buffer:ceil(longitude/2)+buffer
    for j=ceil(lattitude/2)-buffer:ceil(lattitude/2)+buffer
        positions(i,j)=River(i,j);
        if River(j,i)~=0
        fZ(k,1)=River(j,i);
        k=k+1;
        end
    end
end

[A, B]=find(positions~=0);
Coordinates=[A,B];

scatter3(A,B,fZ,'filled','black')
hold off
filenameholder=strcat(choice, '_size_', num2str(lattitude), 'x', num2str(longitude), '_width_', num2str(width),  '_buffer_',  num2str(buffer),datestr(now,'mmmm_dd_yyyy_HH_MM_SS_FFF_AM'));
save(filenameholder,'River','Elevation','Coordinates');