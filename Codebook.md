# getdataWk3Project - Code Book
Assignment for Getting and Cleaning Data

## Setup
The goal of this project is to extract and prepare tidy data from an intermediate dataset.

The intermediate dataset was constructed by a third party using raw data collected from the accelerometer and gyroscope of a Samsung Galaxy S smartphone during a series of experiments. 30 test subjects performed 6 different activities while carrying the smartphones on their hips. The raw measurements were sampled using sliding time windows of 128 readings each. A total of 10299 of such windows are present in the data. Those windows were processed to remove noise and compute metrics that aimed to describe the activity taking place (such as means and standard deviations of the raw linear and angular accelerations across the 128 readings in the time window). A total of 561 metrics or features were calculated for each of the 10299 time windows, including metrics in both the time and the frequency domains.

In the intermediate dataset, each of the 10299 time windows is an observation, described by a feature vector of 561 metrics, and associated to one activity and one test subject.

The tidy dataset we seek to extract is defined as a table containing the averages of a certain subset of the 561 features, calculated for each activity and test subject. The features we need are those that represent means or standard deviations.
  
The data was downloaded on 14 Mar 2015 from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The extracted folders contain more detailed information about the experiments, the raw data that was collected, and the metrics.

## Rawest available form of data

The rawest data was not used directly in this project.

It is contained in the files:
* ./UCI HAR Dataset/[train,test]/Inertial Signals/total_acc_[x,y,z]_[train,test].txt - The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g', organized in observations of 128 readings per time window
* ./UCI HAR Dataset/[train,test]/Inertial Signals/body_gyro_[x,y,z]_[train,test].txt - The angular velocity vector measured by the gyroscope, organized in observations of 128 readings per time window. The units are radians/second
...where [train,test] takes one of the two values 'train' or 'test', and [x,y,z] takes one of the three values 'x', 'y', or 'z' (for each of the axis of space).

There is more information about it in the files that come with the dataset.

## Intermediate data

The rawest data was preprocessed by a third party as follows:
* The sensor acceleration signal was processed to separate body acceleration from gravity
* For each of the observations, a vector of 561 features was obtained by calculating variables from the time and frequency domain
* The features were normalized and bounded within [-1, 1]

The dataset of observations and features is the one that was used in this project to construct the tidy data.

## Tidy data

The tidy data is a table that contains, for each combination of activity and test subject, the mean of each of the 66 features (out of the 561 feature vectors of the intermediate dataset), representing means or standard deviations.

The fields are the following (where '[A, B]' means similar variables exist for both 'A' and 'B' options):
* activity: a factor representing the activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* test.subject: an id identifying the test subject (1 to 30)
* t[Body, Gravity]Acc-[mean, std]-[X, Y, Z]: mean of the means (or the standard deviations) in the X (or Y, or Z) direction of space of the time domain Body (or Gravity) component of the acceleration signal
  * tBodyAcc-mean-X
  * tBodyAcc-mean-Y
  * tBodyAcc-mean-Z
  * tBodyAcc-std-X
  * tBodyAcc-std-Y
  * tBodyAcc-std-Z
  * tGravityAcc-mean-X
  * tGravityAcc-mean-Y
  * tGravityAcc-mean-Z
  * tGravityAcc-std-X
  * tGravityAcc-std-Y
  * tGravityAcc-std-Z
* tBodyAccJerk-[mean, std]-[X, Y, Z]: mean of the means (or the standard deviations) in the X (or Y, or Z) direction of space of the time domain Body component of the derivative of the acceleration signal
  * tBodyAccJerk-mean-X
  * tBodyAccJerk-mean-Y
  * tBodyAccJerk-mean-Z
  * tBodyAccJerk-std-X
  * tBodyAccJerk-std-Y
  * tBodyAccJerk-std-Z
