## Getting and Data Cleaning Course - Week 4 Assignment - Codebook  
Author: Luccas Betton  
Date: 28/03/2020

This document presents the process to convert raw data in tidy data collected from the accelerometers from the Samsung Galaxy S smartphone.  

### 1. Raw Data Download

Check if the directory *./UCI HAR Dataset* exists. If not exists, first it will check if the zip file exists, and if not, it's downloaded from the path *https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip*.  
Lastly, the zip file is unziped in the directory *./UCI HAR Dataset*.
 
### 2. Features and Activity Labels

Import the following information in the variables:  
* features - Variable with the features identification. Definition of each variable measured or calculated during the test or train trials.
* activitylbl - Activity Labels indentification

### 3. Test Data

Import the Test Data files in the variables:
* subjecttest - Subjects identification for each measurement from the test data. Each row identifies the subject who performed the activity for each measurement. Its range is from 1 to 30.  
* xtest - Test Data.  The test data variables is renamed with the features identification
* ytest - Type of Activity for each measurement from test data. The Activity number is updated by its properly label from activitylbl variable

Combine Test Data with subjects identification and type of activity. Also, it was created a new column to specifiy that this data is from test raw data.  
* test_data - Complete test data in a tidy format

### 4. Train Data

Import the Train Data files in the variables:
* subjecttrain - Subjects identification for each measurement from the train data. Each row identifies the subject who performed the activity for each measurement. Its range is from 1 to 30.  
* xtrain - Train Data.  The train data variables is renamed with the features identification
* ytrain - Type of Activity for each measurement from train data. The Activity number is updated by its properly label from activitylbl variable

Combine Train Data with subjects identification and type of activity. Also, it was created a new column to specifiy that this data is from train raw data.  
* train_data - Complete train data in a tidy format

### 5. Merge Test and Data  

Combine test and train data
total_data - Tidy data with test and train measurements

### 6. Mean and Standard deviation

Resume total data (test and train data) just for variables with mean or standard deviation information.  
* features_meanstd - Labels from variables that was calculated mean or standard deviation 
* total_data_meanstd - Tidy data with mean and standard deviation of total data

### 7. Average of each variable
Calculate average of each variable from variable *total_data_meanstd*
* total_data_mnst_gr - Group total data with just mean and standard deviation variables by subject and type of activity
* resume_data_mnst - Tidy data with average for each variable divided by subject and type of activity

Finnaly, the Text File *tidyDataSet* contains the independent tidy data with average for each variable divided by subject and type of activity.
