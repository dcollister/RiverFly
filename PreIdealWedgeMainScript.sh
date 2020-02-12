#!/bin/csh

#Submission script for type6 simulation


#$ -l h=!q16copt120
#$ -q long
#$ -pe smp 1         
#$ -N  flyrivermain 	# Specify job name
#$ -t 1-20:1       #specify number of data input files
#$ -q long
#$ -r y

module load matlab

set pb=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set pd=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set nmoves=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set altprobcoeff=(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set upcoeff=( -1  -1  -1  -1  -1  -1 -1  -1  -1 -1 -1  -1  -1  -1  -1  -1 -1  -1  -1 -1)
set type=(2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
set probtype=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set bias= ( 0 1.00 1.02 1.04 1.06 1.08 1.1 1.12 1.14 1.16 1.18 1.20 1.22 1.24 1.26 1.28 1.30 1.40 1.50 2)

matlab -nodisplay -nosplash -nojvm -r "PreIdealWedgeMainScript($pb[${SGE_TASK_ID}],$pd[${SGE_TASK_ID}],$nmoves[${SGE_TASK_ID}],$altprobcoeff[${SGE_TASK_ID}],$type[${SGE_TASK_ID}],$upcoeff[${SGE_TASK_ID}],$probtype[${SGE_TASK_ID}],$bias[${SGE_TASK_ID}]);exit"

set pb=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set pd=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set nmoves=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set altprobcoeff=(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set upcoeff=( -1  -1  -1  -1  -1  -1 -1  -1  -1 -1 1 1 1 1 1 1 1 1 1 1)
set type=(2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
set probtype=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set bias= (0.000001 0.00001  0.0001 0.001 0.01 0.1 1 10 100 1000  0.000001 0.00001  0.0001 0.001 0.01 0.1 1 10 100 1000)

matlab -nodisplay -nosplash -nojvm -r "PreIdealWedgeMainScript($pb[${SGE_TASK_ID}],$pd[${SGE_TASK_ID}],$nmoves[${SGE_TASK_ID}],$altprobcoeff[${SGE_TASK_ID}],$type[${SGE_TASK_ID}],$upcoeff[${SGE_TASK_ID}],$probtype[${SGE_TASK_ID}],$bias[${SGE_TASK_ID}]);exit"

set pb=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set pd=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set nmoves=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set altprobcoeff=(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set upcoeff=( -5  -5  -5  -5  -5  -5 -5  -5  -5 -5 5 5 5 5 5 5 5 5 5 5)
set type=(2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
set probtype=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set bias= (0.000001 0.00001  0.0001 0.001 0.01 0.1 1 10 100 1000  0.000001 0.00001  0.0001 0.001 0.01 0.1 1 10 100 1000)

matlab -nodisplay -nosplash -nojvm -r "PreIdealWedgeMainScript($pb[${SGE_TASK_ID}],$pd[${SGE_TASK_ID}],$nmoves[${SGE_TASK_ID}],$altprobcoeff[${SGE_TASK_ID}],$type[${SGE_TASK_ID}],$upcoeff[${SGE_TASK_ID}],$probtype[${SGE_TASK_ID}],$bias[${SGE_TASK_ID}]);exit"

set pb=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set pd=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set nmoves=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set altprobcoeff=(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set upcoeff=( -10  -10  -10  -10  -10  -10 -10  -10  -10 -10 10 10 10 10 10 10 10 10 10 10)
set type=(2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
set probtype=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set bias= (0.000001 0.00001  0.0001 0.001 0.01 0.1 1 10 100 1000  0.000001 0.00001  0.0001 0.001 0.01 0.1 1 10 100 1000)

matlab -nodisplay -nosplash -nojvm -r "PreIdealWedgeMainScript($pb[${SGE_TASK_ID}],$pd[${SGE_TASK_ID}],$nmoves[${SGE_TASK_ID}],$altprobcoeff[${SGE_TASK_ID}],$type[${SGE_TASK_ID}],$upcoeff[${SGE_TASK_ID}],$probtype[${SGE_TASK_ID}],$bias[${SGE_TASK_ID}]);exit"

set pb=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set pd=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set nmoves=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set altprobcoeff=(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set upcoeff=( -50  -50  -50  -50  -50  -50 -50  -50  -50 -50 50 50 50 50 50 50 50 50 50 50)
set type=(2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
set probtype=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set bias= (0.000001 0.00001  0.0001 0.001 0.01 0.1 1 10 100 1000  0.000001 0.00001  0.0001 0.001 0.01 0.1 1 10 100 1000)

matlab -nodisplay -nosplash -nojvm -r "PreIdealWedgeMainScript($pb[${SGE_TASK_ID}],$pd[${SGE_TASK_ID}],$nmoves[${SGE_TASK_ID}],$altprobcoeff[${SGE_TASK_ID}],$type[${SGE_TASK_ID}],$upcoeff[${SGE_TASK_ID}],$probtype[${SGE_TASK_ID}],$bias[${SGE_TASK_ID}]);exit"


set pb=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set pd=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set nmoves=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set altprobcoeff=(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set upcoeff=( -100  -100  -100  -100  -100  -100 -100  -100  -100 -100 100 100 100 100 100 100 100 100 100 100)
set type=(2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
set probtype=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set bias= (0.000001 0.00001  0.0001 0.001 0.01 0.1 1 10 100 1000  0.000001 0.00001  0.0001 0.001 0.01 0.1 1 10 100 1000)

matlab -nodisplay -nosplash -nojvm -r "PreIdealWedgeMainScript($pb[${SGE_TASK_ID}],$pd[${SGE_TASK_ID}],$nmoves[${SGE_TASK_ID}],$altprobcoeff[${SGE_TASK_ID}],$type[${SGE_TASK_ID}],$upcoeff[${SGE_TASK_ID}],$probtype[${SGE_TASK_ID}],$bias[${SGE_TASK_ID}]);exit"


set pb=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set pd=( 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01)
set nmoves=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set altprobcoeff=(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set upcoeff=( -1000  -1000  -1000  -1000  -1000  -1000 -1000  -1000  -1000 -1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000)
set type=(2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2)
set probtype=( 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
set bias= (0.000001 0.00001  0.0001 0.001 0.01 0.1 1 10 100 1000  0.000001 0.00001  0.0001 0.001 0.01 0.1 1 10 100 1000)

matlab -nodisplay -nosplash -nojvm -r "PreIdealWedgeMainScript($pb[${SGE_TASK_ID}],$pd[${SGE_TASK_ID}],$nmoves[${SGE_TASK_ID}],$altprobcoeff[${SGE_TASK_ID}],$type[${SGE_TASK_ID}],$upcoeff[${SGE_TASK_ID}],$probtype[${SGE_TASK_ID}],$bias[${SGE_TASK_ID}]);exit"

