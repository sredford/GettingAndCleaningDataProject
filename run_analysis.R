# Load some useful libraries
library(reshape2)
library(dplyr)

# Load data into data frames
s_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

s_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# Give nice column names
valid_column_names <- make.names(names=features[,2], unique=TRUE, allow_ = TRUE)
colnames(x_test) <- valid_column_names
colnames(x_train) <- valid_column_names
colnames(s_test) <- c("Subject")
colnames(s_train) <- c("Subject")
colnames(y_test) <- c("Activity")
colnames(y_train) <- c("Activity")

# Merge the training and the test sets to create one data set
test <- cbind(s_test,y_test,x_test)
train <- cbind(s_train,y_train,x_train)
mergedData <- rbind(test,train)

# Extract only the measurements on the mean and standard deviation for each measurement
sel_mergedData <- select(.data = mergedData,Subject,Activity,contains("mean"),contains("std"))

# Use descriptive activity names to name the activities in the data set
activities[,2]<-as.character(activities[,2])

for(i in 1:nrow(sel_mergedData)){
  sel_mergedData[i,2]<-activities[sel_mergedData[i,2],2]
}

# Appropriately label the data set with descriptive variable names 
# already done in lines 17-24
# see codebook for additional explanation of varaible names

# Create a second, independent tidy data set with the average
# of each variable for each activity and each subject
meltdf <- melt(sel_mergedData, id.var = c("Subject", "Activity"))
meansdf <- dcast(meltdf , Subject + Activity ~ variable, mean)

# Save this tidy data set
write.table(meansdf, file = "FinalData.txt", row.names=FALSE)
