# Getting-and-Cleaning-Data-Week-4-Proyect

I will describe and organize this file as my run_analysis.R file.

# STEP 0

In order to have the test and the train dataset that are required for the STEP 1 of the Assignment (Proyect), I must build the datasets that I mentioned earlier.
First, I read the README.md file that was in the UCI HAR Dataset repository from the downloaded ZIP file. The UCI HAR Dataset repository has variables that measured the Acceleration and Gyroscope of 30 subjects that realized 6 different activities (Walk, walk upstairs, walk downstairs, sit, stand and lay)
Second, now that I have some previous knowledge of the dataset that I need to reassemble, I started to upload the .txt files in R.
Third, I assembled the files by its number of columns or rows. My suposition is that the internal signals repository has no use in this Assigment.

# STEP 1

Now that I have both datasets, I merged them into a single one called fusion.

# STEP 2

I obtained the column names of the fusion dataset and filtered the column names that had the word: mean or std.
With the select function I filered the columns that I needed from the fusion dataset.

# STEP 3

The activity column had only the number of activity and I replaced it with the corresponding activity name.

# STEP 4

I renamed the labels of the data set with descriptive variable names. with the sub function

# STEP 5

I made the Tidy Dataset with the mean of each column by activity an subject, obtaining 180 rows.
This was achieved with the melt and dcast function.
