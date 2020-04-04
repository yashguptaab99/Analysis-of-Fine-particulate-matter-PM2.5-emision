#import llibrary and read data
library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#first group by year and find total emission of that year
total.emission.year<- NEI %>%
        group_by(year) %>%
        filter(fips == "24510") %>%
        summarise(Total.Emmision.Baltimore = sum(Emissions, na.rm = TRUE))
total.emission.year

#store plot in png file
png("plot2.png", width = 480, height = 480)
plot(total.emission.year$year, total.emission.year$Total.Emmision.Baltimore, 
     type = "l",
     lwd = 2,
     xlab = "Year", 
     ylab = "Total Annual Emission [Tons]", 
     main = "Total Annual Emission in Baltimore by Year")
#close connection
dev.off()