#import llibrary and read data
library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Extract SCC where vehicle is source
SCC.vehicle<-SCC[grep("[Vv]eh",SCC$Short.Name),]
#now create subset of NEI where above SCC element are present
NEI.vehicle<-subset(NEI,NEI$SCC %in% SCC.vehicle$SCC)
#group by year and find total emission of that year for Batltimore
NEI.vehicle.total <- NEI.vehicle %>% 
        group_by(year) %>%
        filter(fips == "24510") %>%
        summarize(Total.vehicle = sum(Emissions, na.rm = TRUE))


#store plot in png file
png("plot5.png", width = 480, height = 480)
#plot
ggplot(NEI.vehicle.total, 
       aes(NEI.vehicle.total$year, NEI.vehicle.total$Total.vehicle))+
        geom_line()+
        xlab("Year") +
        ylab("Total Emissions [Tons]") +
        ggtitle("Total Annual Vehicle Emissions in the US")
#close connection
dev.off()