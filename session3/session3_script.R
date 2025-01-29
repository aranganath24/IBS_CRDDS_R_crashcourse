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


# read in Persson-Tabellini data reads in the workshop dataset 
# (Persson and Tabellini cross-national dataset) by passing the file path as 
# an argument to the "read_csv" and assigns it to a new object named "pt"

# Views the dataset in the R Studio data viewer

# makes a copy of "pt", called "pt_copy" that we can use for processing and analysis; 
# keeps the original data frame, "pt" untouched

# makes toy dataset, assigned to object named "student_scores"

# uses "is.na" to return a logical matrix indicating missing values (TRUE for missing values)

# calculates total number of missing values in "student_scores"

# calculates total number of missing values per column

# calculates missing data percentage in "student_scores"
# first calculates count of missing values and assigns it to "total_missing"

# calculates total number of cells and assigns it to "total_values"

# calculates percentage of missing data and assigns it to "missing_pct"

# prints contents of "missing_pct"

# creates function to calculate the percentage of missing data in a dataset

# passes "student_scores" as an argument to custom function
# "missing_data_percentage" which yields the percentage of missing
# data in the "student_scores" dataset

# calculates missing data percentage in pt_copy

# calculates percentage of missing data per column in "student_scores" and 
# assigns the resulting vector to an object named "missing_pct_per_col"


# prints contents of "missing_pct_per_col"

# removes all rows with NA values from "student_scores"

# removes all rows where "Age" has NA values in "student_scores"

# removes all rows where "Score" has NA values in "student_scores"

# replace NA values in the "Score" column with 0

# calculates mean of "Score" (NA values are not excluded; default behavior)

# calculates mean of "Score" (NA values are excluded due to na.rm=TRUE specification; 
# as a result, the function computes an average based on non-NA values)

# Generate summary statistics for "pt_copy" and assign table of summary statistics 
# to a new object named "pt_copy_summarystats1"

# prints contents of "pt_copy_summarystats1" to console

# View "pt_copy_summarystats1" in Viewer

# creates toy dataset for illustrative purposes and assigns it to object named "df_sample"

# generates summary statistics with describe function and assigns it to
# "df_sample_summary_default"; na.rm=TRUE ignores NA values when calculating 
# summary statistics

# Views "df_sample_summary_default" in Viewer

# # generates summary statistics with describe function and assigns it 
# to "df_sample_summary_B"; na.rm=FALSE removes rows with any NA values before 
# calculating summary statistics (in other words, summary statistics are 
# computed on rows with complete data)

# views "df_sample_summary_B" in Viewer

# writes a function that takes a column as input and checks whether 
# there are any NA values in that column; returns TRUE if there is, FALSE otherwise


# discards columns in "pt_copy" that have missing data/NA Values, 
# and assigns the resulting data frame to a new object named "pt_copy_NAcolumns_removed"

# Views "pt_copy_NAcolumns_removed" in data Viewer


# passes "pt_copy_NAcolumns_removed" as an argument to "describe" function, 
# which generates summary statistics only for variables without missing observations;
# the table of summary statistics is assigned to a new object named 
# "pt_copy_NAcolumns_removed_summarystats"

# Views "pt_copy_NAcolumns_removed_summarystats" in Viewer

# creates function to take dataset input and return a table of 
# summary statistics only for variables that have no missing values

# passes "pt_copy" as argument to "summary_stats_noNAcolumns" function

# Define a named function to count missing values

# applies "count_missing" function to the columns of "pt_copy", 
# and deposits the results (i.e. count of missing values in each column of "pt_copy") 
# to a numeric vector assigned to the object "missing_values_vector"

# adds "missing_values_vector" as a column named "missing" to 
# "pt_copy_summarystats1" summary stats table

# Views pt_copy_summarystats1 in Viewer

# selects columns from "pt_copy" that are numeric

# views "pt_copy_numeric" in data viewer

# uses "descr" function from summarytools package to create a table of 
# summary statistics as a data frame and assigns it to "pt_summary_ST"

# views "pt_summary_ST" in data viewer

# uses stargazer package to generate summary statistics for pt_copy

# creates frequency table for the continent variable

# creates crosstab with continent and federal variables

# Creates summary statistics for each continent grouping, 
# and puts results in list named "summary_stats_by_continent"

# Accessing continent-level summary statistics for africa from the 
# "summary_stats_by_continent" list

# Group-level summary statistics can be assigned to their own object for easy retrieval

# Generate a table that displays summary statistics for trade at the 
# continent level and assign to object named "trade_age_by_continent"

# prints contents of "trade_age_by_continent"

# bring the "country" column to the front of the dataset

# Views "pt_copy" in data viewer

# bring the "country", "list", "trade", "oecd" columns to the front of the dataset

# View "pt_copy" in data viewer

# Renaming a variable (renames "list" to "party_list")

# sorting in ascending (low to high) order with respect to the "trade" variable

# sorting in descending (high to low) order with respect to the "trade" variable

# takes the "pt_copy" dataset, relocates "country", "continent", and "trade" 
# to the front of the dataset, and then arranges the dataset based on the 
# "continent" variable, then in descending order with respect to the "trade" variable


# Create new variable named "non_catholic_80" that is calculated by substracting the 
# Catholic share of the population in 1980 ("catho80") from 100  and relocates "country", 
# "catho80", and the newly created "non_catholic_80" to the front of the dataset

# Selects "country", "cgexp", "cgrev", and "trade" variables from the 
# "pt_copy" dataset and assigns the selection to a new object named "pt_copy_selection"

# deletes "federal" variable from "pt_copy_selection"

# deletes "federal" and "trade" from "pt_copy_selection" and assigns it to 
# new object named "pt_copy_selection_modified"


# Creates a new dummy variable based on the existing "trade" variable named 
# "trade_open" (which takes on a value of "1" if "trade" is greater than or equal to 77, 
# and 0 otherwise) and then moves the newly created variable to the front of the dataset 
# along with "country" and "trade"; all changes are assigned to "pt_copy", 
# thereby overwriting the existing version of "pt_copy"


# Creates a new variable in the "pt_copy" dataset named "trade_level" 
# (that is coded as "Low Trade" when the "trade" variable is greater than 15 and 
# less than 50, coded as "Intermediate Trade" when "trade" is greater than or 
# equal to 50 and less than 100, and coded as "High TradE" when "trade" is 
# greater than or equal to 100), and then reorders the dataset such that "country", 
# "trade_level", and "trade" are the first three variables in the dataset

# Creates dummy variables from "trade_level" column, and relocates the 
# new dummies to the front of the dataset

# Extracts OECD observations in "pt_copy" and assigns to object named "oecd_countries"

# Extracts observations for which cgrev (central government revenue as % of gdp)>40, 
# and assigns to object named "high_revenues"

# Extracts observations for which the "catho80" variable is less than or equal to 50

# Extracts federal OECD countries (where oecd=1 AND federal=1) and assigns to 
# a new object named "oecd_federal_countries"

# Extracts observations that are in Africa ("africa") OR in 
# Asia/Europe ("asiae) and assigns to an object named "asia_europe_africa"

# Extracts all non-Africa observations and assigns to object named "pt_copy_sans_africa"



