source('get_data.R')
require(dplyr)
require(ggplot2)

combo <- left_join(NEI, SCC, by = "SCC") %>%
  filter(fips == "24510" | fips == "06037") %>%
  mutate()

vehicle <- combo[grepl("vehicle", combo$Short.Name, ignore.case = TRUE), ]

# Calculate total emissions per year by type
em_total <- vehicle %>%
  group_by(year, fips) %>%
  summarize(total = sum(Emissions, na.rm = TRUE))

em_total$year <- as.factor(em_total$year)

# Open PNG device, set size
png('plot6.png', width = 500, height = 500)

# Create plot
ggplot(data = em_total, aes(x = year, y = total, fill = fips)) +
  geom_bar(stat = "identity", position = "dodge", na.rm = TRUE) +
  theme_classic() +
  labs(title = "Motor Vehicle Emissions", x = "Year", y = "PM2.5 Emissions (Tons)") +
  scale_fill_discrete(name = "City", breaks = c("24510", "06037"), labels = c("Baltimore", "Los Angeles"))

# Close PNG device
dev.off()
