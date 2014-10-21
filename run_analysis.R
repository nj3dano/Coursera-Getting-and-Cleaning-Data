#################################################################################
# D. Kessler Getting and Cleaning Data
# Coursera October 2014 course project
#################################################################################
# usage:
# source('./run_analysis.R')
# run_analysis()
#################################################################################
# Use of this dataset in publications must be acknowledged by referencing
# the following publication [1] 
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
# Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a 
# Multiclass Hardware-Friendly Support Vector Machine. International Workshop of
# Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.
# This dataset is distributed AS-IS and no responsibility implied or explicit can
# be addressed to the authors or their institutions for its use or misuse. Any
# commercial use is prohibited. Jorge L. Reyes-Ortiz, Alessandro Ghio,
# Luca Oneto, Davide Anguita. November 2012.
##############################################################################

library(reshape2)

# mydebug levels, 0 none, 1 some, 2 verbose
myDebug <- 0

run_analysis <- function() {  
    
    #############################################################################
    # PreStep. make sure data exists
    #############################################################################
    mainDir="."
    subDir<-"UCI HAR Dataset"
    
    if( (file.exists(file.path(mainDir, subDir))) ){
        if (myDebug == 1 ) {print("directory exists")}
        setwd(mainDir)  
    } else {
        if (myDebug == 1 ) {print("Need to create directory and get the data")}
        setwd(mainDir)
        setInternet2(use = TRUE)
        fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        destFile<-"getdata-projectfiles-UCI HAR Dataset.zip"
        download.file(fileUrl, destfile=destFile) 
        unzip(destFile) 
    }
    if (myDebug == 1 ) {print(getwd())}
    
    #############################################################################
    # 1. Merge the training and the test sets to create one data set
    #    do not need the inertial folder
    #    subject = which person, 1-30, total 30 volunteers
    #    y = which activity, 1-6, numerical code at time measurement taken
    #    X = 561 feature vector with time and frequency domain variables
    #############################################################################
    X_train <- read.table((paste(mainDir, "/", subDir,"/train/X_train.txt", sep= "")))
    y_train <- read.table((paste(mainDir, "/", subDir,"/train/y_train.txt", sep= "")))
    subject_train <- read.table((paste(mainDir, "/", subDir,"/train/subject_train.txt", sep= "")))
                               
    X_test <- read.table((paste(mainDir, "/", subDir,"/test/X_test.txt", sep= "")))
    y_test <- read.table((paste(mainDir, "/", subDir,"/test/y_test.txt", sep= "")))
    subject_test <- read.table((paste(mainDir, "/", subDir,"/test/subject_test.txt", sep= "")))

    # merge vertically, "stack" the rows of both tables train and test
    X_merged<-rbind(X_train, X_test)
    y_merged<-rbind(y_train, y_test)
    subject_merged<-rbind(subject_train, subject_test)
    
    if (myDebug == 1) {
        print(dim(X_train))        # 7352x561
        print(dim(y_train))        # 7352x1
        print(dim(subject_train))  # 7352x1
        print(dim(X_test))         # 2947x561
        print(dim(y_test))         # 2947x1
        print(dim(subject_test))   # 2947x1
        print(dim(X_merged))       # 10229x561
        print(dim(y_merged))       # 10229x1
        print(dim(subject_merged)) # 10229x1
    }
    
    #################################################################################
    # 2. Extract only measurements on mean and standard dev for each measurement
    #    A feature_vector, 561 objects of 2 variables, a number and a description
    #################################################################################
    features <- read.table((paste(mainDir, "/", subDir,"/features.txt", sep= "")),
                            header=FALSE,
                            col.names=c("featureid", "featurename"))
    
    # pull out mean and std, but don't pull out meanFreq for example
    # so you need to put the () in the pattern match on feature names
    # you end up with 66 objects (rows), 2 variables id and name
    rowsWanted<-subset(features, regexpr("(mean|std)\\(\\)",features$featurename) > 0)
    featureids<-rowsWanted[,1]
    featurenames<-rowsWanted[,2]
    
    # you want all the X data rows, but only columns matching the feature pattern
    # you end up with 10299 objects (rows) of 66 variables for mean and std
    X_merged<-X_merged[, featureids]
           
    #################################################################################
    # 3. Uses descriptive activity names to name the activities in the data set
    #    activity file has 6 objects of 2 variables, an id and activity label
    #################################################################################
    activity <- read.table((paste(mainDir, "/", subDir,"/activity_labels.txt", sep= "")),
                            header=FALSE,
                            col.names=c("activityid", "activitylabel"))
    
    # this adds a second column to y_merged
    #y_merged$activitylabel <- apply(y_merged, 1, function(x) activity$activitylabel[x])
    
    # this replaces the id with the activity label, leaving you one column
    y_merged[1] <- apply(y_merged, 1, function(x) activity$activitylabel[x])
    
    #################################################################################
    # 4. Appropriately label the data set (X_merged) with descriptive variable names
    #    per lecture, all lower case, no dashes, no parens, descriptive
    #################################################################################
    names(y_merged) <- "activity"
    names(subject_merged) <- "subject"
    
    # remove offenders to style
    featurenames <- tolower(featurenames)
    featurenames <- gsub("-", "", featurenames) 
    featurenames <- gsub("\\(", "", featurenames) 
    featurenames <- gsub("\\)", "", featurenames)
    
    # make names more descriptive
    featurenames <- sub("^t", "time", featurenames) 
    featurenames <- sub("^f", "frequency", featurenames) 
    featurenames <- gsub("bodybody", "body", featurenames)
    featurenames <- gsub("acc", "acceleration", featurenames)
    
    names(X_merged) <- featurenames  # 66 columns
    
    #################################################################################
    # 5. From the data set in step 4 creates a second, independent tidy data set
    #    with the average of each variable for each activity and each subject.
    #################################################################################
    
    # let's add the subject and activites to the data set, total 68 columns
    X_merged<-cbind(X_merged, y_merged, subject_merged)
    
    # reshape the data from wide to long form, molten
    melted = melt(X_merged, id = c("activity", "subject"), na.rm=TRUE)
    
    # reshape the molten data and aggregrate
    # By aggregating by subject and activities, the final data set has
    # 180 rows (30 subjects and 6 activities) and 68 variables
    tidy = dcast(melted, subject + activity ~ variable, mean)

    # write the tidy data set to a txt file per instructions
    write.table(tidy, file="tidy.txt", sep=" ", row.names=FALSE, col.names=TRUE)
    
    # give the instruction to read the data back in
    checktidydata <- read.table("tidy.txt", sep=" ", header=TRUE)
    print( "Tidy Data")
    print( dim(checktidydata) ) 
}
