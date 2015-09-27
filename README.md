==================================================================
# getdata-project
==================================================================
Joseph C. Mushi,
Network and Cyber Security (NCS) REsearch Group,
Departmet of Computer Science, College of ICT,
University of Dar es Salaam,
P. O. Box 33335, Dar es Salaama, Tanzania.
mushyjc(at)gmail.com
==================================================================

This Github Repository contain script that collect, manipulate, and clean dataset to prepare tidy data.

The script is writen in a flow that responds to the order of questions.

=================================================================================================================
In response to question 1, the script:

- set working directory to a folder that contain unzipped files downloaded for the project:

- then read training data from downloaded files into features, activityLables, subjectTrain, xTrain and 
  yTrain variables in table format.

- The script assign names to columns of read files

- The script merge yTrain, subjectTrain, xTrain to create a finalTraining dataset called trainingData

- After work with training data, the script start working on test data by reading the data from downloaded
  files into subjectTest, xTest and yTest variables in table format.

- Likewise, the script give names to columns of test files

- The script merge xTest, yTest, subjectTest to create finalTest dataset called testData

- Having training and test dataset, the script merge these two Dataset to create finalData

- And finally for question 1, the script set vector for column names to be used in Question 2

=================================================================================================================

In response to question 2, the script: 

- creates a logicalVector that contains TRUE values for the ID, mean() and standard deviation() columns 
  and FALSE for others

- the script then subset finalData based on the logicalVector to keep only desired columns

=================================================================================================================

In response to question 3, the script:

- merge the finalData dataset with acitivityLables to set descriptive names for activities

- and then update column-Names vector based on descriptive names for activities

=================================================================================================================

In response to question 4, the script:

- clean variable names

- give new descriptive column names to the finalData set

=================================================================================================================

In response to question 5, the script:

- creates new dataframe without lables on its columns

- summarize the dataframe to include mean of variables for each activity and each subject

- merging tidyData with lables to set descriptive names for acitvities

- export the tidyData in txt format for submission

- export the tidyData in machine-readable CSV format

License:
========
This sript is written and tested in RStudio-0.99.484 installed on Ubuntu 14.04LTS. All the libraries are well 
loaded on R-3.2. The script and associated files are free for reuse for academic purpose. 
