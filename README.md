coursera: Getting and Cleaning Data - course project
=================================

The data collected from the accelerometers from the Samsung Galaxy S smartphone can be processed by the R script run_analysis.R, it will do the following works:
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The data should placed in the working directory, unzip the data to subdirectory named "UCI HAR Dataset", and run run_analysis.R, the step 5 will create file "data_all_avg.txt" in the working directory.
