library(ggplot2)

data <- read.csv("~/Desktop/info/Global Population Trends(2016-2022) 2.csv", stringsAsFactors = FALSE)

data$Total.Population <- as.numeric(gsub(",", "", gsub("-", NA, data$Total.Population)))
data$Urban.Population <- as.numeric(gsub(",", "", gsub("-", NA, data$Urban.Population)))

print(paste("Missing Total Population:", sum(is.na(data$Total.Population))))
print(paste("Missing Urban Population:", sum(is.na(data$Urban.Population))))

ggplot(data, aes(x = Total.Population, y = Urban.Population)) +
  geom_point() +
  scale_x_log10() +  
  scale_y_log10() +  
  labs(title = "Scatter Plot of Total Population vs. Urban Population",
       x = "Total Population (log scale)",
       y = "Urban Population (log scale)") +
  theme_minimal()
