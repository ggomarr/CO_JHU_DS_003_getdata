# This script requires the workspace to contain the following files and folders:
# [workspace]/
#     |_UCI HAR Dataset/
#         |_activity_labels.txt
#         |_features.txt
#         |_train/
#         |   |_subject_train.txt
#         |   |_X_train.txt
#         |   |_y_train.txt
#         |_test/
#         |   |_subject_test.txt
#         |   |_X_test.txt
#         |   |_y_test.txt

# Load train activity data
train_activity<-read.table("./UCI HAR Dataset/train/y_train.txt")
# Load train test subject data
train_subject<-read.table("./UCI HAR Dataset/train/subject_train.txt")
# Load train feature data
train_data<-read.table("./UCI HAR Dataset/train/X_train.txt")
# Bind the three, column wise, into a single set, recycling train_data to avoid duplication
train_data<-cbind(train_activity,train_subject,train_data)

# Load test activity data
test_activity<-read.table("./UCI HAR Dataset/test/y_test.txt")
# Load test test subject data
test_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt")
# Load test feature data
test_data<-read.table("./UCI HAR Dataset/test/X_test.txt")
# Bind the three, column wise, into a single set, recycling test_data to avoid duplication
test_data<-cbind(test_activity,test_subject,test_data)

# Bind both test and train datasets, by row
mydata<-rbind(train_data,test_data)

# Load field names
field_names<-read.table("./UCI HAR Dataset/features.txt")
# Find fields to be kept in the original data files
keep_fields<-sort(c(grep("mean()",field_names$V2,fixed=TRUE),grep("std()",field_names$V2,fixed=TRUE)))
# Get list of field labels for later
keep_field_names<-as.character(field_names$V2[keep_fields])
# Remove parentheses from labels
keep_field_names<-gsub("\\()","",keep_field_names)
# These fields have shifted right by two in mydata because of the addition of 'activity' and 'test subject'
keep_fields<-keep_fields+2
# Add fields 1 ('activity') and 2 ('test subject') to the list of files to be kept from mydata
keep_fields<-c(1,2,keep_fields)
# Add 'activity' and 'test subject' field names to fields_names
keep_field_names<-c('activity','test.subject',keep_field_names)

# Keep only the fields to be kept
mydata<-mydata[,keep_fields]

# Load activity names
activity_names<-read.table("./UCI HAR Dataset/activity_labels.txt")
# Transform column 1 into a factor using the activity names as labels
mydata$V1<-factor(mydata$V1,labels=as.character(activity_names$V2))

# Add field names.
colnames(mydata)<-keep_field_names

# Aggregate using the mean grouping by 'activity' and 'test.subject'
final_data<-aggregate(mydata[-c(1,2)],by=list(mydata[,1],mydata[,2]),mean)
# Reorder by 'activity' then by 'test.subject'
final_data<-final_data[order(final_data[,1],final_data[,2]),]

# Readd the names of the first two fields
colnames(final_data)[1:2]<-keep_field_names[1:2]
# The field names could be just added at the end to avoid this last renaming step.
# The renaming step is necessary because the function aggregate will rename the aggregation keys to Group.1 and Group.2

# Save the final table to a text file
write.table(final_data,file="tidy_data.txt",row.name=FALSE)
