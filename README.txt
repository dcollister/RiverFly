This text file contains a brief description of each file in the repository

Alt_gridprob.m: Matlab function takes in an altitude matrix altLandGrid (usually generated by readshapealt) and returns a cells 2D-array where each cell contains the 9 elements array
containing the probabilities to move in any of the 9 neighborhood grid points corresponding to the position on altLandGrid determined by the cell array coordinates.
The function contained here to generate probabilities of movement from local altitudes is currently hardcoded but can be changed or coded in a separate function.
Current function based on the difference from maximum altitude in the neighborhood. 
(can also return a landGrid cell 2D array with neighborhood altitudes instead of probabilities)

Alt_gridprob2.m: Matlab function takes in an altitude matrix altLandGrid (usually generated by readshapealt) and returns a cells 2D-array where each cell contains the 9 elements array
containing the probabilities to move in any of the 9 neighborhood grid points corresponding to the position on altLandGrid determined by the cell array coordinates.
The function contained here to generate probabilities of movement from local altitudes is currently hardcoded but can be changed or coded in a separate function.
Current function based on the difference from the central (current) altitude in the neighborhood. 
(can also return a landGrid cell 2D array with neighborhood altitudes instead of probabilities)

altitudetest.sh: Submission script (use on ND CRC or similar) to use type2scriptalt.m. Provides an altitudefile name and shapefile name.

flyPositioning.m: Matlab function used to populate the river areas with flies (randomly). Inputs coordinates of water grid points on a landGrid matrix and the population to distribute. 
Outputs coordinates, gender, and genetic pool for each fly place on the grid (note: gender and genetic pool are currently not used).

flyrivertype1.m: The old version of the main Matlab function for the project. This version simplifies the landGrid to 0s and 1s, indicating either land and water respectively,
 and assigns a weight for the probability of movement in the neighborhood to each type. Inputs are gridType (Random, Fractal, or from shapefile), 
 pb= probability of birth per unit time (on the river), pd= death probability per unit time, numberOfKids= number of offsprings, 
 simulationTimeLength= max length of simulation (unit time=hours),flyPopulationSize= initial population size, 
 nmoves= number of times a fly moves (changes 1 adjacent grid position) in a unit time.
 The output is saved to a Matlab data file ('.mat') containing the inputs and data on river, altitude, and flies at each time step (see the end of described file for details).

flyrivertype2.m: The new version of the main Matlab function for the project. This version still uses a simplified landGrid to 0s and 1s, indicating either land and water respectively,
 used to determine if a fly is on water or land (for reproduction purpose).  If an altitude file is provided this version assigns a weight for the probability of movement in the neighborhood based on altitude data from a matrix altGrid. Inputs are gridType (Random, Fractal, or from shapefile, or from both shapefile and altitudefile), 
 pb= probability of birth per unit time (on the river), pd= death probability per unit time, numberOfKids= number of offsprings, 
 simulationTimeLength= max length of simulation (unit time=hours),flyPopulationSize= initial population size, 
 nmoves= number of times a fly moves (changes 1 adjacent grid position) in a unit time.
  The output is saved to a Matlab data file ('.mat') containing the inputs and data on river, altitude, and flies at each time step (see the end of described file for details).
  
gridprob.m: Matlab function takes in a matrix of 0s and 1s indicating land and water (usually generated by readshapealt) and probability weights for both. Returns a cells 2D-array where each cell contains the 9 elements array
containing the probabilities to move in any of the 9 neighborhood grid points corresponding to the position on landGrid determined by the cell array coordinates.
Note this function does not use altitudes to simulate the movement of flies, only a boolean statement distinguishing between land and water. 

gridTestHammyJammy.m (Daniel, name to change): subfunction used to create landGrid when Random or Fractal rivers are selected in main code function (see flyrivertype1.m and riverCreation.m).

job.sh: Submission script (use on ND CRC or similar) to use type2script.m. Provides an altitudefile name and shapefile name.

move_v3.m: Matlab function moves flies based on random number generation and probabilities provided to move in each of the 9 neighborhood slots. Takes inputs the current data on flies
(including positions), landGrid matrix, landGrid_prob probabilities, current population size, positions of the river, and timestep index. Returns new data on flies based on prescribed movement (also removes flies going out of bound and reports them as dead).

multibirthrate.sh: Submission script (use on ND CRC or similar) to use type3script.m. Allows running multiple jobs with different birthrates in parallel.
 Provides an altitudefile name, shapefile name, and birthrate given by task number.

plotscript.m: This script contains useful plot routines to display the results of simulations. Note simulation data needs to be loaded before executing the script.

plotsubpopareas.m: This script allows to plot data relative to subareas of the domain.

README.txt: The file you are reading right now.

readshape2.m: Matlab Function reads in a shapefile and returns a landGrid matrix with 0s for land and 1s for water (can specify the resolution of the grid and buffer around the given region).

readshapealt.m: Matlab Function reads in a shapefile and returns a landGrid matrix with 0s for land and 1s for water (can specify the resolution of the grid and buffer around the given region).

readshapealtord.m: Matlab Function reads in a shapefile and altitude GeoTIFF file and returns a landGrid matrix with 0s for land and 1s for water as well as an altGrid matrix with the altitudes.
In this function, the resolution is predetermined by the altitude file and buffer is set to 1 (no buffer). The GeoTIFF region should fully contain the shapefile region (better if bigger)
and should use the same units for distance and geolocation coordinates.

readshape.m: (Old version, use readshape2 unless needed) 
Matlab Function reads in a shapefile and returns a landGrid matrix with 0s for land and 1s for water (can specify the resolution of the grid and buffer around the given region).

riverCreation.m (Daniel): Matlab function to create landGrid space when Random or Fractal rivers are selected in main code function (see flyrivertype1.m and gridTestHammyJammy.m)

sorting.m (Daniel, not currently use): sorting function

type1script.m: Matlab script function to setup parameters (usually from job script file but can be called directly) and call the flyrivertype1 function.

type2scriptalt.m: Matlab script function to setup parameters (usually from job script file but can be called directly) and call the flyrivertype2 function.
In this version birth and death probabilities are set to zero to test the movement of flies under altitude based movement conditions.

type2script.m: Matlab script function to setup parameters (usually from job script file but can be called directly) and call the flyrivertype2 function.

type3script.m: Matlab script function to setup parameters (usually from job script file but can be called directly) and call the flyrivertype2 function.
In this version, the reproduction rate is set based on the task number assigned as input to the function (NTASK).

