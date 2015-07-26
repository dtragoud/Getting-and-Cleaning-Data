# Here are the data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1. Merges the training and the test sets to create one data set.

temp1 <- read.table("train/X_train.txt")
temp2 <- read.table("test/X_test.txt")
Obs <- rbind(temp1, temp2)                                                      # construct the joint data.frame of observations (train, test)

temp1 <- read.table("train/subject_train.txt")
temp2 <- read.table("test/subject_test.txt")
Subs <- rbind(temp1, temp2)                                                     # construct the joint data.frame of subjects (train, test)

temp1 <- read.table("train/y_train.txt")
temp2 <- read.table("test/y_test.txt")
Lbls <- rbind(temp1, temp2)                                                     # construct the joint data.frame of labels (train, test)

rm(temp1, temp2)                                                                # delete the tmp variables

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")                                          # read the "features" table.
indices_mean_std <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])               # extract the indices of the mean and std measurements.
Obs <- Obs[, indices_mean_std]                                                  # match the values of Obs for the indices for mean and std.
names(Obs) <- features[indices_mean_std, 2]                                     # extract the names of the measurement for the indices.                              
names(Obs) <- gsub("\\(|\\)", "", names(Obs))                                   # replace () in the names above with a blank.
names(Obs) <- tolower(names(Obs))                                               # all names converted to lower letters.

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")                                 # read the relevant file
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))         # ommit underscore and caps
Lbls[,1] = activities[Lbls[,1], 2]                                              # combine Subs data with labels
names(Lbls) <- "activity"                                                       # appropriately name data

# 4. Appropriately labels the data set with descriptive activity names.

names(Subs) <- "subject"                                                        # appropriately name data
cleaned_data <- cbind(Subs, Lbls, Obs)                                          # column bind data Obs, Subs, Lbls
write.table(cleaned_data, "cleaned_data.txt")                                   # create clean data file

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of
# each variable for each activity and each subject.

uniqueSubjects = unique(Subs)[,1]                                               # calculate unique values from Lbls
numSubjects = length(unique(Subs)[,1])                                          # calculate number of unique values from Lbls
numActivities = length(activities[,1])                                          # calculate length of "activities"                                  
numCols = dim(cleaned_data)[2]                                                  # calculate number of columns for cleaned data                                              
tmpmtr = cleaned_data[1:(numSubjects*numActivities), ]                          # construct a temp matrix

# The following loop calculates the average of each variable and each activity and each subject
# using the data we constructed above. Finally, data are written to the ata_averages.txt

row = 1
for (s in 1:numSubjects) {
        for (a in 1:numActivities) {
                tmpmtr[row, 1] = uniqueSubjects[s]                              # cycle through all unique subjects
                tmpmtr[row, 2] = activities[a, 2]                               # cycle through all activities
                tmp <- cleaned_data[cleaned_data$subject==s & cleaned_data$activity==activities[a, 2], ]
                tmpmtr[row, 3:numCols] <- colMeans(tmp[, 3:numCols])            # write the mean data to the temp matrix
                row = row+1
        }
}

write.table(tmpmtr, "data_averages.txt")                                        # create clean data file with avgs