# runAnalysis.R

# Course code: get-032

# Joseph C. Mushi (University of Dar es Salaam, Tanzania)
#-----------------------------------------------------------------------------------------------------

# Qn. 1: Merge the training and the test sets to create one data set.

# set working directory:
# The downloaded file has extracted into created folder for the project
setwd('/home/jcmushi/R/getdata-project/')

# Read data into table format from the following file:
# features.txt, activity_lables.txt, subject_train.txt, X_train.txt and y_train.txt
features = read.table('./features.txt', header = FALSE)
activityLables = read.table('./activity_labels.txt', header = FALSE)
subjectTrain = read.table('./train/subject_train.txt', header = FALSE)
xTrain = read.table('./train/X_train.txt', header = FALSE)
yTrain = read.table('./train/y_train.txt', header = FALSE)

# give names to columns of read files 
colnames(activityLables) = c('activityID', 'activityLable')
colnames(subjectTrain) = "subjectID"
colnames(xTrain) = features[,2] 
colnames(yTrain) = "activityID"

# Merge yTrain, subjectTrain, xTrain to bind finalTraining dataset
trainingData = cbind(yTrain, subjectTrain, xTrain)

# Now, read test data
subjectTest = read.table('./test/subject_test.txt', header = FALSE)
xTest = read.table('./test/X_test.txt', header = FALSE)
yTest = read.table('./test/y_test.txt', header = FALSE)

# give names to columns of test files 
colnames(subjectTest) = "subjectID"
colnames(xTest) = features[,2]
colnames(yTest) = "activityID"


# Merge xTest, yTest, subjectTest to create finalTest dataset 
testData = cbind(yTest,subjectTest,xTest)


# Merge Training and Test Dataset to create merged dataset called finalData dataset
finalData = rbind(trainingData,testData)

# Set vector for column names to be used in Qn. 2
colnames  = colnames(finalData)

# Qn. 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
logicalVector = (grepl("activity..", colnames) | grepl("subject..", colnames) | grepl("-mean..", colnames) & !grepl("-meanFreq..", colnames) & !grepl("mean..-", colnames) | grepl("-std..", colnames) & !grepl("-std()..-", colnames))

# Subset finalData based on the logicalVector to keep only desired columns
finalData = finalData[logicalVector==TRUE]

# Qn. 3: Uses descriptive activity names to name the activities in the data set

# Merge the finalData dataset with acitivityLables to set descriptive names for activities
finalData = merge(finalData, activityLables, by='activityID', all.x = TRUE)

# Update column-Names vector based on descriptive names for activities
colnames  = colnames(finalData)

# Qn. 4: Appropriately labels the data set with descriptive variable names. 

# Clean variable names
for (i in 1:length(colnames)) 
{
  colnames[i] = gsub("\\()", "", colnames[i])
  colnames[i] = gsub("-std$", "StdDev", colnames[i])
  colnames[i] = gsub("-mean", "Mean", colnames[i])
  colnames[i] = gsub("^(t)", "time", colnames[i])
  colnames[i] = gsub("^(f)", "freq", colnames[i])
  colnames[i] = gsub("([Gg]ravity)", "Gravity", colnames[i])
  colnames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)", "Body", colnames[i])
  colnames[i] = gsub("[Gg]yro", "Gyro", colnames[i])
  colnames[i] = gsub("AccMag", "AccMagnitude", colnames[i])
  colnames[i] = gsub("([Bb]odyaccjerkmag)", "BodyAccJerkMagnitude", colnames[i])
  colnames[i] = gsub("JerkMag", "JerkMagnitude", colnames[i])
  colnames[i] = gsub("GyroMag", "GyroMagnitude", colnames[i])
}

# Give new descriptive column names to the finalData set
colnames(finalData) = colnames

# Qn. 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Create new dataframe without lables on its columns
finalDatawithoutLables  = finalData[, names(finalData) != 'activityLables']

# Summarizing the dataframe to include mean of variables for each activity and each subject
tidyData = aggregate(finalDatawithoutLables[, names(finalDatawithoutLables) != c('activityID','subjectID')], by=list(activityID = finalDatawithoutLables$activityID, subjectID = finalDatawithoutLables$subjectID), mean)

# Merging tidyData with lables to set descriptive names for acitvities
tidyData = merge(tidyData, activityLables, by = 'activityID', all.x = TRUE)

# Export the tidyData in txt format for submission
write.table(tidyData, "./tidyData.txt", row.names = FALSE, sep = "  ")

# Export the tidyData in machine-readable CSV format 
write.table(tidyData, "./tidyData.csv", row.names = FALSE, sep = ",")
