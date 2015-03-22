# Check data files
if (!file.exists('data')) {
  dir.create('data')
}
if (!file.exists('data/Source_Classification_Code.rds')
    | !file.exists('data/summarySCC_PM25.rds')) {
  unzip('exdata_data_NEI_data.zip',exdir='data',overwrite=TRUE)
}

# Load RDS
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Sample data for testing
NEIsample <- NEI[sample(nrow(NEI), size = 1000, replace = F), ]

# Aggregate
Emissions <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)
Emissions$PM <- round(Emissions[, 2] / 1000, 2)

# Save png
png(filename = "plot1.png")
barplot(Emissions$PM, names.arg = Emissions$Group.1, main = expression('Total Emission of PM'[2.5]), xlab = 'Year', ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()