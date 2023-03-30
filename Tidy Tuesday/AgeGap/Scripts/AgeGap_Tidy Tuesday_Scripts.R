#############################################
### Tidy Tuesdays, AgeGap
### Created by: Helia Tehrani
### Created on: 2023-03-25
### Last updated: 2023-04-24
##########################
#### Load libraries 
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

#############################
##The topic of this week's tidy tuesday is Hollywood age differences between love interests.

### Read in Data 
urlfile="https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-14/age_gaps.csv" #names url file
mydata <- read_csv(url(urlfile)) #read in csv from github 
View(mydata)


mydata_select <-mydata %>%
  select(movie_name,character_1_gender,character_2_gender,actor_1_age,actor_2_age) #selected the rows I want to use
View(mydata_select) #view new data frame

gender_difference_pivot <- mydata_select %>% #dataframe to use from the chosen data frame from my original data "mydata"
  pivot_longer(cols = character_1_gender:character_2_gender, #pivot to combine the man and woman columns into a single named gender
               names_to = "Character_Type", 
               values_to = "Character_Gender") 
View(gender_difference_pivot)

gender_difference_dbl_pivot <- gender_difference_pivot %>% 
  pivot_longer(cols = actor_1_age:actor_2_age, #pivot from numerical columns to create age column
               names_to = "Actor_Type", #actor age 1 or 2
               values_to = "Character_Age") #actor age
View(gender_difference_dbl_pivot)
praise()



ggplot(gender_difference_dbl_pivot, #double pivot dataframe
       aes(y = Character_Type, #Character 1 or 2 denotes the primary or secondary role.
           x = Character_Age))+ #characters ages
  geom_density_ridges(aes(fill = Character_Gender), #density plot with gender as the fill
                      alpha = 0.6, #transparency
                      show.legend = TRUE)+ #legend
 scale_color_gradient(high ="blue", low ="gray") +                
  theme_classic()+ #my favorite theme
  labs(title ="Differences in Actor Gender", #title of plot
       x = "Actor Age", #x axis title
       y = "Actor Gender", #y axis title
       fill = "Actor Sex")+ #leged titile
  theme(axis.title = element_text(size = 11), #bigger x and y axis titles
        plot.title = element_text(hjust=0.8)) #adjust title to the left
ggsave(here("AgeGap","Outputs", "agegap_plot.jpg"))

