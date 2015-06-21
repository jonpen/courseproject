# Codebook

This file contains the following information:

- Information regarding the raw data used for this analysis
- Description of how to run the script run_analysis.R script within this repository
- An outline of the script algorithm
- A description of the result data sets from script execution (cleaned data set within R and the export file)

### Raw Data

The raw data can be found at the following link:

[Raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

This data set represents data collected from the accelerometers of Samsung Galaxy S smartphones being used by test subjects. You can find more information about the project [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### Running the Script

In order to run the script run_analysis.R, you'll have to perform the following initial tasks:

1. Download the data file.
2. Unzip the file
3. Set the working directory of your R environment to the "UCI HAR Dataset" directory within the unzipped folder structure. *Note:* This is important as otherwise the R script will not work.
4. Source the run_analysis.R script

If this script is successful, you should see two finished products:

1. The file tidyDataSet.txt should have been created within the "UCI HAR Dataset" directory (i.e. the current working directory)
2. The data frame 'namedData' within the R environment.

Note that if you would like to compare the exported file that results from the script execution, you can find an example within this repository (tidyDataSet.txt).

### Algorithm Outline

This R script performs the following steps:

1. It loads the following file

### Data Information

### Measurements
