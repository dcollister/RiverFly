function [hi,xCoords,yCoords,heightRiver,widthRiver] = baseNodeCreation(riverSplits)
% clf;
heightRiver=20*riverSplits;
widthRiver=10*2^(riverSplits+1);

bottomLeftNode=-widthRiver/2;
bottomRightNode=widthRiver/2;
xCoords=zeros(1);
yCoords=zeros(1);
nodeCounter=1;
splits=0;

for y0=0:heightRiver/(2*riverSplits):heightRiver
    
    if 0==mod(y0,20)&&y0>0
        splits=splits+1;
        
    end
    
    for j=1:2^splits
        xCoords(nodeCounter)=bottomLeftNode+(2*j-1)*(bottomRightNode-bottomLeftNode)/(2^(splits+1));
        yCoords(nodeCounter)=y0;
        nodeCounter=nodeCounter+1;
        
        if mod(y0,20)==0
            for jOne=1:10
                xCoords(nodeCounter)=xCoords(nodeCounter-1);
                yCoords(nodeCounter)=y0+jOne;
                nodeCounter=nodeCounter+1;
            end
        end
    end
    
end

hi=[xCoords' yCoords'];



end
