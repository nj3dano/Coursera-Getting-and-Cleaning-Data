Coursera-Getting-and-Cleaning-Data
==================================

Johns Hopkins MOOC class October 2014 Getting and Cleaning Data  
D. Kessler 10/21/14 - run_analysis.R README explanation of the script

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

### DATA SOURCE
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### DATA DESCRIPTION
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Human Activity Recognition data, multivariate with 10299 instances and 561 attributes. Recorded 30 subjects performing 6 activities.

###ACTIVITY LABELS
A data file, namely `activity_labels.txt` provides the mapping from a numerical representation to a description of y activity of daily life.
1=WALKING
2=WALKING_UPSTAIRS
3=WALKING_DOWNSTAIRS
4=SITTING
5=STANDING
6=LAYING

###FEATURE LABELS
A data file, namely `features.txt` come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. More information on this data is available in the `features_info.txt` file that you will find in your directory when your data is unzipped.

**These signals** were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.  
tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

**The set of variables estimated were:**  
mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation  
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.   
iqr(): Interquartile range  
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal   
kurtosis(): kurtosis of the frequency domain signal   
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between to vectors.  

**Additional set of vectors:**
Additional vectors obtained by averaging the signals in a signal window sample.
These are used on the angle() variable:  
gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean

###HUMAN ACTIVITY RECOGNITION DATA
Merge the training and the test sets to create one data set. The subject data `subject_train.txt, subject_text.txt` is which person, 1-30, as there were a total of 30 volunteers. Activity data y, `y_train.txt, y_test.txt` is the activity, a value 1-6, which is a numerical code at the time the measurement is taken; and X, `X_train and X_test.txt` is a 561 feature vector with time and frequency domain variables. When you merge the data, stack it vertically.

##FOR THIS PROJECT
###SUBSET OF THE DATA: MEAN and STANDARD DEVIATION
####Extracts only the measurements on the mean and standard deviation for each measurement.
I determined the columns that represented the mean and standard deviation were mean() and std() leading me to select 66 features. I did not include meanFreq, gravityMean, tBodyAccMean and tBodyAccJerkMean because they are weighted averages, and not a mean. I am taking the position that mean and average are not the same, mean is the middle of the integer in given series, and average is the ratio of sum of all numbers and amount of numbers.  Thus these are the 66 columns I selected from the original data. You want all the X data rows, but only columns matching the feature pattern for mean and std so you end up with 10299 objects (rows) of 66 variables for mean and standard deviation.

**The 66 variables I selected, as originally named:**  
    tBodyAcc-mean()-X           (column  1 )  
    tBodyAcc-mean()-Y           (column  2 )  
    tBodyAcc-mean()-Z           (column  3 )  
    tBodyAcc-std()-X            (column  4 )  
    tBodyAcc-std()-Y            (column  5 )  
    tBodyAcc-std()-Z            (column  6 )  
    tGravityAcc-mean()-X        (column  41 )  
    tGravityAcc-mean()-Y        (column  42 )  
    tGravityAcc-mean()-Z        (column  43 )  
    tGravityAcc-std()-X         (column  44 )  
    tGravityAcc-std()-Y         (column  45 )  
    tGravityAcc-std()-Z         (column  46 )  
    tBodyAccJerk-mean()-X       (column  81 )  
    tBodyAccJerk-mean()-Y       (column  82 )  
    tBodyAccJerk-mean()-Z       (column  83 )  
    tBodyAccJerk-std()-X        (column  84 )  
    tBodyAccJerk-std()-Y        (column  85 )  
    tBodyAccJerk-std()-Z        (column  86 )  
    tBodyGyro-mean()-X          (column  121 )  
    tBodyGyro-mean()-Y          (column  122 )  
    tBodyGyro-mean()-Z          (column  123 )  
    tBodyGyro-std()-X           (column  124 )  
    tBodyGyro-std()-Y           (column  125 )  
    tBodyGyro-std()-Z           (column  126 )  
    tBodyGyroJerk-mean()-X      (column  161 )  
    tBodyGyroJerk-mean()-Y      (column  162 )  
    tBodyGyroJerk-mean()-Z      (column  163 )  
    tBodyGyroJerk-std()-X       (column  164 )  
    tBodyGyroJerk-std()-Y       (column  165 )  
    tBodyGyroJerk-std()-Z       (column  166 )  
    tBodyAccMag-mean()          (column  201 )  
    tBodyAccMag-std()           (column  202 )  
    tGravityAccMag-mean()       (column  214 )  
    tGravityAccMag-std()        (column  215 )  
    tBodyAccJerkMag-mean()      (column  227 )  
    tBodyAccJerkMag-std()       (column  228 )  
    tBodyGyroMag-mean()         (column  240 )  
    tBodyGyroMag-std()          (column  241 )  
    tBodyGyroJerkMag-mean()     (column  253 )  
    tBodyGyroJerkMag-std()      (column  254 )  
    fBodyAcc-mean()-X           (column  266 )  
    fBodyAcc-mean()-Y           (column  267 )  
    fBodyAcc-mean()-Z           (column  268 )  
    fBodyAcc-std()-X            (column  269 )  
    fBodyAcc-std()-Y            (column  270 )  
    fBodyAcc-std()-Z            (column  271 )  
    fBodyAccJerk-mean()-X       (column  345 )  
    fBodyAccJerk-mean()-Y       (column  346 )  
    fBodyAccJerk-mean()-Z       (column  347 )  
    fBodyAccJerk-std()-X        (column  348 )  
    fBodyAccJerk-std()-Y        (column  349 )  
    fBodyAccJerk-std()-Z        (column  350 )  
    fBodyGyro-mean()-X          (column  424 )  
    fBodyGyro-mean()-Y          (column  425 )  
    fBodyGyro-mean()-Z          (column  426 )  
    fBodyGyro-std()-X           (column  427 )  
    fBodyGyro-std()-Y           (column  428 )  
    fBodyGyro-std()-Z           (column  429 )  
    fBodyAccMag-mean()          (column  503 )  
    fBodyAccMag-std()           (column  504 )  
    fBodyBodyAccJerkMag-mean()  (column  516 )  
    fBodyBodyAccJerkMag-std()   (column  517 )  
    fBodyBodyGyroMag-mean()     (column  529 )  
    fBodyBodyGyroMag-std()      (column  530 )  
    fBodyBodyGyroJerkMag-mean() (column  542 )  
    fBodyBodyGyroJerkMag-std()  (column  543 )  

