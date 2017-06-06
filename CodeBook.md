Created a R script - run_analysis.R that does the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set.
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

First set the working directory, install and load the data.table package.
Next, downloaded the file from given URL and unzipped the dataset to data directory.
Load the data files and merge all data in one data set using the rbind() function to combine the files based on those that have the same columns.
Then, I extract only those columns with the mean and standard deviation measures, and update the column names.
Then, create vector for defining ID, mead and standard deviation.
Combine all the data together and and make subset from merged dataset and used descriptive activity names to name the activities in the data set.
Finally, I create a second independent tidy data set (secTidySet.txt) with the average of each variable for each activity and each subject


Variables Used:
* x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
* x_data, y_data and subject_data merge the previous datasets to further analysis.
* features contains the correct names for the x_data dataset, which are applied to the column names stored inpackage to be installed and loaded
