# install packages
install.packages("psych")
install.packages("janitor")
install.packages("fastDummies")
install.packages("stargazer")
install.packages("gtsummary")
install.packages("ggeffects")

# install packages with a vector
install.packages(c("psych", "janitor", "fastDummies", "stargazer", "gtsummary",
                   "ggeffects"))


# load libraries
library(tidyverse)
library(janitor)
library(fastDummies)
library(stargazer)
library(gtsummary)
library(ggeffects)
library(summarytools)


# read in Persson-Tabellini data reads in the workshop dataset 
# (Persson and Tabellini cross-national dataset) by passing the file path as 
# an argument to the "read_csv" and assigns it to a new object named "pt"
pt<-read_csv("data/pt/persson_tabellini_workshop.csv")

# Views the dataset in the R Studio data viewer
View(pt)

# makes a copy of "pt", called "pt_copy" that we can use for processing and analysis; 
# keeps the original data frame, "pt" untouched
pt_copy<-pt

# makes toy dataset, assigned to object named "student_scores"
student_scores<-data.frame(ID=c(1:5),
                           Age=c(25, NA, 30, 22, NA),
                           Score=c(85, 90, NA, 78, 88))

# uses "is.na" to return a logical matrix indicating missing values (TRUE for missing values)
is.na(student_scores)

# calculates total number of missing values in "student_scores"
sum(is.na(student_scores))

# calculates total number of missing values per column
colSums(is.na(student_scores))

# calculates missing data percentage in "student_scores"
# first calculates count of missing values and assigns it to "total_missing"
total_missing<-sum(is.na(student_scores))

# calculates total number of cells and assigns it to "total_values"
total_values<-prod(dim(student_scores))

# calculates percentage of missing data and assigns it to "missing_pct"
missing_pct<-(total_missing/total_values)*100

# prints contents of "missing_pct"
missing_pct

# creates function to calculate the percentage of missing data in a dataset
missing_data_percentage<-function(dataset){
  # generate count of missing values
  total_missing<-sum(is.na(dataset))
  # calculates total number of cells
  total_values<-prod(dim(dataset))
  missing_pct<-(total_missing/total_values)*100
  return(missing_pct)
}
  

# passes "student_scores" as an argument to custom function
# "missing_data_percentage" which yields the percentage of missing
# data in the "student_scores" dataset
missing_data_percentage(student_scores)

# calculates missing data percentage in pt_copy
missing_data_percentage(pt_copy)

# calculates percentage of missing data per column in "student_scores" and 
# assigns the resulting vector to an object named "missing_pct_per_col"
missing_pct_per_col<-colSums(is.na(student_scores))/nrow(student_scores)*100


# prints contents of "missing_pct_per_col"
missing_pct_per_col

# removes all rows with NA values from "student_scores"
drop_na(student_scores)

# removes all rows where "Age" has NA values in "student_scores"
drop_na(student_scores, Age)

# removes all rows where "Score" has NA values in "student_scores"
drop_na(student_scores, Score)

# replace NA values in the "Score" column with 0
replace_na(student_scores, list(Score=0))

# calculates mean of "Score" (NA values are not excluded; default behavior)
mean(student_scores$Score)

# calculates mean of "Score" (NA values are excluded due to na.rm=TRUE specification; 
# as a result, the function computes an average based on non-NA values)
mean(student_scores$Score, na.rm=TRUE)

# Generate summary statistics for "pt_copy" and assign table of summary statistics 
# to a new object named "pt_copy_summarystats1"
pt_copy_summarystats1<-describe(pt_copy)

# prints contents of "pt_copy_summarystats1" to console
pt_copy_summarystats1

# View "pt_copy_summarystats1" in Viewer
View(pt_copy_summarystats1)

# creates toy dataset for illustrative purposes and assigns it to object named "df_sample"
df_sample<-data.frame(Country=c("A", "B", "C", "D"),
                      Variable=c(10, NA, 15, 20),
                      Variable2=c(5,8,12, NA))

# generates summary statistics with describe function and assigns it to
# "df_sample_summary_default"; na.rm=TRUE ignores NA values when calculating 
# summary statistics
df_sample_summary_default<-describe(df_sample, na.rm=TRUE)

# Views "df_sample_summary_default" in Viewer
View(df_sample_summary_default)

