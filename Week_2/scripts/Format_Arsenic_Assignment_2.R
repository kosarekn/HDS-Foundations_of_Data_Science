## Load the haven library to read in .xpt files
library(haven)

## Read in files
arsenic_df <- read_xpt("/Users/f002yt8/Documents/GitHub/HDS-Foundations_of_Data_Science/Week_2/Data/UTAS_I.xpt")
demographics_df <- read_xpt("/Users/f002yt8/Documents/GitHub/HDS-Foundations_of_Data_Science/Week_2/Data/DEMO_I.xpt")

head(arsenic_df)
head(demographics_df)

arsenic_df <- arsenic_df[,c("SEQN","URXUAS","URDUASLC")]
demographics_df <- demographics_df[,c("SEQN","RIAGENDR","RIDAGEYR","DMDMARTL","DMDEDUC2")]

final_df <- merge(demographics_df, arsenic_df, by="SEQN")

head(final_df)

colnames(final_df) <- c("Participant_ID","Gender","Age","Marital_Status","Education_Level","Arsenic_Total","Arsenic_Binary")

# Method 1: Using factor() with labels
final_df$Gender <- factor(final_df$Gender, 
                          levels = c(1, 2, "."), 
                          labels = c("Male", "Female", "Missing"))

final_df$Marital_Status <- factor(final_df$Marital_Status, 
                                  levels = c(1, 2, 3, 4, 5, 6, 77, 99, "."), 
                                  labels = c("Married", "Widowed", "Divorced", "Separated", "Never Married", "Living with a Partner", "Refused", "Don't Know", "Missing"))

final_df$Education_Level <- factor(final_df$Education_Level, 
                                   levels = c(1, 2, 3, 4, 5, 7, 9, "."), 
                                   labels = c("Less Than 9th Grade", "9-11th Grade", "High School", "Some College", "College or Above", "Refused","Don't Know", "Missing"))

levels(factor(final_df$Gender))
levels(factor(final_df$Marital_Status))
levels(factor(final_df$Education_Level))

head(final_df)

write.csv(final_df, "/Users/f002yt8/Documents/GitHub/HDS-Foundations_of_Data_Science/Week_2/Data/Assignment_2_Arsenic.csv")