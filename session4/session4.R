# reads in PT data into R
pt<-read_csv("data/pt/persson_tabellini_workshop.csv")

# makes dataset copy
pt_copy<-pt

# filters Africa observations
pt_africa<-pt_copy %>% 
            filter(continent=="africa") %>% 
             drop_na(cgexp)

# Creates a bar chart of the "cgexp" variable (central government expenditure as a share of GDP) 
# for the Africa observations and assigns the plot to an object named "cgexp_africa"
cgexp_africa<-
  ggplot(pt_africa)+
  geom_col(aes(x=country, y=cgexp))+
  labs(
    title="Central Govt Expenditure as Pct of GDP for Select African Countries (1990-199)",
    x="Country Name",
    y="CGEXP")+
  theme(plot.title=element_text(hjust=0.5),
        axis.text.x=element_text(angle=90))

# prints cgexp_africa
cgexp_africa

# Creates a bar chart of the "cgexp" variable (central government expenditure as a share of GDP) 
# for the Africa observations; countries are on the x axis and arrayed in ascending order with 
# respect to the cgexp variable, which is on the y-axis; plot is assigned to an object named 
# "cgexp_africa_ascending"
cgexp_africa_ascending<-
  ggplot(pt_africa)+
  geom_col(aes(x=reorder(country, cgexp), y=cgexp))+
  labs(
    title="Central Govt Expenditure as Pct of GDP for Select African Countries (1990-199)",
    x="Country Name",
    y="CGEXP")+
  theme(plot.title=element_text(hjust=0.5),
        axis.text.x=element_text(angle=90),
        axis.title.x=element_text(margin=margin(t=20)))


# prints "cgexp_africa_ascending"
cgexp_africa_ascending


# Creates a bar chart of the "cgexp" variable (central government expenditure as a share of GDP) 
# for the Africa observations; countries are on the x axis and arrayed in descending order 
# with respect to the cgexp variable, which is on the y-axis; plot is assigned to 
# an object named "cgexp_africa_descending"
cgexp_africa_descending<-
  ggplot(pt_africa)+
  geom_col(aes(x=reorder(country, -cgexp), y=cgexp))+
  labs(
    title="Central Govt Expenditure as Pct of GDP for Select African Countries (1990-199)",
    x="Country Name",
    y="CGEXP")+
  theme(plot.title=element_text(hjust=0.5),
        axis.text.x=element_text(angle=90),
        axis.title.x=element_text(margin=margin(t=20)))


# prints contents of "cgexp_africa_descending"
cgexp_africa_descending

# creates a sideways bar chart using the "coord_flip" function and assigns it to a 
# new object named "cgexp_africa_ascending_inverted"  
cgexp_africa_ascending_inverted<-cgexp_africa_ascending+
                                    coord_flip()


# prints "cgexp_africa_ascending_inverted"
cgexp_africa_ascending_inverted


# fixes x axis labels
cgexp_africa_ascending_inverted<-cgexp_africa_ascending_inverted+
                                  theme(axis.text.x=element_text(angle=0))

# prints contents of "cgexp_africa_ascending_inverted"
cgexp_africa_ascending_inverted

# removes rows with NA values for "cgexp" and "trade; assigns cleaned dataset to 
# object named "pt_copy_cleaned"
pt_copy_cleaned<-pt_copy %>% drop_na(cgexp, trade)

# Creates scatterplot with "cgexp" variable on x-axis and "trade" 
# variable on y-axis and assigns to object named "scatter_cgexp_trade"
scatter_cgexp_trade<-
  ggplot(pt_copy_cleaned)+
  geom_point(aes(x=cgexp, y=trade))+
  labs(title="Trade Share of GDP \nas a function of \n Central Govt Expenditure (1990-1999)",
       x="Central Government Expenditure (Pct of GDP", y="Overall Trade (Pct of GDP)")+
  theme(plot.title=element_text(hjust=0.5))

# prints contents of "scatter_cgexp_trade"
scatter_cgexp_trade

