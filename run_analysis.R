setwd("C:/Users/juanc/OneDrive/Escritorio")
 
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")

xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")

features<- read.table("./UCI HAR Dataset/features.txt", quote="\"", comment.char="")

## STEP 0
#Test
colnames(xtest)=features[,2]
#View(xtest)
test<-subject_test
colnames(test)="Subject"
colnames(ytest)="Activity"

test<-cbind(test,ytest)
test<-cbind(test,xtest)
#View(test)

#Train
colnames(xtrain)=features[,2]
#View(xtrain)
train<-subject_train
colnames(train)="Subject"
colnames(ytrain)="Activity"

train<-cbind(train,ytrain)
train<-cbind(train,xtrain)
#View(train)


## STEP 1

fusion<-rbind(train,test)
#View(fusion)

## STEP 2 

nombres<-colnames(fusion)

subject<-grep("(Subject)+",nombres, value=TRUE)
actividad<-grep("(Activity)+",nombres, value=TRUE)
meand<-grep("(mean)+",nombres, value=TRUE)
strd<-grep("(std)+",nombres, value=TRUE)

conjunto<-c(subject,actividad,meand,strd) ##vector


library(dplyr)

meanstrd<-select(fusion,conjunto)


## STEP 3

activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
colnames(activitylabels)=c("ID","Activity")

mergedData=merge(meanstrd, activitylabels, by.x="Activity",by.y="ID")

mergedData$Activity<-mergedData$Activity.y
mergedData<-mergedData[,1:81]


## STEP 4

nombre<-names(mergedData)
nombre<- sub("^t", "Time", nombre)
nombre<- sub("^f", "Frecuency", nombre)
nombre<- sub("(Acc)+", "Acceleration", nombre)
nombre<- sub("(Gyro)+", "Gyroscope", nombre)
nombre<- sub("(std)+", "Stand.Dev.", nombre)
 
nombre<- sub("(X)+", "X axis", nombre)
nombre<- sub("(Y)+", "Y axis", nombre)
nombre<- sub("(Z)+", "Z axis", nombre)
 
colnames(mergedData)=nombre


## STEP 5 

  
#install.packages("reshape2")
library(reshape2)

meltdata<-melt(mergedData, id=c("Activity", "Subject"))

Final<-dcast(meltdata,Activity+Subject~variable, mean)
View(Final)

#write.table(Final, "./Tidy dataset .txt", sep="\t")
write.table(Final, "./Tidy dataset .txt", row.names=FALSE, col.names=TRUE)
