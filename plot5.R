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

# Load RDS
NEI <- readRDS("data/summarySCC_PM25.rds")
NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
SCC <- readRDS("data/Source_Classification_Code.rds")

# Baltimore City, Maryland == fips
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate
MD.df <- aggregate(MD.onroad[, 'Emissions'], by = list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')

# Save png
png('plot5.png')
ggplot(data = MD.df, aes(x = year, y = Emissions)) + geom_bar(aes(fill = year), stat = "identity") + guides(fill = F) + ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position = 'none') + geom_text(aes(label = round(Emissions, 0), size = 1, hjust = 0.5, vjust = 2))
dev.off()