# Creates scatterplot with "cgexp" variable on x-axis and "trade" variable on y-axis, 
# and uses different color points for different continents; plot is assigned to object 
# named "scatter_cgexp_trade_grouped"
scatter_cgexp_trade_grouped<-
  ggplot(pt_copy_cleaned)+
  geom_point(aes(x=cgexp, y=trade, color=continent))+
  labs(title="Trade Share of GDP \nas a function of \n Central Govt Expenditure (1990-1999)",
       x="Central Government Expenditure (Pct of GDP", y="Overall Trade (Pct of GDP)")+
  theme(plot.title=element_text(hjust=0.5))

# prints contents of "scatter_cgexp_trade_grouped"
scatter_cgexp_trade_grouped

# Creates continent-level subplots for scatterplot, using facets; assigns plot 
# to new object named "scatter_cgexp_trade_facets"
scatter_cgexp_trade_facets<-
  ggplot(pt_copy_cleaned)+
  geom_point(aes(x=cgexp, y=trade))+
  facet_wrap(~continent, nrow=2)


# prints "scatter_cgexp_trade_facets"
scatter_cgexp_trade_facets


# Creates scatterplot with "cgexp" variable on x-axis and "trade" variiable on y-axis, 
# adds line of best fit; plot assigned to object named "scatter_cgexp_trade_line"
scatter_cgexp_trade_line<-
  ggplot(pt_copy_cleaned)+
  geom_point(aes(x=cgexp, y=trade,))+
  geom_smooth(aes(x=cgexp, y=trade), method="lm")
  labs(title="Trade Share of GDP \nas a function of \n Central Govt Expenditure (1990-1999)",
       x="Central Government Expenditure (Pct of GDP", y="Overall Trade (Pct of GDP)")+
  theme(plot.title=element_text(hjust=0.5))

# Prints contents of "scatter_cgexp_trade_line"
scatter_cgexp_trade_line

# computes correlation coefficient between "trade" and "cgexp" variables and assigns 
# the result to a new object named "trade_cgexp_cc"
trade_cgexp_cc<-cor.test(pt_copy$trade, pt_copy$cgexp)

# prints results of "trade_cgexp_cc"
trade_cgexp_cc

# cleans up formatting of "trade_cgexp_cc"
broom::tidy(trade_cgexp_cc)

# assigns well-formatted model output to "trade_cgexp_cc_clean"
trade_cgexp_clean<-broom::tidy(trade_cgexp_cc)
trade_cgexp_clean

# Extracts variables for which we want a correlation matrix
desired_variables<-pt_copy %>% select(trade, cgexp, cgrev, catho80)

# Creates correlation matrix from "desired_variables" object and assigns 
# to object named "cor_matrix"
cor_matrix<-cor(desired_variables, use="complete.obs")

# prints contents of "cor_matrix"
cor_matrix

# implements bivariate regression with "gexp" as DV and "trade" as IV; 
# assigned to "regression1" object
regression1<-lm(cgexp~trade, data=pt_copy)

# prints output of "regression1"
summary(regression1)

# Implements regression with "cgexp" as DV, and assigns to object named "regression2"
regression2<-lm(cgexp~gastil+lyp+trade+prop1564+prop65+federal+oecd, data=pt_copy)

# prints output of "regression2"
summary(regression2)

# prints class of "continent" variable
class(pt_copy$continent)

# adds "continent" categorical variable to previously run "regression2" model; 
# output of model assigned to object named "regression3"
regression3<-lm(cgexp~gastil+lyp+trade+prop1564+prop65+federal+oecd+continent, data=pt_copy)


# opens model output of "regression3"
summary(regression3)

# Set "continent" variable as factor
pt_copy$continent<-as.factor(pt_copy$continent)
class(pt_copy$continent)

# check levels of "continent" factor variable
levels(pt_copy$continent)

# Relevels "continent" factor variable to set "other" as reference category
pt_copy$continent<-relevel(pt_copy$continent, ref="other")

# check levels of "continent" factor variable
levels(pt_copy$continent)

# runs regression model with releveled continent variable, "other" is excluded category
regression4<-lm(cgexp~gastil+lyp+trade+prop1564+prop65+federal+oecd+continent, data=pt_copy)

# prints model output of "regression4
summary(regression4)

# Use "continent" field to make continent dummy variables
pt_copy<-pt_copy %>% dummy_cols("continent")

