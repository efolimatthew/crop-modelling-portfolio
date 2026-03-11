# ===============================================
# Script: generate_yield_dataset.R
# Project: Drought × Nitrogen Yield Interaction
#
# Purpose:
# Generate synthetic field trial data to study
# the interaction between water availability
# and nitrogen fertilization on crop yield.
#
# Output:
# data/yield_analysis.csv
# ===============================================

# Ensure reproducibility
set.seed(123)

# Create data directory if it does not exist
if (!dir.exists("data")) {
  dir.create("data")
}

# Define treatment levels
water_levels <- c("Low", "Medium", "High")
nitrogen_levels <- c("Low", "Medium", "High")
replicates <- 1:5

# Generate full factorial experiment
data <- expand.grid(
  Water = water_levels,
  Nitrogen = nitrogen_levels,
  Replicate = replicates
)

# Base water effect
water_effect <- ifelse(data$Water == "Low", 2,
                       ifelse(data$Water == "Medium", 4, 6))

# Nitrogen effect
nitrogen_effect <- ifelse(data$Nitrogen == "Low", 0,
                          ifelse(data$Nitrogen == "Medium", 0.5, 1))

# Water modifier controlling nitrogen efficiency
water_modifier <- ifelse(data$Water == "Low", 0.4,
                         ifelse(data$Water == "Medium", 0.8, 1))

# Final yield with interaction
data$Yield <- water_effect +
  nitrogen_effect * water_modifier +
  rnorm(nrow(data), 0, 0.2)

# Save dataset
write.csv(data, "data/yield_analysis.csv", row.names = FALSE)

# Preview dataset
head(data)

cat("Dataset saved to: data/yield_analysis.csv\n")