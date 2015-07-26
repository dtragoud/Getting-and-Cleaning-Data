"run_analysis.R" Code Book
========================

Original data taken from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Script run_analysis.R performs the following:

*Merges the training and the test sets to create one data set.

Firstly, the script merges train/X_train.txt with test/X_test.txt into a 10299x561 data frame. The original description lists  10299 Number of Instances and 561 Number of Attributes.
Secondly, the script merges train/subject_train.txt with test/subject_test.txt into a 10299x1 data frame (including subject IDs) and train/y_train.txt with test/y_test.txt into a 10299x1 data frame (including activity IDs).

Obs variable is used to store the merged data for the measurements (observations)
Subs variable is used to store the merged data for the subjects
Lbls variable is used to store the merged data for the labels

tmp1 and temp2 are used temporarily to join the data and are then deleted from workspace

*Extracts only the measurements on the mean and standard deviation for each measurement.

The script reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement into a 10299x66 data frame.

features variable is used to store the features.txt table data
indices_mean_std variable is used to store the indices of the mean and standard deviation measurements

*Uses descriptive activity names to name the activities in the data set.

The script reads activity_labels.txt and applies descriptive activity names to name the activities in the data set: 1. walking 2. walkingupstairs 3. walkingdownstairs 4. sitting 5. standing 6. laying

activities variable is used to store the activity_labels.txt table data

*Appropriately labels the data set with descriptive variable names. 

All feature names (attributes) and activity names are converted to lower case, underscores and brackets () are removed and the 10299x66 data frame containing features with 10299x1 data frames containing activity labels and subject IDs are merged into clean_data.txt, a 10299x68 data frame such that the first column contains subject IDs, the second column activity names, and the last 66 columns are measurements. 

cleaned_data variable is used to store the data frame containing the clean data

*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The scripts creates a independent tidy data set with the average of each measurement for each activity and each subject. The result is saved as data_averages.txt of dimensions 180x68. There are 66 attributes in the columns plus one column (first) containing the subject IDs and one more (second) containing the acvtivity IDs. There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.

uniqueSubjects is used to store the indices of the unique subjects of variable Subs
numSubjects is used to store the number of the above indices
numActivities is used to store the number of activities
numCols is used to stored the number of columns in cleaned_data
tmpmtr is used to store the temporary matrix we will used for writing the average clean data file

