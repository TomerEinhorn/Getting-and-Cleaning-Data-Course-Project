This CodeBook describes all the data manipulation made by the run_analysis.R script and the definitions of all the variable names in the 
tidyData.txt file. 

##Dataset Used:

The data in the run_analysis.R file was obtained from "Human Activity Recognition Using Smartphones Data Set". T

he data linked are collected from the accelerometers from the Samsung Galaxy S smartphone. A 

full description is available at the site http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data was downloaded within the script from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

the downloaded zip file includes the following files:

- X_train.txt contains variable features that were used as the train set.
- y_train.txt contains the activities corresponding to X_train.txt.
- subject_train.txt contains information on the subjects that the data was collected from.
- X_test.txt contains variable features that were used as the test set.
- y_test.txt contains the activities corresponding to X_test.txt.
- subject_test.txt contains information on the subjects that the data was collected from.
- activity_labels.txt contains metadata on the different types of activities.
- features.txt contains the features' names in the data sets.

##Transformations made:

features.txt was read into features
X_train.txt was read into X_train.
X_test.txt was read into X_test.
then the two were merged together into X.
features was transformed to include only the means and std's.
X_mean_std was assigned with features' value.
y_train.txt was read into y_train.
y_test.txt was read into y_test.
then the two were merged together into y.
activity_labels.txt was read into activity_labels.
the proper activity names were assigned to y using the activity_labels indexes.
y and X were binded together columnwise to create X_activity_labels 
and y and x_mean_std were binded together columnwise to create X_mean_std_activity_labels.

subject_test.txt was read into subject_test.txt and subject_train.txt was read into subject_train and then they were merged together
to subject.

then, a tidy data frame named tidyData was created, with the averages aggregated into it, and finally the tidyData was exported into 
a text file named tidyData.txt.

##Output Data Set

The output data TidyData.txt is a a space-delimited value file. The header line contains the names of the variables. 
It contains the mean and standard deviation values of the data contained in the original data set. 


