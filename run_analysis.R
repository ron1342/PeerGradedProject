## Peer Graded Assignment

## Getting and cleaning data course

library(dplyr)

# First of all, the codes below assume we are already in the "/UCI HAR Dataset" directory


## 1 - Merges the training and the test sets to create one data set. 

#Let's start by merging the training and the tests sets to create one data set

testx <- read.table("./test/X_test.txt", header = FALSE, sep ="")
testy <- read.table("./test/y_test.txt", header = FALSE, sep ="")
subjecttest <- read.table("./test/subject_test.txt", header = FALSE, sep ="")

# testx shows the data for an acitivity performed by one of the 30 volunteers.
# As said in the readme.txt, this data is a 561-feature vector with time and frequency domain variables.
# Let's put testx and testy together

testy <- rename(testy, activity = V1)
subjecttest <- rename(subjecttest, subject = V1)
test <- cbind(testy,subjecttest, testx)

# To finish, let's also create a column called "dataset" so we can save the information
# of which data set is the data from ("train" or "test")
whichdataset <- as.data.frame(rep("test", nrow(test)), responseName = "dataset")
colnames(whichdataset) <- c("dataset")

test <- cbind(whichdataset, test)


##arrange df vars by position - from "http://stackoverflow.com/questions/5620885/how-does-one-reorder-columns-in-a-data-frame"
##'vars' must be a named vector, e.g. c("var.name"=1)
arrange.vars <- function(data, vars){
        ##stop if not a data.frame (but should work for matrices as well)
        stopifnot(is.data.frame(data))
        
        ##sort out inputs
        data.nms <- names(data)
        var.nr <- length(data.nms)
        var.nms <- names(vars)
        var.pos <- vars
        ##sanity checks
        stopifnot( !any(duplicated(var.nms)), 
                   !any(duplicated(var.pos)) )
        stopifnot( is.character(var.nms), 
                   is.numeric(var.pos) )
        stopifnot( all(var.nms %in% data.nms) )
        stopifnot( all(var.pos > 0), 
                   all(var.pos <= var.nr) )
        
        ##prepare output
        out.vec <- character(var.nr)
        out.vec[var.pos] <- var.nms
        out.vec[-var.pos] <- data.nms[ !(data.nms %in% var.nms) ]
        stopifnot( length(out.vec)==var.nr )
        
        ##re-arrange vars by position
        data <- data[ , out.vec]
        return(data)
}

test <- arrange.vars(test, c("dataset"=3))

## Now we need to do the same steps for "train"

trainx <- read.table("./train/X_train.txt", header = FALSE, sep ="")
trainy <- read.table("./train/y_train.txt", header = FALSE, sep ="")
subjecttrain <- read.table("./train/subject_train.txt", header = FALSE, sep ="")

# trainx shows the data for an acitivity performed by one of the 30 volunteers.
# As said in the readme.txt, this data is a 561-feature vector with time and frequency domain variables.
# Let's put trainx and trainy together

trainy <- rename(trainy, activity = V1)
subjecttrain <- rename(subjecttrain, subject = V1)
train <- cbind(trainy,subjecttrain, trainx)

whichdataset <- as.data.frame(rep("train", nrow(train)), responseName = "dataset")
colnames(whichdataset) <- c("dataset")

train <- cbind(whichdataset, train)

train <- arrange.vars(train, c("dataset"=3))


# Now we can finally bind test and train together

data <- rbind(train, test)

# We also need to set the names to all the other variables

names <- read.csv("features.txt", header = FALSE, sep = " ")
names <- as.character(names$V2)
colnames(data) <- c("activity", "subject", "dataset", names)


## 2 - Extracts only the measurements on the mean and standard deviation for each measurement.

# Since there are duplicated column names, we need to get rid of those.
# The following code is a solution to this problem and it was extracted from "http://stackoverflow.com/questions/28549045/dplyr-select-error-found-duplicated-column-name"

data <- data[ , !duplicated(colnames(data))]

finaldata <- select(data, activity, subject, dataset, matches("(mean|std)\\(.*\\)"))

## 3 - Uses descriptive activity names to name the activities in the data set

# The following code to do this part was taken from: "http://stackoverflow.com/questions/6954017/r-replace-characters-using-gsub-how-to-create-a-function"

from <- c("1", "2", "3", "4", "5", "6")
to <- c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")
gsub2 <- function(pattern, replacement, x, ...) {
        for(i in 1:length(pattern))
                x <- gsub(pattern[i], replacement[i], x, ...)
        x
}

finaldata$activity <- gsub2(from, to, finaldata$activity)


## 4 - Appropriately labels the data set with descriptive variable names.

# This step was already performed in the previous steps. To know more about the variables, check the CodeBook.md file.


## 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


act <- aggregate(finaldata[4:69], by=list(finaldata$activity), mean)
type <- as.data.frame(rep("activity", nrow(act)), responseName = "type")
colnames(type) <- c("type")
act2 <- cbind(act, type)
act2 <- arrange.vars(act2, c("type"=2))

sub <- aggregate(finaldata[4:69], by=list(finaldata$subject), mean)
type <- as.data.frame(rep("subject", nrow(act)), responseName = "type")
colnames(type) <- c("type")
sub2 <- cbind(sub, type)
sub2 <- arrange.vars(sub2, c("type"=2))

final <- rbind(act2, sub2)

write.table(final, file="tidydata.txt", row.names = FALSE)
