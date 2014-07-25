#
#check for files and downloading if necessary, method for Windows
if(!file.exists("./UCI HAR Dataset")){
  message<-"downloading file"
  url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url,destfile="UCI.zip")
  unzip("UCI.zip")
}
#
#Reading in the data
subjectTest<-read.table("./UCI HAR Dataset/test/subject_test.txt",stringsAsFactors=FALSE)
XTest<-read.table("./UCI HAR Dataset/test/X_test.txt",stringsAsFactors=False)
YTest<-read.table("./UCI HAR Dataset/test/y_test.txt",stringsAsFactors=FALSe)
subjectTrain<-read.table("./UCI HAR Dataset/train/subject_train.txt"stringsAsFactors=FALSe)
XTrain<-read.table("./UCI HAR Dataset/train/X_train.txt"stringsAsFactors=FALSe)
YTrain<-read.table("./UCI HAR Dataset/train/y_train.txt"stringsAsFactors=FALSe)
#
#Creating one data set
test<-cbind(XTest,YTest,subjectTest)
train<-cbind(XTrain,YTrain,subjectTrain)
combined<-rbind(test,train)
#
#extracting the required data, mean and standard deviations for each variable
#then changing column names to descriptive  
required<-cbind(combined[,1:6],combined[,41:46],combined[,81:86],combined[,121:126],combined[,161:166],combined[,201:202],combined[,214:215],combined[,227:228],combined[,240:241],combined[,253:254],combined[,266:271],combined[,345:350],combined[,424:429],combined[,503:504],combined[,516:517],combined[,529:530],combined[,542:543],combined[,562:563])
names<-c("tBodyAccXMean","tBodyAccYMean","tBodyAccZMean","tBodyAccXSD","tBodyAccYSD","tBodyAccZSD","tGravityAccXMean","tGravityAccYMean","tGravityAccZMean","tGravityAccXSD","tGravityAccYSD","tGravityAccZSD","tBodyAccJerkXMean","tBodyAccJerkYMean","tBodyAccJerkZMean","tBodyAccJerkXSD","tBodyAccJerkYSD","tBodyAccJerkZSD","tBodyGyroXMean","tBodyGyroYMean","tBodyGyroZMean","tBodyGyroXSD","tBodyGyroYSD","tBodyGyroZSD","tBodyGyroJerkXMean","tBodyGyroJerkYMean","tBodyGyroJerkZMean","tBodyGyroJerkXSD","tBodyGyroJerkYSD","tBodyGyroJerkZSD","tBodyAccMagMean","tBodyAccMagSD","tGravityAccMagMean","tGravityAccMagSD","tBodyAccJerkMagMean","tBodyAccJerkMagSD","tBodyGyroMagMean","tBodyGyroMagSD","tBodyGyroJerkMagMean","tBodyGyroJerkMagSD","fBodyAccXMean","fBodyAccYMean","fBodyAccZMean","fBodyAccXSD","fBodyAccYSD","fBodyAccZSD","fBodyAccJerkXMean","fBodyAccJerkYMean","fBodyAccJerkZMean","fBodyAccJerkXSD","fBodyAccJerkYSD","fBodyAccJerkZSD","fBodyGyroXMean","fBodyGyroYMean","fBodyGyroZMean","fBodyGyroXSD","fBodyGyroYSD","fBodyGyroZSD","fBodyAccMagMean","fBodyAccMagSD","fBodyBodyAccJerkMagMean","fBodyBodyAccJerkMagSD","fBodyBodyGyroMagMean","fBodyBodyGyroMagSD","fBodyBodyGyroJerkMagMean","fBodyBodyGyroJerkMagSD","Activity","Subject")
names(required)<-names
#
#changing the activity field to descriptive activity names
required$Activity<-replace(required$Activity,required$Activity==1,"Walking")
required$Activity<-replace(required$Activity,required$Activity==2,"WalkingUpstairs")
required$Activity<-replace(required$Activity,required$Activity==3,"WalkingDownstairs")
required$Activity<-replace(required$Activity,required$Activity==4,"Sitting")
required$Activity<-replace(required$Activity,required$Activity==5,"Standing")
required$Activity<-replace(required$Activity,required$Activity==6,"Laying")
#
#creating a second dataset of averages
Factors<-list(required$Activity,required$Subject)
Averages<-aggregate(required,by=Factors,FUN=mean,na.rm=TRUE)
Averages<-Averages[,-c(69:70)]
colnames(Averages)[1:2]<-c("Activity","Subject")
#
#exporting the datasets
write.table(required,"./combinedData.txt",row.names=FALSE)
write.table(Averages,"averageData.txt",row.names=FALSE)
