setwd("/home/peter/Development/Courses/Data Science Track/3-Getting and Cleaning Data/Project")

# download and unzip the required data if it doesn't exist
dataset_filename <- "UCI_HAR_Dataset.zip"
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataset_dir <- "UCI HAR Dataset"

if (!file.exists(dataset_filename)) {
  download.file(dataset_url, dataset_filename, method="curl", mode="w", quiet=TRUE)
}
if (!file.exists(dataset_dir)) {
  unzip(dataset_filename)  
}

# open the required files
train <- read.table(paste(dataset_dir, "train/X_train.txt", sep="/"), header=FALSE)
train_y <- read.csv(paste(dataset_dir, "train/y_train.txt", sep="/"), header=FALSE)
train_s <- read.csv(paste(dataset_dir, "train/subject_train.txt", sep="/"), header=FALSE)
test <- read.table(paste(dataset_dir, "test/X_test.txt", sep="/"), header=FALSE)
test_y <- read.csv(paste(dataset_dir, "test/y_test.txt", sep="/"), header=FALSE)
test_s <- read.csv(paste(dataset_dir, "test/subject_test.txt", sep="/"), header=FALSE)

# read features.txt and use its content as column names for the dataset
colnames <- read.table(paste(dataset_dir, "features.txt", sep="/"), header=FALSE)
colnames$V2 <- gsub("[^a-z]", "", tolower(colnames$V2))
names(train) <- colnames$V2
names(test) <- colnames$V2

# read activity labels and label the activities
activity_names <- read.table(paste(dataset_dir, "activity_labels.txt", sep="/"), header=FALSE)
train_y_names <- activity_names[train_y[,],]$V2
test_y_names <- activity_names[test_y[,],]$V2

# merge the 3 train datasets by adding y and s as additional columns
train["subject"] <- train_s
train["activity"] <- train_y_names

# merge the 3 test datasets by adding y and s as additional columns
test["subject"] <- test_s
test["activity"] <- test_y_names

# merge the test and train datasets by rows
dataset <- rbind(train, test)

# get column indices for all columns containing "mean" or "std"
columns <- c(grep("std", colnames$V2), grep("mean", colnames$V2))
# add the last two columns (subject and activity)
columns <- c(columns, ncol(dataset) -1, ncol(dataset))

# extract those columns
dataset <- dataset[columns]

# create a tidy dataset with the average of each variable for every subject and activity
tidy_dataset <- aggregate(dataset[,1:(ncol(dataset)-2)], FUN=mean, by=list(dataset$activity, dataset$subject))
names(tidy_dataset)[1] = "activity"
names(tidy_dataset)[2] = "subject"

# write the tidy dataset
write.csv(tidy_dataset, "tidydata.csv")
