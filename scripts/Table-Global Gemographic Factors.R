library(knitr)
library(dplyr)
# Data
data <- read.csv("DATA/Global Population Trends(2016-2022).csv")

# Group the data by Country and Year and include the variables
grouped_data <- data %>%
  group_by(Country, Year) %>%
  summarise(Total.Population = sum(Total.Population, na.rm = TRUE),
            Urban.Population = sum(Urban.Population, na.rm = TRUE),
            Birth.Rate = mean(Birth.Rate, na.rm = TRUE),
            Life.Expectancy = mean(Life.Expectancy, na.rm = TRUE))

head(grouped_data)
