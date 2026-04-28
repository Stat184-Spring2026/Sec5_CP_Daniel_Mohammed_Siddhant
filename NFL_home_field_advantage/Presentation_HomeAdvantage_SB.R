# Presenting the NFL home advantage analysis 
## Brief description of what your goals are
## The goal is to take the saved season summary and produce a line chart of home win rate by season.

# Step 1: Load Packages 
library(tidyverse)
# Step 2: Load the saved result 
season_summary <- read_csv("season_summary.csv")

## Step 3: Plot home win rate by season 
## line drops to ~50% in 202 then recovers which supports the
## idea that crowd noise is part of what drives home field advantage since we see a fluctuation in winrate > 5%

season_summary %>%
  ggplot(aes(x = season, y = win_rate, group = 1)) +
  geom_hline(yintercept = 0.5, linetype = "dashed", color = "black") +  #50% reference
  geom_line(color = "red", linewidth = 1) +
  geom_point(size = 3, color = "red") +
  geom_text(aes(label = scales::percent(win_rate, accuracy = 0.1)),
            vjust = -1, size = 3.5) +
  scale_y_continuous(labels = scales::percent_format(),
                     limits = c(0.4, 0.7)) +
  labs(
    title    = "Home win rate by season",
    subtitle = "Dashed line = 50% (no advantage)",
    x        = "Season",
    y        = "Home win rate"
  ) +
  theme_minimal(base_size = 12)
