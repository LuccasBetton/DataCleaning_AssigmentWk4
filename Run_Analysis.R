### Getting and Cleaning Data - ASSIGNMENT 4 
## Author: Luccas Betton
## Date: 28/03/2020

## Libraries necessary for Script Running
library(dplyr)
library(plyr)

## Raw data Download

directory <- "./UCI HAR Dataset"
if(!dir.exists(directory)){
    if(!file.exists("./UCI HAR Dataset.zip")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, destfile = "UCI HAR Dataset.zip", method = "curl")
    }
    unzip("./UCI HAR Dataset.zip")
}

# Read list of all features
features <- read.table("./UCI HAR Dataset/features.txt")

#Activity Labels indentification
activitylbl <- read.table("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)

## Read Test Data
# Read the subsjects file. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

xtest <- read.table("./UCI HAR Dataset/test/X_test.txt") # Test Data
names(xtest) <- features$V2 #Rename xtest columns by features vector

ytest <- read.table("./UCI HAR Dataset/test/y_test.txt") # Test's Activities
ytest$V1 <- activitylbl[ytest$V1,2] #Rename Activity number by its label
    
# Mutate Test Data with subjects identification and type of activity. Also, it was created a new column to specifiy that this data is from testing set.
test_data <- cbind(subject = subjecttest$V1,typeofactivity = ytest$V1,xtest,DataType = rep("Test",nrow(xtest)))

## Read Train Data

# Read the subsjects file. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Read train's data and  training activities 
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt") # Train Data
names(xtrain) <- features$V2 #Rename xtrain columns by features vector

ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
ytrain$V1 <- activitylbl[ytrain$V1,2] #Rename Activity number by its label

# Mutate Train Data with subjects identification and type of activity. Also, it was created a new column to specifiy that this data is from trainning set.
train_data <- cbind(subject = subjecttrain$V1,typeofactivity = ytrain$V1,xtrain,DataType = rep("Train",nrow(xtrain)))

# Complete data with test and train data
total_data <- rbind(test_data,train_data)

# Data with mean and standard deviation calculation
features_meanstd <- grep('mean\\()|std\\()',features$V2,value = TRUE)

# Resume total data (test and train data) just for vaiables with mean or standard deviation information
total_data_meanstd <- total_data[,c("subject","typeofactivity",features_meanstd)]

# Grouped total data by subject and type of activity  
total_data_mnst_gr <- group_by(total_data_meanstd,subject,typeofactivity)

# Average of each variable by each subject and each activity
resume_data_mnst <- summarise_all(total_data_mnst_gr,funs(mean))

# Write Text File with Independent tidy data set with the average of each variable for each activity and each subject.
write.table(resume_data_mnst, file = "tidyDataSet.txt", row.names=FALSE)
