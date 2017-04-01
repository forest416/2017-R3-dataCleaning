# 2017-R3-dataCleaning

## prepare

Copy the R program file run_analysis.R to the same directory as file features file

## File read in process
features
activity_labels
train/subject_train
train/X_train
train/y_train
test/subject_train
test/X_train
test/y_train


## Steps of processing

* Read two data files,
* Re-format the class of column 
* assign variable name
* combine data with subject
* combine data with activity
* merge test and train dataset
* subset data and keep only interest variables: subject, activity and means and std fields.
* Calculate mean by activity and subject

