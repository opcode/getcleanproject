rm(list=ls())
setwd("~/Personal/Coursera/CleaningData/Project");
getwd()

testdatafile <- "data/test/X_test.txt"
testsubjectsfile <- "data/test/subject_test.txt"
testactivitiesfile <- "data/test/y_test.txt"

traindatafile <- "data/train/X_train.txt"
trainsubjectsfile <- "data/train/subject_train.txt"
trainactivitiesfile <- "data/train/y_train.txt"

featuresfile <- "data/features.txt"
features <- read.table(featuresfile, header=FALSE, colClasses=c("numeric", "character"),
                                                   col.names=c("n", "FeatureNames"))
features$FeatureNames <- sub("()", "", features$FeatureNames, fixed=TRUE)
features$FeatureNames <- gsub("-", "_", features$FeatureNames, fixed=TRUE)

#features$FeatureNames <- gsub("[(),]", "_", features$FeatureNames)
tidyFeatureNames <- features$FeatureNames[grepl("meanFreq|mean$|mean_X$|mean_Y$|mean_Z$|std$|std_X$|std_Y$|std_Z$",
                                                features$FeatureNames)]
str(features)

activitiesfile <- "data/activity_labels.txt"
activities <- read.table(activitiesfile, header=FALSE, colClasses=c("numeric", "character"),
                                                       col.names=c("n", "ActivityNames"))

Xtrain <- read.table(traindatafile, header=FALSE)
colnames(Xtrain) <- features$FeatureNames
#rownames(Xtrain) <- sapply(rownames(Xtrain), function(x){paste("train", x, sep="")})
#Xtrain$Activity <- sapply(Xtrain$Activity, function(x){activities$ActivityNames[x]})
str(Xtrain)

Xtest <- read.table(testdatafile, header=FALSE)
colnames(Xtest) <- features$FeatureNames
#rownames(Xtest) <- sapply(rownames(Xtest), function(x){paste("test", x, sep="")})
#Xtest$Activity <- sapply(Xtest$Activity, function(x){activities$ActivityNames[x]})
str(Xtest)

#tidyFeatureNames <- c("Subject", "Activity", tidyFeatureNames)

str(tidyFeatureNames)

Xtest.tidy <- Xtest[, tidyFeatureNames]
rownames(Xtest.tidy) <- sapply(rownames(Xtest.tidy), function(x){paste("train", x, sep="")})
Xtest.tidy$Subject <- read.table(testsubjectsfile, header=FALSE, col.names=c("Subject"))
#Xtest.tidy$Activity <- read.table(testactivitiesfile, header=FALSE, col.names=c("Activity"))
str(Xtest.tidy)

Xtrain.tidy <- Xtrain[, tidyFeatureNames]
rownames(Xtrain.tidy) <- sapply(rownames(Xtrain.tidy), function(x){paste("train", x, sep="")})
Xtrain.tidy$Subject <- read.table(trainsubjectsfile, header=FALSE, col.names=c("Subject"))
#Xtrain.tidy$Activity <- read.table(trainactivitiesfile, header=FALSE, col.names=c("Activity"))
str(Xtrain.tidy)

Xall.tidy <- rbind(Xtest.tidy, Xtrain.tidy)
