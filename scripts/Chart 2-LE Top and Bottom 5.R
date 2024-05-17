# Sam Chen
# INFO 201 
# Exploratory Analysis

#Data
data <- read.csv("DATA/Global Population Trends(2016-2022).csv")

# The data set uses "-" as no data, so replace "-" with NA
data[data == "-"] <- NA

# The data set needs to convert columns to numeric
numeric_cols <- c("Total.Population", "Urban.Population", "Rural.Population", "Population.Density", "Life.Expectancy", "Birth.Rate", "Death.Rate", "Fertility.Rate", "Infant.Mortality.Rate", "Growth.Rate")
data[numeric_cols] <- lapply(data[numeric_cols], function(x) as.numeric(gsub(",", "", x)))

# Remove rows with NA values
data <- na.omit(data)

# Filter data for the years 2018 to 2021 since 2017 data is incomplte
data <- data %>%
  filter(Year >= 2018 & Year <= 2021)

# Create a new data to contain the average life expectancy for each country
average_life_expectancy <- data %>%
  group_by(Country) %>%
  summarize(avg_Life_Expectancy = round(mean(Life.Expectancy, na.rm = TRUE)))

# Sort the countries by average life expectancy and select the top 5 and bottom 5 countries
top_bottom_countries <- average_life_expectancy %>%
  arrange(avg_Life_Expectancy)
top_countries <- top_bottom_countries %>% slice_tail(n = 5)
bottom_countries <- top_bottom_countries %>% slice_head(n = 5)

# Create a bar chart
library(ggplot2) 
chart2 <- ggplot() +
  geom_bar(data = top_countries, aes(x = reorder(Country, avg_Life_Expectancy), y = avg_Life_Expectancy), stat = "identity", fill = "blue") +
  geom_bar(data = bottom_countries, aes(x = reorder(Country, avg_Life_Expectancy), y = avg_Life_Expectancy), stat = "identity", fill = "red") +
  coord_flip() +
  geom_text(data = top_countries, aes(x = reorder(Country, avg_Life_Expectancy), y = avg_Life_Expectancy, label = avg_Life_Expectancy), vjust = 0.5, size = 4, color = "black") +
  geom_text(data = bottom_countries, aes(x = reorder(Country, avg_Life_Expectancy), y = avg_Life_Expectancy, label = avg_Life_Expectancy), vjust = 0.5, size = 4, color = "black") +
  labs(title = "Top 5 and Bottom 5 Countries by Average Life Expectancy (2018-2021)",
       x = "Country",
       y = "Average Life Expectancy",
       fill = "Group") +
  scale_fill_manual(values = c("blue", "red")) +
  theme_minimal()
