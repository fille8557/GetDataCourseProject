# GetDataCourseProject
Repository for the coursera "Getting and Cleaning Data" course project. 

## Data processing
1. Data is loaded into R: same process for test files and train files
X files are the measurements, Y files are the activities and Subject files are the subjects.
X dataset is the biggest: 2947 rows by 561 columns. Y and Subject datasets are both 2947 rows with a single column.

2. Get column names for the X dataset (measurements) from the features.txt file. 
features dataset is 561 rows of 2 columns. The second column is the names corresponding to the column names of the X dataset

3. Change column name in Y dataset to "activity" and Subject dataset to "subject".

4. Combine X, Y, and Subject datasets using cbind.



