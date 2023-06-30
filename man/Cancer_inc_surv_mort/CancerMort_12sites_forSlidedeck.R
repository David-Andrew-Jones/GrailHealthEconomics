##### Mortality for 2019/2020 for UK Core slides

library(ggplot2)
library(plotly)
library(tidyverse)
library(ggpubr)
library(kableExtra)

# Load in data (read.csv could instead be used)

load("~/GrailHealthEconomics/data/data_mort_2001to2020_C0toC97_allandbyagesex.rda")
load("~/GrailHealthEconomics/data/data_mort_2001to2020_bysite_allandbysexandage.rda")

# Create table of results for total cancer deaths by year
res_totalC0toC97deaths_byyear <- data_mort_2001to2020_C0toC97_allandbyagesex %>%
        mutate(across(where(is_character),as_factor)) %>%
        filter(Year == 2019 | Year == 2020) %>%
        filter(!grepl(c("20 to 24|25 to 29|30 to 34|35 to 39|40 to 44|45 to 49|80 to 84|85 to 90|90 and over"), Age_at_Diagnosis)) %>%
        group_by(Year) %>%
        summarise(total = sum(Count))


# Create table of results for total deaths bfor the 12 cancer of interest and calculate the % of total cancer deaths by year
res_12sites <- data_mort_2001to2020_bysite_allandbysexandage %>%
        mutate(across(where(is_character),as_factor)) %>%
        filter(Year == 2019 | Year == 2020) %>%
        filter(!grepl(c("20 to 24|25 to 29|30 to 34|35 to 39|40 to 44|45 to 49|80 to 84|85 to 90|90 and over"), Age_at_Diagnosis)) %>%
        filter(Gender == "Persons") %>%
        filter(Type_of_rate == "Age-specific") %>%
        mutate(site = case_when(ICD10_code == "C21" ~ "Anus",
                                ICD10_code == "C67" ~ "Bladder",
                                ICD10_code == "C18-C20" ~ "Colorectal",
                                ICD10_code == "C15" ~ "Oesophagus",
                                grepl(c("C00|C01|C02|C03|C04|C05|C06|C07|C08|C09|C10|C11|C12|C13|C14|C15|C30|C31|C32"),ICD10_code) ~ "Head and neck",
                                ICD10_code == "C22" ~ "Liver/bile duct",
                                ICD10_code == "C33-C34" ~ "Lung",
                                grepl(c("C81|C82-C86"), ICD10_code) ~ "Lymphoma",
                                ICD10_code == "C25" ~ "Pancreas",
                                ICD10_code == "C90" ~ "Plasma cell neoplasm",
                                ICD10_code == "C16" ~ "Stomach",
                                .default = "other" )) %>%
        filter(site != "other") %>%
        rbind(data_mort_2001to2020_bysite_allandbysexandage %>%
                      mutate(across(where(is_character),as_factor)) %>%
                      filter(Year == 2019 | Year == 2020) %>%
                      filter(!grepl(c("20 to 24|25 to 29|30 to 34|35 to 39|40 to 44|45 to 49|80 to 84|85 to 90|90 and over"), Age_at_Diagnosis)) %>%
                      filter(Gender == "Female") %>%
                      filter(Type_of_rate == "Age-specific") %>%
                      mutate(site = case_when(ICD10_code == "C56" ~ "Ovary",
                                              .default = "other" )) %>%
                      filter(site != "other") ) %>%
        select(Year, Age_at_Diagnosis, site, Count) %>%
        group_by(Year, site) %>%
        summarise(total_site = sum(Count)) %>%
        left_join(res_totalC0toC97deaths_byyear, by = c("Year")) %>%
        mutate(Percentage = (total_site/total) *100) %>%
        mutate(Percent_12sites = sum(Percentage))

# Write results table
write.csv(res_12sites ,"~/GrailHealthEconomics/man/Cancer_inc_surv_mort/res_12sites_percentage_annual_cancerdeaths_201920.csv")


