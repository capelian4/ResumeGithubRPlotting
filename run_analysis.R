library(dplyr)

X_train <- read.table("C:/Users/CA/Downloads/HAR/1/train/X_train.txt", quote="", comment.char="")

Y_train <- read.table("C:/Users/CA/Downloads/HAR/1/train/y_train.txt", quote="", comment.char="")

X_test <- read.table("C:/Users/CA/Downloads/HAR/1/test/X_test.txt", quote="", comment.char="")

Y_test <- read.table("C:/Users/CA/Downloads/HAR/1/test/y_test.txt", quote="", comment.char="")

Features <- read.table("C:/Users/CA/Downloads/HAR/1/features.txt", quote="", comment.char="")

activity_labels <- read.table("C:/Users/CA/Downloads/HAR/1/activity_labels.txt", quote="", comment.char="")

subject_train <- read.table("C:/Users/CA/Downloads/HAR/1/train/subject_train.txt", quote="", comment.char="")

subject_test <- read.table("C:/Users/CA/Downloads/HAR/1/test/subject_test.txt", quote="", comment.char="")

Activity <- rbind (Y_train, Y_test)

names(Activity) <- "Activity"

View(Activity) 

Subject <- rbind(subject_train,subject_test)

names(Subject) <- "Subject"

View(Subject) 

Data <- rbind(X_train,X_test)

names(Data) <- Features[,"V2"]

View(Data) 

Data1 <- cbind.data.frame(Data$`tBodyAcc-mean()-X`, Data$`tBodyAcc-mean()-Y`, Data$`tBodyAcc-std()-X`, Data$`tBodyAcc-std()-Y`, Data$`tGravityAcc-mean()-X`, Data$`tGravityAcc-mean()-Y`, Data$`tGravityAcc-std()-X`, Data$`tGravityAcc-std()-Y`)
View(Data1) 

names(activity_labels$V1) <- "Activity_Code"

names(Activity) <- "Activity_Code"

names(Subject) <- "Subject_Code"

names(Data1)[1] <- "tBodyAcc-mean()-X"

names(Data1)[2] <- "tBodyAcc-means()-Y"

names(Data1)[3] <- "tBodyAcc-std()-X" 

names(Data1)[4] <- "tBodyAcc-std()-Y"

names(Data1)[5] <- "tGravityAcc-mean()-X"

names(Data1)[6] <- "tGravityAcc-mean()-Y"

names(Data1)[7] <- "tGravityAcc-std()-X"

names(Data1)[8] <- "tGravityAcc-std()-Y"

Data2 <- cbind(Subject, Activity, Data1)

View(Data2)

df <- tibble(Data2)

View(df) 

df1 <- group_by(df,Subject_Code,Activity_Code)

final_data <- summarise_all(df1,mean)

write.table(final_data,file="tidy_data_set.txt",row.name=FALSE)

View(final_data)

library(writexl)

write_xlsx(final_data,"C:\Users\CA\Documents\Final_Data.xlsx")
