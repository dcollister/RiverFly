function[]=graphing(name,river,stateX1,stateY1,stateX2,stateY2,GaussProbSumGrid,GaussProbSumGrid2,timeStandardDeviation,graphTypes)

[f1,f2]=find(river==1);
riverNodes(:,1)=f1;
riverNodes(:,2)=f2;
h = figure;
axis tight manual
filename=sprintf('%s%s',name{1},'.gif');%1Dayfor1Week

if graphTypes==0
for time=1:size(timeStandardDeviation,2)
    sz=2.5;
    subplot(1,3,1)
    hold on
    title('River contour with highest population distribution nodes')
    contour(river)
    scatter(stateX1,stateY1,sz,'c','MarkerEdgeColor',[0 .5 .5],...
        'MarkerFaceColor',[0 .7 .7],...
        'LineWidth',5.5)
%     hold off
%     sz=2.5;
%     subplot(2,3,4)
%     hold on
%     contour(river)
%     scatter(stateX2,stateY2,sz,'c','MarkerEdgeColor',[0 .5 .5],...
%         'MarkerFaceColor',[0 .7 .7],...
%         'LineWidth',5.5)
%     hold off
    
    axis tight manual 
    subplot(1,3,2)
    hold on
    title('Heat map of population at 1 week dispersal for Larvae')
    axis xy
    imagesc(GaussProbSumGrid(:,:,time))
    scatter(f2,f1,0.25,'w')
    hold off
    
%     subplot(1,3,5)
%     hold on
%     % contour(river,'w')
%     imagesc(GaussProbSumGrid2(:,:,time))
%     hold off
    Gauss1=GaussProbSumGrid(:,:,time);
%     Gauss2=GaussProbSumGrid2(:,:,time);
    
    axis tight manual
    subplot(1,3,3)
    hold on
    title('Density clouds for the population distribution visualized in 3D')
    surf(Gauss1,'FaceAlpha',0.5,'EdgeColor','none')
    axis tight manual
    view(45,30);
    hold off
%     subplot(2,3,6)
%     surf(Gauss2,'FaceAlpha',0.5,'EdgeColor','none')
    pause(1/6);
    
    axis tight manual 
    
    frame=getframe(h);
    im =frame2im(frame);
    [imind,cm]=rgb2ind(im,256);
    if time == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
end
else
for time=1:size(timeStandardDeviation,2)
%     sz=2.5;
%     subplot(1,2,1)
%     hold on
%     title('River contour with highest population distribution nodes')
%     contour(river)
%     scatter(stateX1,stateY1,sz,'c','MarkerEdgeColor',[0 .5 .5],...
%         'MarkerFaceColor',[0 .7 .7],...
%         'LineWidth',5.5)
%     hold off
%     sz=2.5;
%     subplot(2,3,4)
%     hold on
%     contour(river)
%     scatter(stateX2,stateY2,sz,'c','MarkerEdgeColor',[0 .5 .5],...
%         'MarkerFaceColor',[0 .7 .7],...
%         'LineWidth',5.5)
%     hold off
    
    axis tight manual 
    subplot(1,2,1)
    hold on
    title('Heat map of population at 1 week dispersal for Larvae')
    axis xy
    imagesc(GaussProbSumGrid(:,:,time))
    scatter(f2,f1,0.05,'w')
    hold off
    
%     subplot(1,3,5)
%     hold on
%     % contour(river,'w')
%     imagesc(GaussProbSumGrid2(:,:,time))
%     hold off
    Gauss1=GaussProbSumGrid(:,:,time);
%     Gauss2=GaussProbSumGrid2(:,:,time);
    
    axis tight manual
    subplot(1,2,2)
    hold on
    title('Density clouds for the population distribution visualized in 3D')
    surf(Gauss1,'FaceAlpha',0.5,'EdgeColor','none')
    axis tight manual
    view(15,50);
    
    scatter(f2,f1,0.05,'bl')
    hold off
%     subplot(2,3,6)
%     surf(Gauss2,'FaceAlpha',0.5,'EdgeColor','none')
    pause(1/6);
    
    axis tight manual 
    
    frame=getframe(h);
    im =frame2im(frame);
    [imind,cm]=rgb2ind(im,256);
    if time == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
end
end