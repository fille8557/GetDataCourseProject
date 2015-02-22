# Getting and Cleaning Data Course Project
Readme and Codebook for the "Getting and Cleaning Data" course project. 

###From the course project insctructions:
You should create one R script called run_analysis.R that does the following. 
 1.	Merges the training and the test sets to create one data set.
 2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
 3.	Uses descriptive activity names to name the activities in the data set
 4.	Appropriately labels the data set with descriptive variable names. 
 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  Step 4 happens before step 2, because doing it earlier ensured that the x dataset hadn't been processed too much and the order and names of the columns would match up.

## Data processing
### Step 1: Merge the training and the test sets to create one data set.
1. Data is loaded into R: same process for test files and train files
  * X files are the measurements, Y files are the activities and Subject files are the subjects.
  * X dataset is the biggest: 2947 rows by 561 columns. Y and Subject datasets are both 2947 rows with a single column.

### Step 4: Appropriately label the data set with descriptive variable names.
2. Get column names for the X dataset (measurements) from the features.txt file. 
  * Features dataset is 561 rows of 2 columns. The second column is the names corresponding to the column names of the X dataset

3. Change column name in Y dataset to "activity" and Subject dataset to "subject".

4. Combine X, Y, and Subject datasets for the test and train data using cbind to create "alltrain" and "alltest" datasets.
  * In each dataset there is a column with the subject, a colum with the activity, and many columns with the measurements. Each row is a single observation of a subject, giving the activity and the measurements for that activity. 
  * The cbind is in the same order for alltrain and alltest, so that the rbind below will work: cbind(Subject,Y, X). 

5. Combine alltrain and alltest datasets with rbind. 
 * This dataset has 10299 rows and 563 columns.

###Step 2: Extract only the measurements on the mean and standard deviation for each measurement.

6. Find the columns needed for mean and standard deviation (std) calculations, using grep funciton. This returns a numeric/integer vector with the column numbers needed. These vectors are ordered for readability.

7. Combine the vectors for mean and standard deviation column numbers with the numbers 1 and 2 (subject and activity) to get a vector with all the rows needed for the next steps. 

8. Subset the data with the vector created in the previous step.
 * The dataset still has 10299 rows but only 81 columns.

###Step 3: Use descriptive activity names to name the activities in the data set

9. Recode activity column with the names of the activities, taken from the activity_labels file: 
 * 1 WALKING
 * 2 WALKING_UPSTAIRS
 * 3 WALKING_DOWNSTAIRS
 * 4 SITTING
 * 5 STANDING
 * 6 LAYING

 This was done manually, with the recode function in the car package, rather than creating a dataset and character vector like for the features file.

##Tidy data results
###Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

1. Using the ddply funciton in the plyr package, get the mean of each activity (column), by each subject and activity.
 * This "tidydata" dataset has 180 rows (30 subject x 6 activities) and the same 81 columns from the dataset created in steps 2 and 3 above.
2. Using the melt function in the reshape package, data is reshaped into a long format, with 4 columns: subject (column 1 from tidydata), activity (column 2 from tidydata), measurement (the 79 remaining columns from tidydata), and the mean value (the row data from tidydata).
 * This format was chosen as it is easier to read in a txt file.
 * There are now 14220 rows (180 rows from tidydata x 79 columns of measurements) and 4 columns.
3. The output is the head() of the reshaped, long format tidydata dataset.

##Codebook
 14220 rows and 4 columns

####First two columns
* subject = subject number
* activity = six different types: walking, standing, sitting, laying, walking downstairs, and walking upstairs.

####Measurement column

 The 79 different measurement variables are the mean, mean fequency, and standard deviation (std) for the X, Y, and Z directions of the accelerometer and gyroscope 3-axial raw signals (tAcc-XYZ and tGyro-XYZ), as well as the acceleration signal separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ). There are also the Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ), the magnitude of these three-dimensional signals calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

 time domain signals (mean and standard deviation for each)
* tBodyAcc-XYZ : accelerometer 3-axial raw signals 
* tGravityAcc-XYZ: accelerometer 3-axial raw signals 
* tBodyAccJerk-XYZ: accelerometer Jerk signals
* tBodyGyro-XYZ: gyroscope 3-axial raw signals
* tBodyGyroJerk-XYZ: gyroscope Jerk signals
* tBodyAccMag: magnitude of accelerometer
* tGravityAccMag: magnitude of accelerometer signals
* tBodyAccJerkMag: magnitude of accelerometer Jerk signals
* tBodyGyroMag: magnitude of gyroscope signals
* tBodyGyroJerkMag: gyroscope Jerk signals

frequency domain signals (mean, mean frequency, and standard deviation for each)
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

####Mean column
All measurements are in hertz (Hz).

