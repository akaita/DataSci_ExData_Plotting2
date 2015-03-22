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
NEIsample <- NEI[sample(nrow(NEI), size = 5000, replace = F), ]

# Subset data and append two years in one data frame
MD <- subset(NEI, fips == '24510')

# Save png
png(filename = 'plot2.png')
barplot(tapply(X = MD$Emissions, INDEX = MD$year, FUN = sum), main = 'Total Emission in Baltimore City, MD', xlab = 'Year', ylab = expression('PM'[2.5]))
dev.off()