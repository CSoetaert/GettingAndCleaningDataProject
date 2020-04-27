# GettingAndCleaningDataProject
This repository contains the final project of the Getting and Cleaning Data course from John Hopkins University on Coursera.

For this project, I modified the data provided by this study http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones the way it is described below. 

## Extracting the features name

First I extracted the features names from the file "features.txt" provided with the data. I cleaned the name from un accepted character, to use them as columns name for the datasets.

## Extracting the data from the train and test set and then join them

Then I extracted the subjects, activities and parameters values from the file for the train and test set. Once I had created a data frame for each of the sets, I joined them in one data set. 

## Keeping only the STD and MEAN values

After that, I selected the parameters representing the mean and std of the observations using a regular expression. 

## Using activity names

Then, I replaced the activity value (number), by there name using the "activity.txt" file provided.

## Cleaning columns names and saving dataset

The next step was to clean the name of the columns to make it more understandable to the human eye and then saving the dataset. 
The name for the parameters keep the same method of naming as for the original dataset. 
Finally, I saved the dataset into a csv file called "dataset_step_4.csv". 

## Summarising the dataset

The final step was to group the data set by activity and then subject and the computing the average of each parameter. This is saved in the "dataset_step_5.csv" file.