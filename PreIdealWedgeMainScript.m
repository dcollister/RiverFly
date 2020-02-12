function PreIdealWedgeMainScript(pb,pd,nmoves,altprobcoeff,type,upcoeff,probtype,bias)

fileList = dir('IdealizedGeometries/Wedge_size_1001x1001_width_51_buffer_100.mat');
numfile=length(fileList);
for file=1:numfile
    filename=fileList(file).name(1:end-4);
    load([filename '.mat'],'River','Elevation','Coordinates');
    IdealizedMainScript(River,Elevation,pb,pd,nmoves,altprobcoeff,type,upcoeff,probtype,bias,Coordinates,filename)
end