* tBodyGyro-[mean, std]-[X, Y, Z]: mean of the means (or the standard deviations) in the X (or Y, or Z) direction of space of the time domain gyroscope signal
  * tBodyGyro-mean-X
  * tBodyGyro-mean-Y
  * tBodyGyro-mean-Z
  * tBodyGyro-std-X
  * tBodyGyro-std-Y
  * tBodyGyro-std-Z
* tBodyGyroJerk-[mean, std]-[X, Y, Z]: mean of the means (or the standard deviations) in the X (or Y, or Z) direction of space of the time domain derivative of the gyroscope signal
  * tBodyGyroJerk-mean-X
  * tBodyGyroJerk-mean-Y
  * tBodyGyroJerk-mean-Z
  * tBodyGyroJerk-std-X
  * tBodyGyroJerk-std-Y
  * tBodyGyroJerk-std-Z
* t[Body, Gravity]AccMag-[mean, std]: mean of the means (or the standard deviations) of the magnitude of the time domain Body (or Gravity) component of the acceleration signal
  * tBodyAccMag-mean
  * tBodyAccMag-std
  * tGravityAccMag-mean
  * tGravityAccMag-std
* tBodyAccJerkMag-[mean, std]: mean of the means (or the standard deviations) of the magnitude of the time domain Body component of the derivative of the acceleration signal
  * tBodyAccJerkMag-mean
  * tBodyAccJerkMag-std
* tBodyGyroMag-[mean, std]: mean of the means (or the standard deviations) of the magnitude of the time domain gyroscope signal
  * tBodyGyroMag-mean
  * tBodyGyroMag-std
* tBodyGyroJerkMag-[mean, std]: mean of the means (or the standard deviations) of the magnitude of the time domain derivative of the gyroscope signal
  * tBodyGyroJerkMag-mean
  * tBodyGyroJerkMag-std
* fBodyAcc-[mean, std]-[X, Y, Z]: mean of the means (or the standard deviations) in the X (or Y, or Z) direction of space of the frequency domain Body component of the acceleration signal
  * fBodyAcc-mean-X
  * fBodyAcc-mean-Y
  * fBodyAcc-mean-Z
  * fBodyAcc-std-X
  * fBodyAcc-std-Y
  * fBodyAcc-std-Z
* fBodyAccJerk-[mean, std]-[X, Y, Z]: mean of the means (or the standard deviations) in the X (or Y, or Z) direction of space of the frequency domain Body component of the derivative of the acceleration signal
  * fBodyAccJerk-mean-X
  * fBodyAccJerk-mean-Y
  * fBodyAccJerk-mean-Z
  * fBodyAccJerk-std-X
  * fBodyAccJerk-std-Y
  * fBodyAccJerk-std-Z
* fBodyGyro-[mean, std]-[X, Y, Z]: mean of the means (or the standard deviations) in the X (or Y, or Z) direction of space of the frequency domain gyroscope signal
  * fBodyGyro-mean-X
  * fBodyGyro-mean-Y
  * fBodyGyro-mean-Z
  * fBodyGyro-std-X
  * fBodyGyro-std-Y
  * fBodyGyro-std-Z
* fBodyAccMag-[mean, std]: mean of the means (or the standard deviations) of the magnitude of the frequency domain Body component of the acceleration signal
  * fBodyAccMag-mean
  * fBodyAccMag-std
* fBodyBodyAccJerkMag-[mean, std]: mean of the means (or the standard deviations) of the magnitude of the frequency domain Body component of the derivative of the acceleration signal
  * fBodyBodyAccJerkMag-mean
  * fBodyBodyAccJerkMag-std
* fBodyBodyGyroMag-[mean, std]: mean of the means (or the standard deviations) of the magnitude of the frequency domain gyroscope signal
  * fBodyBodyGyroMag-mean
  * fBodyBodyGyroMag-std
* fBodyBodyGyroJerkMag-[mean, std]: mean of the means (or the standard deviations) of the magnitude of the frequency domain derivative of the gyroscope signal
  * fBodyBodyGyroJerkMag-mean
  * fBodyBodyGyroJerkMag-std