source('get_data.R')
require(dplyr)
require(ggplot2)

combo <- left_join(NEI, SCC, by = "SCC")

coal <- combo[grepl("coal", combo$Short.Name, ignore.case = TRUE), ]

# Calculate total emissions per year by type
em_total <- coal %>%
  group_by(year) %>%
  summarize(total = sum(Emissions, na.rm = TRUE)) %>%
  mutate(sm_total = total / 1000)

em_total$year <- as.factor(em_total$year)

# Open PNG device, set size
png('plot4.png', width = 500, height = 500)

# Create plot
ggplot(data = em_total, aes(x = year, y = sm_total)) +
  geom_bar(stat = "identity", na.rm = TRUE) +
  theme_classic() +
  labs(title = "Coal Emissions", x = "Year", y = "PM2.5 Emissions (Thousands of Tons)")

# Close PNG device
dev.off()