################################################################################
## Libraries
################################################################################
## Loading the necessary libraries
library(tidyverse)
library(MuMIn)
library(knitr)
library(patchwork)
library(statmod)
library(gamlss)
library(MASS)
library(pscl)
library(broom)
library(readxl)
library(ggthemes)
library(scales)


## Setting the working directory
setwd("C:/Users/riese/Documents/CAS Hackathon")


################################################################################
## Exploratory Data Analysis
################################################################################
## Reading in all of the csv files
raw_secondary_data <- read_csv("Hackathon Secondary Data.csv")
raw_primary_data <- read_csv("Hackathon Primary Spreadsheet.csv")
raw_primary_data_w_extras <- read_csv("Hackathon Primary Spreadsheet (reference number, event, dates).csv")


## Cleaning up the data types
secondary_data <- raw_secondary_data %>% 
  mutate(Begin_Date = mdy(Begin_Date)
         ,End_Date  = mdy(End_Date))

primary_data <- raw_primary_data %>% 
  mutate(Start_Date      = coalesce(mdy(Start_Date) ,ymd(Start_Date))
         ,Fellow_Date    = mdy(Fellow_Date)
         ,associate_date = mdy(associate_date)
         ,Registration_Add_Date = coalesce(mdy(Registration_Add_Date) ,ymd(Registration_Add_Date)))

primary_data_w_extras <- raw_primary_data_w_extras %>% 
  mutate(Start_Date = mdy(Start_Date))


## Cleaning up the column names to make them easier to work with
colnames(secondary_data) <- colnames(secondary_data) %>% tolower()
colnames(primary_data) <- colnames(primary_data) %>% tolower()
colnames(primary_data_w_extras) <- colnames(primary_data_w_extras) %>% tolower()


## Looking to see how many participants there were by conference
primary_data %>% 
  mutate(event_name = str_remove_all(event_title ,pattern = "[0-9]{4} ")) %>% 
  group_by(start_date ,event_title ,event_name) %>% 
  summarise(n = n()) %>% 
  ungroup() %>% 
  arrange(start_date) %>% 
  ggplot(aes(x = start_date ,y = n ,group = event_name)) +
    geom_line() +
    geom_point() +
    facet_wrap(~ event_name) +
    scale_y_continuous(label = comma) +
    scale_x_date() +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
    
primary_data %>% 
  mutate(event_abbr = str_remove_all(event_code ,pattern = "[0-9]{2,4}")) %>% 
  group_by(start_date ,event_title ,event_abbr) %>% 
  summarise(n = n()) %>% 
  ungroup() %>% 
  arrange(start_date) %>% 
  ggplot(aes(x = start_date ,y = n ,group = event_abbr)) +
  geom_line() +
  geom_point() +
  facet_wrap(~ event_abbr) +
  scale_y_continuous(label = comma) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

primary_data %>% 
  mutate(start_year = year(start_date)) %>% 
  group_by(start_year) %>% 
  summarise(n = n()) %>% 
  ungroup() %>% 
  arrange(start_year) %>% 
  ggplot(aes(x = start_year ,y = n)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(label = comma) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))


primary_data_w_extras

secondary_data %>% 
  group_by(current_employer) %>% 
  summarise(n = n()) %>% 
  ungroup() %>% 
  arrange(desc(n)) %>% 
  View()


secondary_data %>% 
  group_by(current_industry) %>% 
  summarise(n = n()) %>% 
  ungroup() %>% 
  arrange(desc(n)) %>% 
  View()











