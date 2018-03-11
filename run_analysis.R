library(dplyr)

if (!file.exists('data.zip')) {
  download.file(url='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', destfile="./data.zip")
}

unzip(zipfile='data.zip', exdir='data')

dataPath <- './data/UCI HAR Dataset'

trainingSet <- read.table(file.path(dataPath, 'train/X_train.txt'))
trainingLabels <- read.table(file.path(dataPath, 'train/y_train.txt'))
trainingSubjects <- read.table(file.path(dataPath, 'train/subject_train.txt'))

testSet <- read.table(file.path(dataPath, 'test/X_test.txt'))
testLabels <- read.table(file.path(dataPath, 'test/y_test.txt'))
testSubjects <- read.table(file.path(dataPath, 'test/subject_test.txt'))

activityNames <- read.table(file.path(dataPath, 'activity_labels.txt'))

featureNames <- read.table(file.path(dataPath, 'features.txt'))

# assign column names
colnames(trainingSet) <- featureNames[,2]
colnames(trainingLabels) <- "activityId"
colnames(trainingSubjects) <- "subjectId"

trainingDataMerged <- cbind(trainingSet, trainingLabels, trainingSubjects)

colnames(testSet) <- featureNames[,2]
colnames(testLabels) <- "activityId"
colnames(testSubjects) <- "subjectId"

testDataMerged <- cbind(testSet, testLabels, testSubjects)

combinedTestAndTrainingData <- rbind(trainingDataMerged, testDataMerged)

combinedTestAndTrainingData <- combinedTestAndTrainingData[, !duplicated(colnames(combinedTestAndTrainingData))]
combinedTestAndTrainingData <- mutate(combinedTestAndTrainingData, activityName = activityNames[activityId,2])

allMeanStdData <- select(combinedTestAndTrainingData, matches('mean|Mean|std|Std|activityName|subjectId'))


