#import llibrary and read data
library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Extract SCC where vehicle is source
SCC.vehicle<-SCC[grep("[Vv]eh",SCC$Short.Name),]
#now create subset of NEI where above SCC element are present
NEI.vehicle<-subset(NEI,NEI$SCC %in% SCC.vehicle$SCC)

#group by year and find total emission of that year for Los Angeles
NEI.vehicle.total.LosAngeles <- NEI.vehicle %>% 
        group_by(year) %>%
        filter(fips == "06037") %>%
        summarize(Total.vehicle = sum(Emissions, na.rm = TRUE))
NEI.vehicle.total.LosAngeles<-cbind(NEI.vehicle.total.LosAngeles, "City"=rep("Los Angeles",4))
        

#group by year and find total emission of that year for Baltimore
NEI.vehicle.total.baltimore <- NEI.vehicle %>% 
        group_by(year) %>%
        filter(fips == "24510") %>%
        summarize(Total.vehicle = sum(Emissions, na.rm = TRUE))
NEI.vehicle.total.baltimore<-cbind(NEI.vehicle.total.baltimore, "City"=rep("Baltimore",4))

#now rbind above both city tables
NEI.vehicle.total<-rbind(NEI.vehicle.total.baltimore,NEI.vehicle.total.LosAngeles)

#store plot in png file
png("plot6.png", width = 480, height = 480)
#plot
ggplot(NEI.vehicle.total, 
       aes(NEI.vehicle.total$year, NEI.vehicle.total$Total.vehicle, col = City))+
        geom_line(size = 1)+
        xlab("Year") +
        ylab("Total Emissions [Tons]") +
        ggtitle("Comparison of Total Annual Vehicle Emissions in Baltimore and Los Angeles")
#close connection
dev.off()
