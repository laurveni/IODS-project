# Laura Venieri 19/11/2017
# Exercise 3 for IODS course (Logistic regression): data wrangling on the student performance data set found here https://archive.ics.uci.edu/ml/datasets/Student+Performance

# read the two data sets and check their structure and dimension
math <- read.table("student-mat.csv",sep = ";" , header=TRUE)
str(math)
dim(math)
por <- read.table("student-por.csv",sep = ";" , header=TRUE)
str(por)
dim(por)

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix=c(".math",".por"))
str(math_por)
dim(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))
# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# combine the 'duplicated' answers in the joined data
# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use' which is TRUE if alc_use >2
alc <- mutate(alc, high_use= alc_use>2)

# glimpse at the joined and unified data: 382 observations of 35 variables
glimpse(alc)

# save the data set
write.csv(alc, file="student-alc.csv",row.names=FALSE)

