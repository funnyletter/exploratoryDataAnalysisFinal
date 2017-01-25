source('get_data.R')
require(dplyr)
require(ggplot2)

get_data()

# Calculate total emissions per year by type
em_total <- NEI %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarize(total = sum(Emissions, na.rm = TRUE)) %>%
  mutate(sm_total = total / 100)

em_total$year <- as.factor(em_total$year)

# Open PNG device, set size
png('plot3.png', width = 500, height = 500)

# Create plot
ggplot(data = em_total, aes(x = year, y = sm_total, fill = type)) +
  geom_bar(stat = "identity", position = "dodge", na.rm = TRUE) +
  theme_classic() +
  labs(title = "Emissions in Baltimore", x = "Year", y = "PM2.5 Emissions (Hundreds of Tons)")

# Close PNG device
dev.off()