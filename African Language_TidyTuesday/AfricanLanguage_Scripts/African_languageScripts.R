######################
#African Languages Script
#Created by: Helia Tehrani
#Created on: 2023_03_29
#####################

#Libraries
library(tidyverse)
library(readr)
library(here)
library(nationalparkcolors)
library(praise)
library(devtools)
library(beyonce)
library(ggthemes)
library(hrbrthemes)
library(ggridges)
library(nationalparkcolors)
library(tidytuesdayR)
library(ggplot2)
library(viridis)

#Data 
country_region <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/country_regions.csv') #read in csv
View(country_region)

language_countries <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/language_countries.csv')  #read in csv
View(language_countries)

languages <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/languages.csv")  #read in csv
View(languages)

afrisenti <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-28/afrisenti.csv")  #read in csv
View(afrisenti)

#Joining Data
country_reg_lan <- full_join(country_region, language_countries) #combined countries with relevant regions and languages spoken in said countries
View(country_reg_lan)

country_languages_region <- full_join(country_reg_lan, languages) #merged a new data frame containing languages and their ISO codes
View(country_languages_region)

selected_afrisenti <- afrisenti %>% #african sentiment csv labels and iso codes were chosen
  select(language_iso_code, label)
View(selected_afrisenti)

african_sentiment_full <- full_join(country_languages_region, selected_afrisenti) #joined selected african sentiment dataframe with above mentioned data frame
View(african_sentiment_full)

#plotting
ggplot(african_sentiment_full, #using fully joined data
       aes(x = label, #x axis will be the labels of sentiment
           fill = label))+ #fill will be labels of sentiment
  geom_density(alpha = 0.9)+ #transparency
  scale_color_gradient(high ="pink", low ="gray")
  facet_wrap(~country)+ #facet warp by country
  scale_fill_manual(values = park_palette("CraterLake"))+ #add color to density plot
  theme(axis.text.x=element_blank(), #take off text on x axis
        axis.ticks.x=element_blank())+ #take off marks
  labs(title = "Tweets' Attitude African Countries Posted", # title
       x = "",
       y = "Density of Three Different Sentiments",
       color = "Levels of Sentiment") #couldn't change the legend title
ggsave(here("African Languages_TidyTuesday","Output","Sentiments.jpeg"))