# # generates summary statistics with describe function and assigns it 
# to "df_sample_summary_B"; na.rm=FALSE removes rows with any NA values before 
# calculating summary statistics (in other words, summary statistics are 
# computed on rows with complete data)
df_sample_summary_B<-describe(df_sample, na.rm=FALSE)

# views "df_sample_summary_B" in Viewer
View(df_sample_summary_B)

# writes a function that takes a column as input and checks whether 
# there are any NA values in that column; returns TRUE if there is, FALSE otherwise
check_na<-function(column){
  any(is.na(column))
}

check_na(pt_copy$graft)

# discards columns in "pt_copy" that have missing data/NA Values, 
# and assigns the resulting data frame to a new object named "pt_copy_NAcolumns_removed"
pt_copy_NAcolumns_removed<-discard(pt_copy, check_na)

# Views "pt_copy_NAcolumns_removed" in data Viewer
View(pt_copy_NAcolumns_removed)


# passes "pt_copy_NAcolumns_removed" as an argument to "describe" function, 
# which generates summary statistics only for variables without missing observations;
# the table of summary statistics is assigned to a new object named 
# "pt_copy_NAcolumns_removed_summarystats"
pt_copy_NAcolumns_removed_summarystats<-describe(pt_copy_NAcolumns_removed)

# Views "pt_copy_NAcolumns_removed_summarystats" in Viewer
View(pt_copy_NAcolumns_removed_summarystats)

# creates function to take dataset input and return a table of 
# summary statistics only for variables that have no missing values
summary_stats_noNAcolumns<-function(dataset_input){
  cleaned_dataset<-discard(dataset_input, check_na)
  cleaned_summary_stats<-describe(cleaned_dataset)
  return(cleaned_summary_stats)
}

# passes "pt_copy" as argument to "summary_stats_noNAcolumns" function
summary_stats_noNAcolumns(pt_copy)

# Define a named function to count missing values
count_missing<-function(x){
  sum(is.na(x))
}

# applies "count_missing" function to the columns of "pt_copy", 
# and deposits the results (i.e. count of missing values in each column of "pt_copy") 
# to a numeric vector assigned to the object "missing_values_vector"
missing_values_vector<-map_dbl(pt_copy, count_missing)

# adds "missing_values_vector" as a column named "missing" to 
# "pt_copy_summarystats1" summary stats table
pt_copy_summarystats1$missing<-missing_values_vector

# Views pt_copy_summarystats1 in Viewer
View(pt_copy_summarystats1)

# selects columns from "pt_copy" that are numeric
pt_copy_numeric<-select_if(pt_copy, is.numeric)

# views "pt_copy_numeric" in data viewer
View(pt_copy_numeric)

# uses "descr" function from summarytools package to create a table of 
# summary statistics as a data frame and assigns it to "pt_summary_ST"
pt_summary_ST<-as.data.frame(descr(pt_copy))


# views "pt_summary_ST" in data viewer
View(pt_summary_ST)

# uses stargazer package to generate summary statistics for pt_copy
stargazer(as.data.frame(pt_copy), type="text")

# creates frequency table for the continent variable
freq(pt_copy$continent)

# creates crosstab with continent and federal variables
table(pt_copy$continent, pt_copy$federal)

# Creates summary statistics for each continent grouping, 
# and puts results in list named "summary_stats_by_continent"
summary_stats_by_continent<-describeBy(pt_copy, pt_copy$continent)

# Accessing continent-level summary statistics for africa from the 
# "summary_stats_by_continent" list
summary_stats_by_continent[["africa"]]

# Group-level summary statistics can be assigned to their own object for easy retrieval
africa_summary<-summary_stats_by_continent[["africa"]]

# Generate a table that displays summary statistics for trade at the 
# continent level and assign to object named "trade_age_by_continent"
trade_age_by_continent<-pt_copy %>% 
                          group_by(continent) %>% 
                            summarise(meanTrade=mean(trade), sdTrade=sd(trade),
                                      meanAge=mean(age), sdAge=sd(age),
                                      n=n())

# prints contents of "trade_age_by_continent"
trade_age_by_continent

# bring the "country" column to the front of the dataset
pt_copy<-pt_copy %>% relocate(country)

# Views "pt_copy" in data viewer
View(pt_copy)

# bring the "country", "list", "trade", "oecd" columns to the front of the dataset
pt_copy<-pt_copy %>% relocate(country, list, trade, oecd)

# View "pt_copy" in data viewer

