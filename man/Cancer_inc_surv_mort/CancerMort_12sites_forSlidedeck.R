##### Mortality for 2019 for UK Core slides

library(ggplot2)
library(plotly)
library(tidyverse)
library(ggpubr)
library(kableExtra)

load("~/GRAIL_HE/data/data_mort_2001to2020_C0toC97_allandbyagesex.rda")
load("~/GRAIL_HE/data/data_mort_2001to2020_bysite_allandbysexandage.rda")

res_totalC0toC97deaths_bysex <- data_mort_2001to2020_C0toC97_allandbyagesex %>%
        mutate(across(where(is_character),as_factor)) %>%
        filter(Year == 2019 | Year == 2020) %>%
        filter(!grepl(c("20 to 24|25 to 29|30 to 34|35 to 39|40 to 44|45 to 49|80 to 84|85 to 90|90 and over"), Age_at_Diagnosis)) %>%
        summarise(total = sum(Count))

data_mort_2001to2020_bysite_allandbysexandage <- data_mort_2001to2020_bysite_allandbysexandage %>%
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

                                .default = "other" ))



Anus
Bladder
Colon/rectum
Oesophagus
Head and neck
Liver/bile duct
Lung
Lymphoma
Ovary
Pancreas
Plasma cell neoplasm
Stomach


