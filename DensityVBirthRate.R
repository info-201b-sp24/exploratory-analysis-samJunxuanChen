library(dplyr)
library(ggplot2)

# Read the Data file into R
data <- read.csv("DATA/Global Population Trends(2016-2022).csv")

# Filter the data from 2018 to 2021 because the 2017 population data is missing
filtered_data <- data[data$Year %in% c(2018, 2019, 2020, 2021), ]

# Replace "-" with NA to properly handle missing values
filtered_data$Population.Density <- as.numeric(gsub("-", NA, filtered_data$Population.Density))
filtered_data$Birth.Rate <- as.numeric(gsub("-", NA, filtered_data$Birth.Rate))

# Calculate mean population density and birth rate for each country
average_data <- filtered_data %>%
  group_by(Country) %>%
  summarise(
    Avg_Pop_Density = mean(Population.Density, na.rm = TRUE),
    Avg_Birth_Rate = mean(Birth.Rate, na.rm = TRUE)
  )

# Create scatter plot
ggplot(average_data, aes(x = Avg_Pop_Density, y = Avg_Birth_Rate)) +
  geom_point() +
  labs(x = "Average Population Density", y = "Average Birth Rate", title = "Population Density vs Birth Rate") +
  theme_minimal()
