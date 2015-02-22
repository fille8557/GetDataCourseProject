##load data
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

## get column names from features file
features <- read.table("UCI HAR Dataset/features.txt")
features$V2 <- as.character(features$V2)
names(train_x) <- features$V2
names(test_x) <- features$V2

##assign column names to y and subject
names(train_y) <- "activity"
names(test_y) <- "activity"
names(train_subject) <- "subject"
names(test_subject) <- "subject"

## combine data into test and train sets, then combine into one
alltrain <- cbind(train_subject, train_y, train_x)
alltest <- cbind(test_subject, test_y, test_x)
alldata <- rbind(alltrain, alltest)

##find columns needed for mean and std
findmean <- grep("mean", names(alldata), fixed=TRUE)
findstd <- grep("std", names(alldata), fixed=TRUE)
##add columns 1 and 2 for subject and activity
findall <- c(1,2, sort(c(findmean, findstd)))

##just the mean and std
gooddata <- alldata[, findall]

##change activity labels in alldata
library(car)
gooddata$activity <- recode(gooddata$activity, "1='WALKING'; 
                           2='WALKING_UPSTAIRS'; 
                           3='WALKING_DOWNSTAIRS'; 
                           4='SITTING'; 5='STANDING'; 6='LAYING'")

##average of each variable by activity and subject
library(plyr)
library(reshape)

tidydata <- ddply(gooddata, .(subject, activity), numcolwise(mean))
tidydata2 <- melt(tidydata, id=c("subject", "activity"))
names(tidydata2) <- c("subject", "activity", "measurement", "mean")
head(tidydata2)
