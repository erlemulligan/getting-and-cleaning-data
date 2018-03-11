library(readr)
library(dplyr)

if (!file.exists('data.zip')) {
  download.file(url='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', destfile="./data.zip")
}

unzip(zipfile='data.zip', exdir='data')


