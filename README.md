# GettingAndCleaningDataProject

This project takes data collected from the accelerometers in the Samsung Galaxy S smartphone and transforms it into a single tidy data set for later analysis.

There are two (other) files in this repository:

- the script run_analysis.R which performs the analysis
- the CodeBook file which gives details on the variables, the data, and transformations performed to clean up the data

Explanation of the run_analysis.R script:

1. two libraries are loaded to provide useful functions, reshape2 and dplyr
2. the eight txt files from the unzipped data are loaded 
3. the train and test data sets are given nice column names. This includes using the variable names from the features.txt file for the x data sets
4. the train and test data sets are merged to form a single data set
5. from this data set, only measurements relating to the mean or standard deviation are kept
6. the observations in the Activity column are given descriptive names using the information from the activities.txt file
7. finally, the average of each variable for each activity and each subject is calculated, and stored in a second independent tidy data set
8. this second data set is saved as the output of the script

You can reproduce the analysis with the following steps:

1. download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. unzip the data. The unzipped UCI HAR Dataset folder should be in the same directory as the run_analysis.R script
3. run the run_analysis.R script. The working directory should be set to the directory containing the analysis script and the unzipped data. Two non base libraries are required, reshape2 and dplyr
4. run_analysis.R will produce a text file of the final tidy dataset called FinalData.txt
