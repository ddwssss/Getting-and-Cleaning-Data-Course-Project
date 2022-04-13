# The codebook for the tidy data set

## General info
You can read in the tidy data set tidy_data.txt into R via read.table("tidy.txt").
The is a table with dimensions 180 x 68. The first column is the subject, i.e. the person who is using the device.
The second column shows the activity. The residual columns show the accelerometer and gyroscope data. A list of these features can be found in the feature list.

## How the data are transformed by the script:
1) The data are simplified for processing
2) Define the standard deviations and means.
4) Perform steps 1-3 for the test and the training set.
5) Transform activity names into factors.
6) Reshape the data so that subjects and activities become a variables of two independent columns.
7) Save the data.
