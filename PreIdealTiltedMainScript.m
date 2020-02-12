function PreIdealTiltedMainScript(pb,pd,nmoves,altprobcoeff,type,upcoeff,probtype,bias)

fileList = dir('IdealizedGeometries/Tilted*');
numfile=length(fileList);
for file=1:numfile
    filename=fileList(file).name(1:end-4);
    load([filename '.mat'],'River','Elevation','Coordinates');
 end

IdealizedMainScript(River,Elevation,pb,pd,nmoves,altprobcoeff,type,upcoeff,probtype,bias,Coordinates,filename)