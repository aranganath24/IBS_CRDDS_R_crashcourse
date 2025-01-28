library(tidyverse)

# reads in file
worldbank_trade_fdi<-read_csv("worldbank_trade_fdi.csv")

# renames "2019[YR 2019]" variable and "Series Code" variable
worldbank_trade_fdi<-worldbank_trade_fdi %>% 
                      rename(economic_variables="2019 [YR2019]",
                             series_code="Series Code")

# converts "economic_variables" to numeric
worldbank_trade_fdi$economic_variables<-as.numeric(worldbank_trade_fdi$economic_variables)

# cleans dataset by dropping NAs
worldbank_trade_fdi<-worldbank_trade_fdi %>% drop_na()

# removes series name
worldbank_trade_fdi<-worldbank_trade_fdi %>% select(-"Series Name")

# reshapes from long to wide; goal is to have columns for the FDI and trade variables
worldbank_trade_fdi_wide<-worldbank_trade_fdi %>% 
                              tidyr:: pivot_wider(names_from=series_code,
                                          values_from=economic_variables,
                                          id_cols = c("Country Name", "Country Code"))

View(worldbank_trade_fdi_wide)

# Problem: each of the economic variables now have their own column, but each country/series pair still
# has its own row, which shouldn't be happening