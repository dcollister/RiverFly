function [landGrid_prob,altGrid]=Alt_gridprob4(altLandGrid,altProbCoeff,landGrid,upcoeff,probtype,bias)
landGrid_prob=cell(size(altLandGrid,2),size(altLandGrid,1));
onRiver_Prob=cell(size(altLandGrid,2),size(altLandGrid,1));


for i=2:size(altLandGrid,2)-1
    for j=2:size(altLandGrid,1)-1
        n=1;
        for ii=i-1:1:i+1
            for jj=j-1:1:j+1
                if landGrid(jj,ii)==1
                    onRiver_Prob{i,j}(1,n)=-upcoeff;
                else
                    onRiver_Prob{i,j}(1,n)=1;
                end
                landGrid_prob{i,j}(1,n)=altLandGrid(jj,ii);
                n=n+1;
            end
        end
    

	%Linear
	if probtype==1
        now_LGij=landGrid_prob{i,j}(1,5);%current position altitude
        deltaHeight{i,j}=bias*(landGrid_prob{i,j}(1,5)-landGrid_prob{i,j});
        
        max_DHij=max(deltaHeight{i,j});
        
        altGrid{i,j}=landGrid_prob{i,j};
        
        min_DHij=min(onRiver_Prob{i,j}.*deltaHeight{i,j});
        
        for count=1:9
            if onRiver_Prob{i,j}(1,count)==1
                landGrid_prob{i,j}(1,count)=1+altProbCoeff*(deltaHeight{i,j}(1,count)+abs(min(0,min_DHij)));
            else
                landGrid_prob{i,j}(1,count)=1+altProbCoeff*(onRiver_Prob{i,j}(1,count)*deltaHeight{i,j}(1,count)+abs(min(0,min_DHij)));
            end
        end
    
	%exponential
	else
		max_LGij=max(landGrid_prob{i,j});
        min_LGij=min(landGrid_prob{i,j});
        now_LGij=landGrid_prob{i,j}(1,5);%current position altitude
				
				
         			if landGrid(j,i)==0
         				landGrid_prob{i,j}=exp(altProbCoeff*(now_LGij-landGrid_prob{i,j}));
         			else
         				landGrid_prob{i,j}=exp(altProbCoeff*onRiver_Prob{i,j}.*(bias*(now_LGij-landGrid_prob{i,j})));
                    end
	end
        sum_LGij=sum(landGrid_prob{i,j});
        landGrid_prob{i,j}=landGrid_prob{i,j}/sum_LGij;
        
    end
end

	