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

#### Data import and preprocessing

* This stage loads the following files from the raw-data:

The following metadata:

+ features.txt: This lists the data field labels for the captured data records
+ activity_labels.txt: This specifies the activity associated with an activity identifier 

From the test data set:

+ test/subjectTest.txt: Specifies which subject corresponds to the captured data record
+ test/y_test.txt: Specifies the subject's activity for the corresponding captured data record
+ test/X_test.txt: The processed accelerometer information from the smart phone

The equivalent files are also loaded for the training data set (just replace test for train)

* The three files for each data set (test/train) are bound together using cbind and stored withinn a new data frame variable e.g. bindedTest <- cbind(subjectTest, xTest, yTest).
* Two additional data fields are then added to each bound data frame. These specify the dataset and the record number and are useful in identifying the original data source at later process stages (if required)
* Finally, the test and train datasets are then merged together using rbind i.e. mergedData <- rbind(bindedTrain, bindedTest)

#### Next stage

### Data Information

### Measurements
