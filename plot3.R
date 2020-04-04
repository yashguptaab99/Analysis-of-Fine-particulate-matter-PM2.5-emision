#import llibrary and read data
library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#first group by year and type, and find total emission of that year
total.emission.year<- NEI %>%
        group_by(year,type) %>%
        filter(fips == "24510") %>%
        summarise(Total.Emmision.Baltimore = sum(Emissions, na.rm = TRUE))
total.emission.years

#store plot in png file
png("plot3.png", width = 480, height = 480)
ggplot(total.emission.year, 
       aes(total.emission.year$year, total.emission.year$Total.Emmision.Baltimore))+
        geom_point(color = "red", 
                   size = 4, 
                   alpha = 1/3) + 
        facet_grid(. ~ type) +
        xlab("Year") +
        ylab("Total Emissions [Tons]") +
        ggtitle("Total Annual Emissions in Baltimore by Pollutant Type")
#close connection
dev.off()

