function[gaussian1,gaussian2]=calcGaussian(distGrid,distGrid2,stateX1,stateX2,river,stateValue,probs,timeStandardDeviation,onOffRiverSwitch)

b1=distGrid.^2;
b2=distGrid2.^2;

[X, Y]=find(river==0);

gaussian1=zeros(size(distGrid,1),size(distGrid,2),size(distGrid,3),size(timeStandardDeviation,2));
gaussian2=zeros(size(distGrid2,1),size(distGrid2,2),size(distGrid2,3),size(timeStandardDeviation,2));




for time=1:size(timeStandardDeviation,2)
    gaussian1(:,:,:,time)=exp(-(b1)/(4*(timeStandardDeviation(time))));
    for slice=1:size(distGrid,3)
        gaussian1(:,:,slice,time)=stateValue(slice)*gaussian1(:,:,slice,time);
    end
    
end

if onOffRiverSwitch == 1
    for i=1:size(X,1)
        gaussian1(X(i),Y(i),:,:)=0;
    end
end

for time=1:size(timeStandardDeviation,2)
    gaussian2(:,:,:,time)=exp(-(b2)/(2*(timeStandardDeviation(time).^2)));
    for slice=1:size(distGrid2,3)
        gaussian2(:,:,slice,time)=probs(1)*gaussian2(:,:,slice,time);
    end
end

if onOffRiverSwitch == 1
    for i=1:size(X,1)
        gaussian2(X(i),Y(i),:,:)=0;
    end
end