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