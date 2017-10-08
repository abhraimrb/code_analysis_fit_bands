if(!file.exists("./assigndata")){dir.create("./assigndata")}##Creation of directory for downloading data
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile = "./assigndata/assignfile.zip")## downloading the data file
unzip(zipfile ="./assigndata/assignfile.zip",exdir ="./assigndata" ) ## unzipping the data file
x_training<-read.table("C:/Users/tamma/Documents/assigndata/UCI HAR Dataset/train/X_train.txt")##Reading x variables of  training set
y_training<-read.table("C:/Users/tamma/Documents/assigndata/UCI HAR Dataset/train/y_train.txt")##Reading y variable of  training set
subject_training<-read.table("C:/Users/tamma/Documents/assigndata/UCI HAR Dataset/train/subject_train.txt")##Reading subject file of training set
x_testing<-read.table("C:/Users/tamma/Documents/assigndata/UCI HAR Dataset/test/X_test.txt")##Reading x variables of testing set
y_testing<-read.table("C:/Users/tamma/Documents/assigndata/UCI HAR Dataset/test/y_test.txt")##Reading y variable of testing set
subject_testing<-read.table("C:/Users/tamma/Documents/assigndata/UCI HAR Dataset/test/subject_test.txt")##Reading subject file of testing set
features<-read.table("C:/Users/tamma/Documents/assigndata/UCI HAR Dataset/features.txt")##Reading features' file
activity_labels<-read.table("C:/Users/tamma/Documents/assigndata/UCI HAR Dataset/activity_labels.txt")##Reading activity details file
colnames(x_training)<-features[,2]## Naming the x variables name from features table
colnames(y_training)<-"activity_no." ## Naming the y variables name as activity no.
colnames(subject_training)<-"subject"## Naming the column name of  subject table of training set.
colnames(x_testing)<-features[,2]## Naming the x variables name from features table
colnames(y_testing)<-"activity_no."## Naming the y variables name as activity no.
colnames(subject_testing)<-"subject"## Naming the column name of  subject table of testing set.
colnames(activity_labels)<-c("activity_no.","activity type")## Naming the column names of activity  table
merge_training<-cbind(x_training,y_training,subject_training)##combining the columns of all training files(merging training files)
merge_testing<-cbind(x_testing,y_testing,subject_testing)##combining the columns of all testing files(merging testing files) 
merge_alldata<-rbind(merge_training,merge_testing)##merging both training and testing dataset into one file
columnnam<-colnames(merge_alldata)## assigning the column names of merged set to an object
mean_std_dev<-(grepl("activity_no.",columnnam)|grepl("subject",columnnam)|grepl("mean..",columnnam)|grepl("std..",columnnam))##Creation of a logical vector to extract the measurement of only  mean and std deviation from the merged data set
datacon_mean_std_dev<-merge_alldata[,mean_std_dev==T]##extraction of measurement of only  mean and std deviation from the merged data set
datawithactivity_lab<-merge(datacon_mean_std_dev,activity_labels,by="activity_no.",all.x=T)##labelling the activity nos. with corresponding lables
secondtidy_dataset<-melt(datacon_mean_std_dev,id=c("subject","activity_no."))
secondtidy_dataset<-dcast(merge_alldata_melted,subject+activity_no.~variable,mean)##Creation of second tidy dataset with the average of each variable for each activity and each subject.
write.table(secondtidy_dataset,"secondtidydataset.txt",row.name=F)##writing the second tidy dataset into a text file in working directory

