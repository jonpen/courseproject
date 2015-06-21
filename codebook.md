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

#### Data Field Extraction

This stage uses the gdata library function matchcols to identify the columns that we want to extract from the merged data set. The following columns are extracted:

* SubjectId: The unique identifier of the subject
* ActivityId: The activity being performed for this data record
* OriginalDataset: The dataset of this data record (Test or Train)
* RowIdInDataset: The row number within the original data set
* Regular expression 'mean': This matches all data columns with a column name containing mean (Note meanFreq is removed in a secondary step)
* Regular expression 'std': This matches all data columns with a column name containing std

The extracted data is stored in a data frame variable 'extractedData'.

#### Add activity labels

The activity text labels are added as a new column to the data set via the join command (plyr library). 

The modified data set is stored in a data frame variable 'labelledData'.

#### Tidy up data labels

The labels for the data set are modified to be more understandable. This is done by changing the names vector for the data frames. I perform the following modifications:

* -X, -Y, -Z is changed to X Axis, Y Axis, Z Axis
* -mean() is changed to Mean
* -std() is changed to StdDev

The modfied data set is stored in a data frame variable 'namedData'.

#### Export tidy data set

This stage involves the following steps:

1. Load the dplyr package
2. Remove the following non-measurement data fields: ActivityId, OriginalDataset, RowIdInDataset
3. Using the dplyr commands 'group_by' and 'summarise_each', the data set is grouped by the activity and subject. This value is stored within the summarisedTidyData data frame variable.
4. The data frame is exported to the file 'tidyDataSet.txt' in the current working directory. Note that the row names are not written to the export file.

### Data Information

This section provides details regarding the data fields within the result objects of the script run_analysis.R. These are:

* The data frame variable 'namedData'. This contains all 10299 data records from the test and train data sets. Each record represents a set of measurements for a particular subject performing a particular activity. 
* The export file 'tidyDataSet.txt'. This file contains a summary of the data contained within namedData. The average value for each measurement variable is calculated for each subject and activity combination. This file contains 180 data records.

#### Data Fields

The result objects contain the following data fields:

*Data Record Information*

* SubjectId: The unique identifier for the test subject. Note that the test subjects were a group of 30 volunteers within the age bracket of 19 to 48 years.
* ActivityId: The unique identifier for the activity being performed by the test subject. (Note: This is only present in the namedData data frame variable)
* ActivityDescription: A text description of the activity being performed. There are six possible values: LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
* OriginalDataset: This variable is created by the script. It specifies the dataset to which this data record belongs. Possible values are Test or Train. (Note: This variable is only present in the namedData data frame variable)
* RowIdInDataset: This specifies the corresponding data record within the original dataset for this data record. This is an integer value starting at 1 (i.e. 1 is the first record within the original dataset). (Note: This is only present in the namedData data frame variable).

*Measurement Information*

The final datasets contain 66 measurement variables which reflect calculations based on the accelarometer data provided by the Samsung Galaxy S smartphone. Note that this data has been partially processed within the raw data files. For further details regarding the raw original data, see the README.txt and features_info.txt files within the raw data zip file.

The 66 measurement variables can be identified by their column names. The names include the following details:

* Axis information (Optional): This specifies the axial motion measured by the variable. The possible values are X-Axis, Y-Axis or Z-Axis
* Calculation type: This specifies if the value represents an average value (Mean) or the standard deviation (StdDev)
* Sensor signal: This specifies the particular signal information represented by the value. The sensor signals were generated by the mobile handset accelerometer and gyroscope. The values are:

*Time Domain Signals*
* tBodyAcc-XYZ: Axial motion representing the body acceleration
* tGravityAcc-XYZ: Axial motion representing the gravitational acceleration.
* tBodyAccJerk-XYZ: Axial motion representing jerk motions
* tBodyGyro-XYZ: Axial angular velocity for the body 
* tBodyGyroJerk-XYZ: Axial angular velocity for jerk motions.
* tBodyAccMag: Magnitude of the body acceleration
* tGravityAccMag: Magnitude of the gravitational acceleration
* tBodyAccJerkMag: Magnitude of the jerk acceleration of the body
* tBodyGyroMag: Magniture of the angular velocity for the body
* tBodyGyroJerkMag: Magnitude of the angular velocity for jerk motions.

*Frequency Domain Signals*
* fBodyAcc-XYZ: Axial motion representing the body acceleration
* fBodyAccJerk-XYZ: Axial motion representing jerk motions
* fBodyGyro-XYZ: Axial angular velocity 
* fBodyAccMag: Magnitude of the body acceleration
* fBodyAccJerkMag: Magnitude of jerk acceleration
* fBodyGyroMag: Magnitude of angular velocity for the body
* fBodyGyroJerkMag: Magnitude of angular velocity for jerk motions.  
