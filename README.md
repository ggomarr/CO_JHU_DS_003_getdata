# getdataWk3Project
Assignment for Getting and Cleaning Data

## Introduction
The goal of this project is to extract and prepare tidy data from an intermediate dataset.

The intermediate dataset was constructed by a third party using raw data collected from the accelerometer and gyroscope of a Samsung Galaxy S smartphone during a series of experiments. The experiments involved 30 test subjects performing 6 different activities while carrying the smartphones on their hips. The raw measurements were then sampled using sliding time windows of 128 readings each. A total of 10299 of such windows are present in the data. Those windows were processed to remove noise and compute metrics that aimed to describe the activity taking place (such as means and standard deviations of the raw linear and angular accelerations across the 128 readings in the time window). A total of 561 metrics or features were calculated for each of the 10299 time windows, including metrics in both the time and the frequency domains.

In the intermediate dataset, each of the 10299 time windows is an observation, described by a feature vector of 561 metrics, and associated to one activity and one test subject.

The dataset was then divided into training and validation sets, which were used to train a classifier capable of identifying the activity taking place from the features calculated on the output of the accelerometer and gyroscope of the cell phone.

The following deliverables are expected:
* A tidy dataset, defined as a table containing the averages of a certain subset of the 561 features, calculated for each activity and test subject. The features we need are those that represent means or standard deviations
* A Github repo containing
  * A README.md file explaining what was done (this file)
  * An R script called run_analysis.R that takes care of the merging, extraction, labelling, and aggregation needed to construct the final tidy dataset
  * A code book called CodeBook.md that describes the variables, the data, and any transformations or work that were performed to clean up the data

It is expected that the notes on this file, those on the code book, and those on the script will have a certain degree of overlap.
  
The data was downloaded on 14 Mar 2015 from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The extracted folders contain more detailed information about the experiments, the raw data that was collected, and the metrics.

The intermediate dataset is divided into several text files:
* activity_labels.txt : maps the 6 activity ids to activity labels
* features.txt : provides field names for the 561 features of the intermediate datasets
* /train/ : contains the 7352 observations (~70% of the total) used to train the classifier
  * /train/y_train.txt : contains the activity code of each of the 7352 training observations
  * /train/subject_train.txt : contains the test subject id of each of the 7352 training observations
  * /train/X_train.txt : contains the 561 features of each of the 7352 training observations
* /test/ : contains the 2947 observations (~30% of the total) used to train the classifier
  * /test/y_test.txt : contains the activity code of each of the 2947 training observations
  * /test/subject_test.txt : contains the test subject id of each of the 2947 training observations
  * /test/X_test.txt : contains the 561 features of each of the 2947 training observations

## Methodology

The following steps will be taken:
* Merge 'activity', 'test subject', and 'feature data' for each of the train and test subdatasets separately
  * The resulting complete train dataset should have 563 fields and 7352 observations
  * The resulting complete test dataset should have 563 fields and 2947 observations
* Append the resulting two datasets into a single one with 563 fields and 10299 observations
* Extract only the features related to means and standard deviations for each observation 
  * These are identified by looking for variables containing the keywords 'mean()' and 'std()' in the file features.txt. A total of 66 such features exist
  * It can be argued that only the means and standard deviations of the features linked directly to the readings of the accelerometer and gyroscope were requested; this interpretation would reduce the number of features to be kept to 6. However, in line with the general sentiment found in the forums, all features that represent means and standard deviations will be kept
  * There are some features that themselves represent means of other features, identifiable by the keyword 'meanFreq()'. These second degree means will not be kept
  * The resulting dataset should contain 68 fields (one activity code, one test subject identifier, and 66 features) and 10299 observations
* Use descriptive activity names to name the activities in the dataset
  * The activity indexes are contained in column 1 of the dataset at this stage, and are mapped in the file activity_labels.txt. Column 1 will be replaced by a field of factors with the activty name
* Label the data set with descriptive variable names
  * The labels found in the file features.txt are considered descriptive enough. The paretheses will be removed to avoid problems with special characters on field names
* Creates the final tidy data set with the average of each feature for each activity and each subject
  * The file will be arranged as activity - subject - averages of the features
  * The tidy dataset will be ordered by activity, then by subject. The assumption is that the type of activity has more information than the type of subject, so the proposed order will cluster similar average observations together on the dataset
  * It is expected that the final tidy data set will contain 68 fields (one activity code, one test subject identifier, and the averages of each of the 66 features) and 180 observations (6 activities and 30 test subjects)
* Saves the final tidy data set as a text file