# GetDataCourseProject
Repository for the coursera "Getting and Cleaning Data" course project. 

## Data processing
1. Data is loaded into R: same process for test files and train files
  * X files are the measurements, Y files are the activities and Subject files are the subjects.
  * X dataset is the biggest: 2947 rows by 561 columns. Y and Subject datasets are both 2947 rows with a single column.

2. Get column names for the X dataset (measurements) from the features.txt file. 
  * Features dataset is 561 rows of 2 columns. The second column is the names corresponding to the column names of the X dataset
3. Change column name in Y dataset to "activity" and Subject dataset to "subject".
4. Combine X, Y, and Subject datasets for the test and train data using cbind to create "alltrain" and "alltest" datasets.
  * In each dataset there is a column with the subject, a colum with the activity, and many columns with the measurements. Each row is a single observation of a subject, giving the activity and the measurements for that activity. 
  * The cbind is in the same order for alltrain and alltest, so that the rbind below will work: cbind(Subject,Y, X). 
5. Combine alltrain and alltest datasets with rbind. 
6. Find the columns needed for mean and standard deviation (std) calculations, using grep funciton. This returns a numeric/integer vector with the column numbers needed. These vectors are ordered for readability.
7. Combine the vectors for mean and standard deviation column numbers with the numbers 1 and 2 (subject and activity) to get a vector with all the rows needed for the next steps. 
8. Subset the data with the vector created in the previous step.



