---
title: "CodeBook"
author: "MoonikaZ"
date: "20 August 2016"
output: html_document
---

This document describes the R code contained in run_analysis.R file.  
Code consists of three parts:

###Reading raw data into R

#####1. Reading training dataset and activity labels for this dataset into R
#####2. Reading test dataset and activity labels for this dataset into R
#####3. Reading column lables and activity names for both dataset into R
    As a result below tables are created:
    (1) train_dataset
    (2) train_activity_label
    (3) train_subject
    (4) test_dataset
    (5) test_activity_label
    (6) test_subject
    (7) column_labels
    (8) activity_labels

###Data manipulation

#####1. Adding column names to train and test datasets
    Dataset (7) is used as column names for (1) & (4)
#####2. Identifying columns containing mean and std and dropping other columns in train and test datasets
    Function grep() is used to identify desired columns. 
    After dropping other columns two data frames are created:
    (9) train_dataset_mean_std 
    (10) test_dataset_mean_std
#####3. Matching activity name with activity label in both: train and test datasets
    Ifelse statement is used here to create new column "activity" in tables (2) & (5) and assign activity name        depending on value in column "activity_label"

#####4. Joining activity datasets with mean and std datasets for train and test datasets 
    Function cbind is used to join (2) & (9) and (5) & (10).
    This results in:
    (11) train_dataset2
    (12) test_dataset2
#####5. Combining train and test data
    (11) & (12) are joint by rbind function and five:
    (13) full_dataset
#####6. Dropping "activity_label" column in full dataset
    This operation creates:
    (14) full_dataset_2
#####7. Adding information about subject and generating new table with summarised data
    Join (3) & (6) via rbind function (in the same order as (11) & (12)) and creates:
    (15) full_subject
    Then cbind (15) and (14) and generate:
    (16) full_dataset_3,
    which is used to create:
    (17) dataset_aggregated,
    containing averages of each variable for each activity and each subject.


###Writing output data
#####Last dataset is saved into "tidydata.txt"" file
