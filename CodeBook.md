This CodeBook describes the data cleaning process for the Coursera Getting and Cleaning Data Course Project.

## Overview of the Raw Data

The original data is the Human Activity Recognition Using Smartphones Data Set described [here]
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). This site has full details
on the raw data.

It also describes the general experiment and the data captured:

"*The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.*"

The citation for this work is:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The data can be downloaded [here]
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Study Design

The data consist of two data files, X_train.txt and X_test.txt, for the training data and the testing data,
respectively. X_train.txt includes 7352 observations of 561 variables. X_test.txt includes 2947 observations of the
same 561 variables. It was observed that some of the column names are duplicated, however, the tidy data set
only included variables of mean or standard deviation, and none of those columns were duplicated.

All of the data were read, and then combined into one data frame with just the columns required for the tidy
data. These numbered 79 variables plus one column for the subject and one column for the activity. The subject
and activity data were stored separately in subject_train.txt and y_train.txt, respectively. Likewise, for the test
subject and activity data, subject_test.txt and y_test.txt.

Once these were combined, the data were partitioned by subject and activity, and the mean was taken for
each column of data. The resulting file was written to tidydata.txt, a copy of which is included in
this repository. The columns from the final, tidy data set are below. The mean and std columns actually refer
to the mean of all values for that subject/activity within the study.

1. Subject, numeric
2. Activity, character
3. fBodyAccJerk_meanFreq_X, numeric
4. fBodyAccJerk_meanFreq_Y, numeric
5. fBodyAccJerk_meanFreq_Z, numeric
6. fBodyAccJerk_mean_X, numeric
7. fBodyAccJerk_mean_Y, numeric
8. fBodyAccJerk_mean_Z, numeric
9. fBodyAccJerk_std_X, numeric
10. fBodyAccJerk_std_Y, numeric
11. fBodyAccJerk_std_Z, numeric
12. fBodyAccMag_mean, numeric
13. fBodyAccMag_meanFreq, numeric
14. fBodyAccMag_std, numeric
15. fBodyAcc_meanFreq_X, numeric
16. fBodyAcc_meanFreq_Y, numeric
17. fBodyAcc_meanFreq_Z, numeric
18. fBodyAcc_mean_X, numeric
19. fBodyAcc_mean_Y, numeric
20. fBodyAcc_mean_Z, numeric
21. fBodyAcc_std_X, numeric
22. fBodyAcc_std_Y, numeric
23. fBodyAcc_std_Z, numeric
24. fBodyBodyAccJerkMag_mean, numeric
25. fBodyBodyAccJerkMag_meanFreq, numeric
26. fBodyBodyAccJerkMag_std, numeric
27. fBodyBodyGyroJerkMag_mean, numeric
28. fBodyBodyGyroJerkMag_meanFreq, numeric
29. fBodyBodyGyroJerkMag_std, numeric
30. fBodyBodyGyroMag_mean, numeric
31. fBodyBodyGyroMag_meanFreq, numeric
32. fBodyBodyGyroMag_std, numeric
33. fBodyGyro_meanFreq_X, numeric
34. fBodyGyro_meanFreq_Y, numeric
35. fBodyGyro_meanFreq_Z, numeric
36. fBodyGyro_mean_X, numeric
37. fBodyGyro_mean_Y, numeric
38. fBodyGyro_mean_Z, numeric
39. fBodyGyro_std_X, numeric
40. fBodyGyro_std_Y, numeric
41. fBodyGyro_std_Z, numeric
42. tBodyAccJerkMag_mean, numeric
43. tBodyAccJerkMag_std, numeric
44. tBodyAccJerk_mean_X, numeric
45. tBodyAccJerk_mean_Y, numeric
46. tBodyAccJerk_mean_Z, numeric
47. tBodyAccJerk_std_X, numeric
48. tBodyAccJerk_std_Y, numeric
49. tBodyAccJerk_std_Z, numeric
50. tBodyAccMag_mean, numeric
51. tBodyAccMag_std, numeric
52. tBodyAcc_mean_X, numeric
53. tBodyAcc_mean_Y, numeric
54. tBodyAcc_mean_Z, numeric
55. tBodyAcc_std_X, numeric
56. tBodyAcc_std_Y, numeric
57. tBodyAcc_std_Z, numeric
58. tBodyGyroJerkMag_mean, numeric
59. tBodyGyroJerkMag_std, numeric
60. tBodyGyroJerk_mean_X, numeric
61. tBodyGyroJerk_mean_Y, numeric
62. tBodyGyroJerk_mean_Z, numeric
63. tBodyGyroJerk_std_X, numeric
64. tBodyGyroJerk_std_Y, numeric
65. tBodyGyroJerk_std_Z, numeric
66. tBodyGyroMag_mean, numeric
67. tBodyGyroMag_std, numeric
68. tBodyGyro_mean_X, numeric
69. tBodyGyro_mean_Y, numeric
70. tBodyGyro_mean_Z, numeric
71. tBodyGyro_std_X, numeric
72. tBodyGyro_std_Y, numeric
73. tBodyGyro_std_Z, numeric
74. tGravityAccMag_mean, numeric
75. tGravityAccMag_std, numeric
76. tGravityAcc_mean_X, numeric
77. tGravityAcc_mean_Y, numeric
78. tGravityAcc_mean_Z, numeric
79. tGravityAcc_std_X, numeric
80. tGravityAcc_std_Y, numeric
81. tGravityAcc_std_Z, numeric

## Code Book

This section describes how the raw data was transformed to the tidy data that was submitted using
run_analysis.R.

The structure of the data and the R code is as follows:

```project/
  data/
    features.txt               # raw data column numbers and labels
    activity_labels.txt        # activity numbers and their labels
    train/
      X_train.txt              # training data set
      y_train.txt              # activity codes for X_train
      subject_train.txt        # subjects for X_train
    test/
      X_test.txt               # test data set
      y_test.txt               # activity codes for X_test
      subject_test.txt         # subjects for X_test
  getcleanproject/             # github repository
  tidydata.txt                 # data file for project submission
  ```
  
  The following steps were used to convert the data:
  
  1. read the features file and normalize the names for R. find those columns that measure mean or std by grepping for "meanFreq|mean$|mean_X$|mean_Y$|mean_Z$|std$|std_X$|std_Y$|std_Z$"
  2. read the activity labels
  3. read the training data, apply the features as column names, add the "train" prefix to the row names
  4. repeat with the test data
  5. create new data frames with just the tidy data columns
  6. rbind() the test and train data frames
  7. add the test and train subjects to the tidy data
  8. convert the activity numbers to their labels
  9. use dply to rearrange the columns, group by subject and activity, and summarize with the mean of all the columns
  10. write the data file
