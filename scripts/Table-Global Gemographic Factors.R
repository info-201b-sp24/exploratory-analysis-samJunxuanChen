library(knitr)
# Read the Data file into R
data <- read.csv("DATA/Global Population Trends(2016-2022).csv")

# Filter the data from 2018 to 2021 because the 2017 population data is missing
filtered_data <- data[data$Year %in% c(2018, 2019, 2020, 2021), ]

# Select the required variables
selected_data <- filtered_data[, c("Country", "Year", "Total.Population", "Urban.Population", "Birth.Rate", "Life.Expectancy")]

# Print the table using kable
kable(selected_data)
