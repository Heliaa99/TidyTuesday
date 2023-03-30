######################
# BobRoss TidyTuesday Script#
# Created by: Helia Tehrani
# Created on: 2023_02_21
# Updated: 2023_02_27

##############
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

#Load Data
bob_ross <- read_csv(
  "https://raw.githubusercontent.com/jwilber/Bob_Ross_Paintings/master/data/bob_ross_paintings.csv") #load the data in

bob_ross <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-21/bob_ross.csv') #read the data in
View(bob_ross)

colors_used <- bob_ross %>% 
  select(season, num_colors, Black_Gesso, Bright_Red, Burnt_Umber, Cadmium_Yellow, Dark_Sienna, Indian_Red, Indian_Yellow, Liquid_Black, Liquid_Clear, Midnight_Black, Phthalo_Blue, Phthalo_Green, Prussian_Blue, Sap_Green, Titanium_White, Van_Dyke_Brown, Yellow_Ochre, Alizarin_Crimson) %>% #select what I want to use in dataframe
  filter(season %in% c(1,2,3,4,5)) %>% #filtered to only show season 1-5
  pivot_longer(cols = Black_Gesso:Alizarin_Crimson, #pivoted longer to ger colors in one group
               names_to = "colors_used",
               values_to = "color_present")
View(colors_used)

ggplot(colors_used,
       aes(x = season,
           y = num_colors,
           fill = colors_used))+
  geom_bar(stat = "identity", width = 0.5)+
  scale_fill_viridis_d()
ggsave(here("Bobross_TidyTuesday","Outputs","ColorBarPlot.png"))
