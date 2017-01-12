#read test data

test_file_name <- "D:/Data Science Specialization/Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt"

test_df <- read.table(test_file_name)

train_file_name <- "D:/Data Science Specialization/Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt"

train_df <- read.table(train_file_name)

#read variables

variables_file_name <- "D:/Data Science Specialization/Getting and Cleaning Data/UCI HAR Dataset/features.txt"

variables_df <- read.table(variables_file_name)

#merge two datasets

merged_df <- rbind(train_df, test_df)

#assign variable names to merged df

names(merged_df) <- variables_df$V2

#subset by std and mean

std_var <- grep("std", variables_df$V2)

mean_var <- grep("mean", variables_df$V2)

std_and_mean <- sort(c(std_var, mean_var))

merged_df <- merged_df[,std_and_mean]

#read labels

label_test_file_name <- "D:/Data Science Specialization/Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt"

label_test_df <- read.table(label_test_file_name)

label_train_file_name <- "D:/Data Science Specialization/Getting and Cleaning Data/UCI HAR Dataset/train/y_train.txt"

label_train_df <- read.table(label_train_file_name)

label_df <- rbind(label_train_df, label_test_df)

names(label_df) <- c("Activity_id")

#add label to dataset

merged_df <- cbind(merged_df, label_df)

#read activity table
activity_label_file_name <- "D:/Data Science Specialization/Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt"

label_tbl_df <- read.table(activity_label_file_name)

names(label_tbl_df) <- c("Activity_id","Activity_name")

#join dataset with activity table by activity_id
res_df <- merge(merged_df, label_tbl_df, by.x = "Activity_id")

col_idx <- grep("Activity_name", names(res_df))
res_df <- res_df[, c(col_idx, (1:ncol(res_df))[-col_idx])]


#handle names
names(res_df)<-gsub("std()", "STD", names(res_df))
names(res_df)<-gsub("mean()", "MEAN", names(res_df))
names(res_df)<-gsub("^t", "time", names(res_df))
names(res_df)<-gsub("^f", "frequency", names(res_df))
names(res_df)<-gsub("Acc", "Accelerometer", names(res_df))
names(res_df)<-gsub("Gyro", "Gyroscope", names(res_df))
names(res_df)<-gsub("Mag", "Magnitude", names(res_df))
names(res_df)<-gsub("BodyBody", "Body", names(res_df))

#
write.table(res_df, "./tidyData.txt", row.name=FALSE)

