library(knitr)
library(dplyr)

data <- read.csv("DATA/Global Population Trends(2016-2022).csv")

# Convert character columns to numeric
data$Total.Population <- as.numeric(gsub(",", "", data$Total.Population))
data$Urban.Population <- as.numeric(gsub(",", "", data$Urban.Population))
data$Birth.Rate <- as.numeric(gsub(",", "", data$Birth.Rate))
data$Life.Expectancy <- as.numeric(gsub(",", "", data$Life.Expectancy))

filtered_data <- data[data$Year %in% c(2018, 2019, 2020, 2021), ]

grouped_data <- filtered_data %>%
  group_by(Country, Year) %>%
  summarise(Total.Population = sum(Total.Population, na.rm = TRUE),
            Urban.Population = sum(Urban.Population, na.rm = TRUE),
            Birth.Rate = mean(Birth.Rate, na.rm = TRUE),
            Life.Expectancy = mean(Life.Expectancy, na.rm = TRUE))

