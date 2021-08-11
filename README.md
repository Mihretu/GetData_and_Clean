---
title: "A readme file on the project for getting and cleaning data"
author: "Alemu Tadesse"
date: "8/11/2021"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
## First download the data required for this project

To download data files for processing from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
(by just clicking and placing the zip file in c:data or whereever is conveient). In this read me file the directory will be assumed to be c:/data
The downloaded files have names X_test.txt, y_test.txt, X_train.txt, Y_train.txt, features.txt, activity_labels.txt, subject_test.txt, subject_train.txt. Detail description of the dataset can be found here https://github.com/ethen8181/Getting-Cleaning-Data-Course-Project

## The goal of this project are to accomplish the following items 

* Merge the training and the test sets to create one data set.
* Extract only the measurements on the mean and standard deviation for each measurement. 
* Use descriptive activity names to name the activities in the data set
* Appropriately label the data set with descriptive variable names. 
* Create a second, independent tidy data set with the average of each variable for each activity and each subject

## The following steps are taken in the run_analysys script to accomplish the above tasks 

1. Read the test ( X_test and Y_test) and train (X_train and Y_train), feature, activity labels and subject (for test and train datasets) files and store the data in the corresponding variable names (example X_test, Y_test...)
2. Rename the X_test and X_train columns with features 

3. Extract only the measurements (X_test and X_train) on the mean and standard deviation for each measurement. 
4. Extract the Activity labels dataset for activity id (which is the first column of Y_test and Y_train )  and assign the values to the second columns of the Y_test and Y_train
5. Rename the Y_test and Y_train  dataframe columns as "ActivityID" and "ActivityLabel" (for 1st and second columns respectively)
6. Combine (column wise - using cbind) X_test and Y_test and also append subject_id as the first column of the combined dataset
7. Combine (Columns wise) X_train and Y_train and also append subject_id as the first column of the combined dataset
8. Combine the datasets in 7 and 8 to make one long dataframe (using rbind)
9. Rename the columns of the measurement columns of dataframe in 9 with more descriptive name. Using commands such as 
names(combined_Dataset)<-gsub("Gyro", "Gyroscope", names(Combined_dataset))

10. Create independent tidy data set with the average of each variable for each activity and each subject of the dataset in 11.