#### APPROPRIATELY LABEL THE DATA SET
Appropriatly labeled the data set (X_merged) with descriptive variable names. I will make them all lower case, with no dashes, no parenthesis and more descriptive names. I will expand acc to acceleration, t to time, f to frequency and bodybody to body; as well as delete all the dashes and parenthesis. This results in the following new names for the data, which is 66 in total.  
     [1] "timebodyaccelerationmeanx"               
     [2] "timebodyaccelerationmeany"               
     [3] "timebodyaccelerationmeanz"               
     [4] "timebodyaccelerationstdx"                
     [5] "timebodyaccelerationstdy"                
     [6] "timebodyaccelerationstdz"                
     [7] "timegravityaccelerationmeanx"            
     [8] "timegravityaccelerationmeany"            
     [9] "timegravityaccelerationmeanz"            
    [10] "timegravityaccelerationstdx"             
    [11] "timegravityaccelerationstdy"             
    [12] "timegravityaccelerationstdz"             
    [13] "timebodyaccelerationjerkmeanx"           
    [14] "timebodyaccelerationjerkmeany"           
    [15] "timebodyaccelerationjerkmeanz"           
    [16] "timebodyaccelerationjerkstdx"            
    [17] "timebodyaccelerationjerkstdy"            
    [18] "timebodyaccelerationjerkstdz"            
    [19] "timebodygyromeanx"                       
    [20] "timebodygyromeany"                       
    [21] "timebodygyromeanz"                       
    [22] "timebodygyrostdx"                        
    [23] "timebodygyrostdy"                        
    [24] "timebodygyrostdz"                        
    [25] "timebodygyrojerkmeanx"                   
    [26] "timebodygyrojerkmeany"                   
    [27] "timebodygyrojerkmeanz"                   
    [28] "timebodygyrojerkstdx"                    
    [29] "timebodygyrojerkstdy"                    
    [30] "timebodygyrojerkstdz"                    
    [31] "timebodyaccelerationmagmean"             
    [32] "timebodyaccelerationmagstd"              
    [33] "timegravityaccelerationmagmean"          
    [34] "timegravityaccelerationmagstd"           
    [35] "timebodyaccelerationjerkmagmean"         
    [36] "timebodyaccelerationjerkmagstd"          
    [37] "timebodygyromagmean"                     
    [38] "timebodygyromagstd"                      
    [39] "timebodygyrojerkmagmean"                 
    [40] "timebodygyrojerkmagstd"                  
    [41] "frequencybodyaccelerationmeanx"          
    [42] "frequencybodyaccelerationmeany"          
    [43] "frequencybodyaccelerationmeanz"          
    [44] "frequencybodyaccelerationstdx"           
    [45] "frequencybodyaccelerationstdy"           
    [46] "frequencybodyaccelerationstdz"           
    [47] "frequencybodyaccelerationjerkmeanx"      
    [48] "frequencybodyaccelerationjerkmeany"      
    [49] "frequencybodyaccelerationjerkmeanz"      
    [50] "frequencybodyaccelerationjerkstdx"       
    [51] "frequencybodyaccelerationjerkstdy"       
    [52] "frequencybodyaccelerationjerkstdz"       
    [53] "frequencybodygyromeanx"                  
    [54] "frequencybodygyromeany"                  
    [55] "frequencybodygyromeanz"                  
    [56] "frequencybodygyrostdx"                   
    [57] "frequencybodygyrostdy"                   
    [58] "frequencybodygyrostdz"                   
    [59] "frequencybodyaccelerationmagmean"        
    [60] "frequencybodyaccelerationmagstd"         
    [61] "frequencybodybodyaccelerationjerkmagmean"  
    [62] "frequencybodybodyaccelerationjerkmagstd"   
    [63] "frequencybodybodygyromagmean"         
    [64] "frequencybodybodygyromagstd"             
    [65] "frequencybodybodygyrojerkmagmean"        
    [66] "frequencybodybodygyrojerkmagstd"

###TIDY DATA
The end result of computation is a file named `tidy.txt` which is a simple space delimited file written to the current working directory. It will be 180 rows (30 subjects and 6 activities) wih 68 variables which include the 66 mean and standard deviation columns plus one column for which subject and one column for which activity.  The data was reshaped and aggregrated resulting in a tidy data set with the average of each variable for each activity and each subject.
    
