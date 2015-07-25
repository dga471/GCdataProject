# README for Getting and Cleaning Data Course Project
Daniel Ang  
July 25, 2015  

#Basic Description
The script included in the GCdataProject Github repo is called "run_analysis.R". In order for it to successfully work, the Samsung data must first be downloaded from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> (as specified in the course project outline) and the file unzipped, such that the folder "UCI HAR Dataset" is in the working directory. This readme will describe, step-by-step, the actions of the script when it is run.

#Part 1: Importing the Dataset
The scripts imports the data from the relevant text files using the read.txt function. The files "X_test.txt","Y_test.txt",and "subject_test.txt" are read for both the train and test data sets. This is the main part of the data. The script also reads in "features.txt", which gives the names for the 561 variables, and "activity_labels.txt", a text file that gives the legend for the different activity names (WALKING, WALKING_UPSTAIRS,etc.). The activity names were previously labeled with a factor consisting of levels 1 to 6, so this text file will be useful to decode the activity name corresponding to these levels later.

#Part 2: Merging the Datasets
The script merges the testing and training data sets using the rbind() function. Both datasets have the same number of columns, so we can think of it as just adding rows of the training data set to the testing data set. This new combined data set is called  `maindata`.

After this, the script adds a few features to `maindata`. It appends a column called `ActName` that tells us what activity each entry corresponds to, then the column `SubjectID`, telling us what subject performed the actions leading to the data of each entry, and `ExpType`, telling us where the entry came from - the testing or training data set. Along the way, we convert the numbers of the textfile "y_text" into activity names via the code obtained from "activity_labels.txt" earlier, so that instead of numbers, we can see the actual activity names in the `ActName` column. By doing this we effectively complete Step 4 specified in the course project outline. The `ExpType` column is not required for this project, but I thought it would be neat to keep track of this variable if one were to actually use this data analysis in the real world.

#Part 3: Extracting Relevant Columns
Next, the script selects the columns of `maindata` that have to do with mean or standard deviation. We do this by using the `grepl` function, looking for any variable names which have the phrase "main" or "std" in them. This more specific dataset is put in the variable `specdata`. Note that `specdata` still contains the `ActName`,`SubjectID`, and `ExpType` columns in addition to the mean and std columns. This results in a total of 82 variables (79 original observable columns + 3 appended columns from part 2).

#Part 4: Renaming Activity Types with Descriptive Names
This is specified as step 4 in the course project outline. But we already did this in part 2 using this script, so there is no need to add any more in this part.

#Part 5: Cleaning Up the Variable Names
In this part, the script cleans up the remaining 82 variable names. We want variable names which are clear, not filled with redundant information, and not too long. Among the things we do are:

* Getting rid of the word "Body" in the variable names since it's redundant: almost all the variables have "Body" in them, with the exception of the "Gravity" ones, for which we will leave the "Gravity" part intact.
* Shortening "Gravity" to "Grav"
* Lenghening "Acc" to "Accel"
* To differentiate normal and FFT data, we add the suffix "FFT" to the latter, and have nothing special for the former.
* Getting rid of redundant dots

The renewed set of variable names, `namevec`, is then applied to the actual set of variable names.

#Part 6: Create an Additional Tidy Data Set of Averages
This is step 6 in the course project outline, and this data set we create is the one we will upload to the course website. The script outputs the data in "wide form". This is accomplished using the `aggregate()` function applied to `specdata`: we aggregate or group the data based on every combination of `ActName` and `SubjectID`. As there are 6 different acts and 30 different people who participated, this results in 180 rows in the new data set. There are 79 columns. This new dataset is put into the variable `newdataset`. In order for this section to run properly, the `dplyr` library must be installed. We use this library as it makes selecting certain columns easier.

#Part 7: Export the Data Into a Text File
Finally, the script exports the data into a text file called "newtidydataset.txt"", which is saved into the same directory as the script. Following the course project outline, we also used the option of `row.names = FALSE`. The file "CodeBook.md" in the GitHub repository elaborates more explicitly about what each column of this new data set contains.
