treat.features.names <- function(features.file) {
  features.names <- as.character(read.table(file=features.file)[,2])
  features.names <- gsub("\\(\\)|\\(|\\)", "", features.names)
  features.names <- gsub("-|,", ".", features.names)
  features.names <- tolower(features.names)
  features.names
}

assemble.full.dataset <- function(train.folder, test.folder, features.file) {
  train.features <- read.table(file=paste0(train.folder,"//X_train.txt"))
  train.activities <- read.table(file=paste0(train.folder,"//y_train.txt"))  
  train.subjects <- read.table(file=paste0(train.folder,"//subject_train.txt"))  
  
  train.dataset <- cbind(train.activities, train.subjects, train.features)
  
  test.features <- read.table(file=paste0(test.folder,"//X_test.txt"))
  test.activities <- read.table(file=paste0(test.folder,"//y_test.txt"))  
  test.subjects <- read.table(file=paste0(test.folder,"//subject_test.txt"))  
  
  test.dataset <- cbind(test.activities, test.subjects, test.features)

  full.set <- rbind(train.dataset, test.dataset)
  
  names <- c("activity", "subject")
  names <- append(names,treat.features.names(features.file))

  names(full.set) <- names
  
  full.set
}

select.desired.features <- function(full.set) {
  features.names <- names(full.set)
  desired.columns <- features.names[grepl("activity|subject|\\.mean|\\.std", features.names)]
  desired.columns <- desired.columns[-grep("\\.meanfreq", desired.columns)]  
  
  selected.features <- full.set[,desired.columns]  
  selected.features  
}

set.activity.labels <- function(selected.set) {
  activity.labels <- read.table(file="activity_labels.txt")
  selected.set$activity <- activity.labels[selected.set$activity,2]
  
  selected.set
}

#Task #1 - Merges the training and the test sets to create one data set.
#Task #4 - Appropriately labels the data set with descriptive variable names.
full.set <- assemble.full.dataset("train","test", "features.txt")

#Task #2 - Extracts only the measurements on the mean and standard deviation for each measurement.
selected.set <- select.desired.features(full.set)

#Task #3 - Uses descriptive activity names to name the activities in the data set
selected.set <- set.activity.labels(selected.set)

#Task #5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
reshaped.set <- melt(selected.set, id=c("activity", "subject"))
summary.set <- dcast(reshaped.set, activity + subject ~ variable, mean)