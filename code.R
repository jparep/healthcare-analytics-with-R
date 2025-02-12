# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load the dataset (assuming it is in a CSV file)
data <- read.csv("your_data.csv", stringsAsFactors = FALSE)

# View the structure of the dataset
str(data)

# Summary statistics of numerical columns
summary(data)

# Checking missing values in the dataset
colSums(is.na(data))

# Convert YearStart and YearEnd to numeric if necessary
data$YearStart <- as.numeric(data$YearStart)
data$YearEnd <- as.numeric(data$YearEnd)

# Convert categorical variables to factors
categorical_cols <- c("LocationAbbr", "LocationDesc", "DataSource", "Topic", "Question", "DataValueUnit", "DataValueType")
data[categorical_cols] <- lapply(data[categorical_cols], as.factor)

# Handling missing values:
# 1. Remove columns with too many missing values
data <- data[, colSums(is.na(data)) < 0.5 * nrow(data)]

# 2. Replace missing values in numerical columns with median
data$DataValueAlt[is.na(data$DataValueAlt)] <- median(data$DataValueAlt, na.rm = TRUE)

# Distribution of DataValueAlt (after handling missing values)
ggplot(data, aes(x = DataValueAlt)) +
  geom_histogram(bins = 30, fill = "blue", alpha = 0.7) +
  labs(title = "Distribution of DataValueAlt", x = "DataValueAlt", y = "Count")

# Count of records per year
ggplot(data, aes(x = YearStart)) +
  geom_bar(fill = "green", alpha = 0.7) +
  labs(title = "Number of Records per Year", x = "YearStart", y = "Count")

  # Checking the top 10 most frequent topics
top_topics <- data %>%
  group_by(Topic) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) %>%
  head(10)

print(top_topics)

# Save the cleaned dataset
write.csv(data, "cleaned_data.csv", row.names = FALSE)

# Display first few rows of the cleaned data
head(data)