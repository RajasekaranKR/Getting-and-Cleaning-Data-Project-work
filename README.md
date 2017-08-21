# Getting and Cleaning Data Courseera Project work
This is the course project for the getting and Cleaning data courseera course. The R script , run_analysis.R does the following:
1. Download the dataset if does not already exist in the working direction
2. Load the activity and feature info
3. Load both the training and test datasets, keeping only those columns which reflect a mean or stadard deviation
4. Loads the activity and subject data for each dataset and merge those columns in the data set.
5. Merge the two datasets
6. Converts  the activity and subject column into factors
7. Creates a tidy data set that consists of the average (mean) value of each variable for each subject and activity pair
The end result is shown in the file tidy.txt