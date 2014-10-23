
DESCRIPTION OF WHAT run_analysis.R DOES:

	1. The script reads the test and trainning data (i.e. the files X_test.txt, y_test.txt, X_train.txt and y_train.txt). It also reads the activity labels (WALKING, STANDING, etc.) from the file activity_labels.txt and the feature names from the file features.txt.
        2. From the previous X_test.txt and X_train.txt, only the features whose name ends with mean(), mean()-{X,Y,Z}, std() or std()-{X,Y,Z} are considered for point 3. The total number of features taken from either X_test.txt or X_train.txt is 66.
	3. The selected data from X_test.txt (according to point 2) is appended to the end of the selected data from X_train.txt (according to point 2). Then the subject ID (numbers form 1 to 30) is appended to the right of the new data frame as a new variable and so is the activity code (numbers form 1 to 6). 
	4. Descriptive names are given to the variables (see the code book file). I have kept the original feature names obtained from features.txt.
	5. The activity variable is factored so that activity labels (obtained from activity_labels.txt) are also included. 
        5. Optionally the resulting data set is ordered according to activity label (ascending) and subject id (ascending). The data frame named fullDataSet is obtained this way. This data set correponds to step 4 in the project assignment.
	6. The resulting data frame is then split into a list with data frame elements. Each element in the list contains data from a single activity and a single subject.
	7. I build then a new data frame called avgDataSet in order to fill it later row by row. It is initalized as a copy of part of the data frame fullDataSet in order to keep the variables names and fix the size. The number of rows is fixed to the length of the split list resulting from point 6.
        8. I iterate through each element in the list splitDataSet (from point 6), get the corresponding data frame in it, average the columns and paste the results in the corresponding row of avgDataSet. The activity label and subject id are obtained from the name of the list element (e.g. "WALKING.1", "LAYING.12", etc.) using the strsplit() function. 
        9. Finally, I write the requested tidy data txt file requested in the step 5 of the project assignment.
        

HOW TO LOAD AND VIEW THE RESULTING TIDY DATA SET IN R:

        1. Set the working directory to where tinyDataSet.txt is.
        2. Type in the R console: data <- read.table("./tidyDataSet.txt", header = TRUE) 
        3. Type in the R console: View(data)

