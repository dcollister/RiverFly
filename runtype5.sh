#!/bin/csh

#Submission script for type5 simulation


#$ -l h=!q16copt120
#$ -q long
#$ -pe smp 24         
#$ -N  type5 	# Specify job name
#$ -t 1-1:1       #specify number of data input files
#$ -q long
#$ -r y

set shape=( SanDimasSubset.shp )
set alt=( DimasSubsetElevation.tif )
module load matlab

matlab -nodisplay -nosplash -nojvm -r "type5simscript('$shape[${SGE_TASK_ID}]','$alt[${SGE_TASK_ID}]');exit"