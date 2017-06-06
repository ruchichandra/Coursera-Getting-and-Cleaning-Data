#Getting and Cleaning Data Course Project

#Synopsis
#The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. Required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that performed to clean up the data called CodeBook.md.

#Data
#Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Here are the data for the project:

#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Assignment
Student have to create one R script called run_analysis.R that does the following:
  * Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set.
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Setting the working directory
getwd()
setwd("C:/1.RC/Coursera/Data Science/Getting and Cleaning Data")

#Installing and loading R package
install.packages("data.table")
library(data.table)

#Data Processing

#1. Downloading and unzipping dataset

#Download the file from given URL
if(!file.exists("./data")) 
{
  dir.create("./data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")

#Unzip dataset to data directory
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

#2. Merging the training and the test sets to create one dataset:

#2.1 Reading files

#Reading trainings tables
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#Reading testing tables
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#Reading feature vector
features <- read.table("./data/UCI HAR Dataset/features.txt")

#Reading activity labels
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#2.2 Assigning column names
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c("activityId", "activityType")

#2.3 Merging all data in one dataset
mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
dataset_AllInOne <- rbind(mrg_train, mrg_test)

#3. Extracting only the measurements on the mean and standard deviation for each measurement
#3.1 Reading column names
colNames <- colnames(dataset_AllInOne)

#3.2 Create vector for defining ID, mead and standard deviatin
mean_and_std <- (grepl("activityId", colNames) |
                   grepl("subjectId", colNames) |
                   grepl("mean..", colNames) |
                   grepl("std..", colNames)
)

#3.3 Making subset from dataset_AllInOne
setForMeanAndStd <- dataset_AllInOne[ , mean_and_std == TRUE]

#4. Using descriptive activity names to name the activities in the data set
setWithActivityNames <- merge(setForMeanAndStd, activityLabels, 
                              by = "activityId",
                              all.x = TRUE)

#5. creating a second, independent tidy data set with the average of each variable for each activity and each subject
#5.1 Creating second tidy dataset
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

#5.2 Writing second tidy dataset in txt file
write.table(secTidySet, "secTidySet.txt", row.names = FALSE)