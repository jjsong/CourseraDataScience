
##### You should create one R script called run_analysis.R that does the following. 
##### 1.Merges the training and the test sets to create one data set.

###check the contents (test)
SubTest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
XTest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
YTest <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")

dim(SubTest)
dim(XTest)
dim(YTest)

###check the contetns (train)
SubTrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
XTrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
YTrain <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

dim(SubTrain)
dim(XTrain)
dim(YTrain)


### binding  
#order : Y-Subject-X
#Y: Training labels.
#subject: Each row identifies the subject 
#         who performed the activity for each window sample. 
#         Its range is from 1 to 30. 
#X: Training set.
test=cbind(YTest, SubTest, XTest)
dim(test)
test[1:10, 1:10]

train=cbind(YTrain, SubTrain, XTrain )
dim(train)
train[1:10, 1:10]

DF <- rbind(test, train)
dim(DF)
DF[10200:10205, 1:3]



##### 2.Extracts only the measurements on the mean and standard deviation for each measurement.
### read and check the features.txt file
features <- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
dim(features)
head(features)
features[1:15,]
tail(features)
features[550:561,]
names(features)

### make and insert colomn name 
DF[1:10, 1:5]
colnames(DF) <- c("activity_labels","subject", as.character(features[,2])) 
DF[1:10, 1:5]

### subsetting columns inclduing - activity_labels, subject, mean(), std()  
columnNew <- grep("mean|std|activity_labels|subject", names(DF))
columnNew
#DF2 : new data set
DF2 <- DF[,columnNew] 
dim(DF2)
DF2[1:5, 1:5]





##### 3.Uses descriptive activity names to name the activities in the data set
### read activity_labels.txt
activity <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
activity
DF2$activity_labels <- activity$V2[match(DF2$activity_labels, activity$V1)]
DF2[1:5, 1:5]



##### 4.Appropriately labels the data set with descriptive activity names. 
#Done at No2 above


##### 5. Creates a second, independent tidy data set with the average of 
#####    each variable for each activity and each subject. 
### make tidy data and save it
DF2Mean <- aggregate(.~ activity_labels + subject, DF2, FUN = mean)
DF2Mean[1:50, 1:5]
dim(DF2Mean)
write.csv(DF2Mean, file="./tidyData.csv")



