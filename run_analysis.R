
### Loading required packages ###
#plyr - used in last part of the assignment
library(plyr)

###############################
### Reading raw data into R ###
###############################

###1. Reading training dataset and activity labels for this dataset into R ###

setwd("C:/Users/Monika/Documents/DS_Specialization_Coursera/Getting & Cleaning Data course/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train")
train_dataset <- read.table("X_train.txt")
train_activity_label <- read.table("y_train.txt")
#unique(train_activity_label)
train_subject <- read.table("subject_train.txt")

###2. Reading test dataset and activity labels for this dataset into R ###

setwd("C:/Users/Monika/Documents/DS_Specialization_Coursera/Getting & Cleaning Data course/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test")
test_dataset <- read.table("X_test.txt")
test_activity_label <- read.table("y_test.txt")
#unique(test_activity_label)
test_subject <- read.table("subject_test.txt")

###3. Reading column lables and activity names for both dataset into R ###

setwd("C:/Users/Monika/Documents/DS_Specialization_Coursera/Getting & Cleaning Data course/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset")
column_labels <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt",stringsAsFactors = FALSE)

#########################
### Data manipulation ###
#########################

###1. Adding column names to train and test datasets ###

names(train_dataset)<-column_labels[,2]
names(test_dataset)<-column_labels[,2]
names(train_activity_label)<-  "activity_label"
names(test_activity_label)<-  "activity_label"

###2. Identifying columns containing mean and std and dropping other columns in train and test datasets ###

mean_Columns <- grep("mean()",column_labels$V2)
std_Columns <- grep("std()",column_labels$V2)
mean_std_Columns <- c(mean_Columns,std_Columns)
#length(mean_Columns)
#length(std_Columns)
#length(mean_std_Columns)

train_dataset_mean_std<- train_dataset[,mean_std_Columns]
test_dataset_mean_std<- test_dataset[,mean_std_Columns]


###3. Matching activity name with activity label in both: train and test datasets ###

# if statements below create new column "activity" and assign activity name depending on value in column "activity_label"
test_activity_label$activity <- ifelse(test_activity_label$activity_label==1,activity_labels[1,2],
                                       ifelse(test_activity_label$activity_label==2,activity_labels[2,2],
                                              ifelse(test_activity_label$activity_label==3,activity_labels[3,2],
                                                     ifelse(test_activity_label$activity_label==4,activity_labels[4,2],
                                                            ifelse(test_activity_label$activity_label==5,activity_labels[5,2],
                                                                   ifelse(test_activity_label$activity_label==6,activity_labels[6,2],0))))))

train_activity_label$activity <- ifelse(train_activity_label$activity_label==1,activity_labels[1,2],
                                        ifelse(train_activity_label$activity_label==2,activity_labels[2,2],
                                               ifelse(train_activity_label$activity_label==3,activity_labels[3,2],
                                                      ifelse(train_activity_label$activity_label==4,activity_labels[4,2],
                                                             ifelse(train_activity_label$activity_label==5,activity_labels[5,2],
                                                                    ifelse(train_activity_label$activity_label==6,activity_labels[6,2],0))))))


###4. Joining activity datasets with mean and std datasets for train and test datasets 
train_dataset2 <- cbind(train_activity_label,train_dataset_mean_std)
test_dataset2 <- cbind(test_activity_label,test_dataset_mean_std)

###5. Combining train and test data
full_dataset <- rbind(test_dataset2,train_dataset2)

###6. Dropping "activity_label" column in full dataset

full_dataset_2 <- full_dataset[,-1]

###7. Adding information about subject and generating new table with summarised data###
full_subject <- rbind(test_subject,train_subject)
names(full_subject) <-"subject"

full_dataset_3 <- cbind(full_subject,full_dataset_2)

dataset_aggregated <-aggregate(. ~subject + activity, full_dataset_3, mean)

####################################################
### Writing output data ###
####################################################

setwd("C:/Users/Monika/Documents/DS_Specialization_Coursera/Getting & Cleaning Data course/getdata%2Fprojectfiles%2FUCI HAR Dataset/")
write.table(dataset_aggregated, file = "tidydata.txt",row.name=FALSE)
