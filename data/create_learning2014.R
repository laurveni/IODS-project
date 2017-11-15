#Laura Venieri 13/11/2017
#RStudio Exercise 2 for IODS course, data source: http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(lrn14) #dimension: 183 rows and 60 columns

str(lrn14) #data.frame: 183 obs. of  60 variables

library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14,one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14,one_of(keep_columns))

# see the stucture of the new dataset
str(learning2014)

# change the name of columns 2,3 and 7
colnames(learning2014)[2] <- "age"
colnames(learning2014)[3] <- "attitude"
colnames(learning2014)[7] <- "points"


# select rows where points is greater than zero
learning2014 <- filter(learning2014, points>0)

# see the stucture of the new dataset: 166 obs. of  7 variables
str(learning2014)

#save data in file learning2014.csv
write.csv(learning2014,file="data/learning2014.csv",row.names=FALSE)

#read the data
MyData <- read.csv(file="data/learning2014.csv")
str(MyData)
head(MyData)

