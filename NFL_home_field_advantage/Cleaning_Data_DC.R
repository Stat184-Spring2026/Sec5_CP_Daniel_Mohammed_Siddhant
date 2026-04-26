# Cleaning the NFL data ----
## Brief description of what your goals are
## The goal is to clean the NFL data to be in a glyph-ready form that can be 
## used to create visualizations in order for us to make insights about whether 
## or not home field advantage is a real phenomenon in the NFL

# Step 1: Load Packages ----
## Needed Packages: tidyverse
library(tidyverse)

# Step 2: Load Data ----
## Needed data: NFL DATA
nfl_raw <- read_csv("nfl_mahomes_era_games.csv")

## Step 3: filter the raw data  ----
nfl_filtered <- nfl_raw %>%
  filter(game_type != "SB") %>%   #remove super bowls
  filter(score_diff != 0)         #remove the tie games

## Step 4: Separate from one row per game to one row per team ----
#this is important for comparing a teams home vs away performance

#first make a total score column to work with
nfl_vars <- nfl_filtered %>%
  mutate(total_points = home_score + away_score) 

#Home team rows 
home_teams <- nfl_vars %>%
  mutate(
    team = home_team,
    opponent = away_team,
    points_for = home_score,
    points_against = away_score,
    location = "Home",
    result = ifelse(game_outcome == 1, "Win", "Loss")
  )

#Away team rows
away_teams <- nfl_vars %>%
  mutate(
    team = away_team,
    opponent = home_team,
    points_for = away_score,
    points_against = home_score,
    location = "Away",
    result = ifelse(game_outcome == 0, "Win", "Loss")
  )

## Step 5 Combine & Arange ----

nfl_clean <- bind_rows(home_teams, away_teams) %>%
  arrange(team, season, week) %>%
  select(season, game_type, week, team, opponent, location, points_for,
         points_against, result, total_points, game_id)

## Step 6 Ensure data is categorized correctly----

#this step is what allows for analysis because the groups are treated as categories 
# and not mathmatical numbers. 

nfl_clean <- nfl_clean %>%
  mutate(
    season = as.factor(season),
    result = as.factor(result),
    location = as.factor(location)
  )



