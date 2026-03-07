# creating data from scratch

# ================================
# Multi-Stress Crop Growth Simulation
# ================================

# Create data directory if it does not exist
if (!dir.exists("data")) {
  dir.create("data")
}

# Simulation time
days <- 1:120

# Initialize biomass vectors
Biomass_Ideal <- numeric(120)
Biomass_Drought <- numeric(120)
Biomass_DroughtDisease <- numeric(120)

# Initial biomass
Biomass_Ideal[1] <- 1
Biomass_Drought[1] <- 1
Biomass_DroughtDisease[1] <- 1

# Model parameters
r <- 0.08
K <- 100

# Growth simulation loop
for(t in 2:120){
  
  Biomass_Ideal[t] <- Biomass_Ideal[t-1] +
    r * Biomass_Ideal[t-1] * (1 - Biomass_Ideal[t-1] / K)
  
  Biomass_Drought[t] <- Biomass_Drought[t-1] +
    r * Biomass_Drought[t-1] * (1 - Biomass_Drought[t-1] / K) * 0.85
  
  Biomass_DroughtDisease[t] <- Biomass_DroughtDisease[t-1] +
    r * Biomass_DroughtDisease[t-1] * (1 - Biomass_DroughtDisease[t-1] / K) * 0.75
}

# Combine results into a dataframe
growth_data <- data.frame(
  Day = days,
  Biomass_Ideal = Biomass_Ideal,
  Biomass_Drought = Biomass_Drought,
  Biomass_DroughtDisease = Biomass_DroughtDisease
)

# Save dataset to the data folder
write.csv(growth_data, "data/multi_stress_crop_growth.csv", row.names = FALSE)

# Print confirmation
cat("Dataset saved to: data/multi_stress_crop_growth.csv\n")