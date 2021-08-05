# ------------------------------------------------------------------------------
# Processing the "Human Activity Recognition Using Smartphones" dataset
# Alemu Tadesse
# ------------------------------------------------------------------------------

### Instruction an R script called run_analysis.R that does the following tasks. 

#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Load: activity
Activity <- read.table("C:/Users/antoe76/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
#Create activity labels
Activity_labels<-Activity[,2]
# Load: featires
features <- read.table("C:/Users/antoe76/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
#Create features labels
features<-features[,2]

# Extract features of the mean and standard deviation for each measurement.
extract_features <- grepl("mean|std", features)

# Load data, add activity labels
X_test <- read.table("C:/Users/antoe76/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
# Extracting the measurement on the mean and standard deviation. 
#X_test = X_test[,extract_features]
dim(X_test)
#[1] 2947  561
length(features)
names(X_test) = features
X_test = X_test[,extract_features]

Y_test <- read.table("C:/Users/antoe76/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("C:/Users/antoe76/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
activity_id<-Y_test[,1]
activity_labels <- read.table("C:/Users/antoe76/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
activity_labels<-activity_labels[,2]
Y_test[,2] = activity_labels[activity_id]
names(Y_test) = c("ActivityID", "ActivityLabel")
View(subject_test) # check what the dat looks like 
names(subject_test) = "Subject"

# since subject_text, x_test and y_test have the same number of rows we can combine them columnwise (cbind)
test_data <- cbind(subject_test, Y_test, X_test)
#names(test_data)<-c("Subject","ActivityID","ActivityLabel")
# Load the X_train & y_train data and apply a similar manipulation as the test data sets shown above 
X_train <- read.table("C:/Users/antoe76/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("C:/Users/antoe76/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("C:/Users/antoe76/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
names(X_train) = features
# Extract only the measurements on the mean and standard deviation for each measurement.
X_train = X_train[,extract_features]


# Load activity data
train_activity_id<-Y_train[,1]
Y_train[,2] = activity_labels[train_activity_id]
names(Y_train) = c("ActivityID", "ActivityLabel")
names(subject_train) = "Subject"

# Cimbine the training dataset
train_data <- cbind(subject_train, Y_train, X_train)

# Merge the test and trainining datasets 
#check if they have the same number of columns for row binding of the datasets 
dim(test_data)
# 2947   82
dim(train_data)
#7352   82

#test_and_train_data = rbind(test_data, train_data)

#The following line produced error 
#Error in match.names(clabs, names(xi)) : 



 # names do not match previous names
 # The error was that the first column nae of the two datasets is different 
 # How did I find that ?
 #names(train_data)==names(test_data)
 #[1] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#[22]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#[43]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#[64]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#View(test_data)


# rename the first ciluymn of test_data as "Subject" - Upper case "S" and then combine the datasets
names(test_data)[names(test_data) == 'subject'] <- 'Subject'
test_and_train_data = rbind(test_data, train_data)

# relabeling the datasets 
names(test_and_train_data)<-gsub("Gyro", "Gyroscope", names(test_and_train_data))
names(test_and_train_data)<-gsub("^t", "time", names(test_and_train_data))
names(test_and_train_data)<-gsub("Mag", "Magnitude", names(test_and_train_data))
names(test_and_train_data)<-gsub("^f", "frequency", names(test_and_train_data))
names(test_and_train_data)<-gsub("Acc", "Accelerometer", names(test_and_train_data))
names(test_and_train_data)<-gsub("BodyBody", "Body", names(test_and_train_data))
names(test_and_train_data)<-gsub("tBody", "TimeBody", names(test_and_train_data))
names(test_and_train_data)<-gsub("-mean()", "Mean", names(test_and_train_data))
names(test_and_train_data)<-gsub("-std()", "STD", names(test_and_train_data))
names(test_and_train_data)<-gsub("-freq()", "Frequency", names(test_and_train_data))
names(test_and_train_data)<-gsub("angle", "Angle", names(test_and_train_data))
names(test_and_train_data)<-gsub("gravity", "Gravity", names(test_and_train_data))


write.csv(test_and_train_data, file = "C:/Users/antoe76/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/tidy_data.csv",row.names=FALSE)
