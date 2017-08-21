#Getting and Cleaning data Project
library(reshape2)
filename<-"getdata_dataset.zip"
#Download the dataset
if(!file.exists(filename)){
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,filename)
}
if(!file.exists("UCI HAR Dataset")){
  Unzip(filename)
}
#Load activity labels and features
activityLabels<-read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2]<-as.character(activityLabels[,2])
features<-read.table("UCI HAR Dataset/features.txt")
features[,2]<-as.character(features[,2])

#Extract only the data on mean and standatd deviation
featuresWanted<-grep(".*mean.*|.*std.*",features[,2])
featuresWanted.names<-features[featuresWanted,2]
featuresWanted.names=grep('-mean','Mean',featuresWanted.names)
featuresWanted.names=grep('-std','Std',featuresWanted.names)
featuresWanted.names<-gsub('[-()]','',featuresWanted.names)

#Load the data sets
train<-read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities<-read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects<-read.table("UCI HAR Dataset/train/subject_train.txt")
train<-cbind(trainSubjects,trainActivities,train)
test<-read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities<-read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects<-read.table("UCI HAR Dataset/test/subject_test.txt")
test<-cbind(testSubjects,testActivities,test)

#merge datasets and labels
allData<-rbind(train,test)
colnames(allData)<-c("Subject","activity",featuresWanted.names)

#turn activities and subjects into factors
allData$activity<-factor(allData$activity,levels=activityLabels[,1],labels=activityLabels[,2])
allData$Subject<-as.factor(allData$Subject)
allData.melted<-melt(allData,id=c("Subject","activity"))
allData.mean<-dcast(allData.melted,Subject+activity~variable,mean)
write.table(allData.mean,"tidy.txt",row.names=FALSE,quote=FALSE)
