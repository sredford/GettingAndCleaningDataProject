# CodeBook for GettingAndCleaningDataProject

This project takes data collected from the accelerometers in the Samsung Galaxy S smartphone and transforms it into a single tidy data set for later analysis. This code book that describes the variables, the data, and the transformations that were performed to clean up the original data and produce the final data set.

### The experiment
30 people aged 19-48 years performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone (Samsung Galaxy S II) on the waist. Using the embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity measurements were captures at a constant rate of 50Hz. The experiments were video-recorded and the data was labeled manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### The available data files
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

For use of this data set, I acknowledge the following publication [1]: 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

### Each observation consists of
- the triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration
- the triaxial Angular velocity from the gyroscope 
- a 561-feature vector with time and frequency domain variables 
- the activity label 
- the identifier of the subject who carried out the experiment
 
### Features
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals and used in this analysis are: 
- mean(): Mean value
- std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

### Processing steps
Once the data has been downloaded and unzipped, eight txt files are loaded by the R script run_analysis.R. They are:

1. subject_test.txt, providing the index of the subject (test subset)
2. y_test.txt, providing the index of the activity (test subset)
3. X_test.txt, providing the data for each of the features (test subset)
4. subject_train.txt, providing the index of the subject (train subset)
5. y_train.txt, providing the index of the activity (train subset)
6. X_train.txt, providing the data for each of the features (train subset)
7. features.txt, providing the list of features
8. activity_labels.txt, providing the list of activities

Descriptive column names are given to each data set:
- "Subject" for the subject column
- "Activity" for the activity column
- the labels for the feature columns are extracted from the features.txt file. Since some of these variable names include invalid characters, valid_column_names is created with make.names().

The train and test data sets are merged to form one data set. First, the subject, y and X data sets belonging to the same subset (train or test) are merged together using cbind. The two resulting data sets are merged together using rbind.

The dplyr packaged is used to select only those variables which contain 'mean' and 'standard deviation' for each measurement. It's ambiguous whether variables such as 'gravityMean' should be included here, they are kept for completeness. In total 88 variables are selected out of the possible 563, including "Subject", "Activity" and 86 features.

The Activity column at this point contains an index from 1 to 6. A more descriptive entry can be achieved by matching this index to the activities data frame, and replacing the index with the corresponding activity (walking, sitting etc).

Finally, since the resulting data set has repeated measurements for each subject and each activity, it is possible to average all measurements belonging to the same subject and activity. This is achieved using the reshape2 melt and dcast functions. The number of observations is reduced from 10299 to 180.

The reduced data set is saved as a text file for further analysis.