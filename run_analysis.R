# run_analysis.R 


#first get data and extract it

if(!file.exists("CourseProject")) {
  dir.create("CourseProject")
}

if(!file.exists("./CourseProject/UCI_HAR_dataset.zip")) {
  ProjUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(ProjUrl, destfile ="./CourseProject/UCI_HAR_dataset.zip")
  unzip("./CourseProject/UCI_HAR_dataset.zip", exdir = "./CourseProject")  
}

features <- as.vector(read.table("./CourseProject/UCI HAR Dataset/features.txt")[[2]])

X_train <- read.table("./CourseProject/UCI HAR Dataset/train/X_train.txt")
 # X_train is the actual data
  names(X_train) <- features

y_train <- read.table("./CourseProject/UCI HAR Dataset/train/y_train.txt")
 # y_train.txt is a list of activity labels, i.e. "walking", "sitting",etc.
  names(y_train) <- "Activity"

TrainSubject <- read.table("./CourseProject/UCI HAR Dataset/train/subject_train.txt")
 # TrainSubject is a list of subjects; there are 21 people randomly selected from the original 30 subjects
 # the 30 people are assigned no.1-30 and the train subject codes do not overlap with test subject codes
  names(TrainSubject) <- "Subject"

train <- cbind(TrainSubject, y_train, X_train)

X_test <- read.table("./CourseProject/UCI HAR Dataset/test/X_test.txt")
  names(X_test) <- features
y_test <- read.table("./CourseProject/UCI HAR Dataset/test/y_test.txt")
  names(y_test) <- "Activity"
TestSubject <- read.table("./CourseProject/UCI HAR Dataset/test/subject_test.txt")
  names(TestSubject) <- "Subject"

test <- cbind(TestSubject, y_test, X_test)

# 1. Merges the training and the test sets to create one data set.

CombinedData <- rbind(train, test)


# 2. Extracts only the measurements on the mean and standard deviation
#    for each measurement.
  A <- rep(c("tBodyAcc", "tGravityAcc", "tBodyAccJerk", "tBodyGyro", "tBodyGyroJerk"), each=6)
  B <- c("mean()", "std()")
  C <- paste(A, B, sep="-")
  D <- rep(c("X", "Y", "Z"), each=2)
  tXYZ <- paste(C, D, sep="-")
  E <- rep(c("tBodyAccMag", "tGravityAccMag", "tBodyAccJerkMag", "tBodyGyroMag", "tBodyGyroJerkMag"), each=2)
  tMag <- paste(E, B, sep="-")
  G <- rep(c("fBodyAcc", "fBodyAccJerk", "fBodyGyro"), each=6)
  H <- paste(G, B, sep="-")
  fXYZ = paste(H, D, sep="-")
  I <- rep(c("fBodyAccMag", "fBodyBodyAccJerkMag", "fBodyBodyGyroMag", "fBodyBodyGyroJerkMag"), each=2)
  fMag <- paste(I, B, sep="-")
  
  featuresMeanStd <- c("Subject", "Activity", tXYZ, tMag, fXYZ, fMag)

  measurementsMeanStd <- CombinedData[, featuresMeanStd]


# 3. Uses descriptive activity names to name the activities in the data set

ActivityLabels <- as.vector(read.table("./CourseProject/UCI HAR Dataset/activity_labels.txt")[[2]])

for (i in 1:length(ActivityLabels)) {
  measurementsMeanStd$Activity[measurementsMeanStd$Activity == i] <- ActivityLabels[i]
}


# 4. Appropriately labels the data set with descriptive variable names 

A2 <- rep(c("totalBodyAcceleration", "totalGravityAcceleration", "totalBodyAccelerationJerk", "totalBodyGyro", "totalBodyGyroJerk"), each=6)
B2 <- rep(c("X_axis", "Y_axis", "Z_axis"), each=2)
C2 <- paste(A2, B2, sep="_")
D2 <- c("Mean", "Stdev")
totalXYZ <- paste(C2, D2, sep="_")
E2 <- rep(c("totalBodyAccelerationMagnitude", "totalGravityAccelerationMagnitude", "totalBodyAccelerationJerkMagnitude", "totalBodyGyroMagnitude", "totalBodyGyroJerkMagnitude"), each=2)
totalMag <- paste(E2, D2, sep="_")
G2 <- rep(c("FdsBodyAcceleration", "FdsBodyAccelerationJerk", "FdsBodyGyro"), times=6)
H2 <- paste(G2, B2, sep="_")
FdsXYZ = paste(H2, D2, sep="_")
I2 <- rep(c("FdsBodyAccelerationMagnitude", "FdsBodyAccelrationJerkMagnitude", "FdsBodyGyroMagnitude", "FdsBodyGyroJerkMagnitude"), times=2)
FdsMag <- paste(I2, D2, sep="_")

newfeatures <- c("Subject", "Activity", totalXYZ, totalMag, FdsXYZ, FdsMag)

names(measurementsMeanStd) <- newfeatures
sortedData <- measurementsMeanStd[order(measurementsMeanStd$Subject, measurementsMeanStd$Activity),]


# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

write.table(sortedData, "./CourseProject/TidyData.txt", sep="\t", row.names = FALSE)
