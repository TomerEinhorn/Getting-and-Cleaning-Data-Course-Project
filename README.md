# Getting-and-Cleaning-Data-Course-Project

# The Goal 

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R file called run_analysis performs the following steps:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The code:
first, we opened the needed packages to reshape our data:

library(data.table)
library(dplyr)
library(utils)

(assuming they are already installed)

then, the original dataset was downloaded from the web and then unzipped:

downloadurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(downloadurl, "./UCI-HAR-dataset.zip", method="auto")

unzip("./UCI-HAR-dataset.zip")

the features.txt, X_test and X_train were loaded into R and then X_train and X_test were merged together (step 1 the script performs as mentioned above):

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

## Step 3: Using descriptive activity names to name the activities
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
  y[y$activity == activity_index,] <- activity_name
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

write.table(tidyData, file = "TidyData.txt", row.names = FALSE)


