#
# Script: run_analysis.R
#
# This script is for the "Getting and Cleaning Data" course.
#
# Instructions
#
# You should create one R script called run_analysis.R that does the following. 
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.
#

# Load metadata

# Read in activity labels
activityLabels <- read.table("activity_labels.txt")
names(activityLabels) <- c("ActivityId", "ActivityDescription")

# Read in features
features <- read.table("features.txt")
names(features) <- c("PositionId", "PositionDescription")

# 1. Merge the training and the test sets to create one data set.

# Load test data

subjectTest <- read.table("test/subject_test.txt")
names(subjectTest) <- c("SubjectId")

xTest <- read.table("test/X_test.txt")
names(xTest) <- features$PositionDescription

yTest <- read.table("test/y_test.txt")
names(yTest) <- c("ActivityId")

# Bind together the test data records
bindedTest <- cbind(subjectTest, xTest, yTest)
bindedTest$OriginalDataset <- "Test"
bindedTest$RowIdInDataset <- 1:nrow(bindedTest)

# Load training subject data

subjectTrain <- read.table("train/subject_train.txt")
names(subjectTrain) <- c("SubjectId")

xTrain <- read.table("train/X_train.txt")
names(xTrain) <- features$PositionDescription

yTrain <- read.table("train/y_train.txt")
names(yTrain) <- c("ActivityId")

# Bind together the training data records
bindedTrain <- cbind(subjectTrain, xTrain, yTrain)
bindedTrain$OriginalDataset <- "Train"
bindedTrain$RowIdInDataset <- 1:nrow(bindedTrain)

# Merge the two datasets together
mergedData <- rbind(bindedTrain, bindedTest)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# Load gdata library
library(gdata)

# Get all columns that match the specified criteria
colNames <- unlist(matchcols(mergedData, with=c("SubjectId", "ActivityId", "mean","std","OriginalDataset", "RowIdInDataset" ), method="or"))

# Select only the desired columns from the dataset
extractedData <- mergedData[,colNames]

# Remove meanFreq columns (possible issue with the without parameter in matchcols)
colNames <- unlist(matchcols(extractedData, with=c("."), without=c("meanFreq")))
extractedData <- mergedData[,colNames]

# 3. Uses descriptive activity names to name the activities in the data set

# Load plyr library
library(plyr)

# Join the Activity Labels to the extracted data set
labelledData <- join(extractedData,activityLabels)

# 4. Appropriately labels the data set with descriptive variable names. 
namedData <- labelledData

# Tidy up x, Y, Z axis reference in labels
names(namedData) <- gsub("-X"," X-Axis", names(namedData))
names(namedData) <- gsub("-Y"," Y-Axis", names(namedData))
names(namedData) <- gsub("-Z"," Z-Axis", names(namedData))

# Tidy up mean and std reference in labels
names(namedData) <- gsub("-mean()"," Mean", names(namedData), fixed=TRUE)
names(namedData) <- gsub("-std()"," StdDev", names(namedData), fixed=TRUE)

# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.

# Rearrange data columns (i.e. removing Activity ID, Dataset origin info)
tidyData <- select(namedData, 1, 71, 3:68)

# Grouping by Subject ID and the activity (description) calculate the average value for each variable
summarisedTidyData <- tidyData %>% group_by(SubjectId, ActivityDescription) %>% summarise_each(funs(mean))

# Export the summarised tidy data set to a file for uploading to the course website
write.table(summarisedTidyData, file="tidyDataSet.txt", row.names=FALSE)
