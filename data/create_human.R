# Laura Venieri 26/11/2017
# Exercise 4 for IODS course: data wrangling on "Human development" and "Gender inequality" datas
# Meta files for the data can be found here: http://hdr.undp.org/en/content/human-development-index-hdi
# Technical notes: http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

#read the data sets
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#dimensions of the data sets
dim(hd)
dim(gii)

#structure
str(hd)
str(gii)

# access the dplyr library
library(dplyr)

#summaries
summary(hd)
summary(gii)

#rename the variables with (shorter) descriptive names
colnames(hd) <- c("rank", "country", "hdi", "life_exp", "exp_edu", "mean_edu","gni_c","gni_rank")
colnames(gii) <-  c("gii_rank", "country","gii", "mat_mort","ad_birth","repr_parl","sedu_f","sed_m","lab_f","lab_m")

# define a new column in gii: ratio of Female and Male populations with secondary education
gii <- mutate(gii, sedu_ratio= sedu_f/sed_m)

# define a new column in gii: ratio of labour force participation of females and males 
gii <- mutate(gii, lab_ratio=lab_f/lab_m)

# join the two datasets using country as identifier
human <- inner_join(hd, gii, by = "country")
str(human)
dim(human)

# save the data set in the data folder
write.csv(human, file="human.csv",row.names=FALSE)

