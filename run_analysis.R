library(plyr)
library(dplyr)

# Download the data files.
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","dataset.zip")

# Read in the features from "features.txt"
feature_list <- read.table("./UCI HAR Dataset/features.txt")

# Assign second column of "feature_list" to "feature_vector"
feature_vector <- feature_list[,"V2"]

# Read in X_train and assign column labels from 'feature_vector'.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=feature_vector,check.names = FALSE)

# Read in y_train and assign column label "Activity"
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names = "Activity")

# Read in subject_train and assign column label "Subject"
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = "Subject")

# Read in X_test and assign column labels from 'feature_vector'.
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=feature_vector,check.names = FALSE)

# Read in y_test and assign column label "Activity"
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names = "Activity")

# Read in subject_test and assign column label "Subject"
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = "Subject")

# Combine X_train and X_test to form df
df <- rbind.data.frame(X_train,X_test)

# Combine y_train and y_test to "Activity" column
activity <- rbind.data.frame(y_train,y_test)

# Combine subject_train and subject_test to "Subject" column
subject <- rbind.data.frame(subject_train,subject_test)

# Select columns that only contain means and standard deviations.
# The grep pattern is "mean\\(\\)" and "std\\(\\)"

# Select column names with means.
df1 <- df[ , grep("mean\\(\\)", names(df), perl = TRUE ) ]

# Select column names with standard deviations.
df2 <- df[ , grep("std\\(\\)", names(df), perl = TRUE ) ]

# Combine the two dataframe and place the columns in alphabetical order.
final_df <- cbind(df1,df2)
final_df <- final_df[,order(names(final_df))]

# Add activity and subject vectors to final_df
final_df <- cbind(activity,subject,final_df)

# Adjust typo for columns with "BodyBody" in their name.
names(final_df) <- gsub("BodyBody", "Body", names(final_df), fixed = TRUE)

# Uncode the activities in the "Activities" column
final_df$Activity[which(final_df$Activity == 1)] ="WALKING"
final_df$Activity[which(final_df$Activity == 2)] ="WALKING_UPSTAIRS"
final_df$Activity[which(final_df$Activity == 3)] ="WALKING_DOWNSTAIRS"
final_df$Activity[which(final_df$Activity == 4)] ="SITTING"
final_df$Activity[which(final_df$Activity == 5)] ="STANDING"
final_df$Activity[which(final_df$Activity == 6)] ="LAYING"

# Sort final_df by Activity and Subject
final_df <- final_df[order(final_df$Subject, final_df$Activity),]

# Calculate mean values for each of the columns
means <- suppressWarnings(aggregate(final_df,by = list(final_df$Activity,final_df$Subject),function (x) mean(as.numeric(as.character(x)))))

# Clean up columns in the "means" dataframe.
means <- subset(means, select=-c(Activity,Subject))
names(means)[names(means)=="Group.1"] <- "Activity"
names(means)[names(means)=="Group.2"] <- "Subject"

# To create 'tidy' data, place "Subject" column at beginning of dataframe.
means <- means %>% select(Subject, everything())
write.table(means,file="tidy_data.txt",row.name=FALSE)
