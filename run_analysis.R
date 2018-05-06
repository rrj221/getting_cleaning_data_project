##read meta data
features <- read.table("data/features.txt")
activityLabels <- read.table("data/activity_labels.txt")
names(activityLabels) <- c("activity", "activitylong")

##read test data
xtest <- read.table("data/test/X_test.txt")
ytest <- read.table("data/test/y_test.txt")
subjectTest <- read.table("data/test/subject_test.txt")

##read train data
xtrain <- read.table("data/train/X_train.txt")
ytrain <- read.table("data/train/y_train.txt")
subjectTrain <- read.table("data/train/subject_train.txt")

##consolidate test and train data
testData <- cbind(subjectTest, ytest, xtest)
trainData <- cbind(subjectTrain, ytrain, xtrain)

##add headers
names(testData) <- c("subject", "activity", as.character(features[,2]))
names(trainData) <- c("subject", "activity", as.character(features[,2]))

##combine data
combinedData <- rbind(testData, trainData)

##names
names <- c(1:2, grep("mean|std", features[,2])+2)
meanStdData <- combinedData[,names]

##add activity names
meanStdData <- join(meanStdData, activityLabels, by = "activity")
meanStdData$activity <- meanStdData$activitylong
meanStdData <- select(meanStdData, -activitylong)


##update the names here


##melt the data and dcast to create the summary
melt <- melt(meanStdData, id = c("subject", "activity"), measure.vars = names(meanStdData)[3:length(names(meanStdData))])
summary <- dcast(melt, subject + activity ~ variable, mean)

##write the summary to a csv
write.csv(summary, "data/summary.csv")

