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


## Setting the working directory
setwd("C:/Users/riese/Desktop/CAS Hackathon")


################################################################################
## Exploratory Data Analysis
################################################################################
## Reading in all of the csv files
raw_secondary_data <- read_csv("Hackathon Secondary Data.csv")
raw_primary_data <- read_csv("Hackathon Primary Spreadsheet.csv")
raw_primary_data_w_extras <- read_csv("Hackathon Primary Spreadsheet (reference number, event, dates).csv")













