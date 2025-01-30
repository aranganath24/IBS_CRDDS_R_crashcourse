# Introduction
#| eval: FALSE
# Install packages using the "install.packages" function
#| eval: FALSE
# Installing multiple packages by passing package names as strings to the "install.packages" function
#| warning: FALSE
#| message: FALSE
# load libraries
#| echo: false
# Preliminaries
# reads in PT data into R
# makes dataset copy
# Visualization with *ggplot2* 
## Bar Charts
# filters Africa observations
# Creates a bar chart of the "cgexp" variable (central government expenditure as a share of GDP) for the Africa observations and assigns the plot to an object named "cgexp_africa"
# prints contents of cgexp_africa
# Creates a bar chart of the "cgexp" variable (central government expenditure as a share of GDP) for the Africa observations; countries are on the x axis and arrayed in ascending order with respect to the cgexp variable, which is on the y-axis; plot is assigned to an object named "cgexp_africa_ascending"
# prints "cgexp_africa_ascending"
# Creates a bar chart of the "cgexp" variable (central government expenditure as a share of GDP) for the Africa observations; countries are on the x axis and arrayed in descending order with respect to the cgexp variable, which is on the y-axis; plot is assigned to an object named "cgexp_africa_descending"
# prints contents of "cgexp_africa_descending"
# creates a sideways bar chart using the "coord_flip" function and assigns it to a new object named "cgexp_africa_ascending_inverted"  
# prints "cgexp_africa_ascending_inverted"
# fixes x axis labels
# prints contents of "cgexp_africa_ascending_inverted"
## Scatterplots
# removes rows with NA values for "cgexp" and "trade; assigns cleaned dataset to object named "pt_copy_cleaned"
# Creates scatterplot with "cgexp" variable on x-axis and "trade" variiable on y-axis and assigns to object named "scatter_cgexp_trade"
# prints contents of "scatter_cgexp_trade"
# Creates scatterplot with "cgexp" variable on x-axis and "trade" variable on y-axis, and uses different color points for different continents; plot is assigned to object named "scatter_cgexp_trade_grouped"
# prints contents of "scatter_cgexp_trade_grouped"
# Creates continent-level subplots for scatterplot, using facets; assigns plot to new object named "scatter_cgexp_trade_facets"
# prints "scatter_cgexp_trade_facets"
# Creates scatterplot with "cgexp" variable on x-axis and "trade" variiable on y-axis, adds line of best fit; plot assigned to object named "scatter_cgexp_trade_line"
# Prints contents of "scatter_cgexp_trade_line"
# Elementary Data Analysis
## Computing Correlations
### Computing a correlation coefficient
# computes correlation coefficient between "trade" and "cgexp" variables and assigns the result to a new object named "trade_cgexp_cc"
# prints results of "trade_cgexp_cc"
# cleans up formatting of "trade_cgexp_cc"
# assigns well-formatted model output to "trade_cgexp_cc_clean"
### Generating a correlation matrix
# generating a correlation matrix
# Extracts variables for which we want a correlation matrix
# Creates correlation matrix from "desired_variables" object and assigns to object named "cor_matrix"
# prints contents of "cor_matrix"
## Basic Regression Models
### Bivariate Regression
# implements bivariate regression with "gexp" as DV and "trade" as IV; assigned to "regression1" object
# prints output of "regression1"
### Multivariate Regression
# Implements regression with "gexp" as DV, and assigns to object named "regression1"
# prints output of "regression2"
### Categorical Variables in a Regression Model
# prints class of "continent" variable
# adds "continent" categorical variable to previously run "regression2" model; output of model assigned to object named "regression3"
# opens model output of "regression3"
# Set "continent" variable as factor
# check levels of "continent" factor variable
# Relevels "continent" factor variable to set "other" as reference category
# check levels of "continent" factor variable
# runs regression model with releveled continent variable, "other" is excluded category
# prints model output of "regression4
# Use "continent" field to make continent dummy variables
# includes dummy variables in regression with "other" as the excluded category; model output assigned to object named "regression5"
# prints model output for "regression4"
### Interaction Terms
# run regression with interaction term between "trade" and "federal"
# prints "trade_federal_interaction" regression table
# Finds mean value of trade variable
# Calculates marginal effects of federalism, with "trade" held at mean
# Prints marginal effects table
# prints underlying structure of "marginal_effect_federalism"
# creates plot of "marginal_effect_federalism"; shows impact of federalism on cgexp when trade is held at means, with 95% confidence intervals
# prints contents of "marginal_effect_federalism_plotted"
# Integrating Datasets
## Data Transfer Part 2: Reading in Multiple Datasets
# prints the names of the files we want to read in and assigns the vector of strings to a new object named "worldbank_filenames" 
# reads world bank files into a list that is assigned to an object named "world_bank_list"
# prints contents of "world_bank_list"
# removes CSV extension from "worldbank_filenames"
# assigns names to datasets in "world_bank_list"
#| eval: false
# extracts fdi dataset from "world_bank_list" by assigned name
#| echo: false
## Joining Data
# extracts fdi dataset from "world_bank_list" by assigned name and assigns it to a new object named "wdi_fdi"
# extracts debt dataset from "world_bank_list" by assigned name and assigns it to a new object named "wdi_debt"
# drop na's in debt and FDI datasets and rename variables
# join together "wdi_fdi" and "wdi_fdi" using country code
## Appending Data
# extracts worldbank FDI data from "world_bank_list" and assigns it to the object "worldbank_fdi_2019"
# extracts worldbank trade data from "world_bank_list" and assigns it to the object "worldbank_trade_2019"
# Appends "worldbank_trade_2019" to "worldbank_fdi_2019" and assigns new dataset to object named "worldbank_trade_fdi"
## Reshaping Data
### Long to Wide
# cleans the dataset before reshaping
# converts "economic_variables" to numeric
# reshapes "worldbank_trade_fdi_cleaned" from long to wide and assigns the wide dataset to an object named "worldbank_trade_fdi_wide"
# renames columns in "worldbank_trade_fdi_wide"
#| eval: false
# Views "worldbank_trade_fdi_wide" in the Viewer
#| echo: false
### Wide to Long
# reshapes "worldbank_trade_fdi_wide" back to long format and assigns the reshaped dataset to a new object named "world_bank_trade_long"
## Automating Data Processing with Functions
# write function to clean World Bank dataset
# Iteratively apply "worldbank_cleaning_function" to all of the datasets in "world_bank_list", and deposit the cleaned datasets into a new list named "world_bank_list_cleaned"
# Data Transfer Part 2: Exporting Data
## Exporting a Data Frame
# exports "worldbank_trade_fdi_wide" to a local directory
## Exporting a Summary Statistics Table
#| eval: false
# writes summary statistics table "pt_copy_summarystats1_df"  as CSV
# exports a text summary stats table with stargazer
# exports an html summary stats table with stargazer
## Exporting Regression Tables
#| results: hide
# makes list container for regressions we want to export
#| results: hide
# exports regressions in "regression_list" via stargazer as html
#| results: hide
# exports regressions in "regression_list" via stargazer as text file
## Iteratively Exporting Multiple Data Frames
# create file names for exported World Bank files
# exports datasets in "world_bank_list_cleaned" to "outputs" directory using filenames in "WB_filenames_export"
# Exercises
