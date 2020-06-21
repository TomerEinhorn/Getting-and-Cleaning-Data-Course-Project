## Open needed libraries:
library(data.table)
library(dplyr)
library(utils)

## File download and unzip:

downloadurl <- "https://d396qusza40orc.cloudfront.net/
                getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(downloadurl, "./UCI-HAR-dataset.zip", method="auto")

unzip("./UCI-HAR-dataset.zip")

## Step 1: Merging the training and the test sets to create one data set:

## First of all, we'll read the needed files:

## Read features column:

features <- read.table("./UCI HAR Dataset/features.txt")

## Read X_train & X_test:

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                      col.names=features[,2])
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt",
                     col.names=features[,2])

## Merging the datasets together:

X <- rbind(X_train, X_test)

## Step 2: Extracting only the measurements on the mean and standard deviation 
## for each measurement.

## First, we need to find the columns with means and std:
features <- features[grep("(mean|std)\\(", features[,2]),]

## Then, we add these to a new variable:
X_mean_std <- X[,features[,1]]

## Step 3: Useing descriptive activity names to name the activities
## in the data set:

## We'll read and merge the Y train and test sets:

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                      col.names = c("activity"))
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",
                     col.names = c("activity"))
y <- rbind(y_train, y_test)

## Now, We'll read the activity labels table and match the proper activity to 
## each of the observations:

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

for (index in 1:nrow(activity_labels)){
  activity_index <- as.numeric(activity_labels[index, 1])
  activity_name <- as.character(activity_labels[index, 2])
  y[y$activity == activity_index] <- activity_name
}

## Step 4: Appropriately labeling the data set with descriptive variable names:
## To do so, we'll bind y & X and y & X_mean_std
X_activity_labels <- cbind(y, X)

X_mean_std_activity_labels <- cbind(y, X_mean_std)

## Step 5: From the data set in step 4, creating a second, 
## independent tidy data set with the average of each variable 
## for each activity and each subject.

## Reading the subject file for the train and test sets:

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                           col.names = c('subject'))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                            col.names = c('subject'))

## Merging the subject sets together:

subject <- rbind(subject_train, subject_test)

## Calculating the averages and making the tidy data data frame:

tidyData <- aggregate(X, by = list(activity = y[,1], subject = subject[,1])
                      , mean)

## Writing tidyData into a text file:

write.table(tidyData, file = "Tidy.txt", row.names = FALSE)