# Renaming a variable (renames "list" to "party_list")
pt_copy<-pt_copy %>% rename(party_list=list)

# sorting in ascending (low to high) order with respect to the "trade" variable
pt_copy<-pt_copy %>% arrange(trade)

# sorting in descending (high to low) order with respect to the "trade" variable
pt_copy<-pt_copy %>% arrange(desc(trade))

# takes the "pt_copy" dataset, relocates "country", "continent", and "trade" 
# to the front of the dataset, and then arranges the dataset based on the 
# "continent" variable, then in descending order with respect to the "trade" variable


# Create new variable named "non_catholic_80" that is calculated by substracting the 
# Catholic share of the population in 1980 ("catho80") from 100  and relocates "country", 
# "catho80", and the newly created "non_catholic_80" to the front of the dataset
pt_copy<-pt_copy %>% 
          mutate(non_catholic_80=100-catho80) %>% 
          relocate(country, catho80, non_catholic_80)

# Selects "country", "cgexp", "cgrev", and "trade" variables from the 
# "pt_copy" dataset and assigns the selection to a new object named "pt_copy_selection"
pt_copy_selection<-pt_copy %>% 
                    select(country, cgexp, cgrev, trade, federal)

View(pt_copy_selection)

# deletes "federal" variable from "pt_copy_selection"
pt_copy_selection %>% select(-federal)

# deletes "federal" and "trade" from "pt_copy_selection" and assigns it to 
# new object named "pt_copy_selection_modified"
pt_copy_selection_modified<-pt_copy_selection %>% select(-c(federal, trade))
View(pt_copy_selection_modified)


# Creates a new dummy variable based on the existing "trade" variable named 
# "trade_open" (which takes on a value of "1" if "trade" is greater than or equal to 77, 
# and 0 otherwise) and then moves the newly created variable to the front of the dataset 
# along with "country" and "trade"; all changes are assigned to "pt_copy", 
# thereby overwriting the existing version of "pt_copy"
pt_copy<-pt_copy %>% mutate(trade_open=ifelse(trade>=77, 1, 0)) %>% 
                    relocate(country, trade_open, trade)


# Creates a new variable in the "pt_copy" dataset named "trade_level" 
# (that is coded as "Low Trade" when the "trade" variable is greater than 15 and 
# less than 50, coded as "Intermediate Trade" when "trade" is greater than or 
# equal to 50 and less than 100, and coded as "High TradE" when "trade" is 
# greater than or equal to 100), and then reorders the dataset such that "country", 
# "trade_level", and "trade" are the first three variables in the dataset
pt_copy<-pt_copy %>% 
          mutate(trade_level=case_when(trade>15 & trade<50~"Low Trade",
                                       trade>=50 & trade<100~"Intermediate Trade",
                                       trade>=100~"High_Trade")) %>% 
              relocate(trade_level, trade)

# Creates dummy variables from "trade_level" column, and relocates the 
# new dummies to the front of the dataset
pt_copy<-pt_copy %>% 
          dummy_cols("trade_level")

# Extracts OECD observations in "pt_copy" and assigns to object named "oecd_countries"
oecd_countries<-pt_copy %>% filter(oecd==1) %>% 
                    relocate(country, oecd)

# Extracts observations for which cgrev (central government revenue as % of gdp)>40, 
# and assigns to object named "high_revenues"
high_revenues<-pt_copy %>% filter(cgrev>40) %>% relocate(country, cgrev)
View(high_revenues)

# Extracts observations for which the "catho80" variable is less than or equal to 50
minority_catholic<-pt_copy %>% filter(catho80<=50) %>% relocate(country, catho80)

# Extracts federal OECD countries (where oecd=1 AND federal=1) and assigns to 
# a new object named "oecd_federal_countries"
oecd_federal_countries<-pt_copy %>% filter(oecd==1 & federal==1) %>% relocate(country, oecd, federal)
View(oecd_federal_countries)

# Extracts observations that are in Africa ("africa") OR in 
# Asia/Europe ("asiae) and assigns to an object named "asia_europe_africa"
asia_europe_africa<-pt_copy %>% filter(continent=="africa"|continent=="asiae") %>% relocate(continent)
View(asia_europe_africa)

# Extracts all non-Africa observations and assigns to object named "pt_copy_sans_africa"
pt_copy_sans_africa<-pt_copy %>% filter(continent!="africa") %>% relocate(continent)
View(pt_copy_sans_africa)

