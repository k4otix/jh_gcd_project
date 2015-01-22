# Getting and Cleaning Data - Course Project

library(dplyr)

# Read in data files
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=F)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors=F)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# Combine test and training sets
x_all <- rbind(x_train, x_test)

# Extract measurements related to the mean and standard deviation.
# Grep column names from features.txt for mean.*() and std.*()
# Apply these more descriptive names to columns, and remove parentheses
# from the variable names, replace hyphens to make them more R and user-friendly
colnames(x_all) <- features$V2
x_sub <- x_all[, grep("(mean|std).*\\(\\)", colnames(x_all))]
colnames(x_sub) <- gsub("\\(\\)", "", colnames(x_sub))
colnames(x_sub) <- gsub("-", "_", colnames(x_sub))

# Add descriptive activity names by binding the acitivity labels from y_train 
# and  y_test.  Replace the number with the corresponding activity_label
x_sub <- cbind(rbind(y_train, y_test), x_sub)
x_sub[,1] <- sapply(x_sub[,1], function(i) activity_labels[i,2])
colnames(x_sub)[1] <- "Activity"

# Add subject identifier to data frame and label the column
x_sub <- cbind(rbind(subject_train, subject_test), x_sub)
colnames(x_sub)[1] <- "Subject"

# Create a new tidy data set with the average of each variable grouped
# by subject and activity
tidy <- x_sub %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))

# Add column names, prefix each with "avg_" (except "Subject" and "Activity")
colnames(tidy)[3:81] <- paste0("avg_", colnames(tidy)[3:81])

# Write out the tidy data set
write.table(tidy, file="tidy.txt", row.name=F)