# includes dummy variables in regression with "other" as the excluded category; 
# model output assigned to object named "regression5"
regression5<-lm(cgexp~gastil+lyp+trade+prop1564+prop65+federal+oecd+continent_africa+continent_asiae+continent_laam, data=pt_copy)


# prints model output for "regression5"
summary(regression5)

# run regression with interaction term between "trade" and "federal"
trade_federal_interaction<-lm(cgexp~trade*federal, data=pt_copy)

# prints "trade_federal_interaction" regression table
summary(trade_federal_interaction)

# Finds mean value of trade variable
mean(pt_copy$trade)

# Calculates marginal effects of federalism, with "trade" held at mean
marginal_effect_federalism<-ggpredict(trade_federal_interaction, term="federal", condition=c(trade=78.7659))

# Prints marginal effects table
marginal_effect_federalism

# prints underlying structure of "marginal_effect_federalism"
marginal_effect_federalism_plotted<-
  ggplot(marginal_effect_federalism)+
  geom_point(aes(x=x, predicted))+
  geom_errorbar(aes(x, ymin=conf.low, ymax=conf.high), width=0.05)+
  scale_x_continuous(breaks=seq(0,1, by=1))+
  labs(title="Predicted Effects of Federalism on Gov't Expenditure\n(with trade set to mean)",
       y="Predicted Expenditure",
       x="Federalism")
      

# creates plot of "marginal_effect_federalism"; shows impact of 
# federalism on cgexp when trade is held at means, with 95% confidence intervals
marginal_effect_federalism_plotted

# prints contents of "marginal_effect_federalism_plotted"

# prints the names of the files we want to read in and assigns the vector of 
# strings to a new object named "worldbank_filenames" 
worldbank_filenames<-list.files("data/wb")

# prints "worldbank_filenames"
worldbank_filenames

# iteratively passes file names in "worldbank_filenames" to the "read_csv" function, 
# and deposits imported world bank files into a list that is assigned to an object named 
# "world_bank_list"; assumes the working directory is the one with the world bank files
world_bank_list<-map(.x=worldbank_filenames, read_csv)

#  prints contents of "world_bank_list"
world_bank_list

# removes CSV extension from "worldbank_filenames"
worldbank_filenames_base<-str_remove(worldbank_filenames, ".csv")
worldbank_filenames_base

# assigns names to datasets in "world_bank_list"
names(world_bank_list)<-worldbank_filenames_base

# extracts fdi dataset from "world_bank_list" by assigned name
world_bank_list[["wdi_fdi2019"]]

# extracts fdi dataset from "world_bank_list" by assigned name and assigns 
# it to a new object named "wdi_fdi"
wdi_fdi<-world_bank_list[["wdi_fdi2019"]]

# extracts trade dataset from "world_bank_list" by assigned name and assigns it 
# to a new object named "wdi_trade"
wdi_trade<-world_bank_list[["wdi_trade2019"]]

# drop na's and rename variable in in trade dataset and assign to "wdi_trade_cleaned"
wdi_trade_cleaned<-wdi_trade %>% 
                    drop_na() %>% 
                    rename(trade_2019=`2019 [YR2019]`)

# drop na's and rename variable in in FDI dataset and assign to "wdi_fdi_cleaned"
wdi_fdi_cleaned<-wdi_fdi %>% 
                   drop_na() %>% 
                   rename(fdi_2019=`2019 [YR2019]`)

# join together "wdi_fdi_cleaned" and "wdi_fdi_cleaned" using country code
fdi_trade_join<-full_join(wdi_fdi_cleaned, wdi_trade_cleaned, by="Country Code")
View(fdi_trade_join)

# Appends "worldbank_trade_2019" to "worldbank_fdi_2019" and assigns new 
# dataset to object named "worldbank_trade_fdi"
worldbank_trade_fdi_appended<-bind_rows(wdi_trade, wdi_fdi)

# cleans the dataset before reshaping
worldbank_trade_fdi_cleaned<-worldbank_trade_fdi_appended %>% 
                              rename(economic_variables="2019 [YR2019]",
                                     series_code="Series Code") %>% 
                            select(-"Series Name") %>% 
                            drop_na()

