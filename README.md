# Readme.md


In order to start the project, we want to merge the training and the tests sets to create one data set
The testx variable shows the data for an acitivity performed by one of the 30 volunteers. As said in the readme.txt, this data is a 561-feature vector with time and frequency domain variables. Then we put testx and testy together.
We also create a column called "dataset" so we can save the information of which data set is the data from ("train" or "test").

The same steps are repeate for "train", where trainx shows the data for an acitivity performed by one of the 30 volunteers.
After putting trainx and trainy together, we can finally bind test and train together. We also need to set the names to all the other variables.

Since there are duplicated column names, the select function from the dplyr package does not work. We need to get rid of those duplicated names in order for it to work.

Finally, for the last part of the project we use the aggregate function to group the data by activity and subject variables, and be able to find the mean for each of the measurements according to theses variables.


You should read the tidydata.txt file using the following code: 
tidydata <- read.table("tidydata.txt", header = TRUE)
