# ==========================================
# Script: 02_analyze_crop_growth.R
# Project: Multi-Stress Crop Growth Simulation
#
# Purpose:
# Analyze simulated crop biomass under multiple
# stress scenarios and generate growth curves.
#
# Input:
# data/multi_stress_crop_growth.csv
#
# Output:
# figures/biomass_growth_curves.png
# ==========================================

# Load libraries
library(ggplot2)
library(dplyr)
library(tidyr)

# Create figures directory if it does not exist
if (!dir.exists("figures")) {
  dir.create("figures")
}

# Load dataset
growth_data <- read.csv("data/multi_stress_crop_growth.csv")

# Preview data
head(growth_data)

# Convert data to long format for easier plotting
growth_long <- growth_data %>%
  pivot_longer(
    cols = c(Biomass_Ideal, Biomass_Drought, Biomass_DroughtDisease),
    names_to = "Condition",
    values_to = "Biomass"
  )

# Rename conditions for cleaner plots
growth_long$Condition <- recode(
  growth_long$Condition,
  Biomass_Ideal = "Ideal",
  Biomass_Drought = "Drought",
  Biomass_DroughtDisease = "Drought + Disease"
)

# Summary statistics
summary_stats <- growth_long %>%
  group_by(Condition) %>%
  summarise(
    Final_Biomass = max(Biomass),
    Mean_Biomass = mean(Biomass)
  )

print(summary_stats)

# Plot growth curves
growth_plot <- ggplot(growth_long, aes(x = Day, y = Biomass, color = Condition)) +
  geom_line(size = 1.2) +
  labs(
    title = "Crop Biomass Growth Under Multi-Stress Conditions",
    x = "Days After Planting",
    y = "Biomass",
    color = "Condition"
  ) +
  theme_minimal()

# Save figure
ggsave(
  filename = "figures/biomass_growth_curves.png",
  plot = growth_plot,
  width = 8,
  height = 5
)

# Print plot to console
print(growth_plot)

# Completion message
cat("Analysis complete.\n")
cat("Figure saved to: figures/biomass_growth_curves.png\n")