```{r}
#First we need to download the zipped folder:

url_project<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url_project, "files_project.zip")

#...and unzip it!
unzip("files_project.zip")

#I decided to quickly check the files and folders in the unzipped folder:
list.files(path = "~/Coursera/GettingandCleaningData/Project/UCI HAR Dataset")

#Next, I read the files to RStudio:
features<- read.table("~/Coursera/GettingandCleaningData/Project/UCI HAR Dataset/features.txt")
activity_labels<- read.table("~/Coursera/GettingandCleaningData/Project/UCI HAR Dataset/activity_labels.txt")
subject_test<- read.table("~/Coursera/GettingandCleaningData/Project/UCI HAR Dataset/test/subject_test.txt")
X_test<- read.table("~/Coursera/GettingandCleaningData/Project/UCI HAR Dataset/test/X_test.txt")
y_test<- read.table("~/Coursera/GettingandCleaningData/Project/UCI HAR Dataset/test/y_test.txt")
subject_train<- read.table("~/Coursera/GettingandCleaningData/Project/UCI HAR Dataset/train/subject_train.txt")
X_train<- read.table("~/Coursera/GettingandCleaningData/Project/UCI HAR Dataset/train/X_train.txt")
y_train<- read.table("~/Coursera/GettingandCleaningData/Project/UCI HAR Dataset/train/y_train.txt")


#After briefly examining the objects I just opened, I realized that the features are variable names for the X_test and X_train tables
head(features)
head(activity_labels)
head(subject_test)
head(X_test)
head(y_test)

#So my next step is to assign column names to X_test...
X_test
colnames(X_test)<- features$V2

#...just checking everything goes as planned
head(X_test)

#Here I assign column names to X_train
colnames(X_train)<- features$V2

#...and check again 
head(X_train)

#We are only interested in certain column names, so we need to subset them. To accomplish this, I create a vector with the column names we are interested in:
a<- grep("std()", colnames(X_train), value = TRUE)
b<- grep("mean()", colnames(X_train), value = TRUE)
names<- c(a, b)
length(names)

#Here I subset X_train and X_test and reassign to the same objects:
library(dplyr)
X_train<- X_train %>% select(names)
X_test<- X_test %>% select(names)

#This line adds two more variables to X_train: subjects and activity labels
X_train<- X_train %>% mutate(subject = subject_train$V1, labels = y_train$V1) 

#Similar with the X_test
X_test<- X_test %>% mutate(subject = subject_test$V1, labels = y_test$V1)
ncol(X_test)

ncol(X_train)

#now it is time to unite X_test and X_train!
X_test_train<- rbind(X_train, X_test)
nrow(X_test_train)

#Here I recode the labels so that they are descriptive:
X_test_train$labels<- recode(X_test_train$labels, `1` = "WALKING",
                             `2` = "WALKING_UPSTAIRS",
                             `3` = "WALKING_DOWNSTAIRS",
                             `4` = "SITTING",
                             `5` = "STANDING",
                             `6` = "LAYING")

head(X_test_train$labels)

unique(X_test_train$subject)

#And finally, I create a new tidy dataset with the summary of all columns, grouped by the subject and the type of activity:
summary_data<- X_test_train %>% group_by(subject, labels) %>% summarise_all(mean)

head(summary_data)
