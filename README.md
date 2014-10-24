Coursera-Getting-and-Cleaning-Data
==================================

Johns Hopkins MOOC class October 2014 Getting and Cleaning Data  
D. Kessler 10/21/14 - run_analysis.R README explanation of the script

###WHAT SCRIPT

**REQUIRED R SCRIPT:** You will have a file named `run_analysis.R` in the current directory.

###WHAT DATA

**SAMSUNG DATA DOWNLOADED:** The run_analysis.R script can be run as long as the Samsung data is also in your working directory with its subdirectories as created when the Samsung zip files are extracted. If the data is not there at run time, the script will download it and unzip it creating the subdirectories and giving access to the needed data.

**SAMSUNG DATA ORIGIN:** https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

**SAMSUNG ORIGINAL DATA DESCRIPTION:** http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Use of this dataset in publications must be acknowledged by referencing
the following publication [1] 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a 
Multiclass Hardware-Friendly Support Vector Machine. International Workshop of
Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.
This dataset is distributed AS-IS and no responsibility implied or explicit can
be addressed to the authors or their institutions for its use or misuse. Any
commercial use is prohibited. Jorge L. Reyes-Ortiz, Alessandro Ghio,
Luca Oneto, Davide Anguita. November 2012.

###PREREQUISITE

**REQUIRED PACKAGE:** make sure reshape2 package is installed. The reshape2 package for R,  provides a common framework for data reshaping and aggregation. It uses what is called `melting and casting`.  Hadley Wickham https://github.com/hadley/reshape
```
install.packages("reshape2")
```

###USAGE
```
install.packages("reshape2")    
source('./run_analysis.R')  
run_analysis()
```

###OUTPUT
The output should be the tidy data set, named tidy.txt, a space deliminted file that is created in your current working directory.

Upon running the script, when it finishes it will print the dimenstions of the tidy data, for example:

```
run_analysis()  
[1] "Tidy Data"  
[1] 180  68
```

###DEBUG:
The script has the ability to print out more information, if you want to see more information during its prossessing, then change the value of the myDebug variable which is near the beginning of the script.

myDebug levels, 0 none, 1 some, 2 verbose  
myDebug <- 0

### BRIEF OVERVIEW OF THE PROCESS
* _PreStep:_ Make sure data exists, if not, the script will download it and unzip it.

* _Step 1:_ Merge the training and the test sets to create one data set, You do not need the inertial folder. The subject data `subject_train.txt, subject_text.txt` is which person, 1-30, as there were a total of 30 volunteers. Activity data y, `y_train.txt, y_test.txt` is the activity, a value 1-6, which is a numerical code at the time the measurement is taken; and X, `X_train and X_test.txt` is a 561 feature vector with time and frequency domain variables. When you merge the data, stack it vertically.

* _Step 2:_ Open the feature data `features.txt`, and using that, extract only the measurements on mean and standard deviation for each measurement. The feature data is a feature_vector, 561 objects of 2 variables, a number and a description.  I determined the columns that represented the mean and standard deviation were mean() and std() leading me to select 66 features. I did not include meanFreq, gravityMean, tBodyAccMean and tBodyAccJerkMean because they are weighted averages, and not a mean. I am taking the position that mean and average are not the same, mean is the middle of the integer in given series, and average is the ratio of sum of all numbers and amount of numbers.  Thus these are the 66 columns I selected from the original data. You want all the X data rows, but only columns matching the feature pattern for mean and std so you end up with 10299 objects (rows) of 66 variables for mean and standard deviation.

    Refer to the CodeBook for the set of variables estimated.

* _Step 3:_ Open the `activity_labels.txt` file and use the descriptive activity names to name the activities in the data set. The activity file has 6 objects of 2 variables, an id and activity label.

* _Step 4:_ Appropriately label the data set (X_merged) with descriptive variable names. I will make them all lower case, with no dashes, no parenthesis and more descriptive names. I will expand acc to acceleration, t to time, f to frequency and bodybody to body; as well as delete all the dashes and parenthesis. This results in new names for the variables, 66 in total.

    Refer to the CodeBook for the specific names of the variables.
    
* _Step 5:_ From the data set in step 4 create a second, independent tidy data set
with the average of each variable, for each activity and each subject. By aggregating the subject and activities, we end up with a final data set of 180 rows (30 subjects, 6 activites each) and 68 variables, the 66 measures and the activity and subject.  This data set meets the criteria for tidy data.
