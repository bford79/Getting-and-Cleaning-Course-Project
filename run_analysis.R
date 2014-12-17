# This script requires the dplyr package, so the first step is to install it if necessary and 
# load the package.
if("dplyr" %in% rownames(installed.packages()) == FALSE) 
     {install.packages("dplyr")}
library(dplyr)

# Then we read all of the relevant tables into R.

# The test subject group.
y_test <- read.table("UCI HAR Dataset/test/y_test.txt") # Activities for each row
x_test <- read.table("UCI HAR Dataset/test/X_test.txt") # Measurments for each row
subj_test <- read.table("UCI HAR Dataset/test/subject_test.txt") # Subjects for each row

# The training subject group.
y_train <- read.table("UCI HAR Dataset/train/y_train.txt") # Activities for each row
x_train <- read.table("UCI HAR Dataset/train/X_train.txt") # Measurments for each row
subj_train <- read.table("UCI HAR Dataset/train/subject_train.txt") # Subjects for each row

# Next, we combine the data tables for each group using cbind().
test <- cbind(subj_test, y_test, x_test)
train <- cbind(subj_train, y_train, x_train)

# Then, we use rbind() to combine all data into a single table, satisfying criterion #1 of
# the assingment.
raw_data <-rbind(test, train)

# Read the features tables into R and and name the variables of our raw data set based on this.
# Since these names are descriptive, this satisfies criterion #4 of the assignment.
features <- read.table("UCI HAR Dataset/features.txt")
features <- as.vector(features[,2]) # Creates vector that only contains the names.
features <- make.names(features, unique=T) # Changes the names so that they are unique and will 
                                           # not confuse R.
colnames <- c("Subj","Activity",features) # Adds column names for subject and activity variables.
colnames(raw_data) <- colnames # Changes column names of the raw data set.

# Rename the activity variables based on the activity_labels table. Satisfying criterion #3
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt") 
for (i in 1:nrow(raw_data)){
     for (x in 1:nrow(activity_labels)){
          if (raw_data[i,"Activity"] == activity_labels[x,1]){
               raw_data[i,"Activity"] <- as.character(activity_labels[x,2])
          }
     } 
}

# Now, we use the dplyr package to select only the mean and standard deviation variables and report
# the average of those measurements for each combination of subject and activity, satisfying
# criteria #2 and #5. NOTE: I chose not to include the "MeanFreq" variables because it is listed 
# seperately from mean() and std() in the features_info document and the assignment did not 
# explicitly ask for it.
raw_tbl <- tbl_df(raw_data)
means_tbl <- raw_tbl %>% 
     select(Subj, Activity, contains(".mean."), contains(".std.")) %>%
     group_by(Subj, Activity) %>%
     summarise_each(funs(mean)) %>%
     arrange(Subj, Activity)

write.table(means_tbl, file = "means_tbl.txt", row.name=F)

