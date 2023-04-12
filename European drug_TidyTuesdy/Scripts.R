##european_drug_development Tidy Tuesday Scripts
##created by:Helia Tehrani
##Date:04/11/2023
###################


#### Load Libraries ######
library(tidyverse)
library(here)
library(tidytuesdayR)

### Loading data
tuesdata <- tidytuesdayR::tt_load('2023-03-14') # reads in data using the tidytuesdayR package

drugs <- tuesdata$drugs
View(drugs) 
glimpse(drugs) # glimpsing enables us to review the info.


### Data Analysis ######
drug_assessment <- drugs %>%
  pivot_longer(cols = conditional_approval:accelerated_assessment, # pivots data into long format into new columns
               names_to = "assessment_type",
               values_to = "assessment") %>%
  mutate(assessment_type = case_when(assessment_type == "accelerated_assessment" ~ "Accelerated Assessment", # renames assesment type
                                     assessment_type == "conditional_approval" ~ "Conditional Approval",
                                     assessment_type == "exceptional_circumstances" ~ "Exceptional Circumstances")) %>%
  group_by(category, assessment_type) %>%  
  filter(assessment == "TRUE") %>% # filters data 
  count(assessment_type) # counts number of each drug assessment type
View(drug_assessment)

drug_assessment_plot <- drug_assessment %>%
  ggplot(mapping = aes(x = assessment_type,
                       y = n,
                       fill = assessment_type)) +
  geom_bar(position = "dodge", # bar graph function
           stat = "identity") +
  labs(x = "Assessment Type",
       y = "Count",
       color = "blue",
       title = "Evaluation of European Drug Authorizations") +
  scale_fill_manual(values = alphonse("mhadeku")) + # sets bar graph colors
  facet_wrap(~category) + # separates out graph by categories
  theme_clean() #my favorite theme
  theme(legend.position = "none") + # I removes legend
  theme(plot.title = element_text(hjust = .5)) # centers plot title
drug_assessment_plot

ggsave(here("European drug_TidyTuesdy","output","european_drug_development.png"), 
       width = 8, height = 6) # adjust size of graph in inches

