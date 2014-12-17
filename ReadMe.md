###Read Me for Getting and Cleaning Data Course Project
Author: Bart Ford  
Date: December 17, 2014

###Background
Data was collected from the motion detection hardware (accelerometer and gyroscope) of a Samsung Galaxy SII smartphone worn by 30 subjects each performing 6 different activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

For each combination of subject and activity the average mean value and average standard deviation are reported for each set of measurements of 33 variables collected or calculated from the raw accelerometer/gyroscope data.

###Manipulation of data.

Raw data files of subject identifiers, corresponding activities and coresponding measurments were downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. These data sets were read into R and combined into one data frame.

The names of the variables were improved so that they did not contain duplicates or illegal characters and were descriptive. The names of the measurement variables were dirived from the features.txt and features_info.txt documents included with the data sets.

The Activity variables were given descriptive names based on the activity_labels.txt document.

Using the dplyr package, the mean and standard deviation variables were selected out. Then, grouped by Subject and Activity, the average of each of these variables was calculated and reported in the data table "means_tbl". 
