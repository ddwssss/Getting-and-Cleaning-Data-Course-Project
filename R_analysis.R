library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
     download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
     unzip("UCI HAR Dataset.zip", exdir = getwd())
}
#test data
data1Test<- read.table("UCI HAR Dataset/test/X_test.txt")
data2Test<- read.table("UCI HAR Dataset/test/Y_test.txt")
SubjectTest <-read.table("UCI HAR Dataset/test/subject_test.txt")

#traindata
data1Train<- read.table("UCI HAR Dataset/train/X_train.txt")
data2Train<- read.table("UCI HAR Dataset/train/Y_train.txt")
SubjectTrain <-read.table("UCI HAR Dataset/train/subject_train.txt")
features<-read.table("UCI HAR Dataset/features.txt")
activity<-read.table("UCI HAR Dataset/activity_labels.txt")

#1. Merges the training and the test sets to create one data set.
data1<-rbind(data1Test, data1Train)
data2<-rbind(data2Test, data2Train)
Subject<-rbind(SubjectTest, SubjectTrain)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
columnsWithMeanSTD <-grep("mean\\(\\)|std\\(\\)", features[,2])
data1 <- data1[columnsWithMeanSTD]

#3.Uses descriptive activity names to name the activities in the data set
data2[,1]<-activity[data2[,1],2]
head(data2) 

#4. Appropriately labels the data set with descriptive variable names. 
names<-features[columnsWithMeanSTD,2]
names(data1)<-names
names(Subject)<-"SubjectID"
names(data2)<-"Activity"
CleanedData<-cbind(Subject, data2, data1)

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
CleanedData<-data.table(CleanedData)
TidyData <- CleanedData[, lapply(.SD, mean), by = .(SubjectID, Activity)] 

write.table(TidyData, "tidy_data.txt", row.names = FALSE, quote = FALSE)


