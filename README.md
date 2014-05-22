# Getting and Cleaning Data Course Project

## Contents

This is the repository for the Getting and Cleaning Data Course Project on Coursera.

The following files are available:

README.md      - this file
run_analysis.R - downloads the data and does all processing (includes comments)
tidydata.csv   - the output of run_analysis.R
CodeBook.md    - a description of tidydata.csv's format

## Task

Here are the data for the project:

[Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The script does the following:

1. Download the data file if it doesn't exist in the current working directory
2. Unzip the data file if the directory doesn't already exist
3. Read the data from X_train.txt, y_train.txt and subject_train.txt
4. Read the data from X_test.txt, y_test.txt and subject_test.txt
5. Read the column names from features.txt and convert them to lower case. Also remove all non-letter-characters.
6. Read all activity names from activity_names.txt
7. Substitute all activity indices with their names
8. Add y_train and subject_train as columns to the train dataset
9. Add y_test and subject_test as columns to the test dataset
10. Combine the train and test datasets
11. Filter all columns that contain either "mean" or "std" in their column names
12. Create a tidy dataset with the average of all those variables per activity and subject
13. Write that dataset to a file "tidydata.csv"



