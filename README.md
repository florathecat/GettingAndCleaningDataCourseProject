GettingAndCleaningDataCourseProject
===================================

This repository contains an R script called "run_analysis.R" in which it fulfills the course project of the coursera course "Getting and Cleaning Data".

The script first checks for the presence of the project folder. If the folder is not there, it creates one.

Next, the script checks for the presence of the raw data. If the raw data doesn't exist, it downloads it from the given url and unzip it.

After extracting the raw data, the script reads each of the three data frames from the train and test subfolder, comebine the three data frames into one, and gives them appropriate column names based on the "readme.txt" and "featuresinfo.txt" in the raw data folder.

Then the script does what the project assignment instructs:

1. Merges the training and the test sets to create one data set.(data frame CombinedData)

2. Extracts only the measurements on the mean and standard deviation for each measurement. (data frame MeasurementsMeanStd)

3. Uses descriptive activity names to name the activities in the data set
   Replace the codes of numbers 1-6 with activity labels provided in the raw dataset.
   
4. Appropriately labels the data set with descriptive variable names 
   I am not particularly creative about this. Just wrote the script to make the column names longer. Also I kind of prefer that the dataset sorted by subject and activity. So I did that, too. (data frame sortedData)

5. Creates a second, independent tidy data set with the average of 
   each variable for each activity and each subject. 
   write the sortedData dataset into a txt file called TidyData.txt since the homework submission page only supports txt, pdf, and image file formats.

