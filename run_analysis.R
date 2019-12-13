library(reshape2)
library(stringr)


# getting data
# download the dataset from UCI machine learning repository
download_data <- function(){      
      file_name <- "har_dataset.zip"
      if (!file.exists(file_name)) {
            file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
            download.file(file_url, file_name, method = "curl")
      }
}

download_data()

## unzip the dataset
unzip_data <- function(){
      if (!file.exists("UCI HAR Dataset")) {
            unzip(file_name)
      }
}

unzip_data()

# cleaning data
# load label data
load_data <- function(data){
      file_url <- sprintf("UCI HAR Dataset/%s.txt", data)
      assign(data, read.table(file_url, stringsAsFactors = FALSE), envir = .GlobalEnv)
}

load_data("activity_labels")
load_data("features")


# select labels with mean and std
selected_labels_index <- grep(".*mean.*|.*std.*", features[, 2])
selected_labels <- features[selected_labels_index, 2]



# add more information into the label names
make_label_names <- function(x) {
      x %>% tolower() %>%
            str_replace_all(c("^t" = "time_", "acc" = "_acceleration", 
                              "^f" = "frequency_", "gyro" = "_gyroscope",
                              "jerk" = "_jerk", "mag" = "_magnitude",
                              "-" = "_", "\\(\\)" = ""))
}

selected_labels <- make_label_names(selected_labels)

# load datasets
# load training datasets
get_train <- function(){
      load_train <- function(data){
            file_url <- sprintf("UCI HAR Dataset/train/%s.txt", data)
            assign(data, read.table(file_url, stringsAsFactors = FALSE), envir = .GlobalEnv)
      }
      
      for (i in c("X_train", "y_train", "subject_train")) {
            load_train(i)
      }
      
      X_train <- X_train[selected_labels_index]
      
      assign("train", cbind(subject_train, y_train, X_train), envir = .GlobalEnv)
}

get_train()

# load test datasets
get_test <- function(){
      load_test <- function(data){
            file_url <- sprintf("UCI HAR Dataset/test/%s.txt", data)
            assign(data, read.table(file_url, stringsAsFactors = FALSE), envir = .GlobalEnv)
      }
      
      for (i in c("X_test", "y_test", "subject_test")) {
            load_test(i)
      }
      
      X_test <- X_test[selected_labels_index]
      
      assign("test", cbind(subject_test, y_test, X_test), envir = .GlobalEnv)
      
}

get_test()

# merge datasets and add labels
all_data <- rbind(train, test)
colnames(all_data) <- c("subject", "activity", selected_labels)

all_data$activity <- factor(all_data$activity, 
                            levels = activity_labels[, 1], labels = activity_labels[, 2])
all_data$subject <- as.factor(all_data$subject)

# get mean for the dataset
all_data_melted <- melt(all_data, id = c("subject", "activity"))
all_data_mean <- dcast(all_data_melted, subject + activity ~ variable, mean)

# save the final dataset
write.table(all_data_mean, "tidy.txt", row.names = FALSE, quote = FALSE)




