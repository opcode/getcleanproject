rm(list=ls())
setwd("~/Personal/Coursera/CleaningData/Project");
getwd()

library("dplyr")

####################################################################
#
# test files for development only (first 100 lines of data)
#
#testdatafile <- "data/test/dev_X_test.txt"
#testsubjectsfile <- "data/test/dev_subject_test.txt"
#testactivitiesfile <- "data/test/dev_y_test.txt"
#
#traindatafile <- "data/train/dev_X_train.txt"
#trainsubjectsfile <- "data/train/dev_subject_train.txt"
#trainactivitiesfile <- "data/train/dev_y_train.txt"
#
####################################################################


# production data
testdatafile <- "data/test/X_test.txt"
testsubjectsfile <- "data/test/subject_test.txt"
testactivitiesfile <- "data/test/y_test.txt"

traindatafile <- "data/train/X_train.txt"
trainsubjectsfile <- "data/train/subject_train.txt"
trainactivitiesfile <- "data/train/y_train.txt"

tidydatafile <- "tidydata.txt" # file to be written and turned in

featuresfile <- "data/features.txt"
features <- read.table(featuresfile, header=FALSE, colClasses=c("numeric", "character"),
                                                   col.names=c("n", "FeatureNames"))

# normalize feature names for valid R column names
features$FeatureNames <- sub("()", "", features$FeatureNames, fixed=TRUE)
features$FeatureNames <- gsub("-", "_", features$FeatureNames, fixed=TRUE)

#features$FeatureNames <- gsub("[(),]", "_", features$FeatureNames)

# select only true mean and std columns for the tidy data
tidyFeatureNames <- features$FeatureNames[grepl("meanFreq|mean$|mean_X$|mean_Y$|mean_Z$|std$|std_X$|std_Y$|std_Z$",
                                                features$FeatureNames)]
str(features)

activitiesfile <- "data/activity_labels.txt"
activities <- read.table(activitiesfile, header=FALSE, colClasses=c("numeric", "character"),
                                                       col.names=c("n", "ActivityNames"))

Xtrain <- read.table(traindatafile, header=FALSE)
colnames(Xtrain) <- features$FeatureNames
rownames(Xtrain) <- sapply(rownames(Xtrain), function(x){paste("train", x, sep="")})
#Xtrain$Subject <- read.table(trainsubjectsfile, header=FALSE, col.names=c("Subject"))
#Xtrain$Activity <- read.table(trainactivitiesfile, header=FALSE, col.names=c("Activity"))
#Xtrain$Activity <- sapply(Xtrain$Activity, function(x){activities$ActivityNames[x]})
str(Xtrain)

Xtest <- read.table(testdatafile, header=FALSE)
colnames(Xtest) <- features$FeatureNames
rownames(Xtest) <- sapply(rownames(Xtest), function(x){paste("test", x, sep="")})
#Xtest$Subject <- read.table(testsubjectsfile, header=FALSE, col.names=c("Subject"))
#Xtest$Activity <- read.table(testactivitiesfile, header=FALSE, col.names=c("Activity"))
#Xtest$Activity <- sapply(Xtest$Activity, function(x){activities$ActivityNames[x]})
str(Xtest)

#tidyFeatureNames <- c("Subject", "Activity", tidyFeatureNames)

str(tidyFeatureNames)

Xtest.tidy <- Xtest[, tidyFeatureNames]
#rownames(Xtest.tidy) <- sapply(rownames(Xtest.tidy), function(x){paste("test", x, sep="")})

str(Xtest.tidy)

Xtrain.tidy <- Xtrain[, tidyFeatureNames]
#rownames(Xtrain.tidy) <- sapply(rownames(Xtrain.tidy), function(x){paste("train", x, sep="")})

str(Xtrain.tidy)

Xall.tidy <- rbind(Xtest.tidy, Xtrain.tidy)

str(Xall.tidy)
rownames(Xall.tidy)

train.subjects <- read.table(trainsubjectsfile, header=FALSE, col.names=c("Subject"))
str(train.subjects)
train.activities <- read.table(trainactivitiesfile, header=FALSE, col.names=c("Activity"))
str(train.activities)
#train.activities$Activity <- sapply(train.activities$Activity, function(x){activities$ActivityNames[x]})
#str(train.activities)

test.subjects <- read.table(testsubjectsfile, header=FALSE, col.names=c("Subject"))
str(test.subjects)
test.activities <- read.table(testactivitiesfile, header=FALSE, col.names=c("Activity"))
str(test.activities)
#test.activities$Activity <- sapply(test.activities$Activity, function(x){activities$ActivityNames[x]})
#str(test.activities)

all.subjects <- c(test.subjects$Subject, train.subjects$Subject)
class(all.subjects)
str(all.subjects)

all.activities <- c(test.activities$Activity, train.activities$Activity)
class(all.activities)
str(all.activities)

Xall.tidy$Subject <- all.subjects
Xall.tidy$Activity <- all.activities
str(Xall.tidy)

Xall.tidy

table(Xall.tidy$Subject, Xall.tidy$Activity)

#df <- select(Xall.tidy, Subject, Activity, fBodyAcc_meanFreq_Z:fBodyAccJerk_mean_X)

# prepare the data frame with means of all tidy data by Subject/Activity
df <- Xall.tidy
df <- mutate(df, subact=paste(Subject, Activity, sep=":"))
df <- group_by(df, subact)

# summarise(df, mean1=mean(fBodyAcc_meanFreq_Z), mean2=mean(fBodyAccJerk_mean_X))

# summarise_each will create summary data for each combination of Subject/Activity
df.final <- summarise_each(df, funs(mean))
str(df.final)

# order by Subject and then by Activity
df.final <- arrange(df.final, Subject, Activity)
str(df.final)

# remove the group_by column
df.final <- select(df.final, -subact)
str(df.final)

# put Subject, Activity in first two columns
df.final <- select(df.final, Subject, Activity, 1:ncol(df.final))
str(df.final)

# use full Activity names for readability
df.final$Activity <- sapply(df.final$Activity, function(x){activities$ActivityNames[x]})
df.final

# test with just a subset of the resulting df
df.test <- select(df.final, Subject, Activity, tBodyAcc_mean_X)
head(df.test, n=20)
tail(df.test, n=20)

# save tidy data file
write.table(df.final, tidydatafile, row.names=FALSE)


