# Load libraries
library(ggplot2)

# Check data files
if (!file.exists('data')) {
  dir.create('data')
}
if (!file.exists('data/Source_Classification_Code.rds')
    | !file.exists('data/summarySCC_PM25.rds')) {
  unzip('exdata_data_NEI_data.zip',exdir='data',overwrite=TRUE)
}

# Loads RDS
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Sample data for testing
NEIsample <- NEI[sample(nrow(NEI), size = 5000, replace = F), ]

# Baltimore City, Maryland == fips
MD <- subset(NEI, fips == 24510)
MD$year <- factor(MD$year, levels = c('1999', '2002', '2005', '2008'))

# Save png
png('plot3.png', width = 800, height = 500)
ggplot(data = MD, aes(x = year, y = log(Emissions))) + facet_grid(. ~ type) + guides(fill = F) + geom_boxplot(aes(fill = type)) + stat_boxplot(geom = 'errorbar') + ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + ggtitle('Emissions per Type in Baltimore City, Maryland') + geom_jitter(alpha = 0.10)
dev.off()