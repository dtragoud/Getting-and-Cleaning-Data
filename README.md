How to use "run_analysis.R"
=========================

Data source can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzip the data at a folder e.g. C:\Users\YourName\Desktop\Clean_Data

Put run_analysis.R into C:\Users\YourName\Desktop\Clean_Data\UCI HAR Dataset

In RStudio navigate to the above folder and set it as the working directory

In RStudio give the command source("run_analysis.R")

Use data <- read.table("data_averages.txt") to read the data

In RStudio give the command dim(data) to check the dimensions of the data

Dimensions should be 180x68 since there are 30 subjects and 6 activities, thus for each activity and each subject we count 30*6 = 180 rows.
