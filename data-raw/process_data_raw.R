# Code to generate .Rd data files ----

# clear workspace ----
rm(list =ls())
library(dplyr)

# save data from data-raw ----
directory <- "data-raw/"

# data incidence ----
data_inc_2001to2020_C0toC97_allageandbysex <- read.csv(paste0(directory, "Inc_data_01to20_allsites_allageandbysex.csv"))

data_inc_2001to2020_C0toC97_allandbyagesex <- read.csv(paste0(directory, "Inc_data_01to20_allsites_allandbyagesex.csv"))

data_inc_2001to2020_bysite_allandbysex <- read.csv(paste0(directory, "Inc_data_01to20_bysite_allandbysex.csv"))

data_inc_2001to2020_bysite_allandbysexandage <- read.csv(paste0(directory, "Inc_data_01to20_bysite_allandbysexandage.csv"))

# data mortality ----
data_mort_2001to2020_C0toC97_allageandbysex <- read.csv(paste0(directory, "Mort_data_01to20_allsites_allageandbysex.csv"))

data_mort_2001to2020_C0toC97_allandbyagesex <- read.csv(paste0(directory, "Mort_data_01to20_allsites_allandbyagesex.csv"))

data_mort_2001to2020_bysite_allandbysex <- read.csv(paste0(directory, "Mort_data_01to20_bysite_allandbysex.csv"))

data_mort_2001to2020_bysite_allandbysexandage <- read.csv(paste0(directory, "Mort_data_01to20_bysite_allandbysexandage.csv"))

# data survival ----

data_surv_2001to2019_bysite <- read.csv(paste0(directory, "surv_data_trends_2009to2020.csv"))

data_surv_2001to2019_bysite <- data_surv_2001to2019_bysite %>%
        rename( `2006 to 2010` = X2006.to.2010,
                `2007 to 2011` = X2007.to.2011,
                `2008 to 2012` = X2008.to.2012,
                `2009 to 2013` = X2009.to.2013,
                `2010 to 2014` = X2010.to.2014,
                `2011 to 2015` = X2011.to.2015,
                `2012 to 2016` = X2012.to.2016,
                `2013 to 2017` = X2013.to.2017,
                `2014 to 2018` = X2014.to.2018,
                `2015 to 2019` = X2015.to.2019) %>%
        pivot_longer(cols = c(`2006 to 2010`:`2015 to 2019`) , names_to = "Diag_years")

# transfer to data folder ----

usethis::use_data(data_inc_2001to2020_C0toC97_allageandbysex,
                  data_inc_2001to2020_C0toC97_allandbyagesex,
                  data_inc_2001to2020_bysite_allandbysex,
                  data_inc_2001to2020_bysite_allandbysexandage,
                  data_mort_2001to2020_C0toC97_allageandbysex,
                  data_mort_2001to2020_C0toC97_allandbyagesex,
                  data_mort_2001to2020_bysite_allandbysex,
                  data_mort_2001to2020_bysite_allandbysexandage,
                  data_surv_2001to2019_bysite,
                  overwrite = TRUE)
