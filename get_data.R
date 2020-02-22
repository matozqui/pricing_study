# Init libraries
source('config.r')
library(utils)
library(readr)
library(dplyr)
library(devtools)
library(logging)
library(assertthat)
library(testthat)

#Init log
addHandler(writeToFile, file="./filelog.log", level='INFO')
getLogger()[['handlers']]

#Import data
data <- read_csv('./Data/wfp_market_food_prices.csv')

#Unit tests
test_file('./tests.R')

#Understand data
summary(data)
data %>% count(mp_year)
colnames(data)
head(data)

#as.data.frame()

#Filtering
data_retail   <-  data %>% 
                  filter(data$pt_name=='Retail') %>% 
                  count(cm_name,pt_name) %>% 
                  top_n(30)

data_wholesale <- data %>% 
                  filter(data$pt_name=='Wholesale') %>% 
                  count(cm_name,pt_name) %>% 
                  top_n(30)

data_re_wh    <- merge(x=data_wholesale,y=data_retail,by="cm_name")

data          <- data %>% filter(data$cm_name %in% data_re_wh$cm_name)


