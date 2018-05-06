# getting_cleaning_data_project

## the data

The data is stored in the "data" directory. It is the original data from the UCI Machine Learning Repository

Smartphone-Based Recognition of Human Activities and Postural Transitions Data Set
http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions

The data is broken out into test and training data. Each set contains the subjects' unique identifiers, the activities, and the measurements.

Files with activity and features descriptions are also shown.

## the R script

run_analysis.R

The script loads in the original study data and performs the following steps.

1. Merges the training and the test sets to create one data set.
   * The training and test sets are put into data frames and the subject, activity, and values are put into a single data frame using   cbind().
   * The data frames are given column headers from the features file
   * The test and training data are merged using rbind()
2. Extracts only the measurements on the mean and standard deviation for each measurement.
   * grep() is used to find any columns containing "mean" or "std" from the combined data frame
   * a new data frame is made to include only those columns (and the subject and activity) 
3. Uses descriptive activity names to name the activities in the data set
   * join() is used to replace the numeric activity values with their descriptions from the activity_labels file
4. Appropriately labels the data set with descriptive variable names.
   * the following steps are performed on the variable names to make them more descriptive
     1. replace t and f with time and frequency
     2. replace Acc with Acceleration
     3. replace Gyro with Gyroscope
     4. replace Freq with Frequency
     5. replace Mag with Magnitude
     6. replace -mean with Mean and -std with StdDev
     7. remove remaining "-" characters
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
   * the combined dataset is "melted" using melt() (part of the reshape2 package)
   * this creates a narrow dataset with one column called "value" showing the values and all of the measurement columns collapsed into one column called "variable"
   * dcast is used to create the summary of the mean of all subject and activity combinations for each measurment variable
   * this results in a wide form tidy data set which is stored in a variable called summary
   * write.csv() is used to write the summary to a csv file and save it in the data directory