# prints class of "economic_variables" column
class(worldbank_trade_fdi_cleaned$economic_variables)

# converts "economic_variables" to numeric
worldbank_trade_fdi_cleaned$economic_variables<-as.numeric(worldbank_trade_fdi_cleaned$economic_variables)

# reshapes "worldbank_trade_fdi_cleaned" from long to wide and assigns the 
# wide dataset to an object named "worldbank_trade_fdi_wide"
worldbank_trade_fdi_wide<-worldbank_trade_fdi_cleaned %>% 
                            tidyr:: pivot_wider(names_from=series_code,
                                                values_from=economic_variables)

# renames columns in "worldbank_trade_fdi_wide"
worldbank_trade_fdi_wide<-worldbank_trade_fdi_wide %>% 
                            rename(trade2019=NE.TRD.GNFS.ZS,
                                   FDI2019=BX.KLT.DINV.WD.GD.ZS)

# Views "worldbank_trade_fdi_wide" in the Viewer

# reshapes "worldbank_trade_fdi_wide" back to long format and assigns 
# the reshaped dataset to a new object named "world_bank_trade_long"
world_bank_trade_long<-worldbank_trade_fdi_wide %>% 
                        pivot_longer(cols=c(FDI2019, trade2019),
                                     names_to="economic_variable",
                                     values_to="2019")
View(world_bank_trade_long)

# write function to clean World Bank dataset
worldbank_cleaning_function<-function(input_dataset){
  modified_dataset<-input_dataset %>% 
                      select(-"Series Code") %>% 
                      rename("Country"="Country Name",
                             "CountryCode"="Country Code",
                             "Series"="Series Name",
                             "2019"="2019 [YR2019]") %>% 
              drop_na(CountryCode)
  return(modified_dataset)
}


# passes "wdi_trade" to "worldbank_cleaning_function"
worldbank_cleaning_function(wdi_trade)

# Iteratively apply "worldbank_cleaning_function" to all of the datasets 
# in "world_bank_list", and deposit the cleaned datasets into a new list named 
# "world_bank_list_cleaned"
world_bank_list_cleaned<-map(.x=world_bank_list, .f=worldbank_cleaning_function)
world_bank_list_cleaned

# exports "worldbank_trade_fdi_wide" to a local directory
write_csv(worldbank_trade_fdi_wide, "outputs/worldbank_trade_fdi.csv")

# recreates pt_copy_summarystats1
pt_copy_summarystats1<-describe(pt_copy)

# writes summary statistics table "pt_copy_summarystats1_df"  as CSV
write.csv(pt_copy_summarystats1, "outputs/summary_statistics.csv")

# exports a text summary stats table with stargazer
stargazer(as.data.frame(pt_copy), type="text", "Descriptive Statistics", digits=2, out="outputs/summary_stats.txt")

# makes list container for regressions we want to export
regression_list<-list(regression1, regression2, regression3)

# exports regressions in "regression_list" via stargazer as html
stargazer(regression_list, type="html", out="outputs/cgexp_regressions.html")

# exports regressions in "regression_list" via stargazer as text file
stargazer(regression_list, type="text", out="outputs/cgexp_regressions.txt")


# create file names for exported World Bank files
WB_filenames_export<-paste0("outputs/", worldbank_filenames_base, "_cleaned.csv")

# prints "WB_filenames_export" contents
WB_filenames_export

# exports datasets in "world_bank_list_cleaned" to "outputs" directory 
# using filenames in "WB_filenames_export"
walk2(.x=world_bank_list_cleaned, .y=WB_filenames_export, .f=write_csv)

# exports "cgexp_africa_ascending_inverted" as .png file using "ggsave" function
ggsave("outputs/africa_bar_chart.png", cgexp_africa_ascending_inverted, width=10, height=5)

# exports "cgexp_africa_ascending_inverted" as .pdf file using "ggsave" function
ggsave("outputs/africa_bar_chart.pdf", cgexp_africa_ascending_inverted, width=10, height=5)


# exports multiple files using pdf graphics device
pdf("outputs/workshop_visualizations.pdf", width=12, height=5)
cgexp_africa_ascending_inverted
scatter_cgexp_trade_line
dev.off()



