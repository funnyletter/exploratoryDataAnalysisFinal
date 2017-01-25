source('get_data.R')
require(dplyr)

# Calculate total emissions per year
em_total <- NEI %>%
  group_by(year) %>%
  summarize(total = sum(Emissions, na.rm = TRUE)) %>%
  mutate(sm_total = total / 1000000)

# Open PNG device, set size
png('plot1.png', width = 500, height = 500)

# Create plot with snazzy one-liner. Two-liner?
barplot(em_total$sm_total,  names.arg = em_total$year, main = "Total Emissions by Year", xlab = "Year",
        ylab = "PM2.5 Emissions (Millions of Tons)", col = "maroon", ylim = c(0,8))

# Close PNG device
dev.off()