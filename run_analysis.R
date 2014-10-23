
#Read all the data
dataSet1 <- read.table("./UCI_HAR_Dataset/test/X_test.txt", header = FALSE, 
                       sep = "", dec = ".", fill = TRUE)
dataSet2 <- read.table("./UCI_HAR_Dataset/train/X_train.txt", header = FALSE, 
                       sep = "", dec = ".", fill = TRUE)
labels1 <- read.table("./UCI_HAR_Dataset/test/y_test.txt", header = FALSE, 
                      sep = "")
labels2 <- read.table("./UCI_HAR_Dataset/train/y_train.txt", header = FALSE, 
                      sep = "")
subjects1 <- read.table("./UCI_HAR_Dataset/test/subject_test.txt", 
                        header = FALSE, sep = "")
subjects2 <- read.table("./UCI_HAR_Dataset/train/subject_train.txt", 
                        header = FALSE, sep = "")
reqFeatures <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 
             240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517,
             529:530, 542:543)
featureNames <- read.table("./UCI_HAR_Dataset/features.txt", header = FALSE, 
                           sep = "")
activityLabels <- read.table("./UCI_HAR_Dataset/activity_labels.txt", 
                             header = FALSE, sep = "")
activityLabels$V2 <- as.vector(activityLabels$V2)

#build the joint data set
dataSet <- rbind(dataSet1[, reqFeatures], dataSet2[, reqFeatures])
labels <- rbind(labels1, labels2)
subjects <- rbind(subjects1, subjects2)
fullDataSet <- cbind(labels, subjects, dataSet)
names(fullDataSet) <- c("Activity", "Subject", 
                        as.vector(featureNames[reqFeatures,2]))
fullDataSet$Activity <- factor(fullDataSet$Activity, levels = activityLabels$V1, 
                               labels = activityLabels$V2)
# optionally order the set by activity and subject
fullDataSet <- fullDataSet[order(fullDataSet$Activity, -fullDataSet$Subject, 
                                 decreasing = TRUE), ]

#build a tidy data set with average values in fullDataSet 
splitDataSet <- split(fullDataSet[,c(3:length(fullDataSet))], fullDataSet[,c(1,2)])
activitySubjectInSplit <- names(splitDataSet)
avgDataSet <- fullDataSet[c(1:length(splitDataSet)),]
for (index in seq_along(splitDataSet)) {
        tempDF <- as.data.frame(splitDataSet[index])
        actSubject <- unlist(strsplit(activitySubjectInSplit[index], "[.]"))
        avgDataSet[index,1:2] <- actSubject
        avgDataSet[index,3:length(avgDataSet)] <- colMeans(tempDF, na.rm = FALSE)        
}

#write the file
file <- file("./tidyDataSet.txt",open="wt")
write.table(avgDataSet, file = file, row.names = FALSE)
close(file)

