# Processing the NFL data ----
## Brief description of what your goals are
## The goal is to take the cleaned NFL data and summarise home win rate by
## season. This file does the calculation and saves the result so the
## presentation file can load it and make the visual.

# Step 1: Load Packages ----

library(tidyverse)

# Step 2: Load the cleaned data ----
## Run the cleaning script to bring nfl_clean into the environment
source("Cleaning_Data_DC.R")

## Step 3: Summarise home win rate by season ----
## filtering to home rows only so each game counts once

season_summary <- nfl_clean %>%
  filter(location == "Home") %>%
  group_by(season) %>%
  summarise(
    games    = n(),
    win_rate = mean(result == "Win"),
    .groups  = "drop"
  )

## Step 4: Saving the result ----
write_csv(season_summary, "season_summary.csv")
