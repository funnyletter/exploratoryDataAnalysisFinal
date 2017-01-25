source('get_data.R')
require(dplyr)
require(ggplot2)

combo <- left_join(NEI, SCC, by = "SCC") %>%
  filter(fips == "24510")

vehicle <- combo[grepl("vehicle", combo$Short.Name, ignore.case = TRUE), ]

# Calculate total emissions per year by type
em_total <- vehicle %>%
  group_by(year) %>%
  summarize(total = sum(Emissions, na.rm = TRUE))

em_total$year <- as.factor(em_total$year)

# Open PNG device, set size
png('plot5.png', width = 500, height = 500)

# Create plot
ggplot(data = em_total, aes(x = year, y = total)) +
  geom_bar(stat = "identity", na.rm = TRUE) +
  theme_classic() +
  labs(title = "Motor Vehicle Emissions in Baltimore", x = "Year", y = "PM2.5 Emissions (Tons)") +
  ylim(0,80)

# Close PNG device
dev.off()
