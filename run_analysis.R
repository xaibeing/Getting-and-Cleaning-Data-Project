
# 1. Merges the training and the test sets to create one data set.

# set dir
dataDir <- "UCI HAR Dataset"
trainDataDir <- paste( dataDir, "/train", sep="" )
testDataDir <- paste( dataDir, "/test", sep="" )

# read training data
subject_train <- read.table( paste( trainDataDir, "/subject_train.txt", sep="" ), header=FALSE, sep="" )
X_train <- read.table( paste( trainDataDir, "/X_train.txt", sep="" ), header=FALSE, sep="" )
y_train <- read.table( paste( trainDataDir, "/y_train.txt", sep="" ), header=FALSE, sep="" )
data_train <- cbind( subject_train, y_train, X_train )

# read test data
subject_test <- read.table( paste( testDataDir, "/subject_test.txt", sep="" ), header=FALSE, sep="" )
X_test <- read.table( paste( testDataDir, "/X_test.txt", sep="" ), header=FALSE, sep="" )
y_test <- read.table( paste( testDataDir, "/y_test.txt", sep="" ), header=FALSE, sep="" )
data_test <- cbind( subject_test, y_test, X_test )

# Merges the training and the test sets
data_all <- rbind( data_train, data_test )

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# read features
features <- read.table( paste( dataDir, "/features.txt", sep="" ), header=FALSE, sep="", stringsAsFactors=FALSE )

# make vector of columns which has "mean" or "std"
colMeanStdIndex <- c( 1, 2 )
colMeanStdName <- c( "subject", "activity" )
for( rowIndex in 1:nrow(features) )
{
	if( grepl( "mean", features$V2[rowIndex] ) | grepl( "std", features$V2[rowIndex] ) )
	{
		colMeanStdIndex <- c( colMeanStdIndex, rowIndex + 2 )
		colMeanStdName <- c( colMeanStdName, features$V2[rowIndex] )
	}
}

#colMeanStdIndex
#colMeanStdName

# Extracts only the measurements on the mean and standard deviation
data_all <- data_all[ , colMeanStdIndex ]

# 4. labels the data set with descriptive variable names. 
colnames(data_all) <- colMeanStdName

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table( paste( dataDir, "/activity_labels.txt", sep="" ), header=FALSE, sep="", stringsAsFactors=FALSE )
data_all[["activity"]] <- activity_labels[ match( data_all[['activity']], activity_labels[[1]] ) , 2 ]

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
data_all_avg <- data_all
data_all_avg$subject_activity <- paste( data_all_avg$subject, data_all_avg$activity )
data_all_avg <- aggregate( x = data_all_avg[ , 3:( ncol(data_all_avg) - 1 ) ], by = list( subject_activity = data_all_avg$subject_activity ), FUN = mean, na.rm = T )

# save data set to csv file
write.csv( data_all_avg, "data_all_avg.txt", row.names=FALSE )
