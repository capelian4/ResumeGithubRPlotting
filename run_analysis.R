##R script called run_analysis.R
> library(data.table)
> library(dplyr)
> library(tidyr)
> library(magrittr)
> library(readxl)
> library(writexl)

subject_test <- read.table("C:/Users/CA/Downloads/HAR/1/test/subject_test.txt", quote="", comment.char="")

View(subject_test)

X_test <- read.table("C:/Users/CA/Downloads/HAR/1/test/X_test.txt", quote="", comment.char="")

View(X_test)

y_test <- read.table("C:/Users/CA/Downloads/HAR/1/test/y_test.txt", quote="", comment.char="")

View(y_test)

subject_train <- read.table("C:/Users/CA/Downloads/HAR/1/train/subject_train.txt", quote="", comment.char="")

View(subject_train)

X_train <- read.table("C:/Users/CA/Downloads/HAR/1/train/X_train.txt", quote="", comment.char="")

View(X_train)

y_train <- read.table("C:/Users/CA/Downloads/HAR/1/train/y_train.txt", quote="", comment.char="")

View(y_train)

features <- read.table("C:/Users/CA/Downloads/HAR/1/features.txt", quote="", comment.char="")

activity_labels <- read.table("C:/Users/CA/Downloads/HAR/1/activity_labels.txt", quote="", comment.char="")

View(activity_labels)

names(subject_train)[1] <- "Subject"

names(subject_test)[1] <- "Subject"

Subject <- rbind(subject_train, subject_test)

X <- rbind(X_train, X_test)

Y <- rbind(y_train, y_test)

Data <- cbind(Subject, X, Y)

XMean <- colMeans(X, na.rm = TRUE)

X_SD <- X %>% summarise_if(is.numeric, sd)

X <- rbind(XMean, X_SD)

YMean <- colMeans(Y, na.rm = TRUE)

Y_SD <- Y %>% summarise_if(is.numeric, sd)

Y <- rbind(YMean, Y_SD)

Data2 <- cbind(Subject, X_SD, Y_SD)

names(Data2)[3-50] <- "SD"

names(Data2)[1] <- "Incident"

names(Data2)[2] <- "Features"

names(Data2)[47] <- "SD"

Data3 <- cbind(activity_labels, X_SD, Y_SD)

Data4 <- colMeans(Data3[sapply(Data3, is.numeric)])

View(Data4)

Data5 <- Data3[, c("SD")]

Data6 <- cbind(activity_labels, Data4)

View(Data5)

names(Data6)[1] <- "Activity_No."

names(Data6)[2] <- "Activity"

names(Data6)[3] <- "SD"

installed.packages(writexl)

write_xlsx(Data6,"C:\Users\CA\Documents\Data6.xlsx")
