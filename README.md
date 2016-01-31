# getting-and-cleaning-data

The run_analysis.R script was created as the final project from Getting and Cleaning Data course from Coursera.
It processes the data from Human Activity Recognition Using Smartphones Data Set (UCI Machine Learning Repository) 
and creates a tidy dataset, merging data and organizing it for a smoother analysis processing.

Its main functions are:
getFilePath - adds to a relative file path the base path to HAR dataset data
assemble.full.dataset - merges train and test dataset into one, adding activity and subject information to measurements,
			and changing variable names to be more readable and according to the usual pattern
select.desired.features - selects only the mean and std (standard variation) measurements from the dataset
set.activity.labels - changes activity codes to labels in dataset for better analysis
summarize.data - groups data by both activity and subject, applying the mean function to the result of each feature column

The script workflow:
1 - Build the dataset (assemble.full.dataset)
2 - Select the mean and std features (select.desired.features)
3 - Set activity names labelling the data measurements
4 - Summarizes data grouping by both activity and subject
5 - Writes generated summarized tidy data to a text file