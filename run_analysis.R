library(data.table)
library(dplyr)
library(tools)
library(crayon)

# Get features and activities names
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("id", "name"))
## Cleaning features names
cleanFeaturesName <- function(str) {
  str <- gsub("[-(),]", "_", str)
  str
}
features$name <- sapply(features$name, cleanFeaturesName)

# Read the train subjects, values and labels and create a data table with it
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("val"))
train_X <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$name)
train_y <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("val"))
train <- data.table(activity = train_y$val, subject = train_subject$val, train_X)

# Read the test subjects, values and labels and create a data table with it
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("val"))
test_X <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$name)
test_y <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("val"))
test <- data.table(activity = train_y$val, subject = train_subject$val, train_X)

##### STEP 1 #####
# Join the train and test data set
dataset <- rbind(train, test)

##### STEP 2 #####
# Select only the mean and stds of each value 
dataset <- select(dataset, activity, subject, matches(".*(mean|std)_.*", ignore.case = FALSE))

##### STEP 3 #####
# Replace activities number by their names
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "name"))
convertActivityNumberToName <- function(num) {
  name <- activities$name[activities$id == num]
  name
}
dataset$activity <- sapply(dataset$activity, convertActivityNumberToName)

##### STEP 4 #####
# Name the variables of the dataset
## This step has been taken in account in all the steps above. Therefore, only a name cleaning for the complex features name is necessary.
cleanColNames <- function(name) {
  name <- gsub("_"," ", name)
  name <- gsub("   "," ", name)
  name <- trimws(name)
  name
}
names(dataset) <- sapply(names(dataset), cleanColNames)

write.table(dataset, "dataset_step_4.txt")

##### STEP 5 #####
# Creating a dataset with the mean of each variable grouped by activity and then subject.
by_activity_subject <- group_by(dataset, activity, subject)
dataset5 <- summarise_all(by_activity_subject, mean)

write.table(dataset5, "dataset_step_5.txt", row.names = FALSE)



