The file with R code "run_analysis.R" performs the following steps to process the UCI Human Activity Recognition (HAR) Dataset:

1. Reading in the files and merging the training and the test sets to create one data set:
   1.1 Reading files:
     - Reading training tables (`x_train.txt`, `y_train.txt`, `subject_train.txt`).
     - Reading testing tables (`x_test.txt`, `y_test.txt`, `subject_test.txt`).
     - Reading feature vector from `features.txt`.
     - Reading activity labels from `activity_labels.txt`.
   1.2 Assigning variable names to the datasets.

2. Extracting only the measurements on the mean and standard deviation for each measurement:
   2.1 Reading variable names from `features`.
   2.2 Creating a vector to define which variables represent IDs, means, and standard deviations.
   2.3 Making a necessary subset from the merged dataset based on the defined vector.

3. Using descriptive activity names to label the activities in the dataset.

4. Appropriately labeling the dataset with descriptive variable names.

5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject:
   5.1 Making the second tidy data set by aggregating the data based on activity and subject.
   5.2 Writing the second tidy data set to a text file named "tidy_data.txt".

The code assumes that all the data is present in the same folder, uncompressed, and with the original names intact.

Regarding the variables used in the code:
- `x_train`, `y_train`, `x_test`, `y_test`, `subject_train`, and `subject_test` contain the data from the downloaded files.
- `x_data`, `y_data`, and `subject_data` merge the previous datasets for further analysis.
- `features` contains the correct names for the variables in `x_data`, which are applied to the column names stored in the dataframe.
