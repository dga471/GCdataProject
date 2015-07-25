#Getting and Cleaning Data: Course Project

#We assume that we have downloaded and unzipped the data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", such that we have a folder called "UCI HAR Dataset" in the working directory. The folders "test" and "train" are in this folder.

#PART 1: IMPORTING THE DATASET
#We first import both the training and test data into the program:

actlab <- read.table("UCI HAR Dataset/activity_labels.txt") #a code describing the 6 different activities done when taking the data
featlab <- read.table("UCI HAR Dataset/features.txt",stringsAsFactors = FALSE) #a vector of the names of the variables for each entry

namevec = featlab[,2] #take second column which has the actual variable names

#Test data
testdatax <- read.table("UCI HAR Dataset/test/X_test.txt",stringsAsFactors = FALSE,col.names = namevec) #when importing, labels the columns using namevec immediately
testdatay <- read.table("UCI HAR Dataset/test/Y_test.txt")
testsubj <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Train data
traindatax <- read.table("UCI HAR Dataset/train/X_train.txt",stringsAsFactors = FALSE,col.names = namevec)
traindatay <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainsubj <- read.table("UCI HAR Dataset/train/subject_train.txt")


# PART 2: MERGING THE DATASETS, AND ADDING COLUMNS TO CLARIFY DATA (AND ALSO ADDING APPROPRIATE ACTIVITY NAMES)
#merge the two datasets, which have the same columns.
maindata <- rbind(testdatax,traindatax)
#As a result we now have a 561-column data set with 7352 + 2947 = 10299 rows

#now to give identifiers for the activity type, whether the entry comes from the training or testing data set, etc.

testdatay <- as.data.frame(testdatay) #convert to data frame
traindatay <- as.data.frame(traindatay)

#ADD ACTIVITY LABELS. THIS ALSO COMPLETES STEP 4 IN THE COURSE PROJECT OUTLINE
names(testdatay) = "ActName"
names(traindatay) = "ActName"
mainactlab <- rbind(testdatay,traindatay)
maindata$ActName <- factor(mainactlab[[1]],levels = 1:6,labels = actlab$V2) #now the 1 to 6 are given the labels WALKING, WALKING_UPSTAIRS, etc., and then added as a new column to the main dataset

#ADD SUBJECT ID
maindata$SubjectID <- rbind(testsubj,trainsubj)

#ADD EXPERIMENT TYPE (test/train)
etypetest = data.frame(rep("test",nrow(testdatax)))
etypetrain = data.frame(rep("train",nrow(traindatax)))
names(etypetest) = "ExpType"
names(etypetrain) = "ExpType"
maindata$ExpType <- rbind(etypetest,etypetrain)

#PART 3: EXTRACTING VARIABLES OF MEAN AND STANDARD DEVIATION ONLY
fcomb <- grepl("mean|std|ExpType|ActName|SubjectID",names(maindata)) #find variables with labels containing "mean", "std", "ExpType","ActName", or "SubjectID"

specdata <- maindata[,fcomb] #take columns of maindata which contain mean or std in their variable name

#PART 4: RENAMING ACTIVITY TYPES WITH DESCRIPTIVE NAMES
#Already did this in Part 2, when we appended the ActName column and replaced the numbers 1-6 with the appropriate activity names (WALKING,WALKING_UPSTAIRS,etc)

#PART 5: CLEANING UP THE VARIABLE NAMES
namevec <- names(specdata)
namevec <- gsub("tBody","",namevec) #get rid of "Body" since it's redundant: almost all the variables have "Body" in them, with the exception of the "Gravity" ones, for which we will leave the "Gravity" part intact
namevec <- gsub("tGravity","Grav",namevec) #abbreviate "Gravity"
namevec <- gsub("fBody","FFT",namevec) #replace "f" with "FFT" to clearly indicate that it is derived from a Fast Fourier Transform
namevec <- gsub("Body","",namevec) 
namevec <- gsub("Acc","Accel",namevec)
namevec <- gsub("...X",".x",namevec)
namevec <- gsub("...Y",".y",namevec)
namevec <- gsub("...Z",".z",namevec)
namevec <- gsub("Mag.mean..","Mag.mean",namevec)
namevec <- gsub("Mag.std..","Mag.std",namevec)
namevec <- gsub("Mag.meaneq..","Mag.meaneq",namevec)#get rid of redundant dots
namevec

names(specdata) <- namevec #apply it to our dataset

#PART 6: CREATE AN ADDITIONAL TIDY DATASET OF AVERAGES
#Here we're going to use the "wide form", where there will be 82 columns, including the averages of 79 mean/std variables (not including the 3 appended columns for ActName, ExpType, and SubjectID). For the first two columns, we will move the columns SubjectID, ActName and ExpType to these columns, placed in that order. In that way, all combinations of the SubjectID and Activity name will be present. Note that the ExpType column is going to disappear as we are not differentiating between training and testing data, although we will keep it in the specdata dataset for future reference if needed (in a hypothetical situation where we are actually doing real-world data analysis using this dataset)

library(dplyr)
specdata$SubjectID = unlist(specdata$SubjectID)
newdataset <- aggregate(select(specdata,-(ActName:ExpType)),list(specdata$ActName,specdata$SubjectID),mean)

#PART 7: EXPORT THE NEW DATASET

write.table(newdataset,"newtidydataset.txt",row.names = FALSE)