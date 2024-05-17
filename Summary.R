library(dplyr)

data <- read.csv("DATA/Global Population Trends(2016-2022).csv", stringsAsFactors = FALSE)

# Replace dashes with NA and convert relevant columns to numeric
numeric_columns <- c("Total.Population", "Urban.Population", "Rural.Population", "Population.Density", 
                     "Life.Expectancy", "Birth.Rate", "Death.Rate", "Fertility.Rate", "Infant.Mortality.Rate", "Growth.Rate")

data[numeric_columns] <- lapply(data[numeric_columns], function(x) as.numeric(gsub("-", NA, gsub(",", "", x))))

get_summary_info <- function(df) {
  summary_info <- list()
  
  # Number of unique countries
  summary_info$num_countries <- length(unique(df$Country))
  
  # Maximum Life Expectancy
  summary_info$max_life_expectancy <- max(df$Life.Expectancy, na.rm = TRUE)
  
  # Country with the highest birth rate
  summary_info$highest_birth_rate_country <- df %>%
    filter(Birth.Rate == max(Birth.Rate, na.rm = TRUE)) %>%
    select(Country) %>%
    pull(Country)
  
  # Average Population Density
  summary_info$average_population_density <- mean(df$Population.Density, na.rm = TRUE)
  
  # Total Urban Population for the most recent year of each country
  recent_urban_population <- df %>%
    group_by(Country) %>%
    filter(Year == max(Year, na.rm = TRUE)) %>%
    summarise(Latest.Urban.Population = sum(Urban.Population, na.rm = TRUE)) %>%
    ungroup()
  
  summary_info$total_urban_population <- sum(recent_urban_population$Latest.Urban.Population)
  
  return(summary_info)
}

summary_data <- get_summary_info(data)

print(summary_data)