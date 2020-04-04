#import llibrary and read data
library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Extract SSC where coal is present
SCC.coal.comb<-SCC[grep("[Cc]oal", SCC$EI.Sector),]
#now create subset of NEI where above SCC element are present
NEI.coal.comb<-subset(NEI,NEI$SCC %in% SCC.coal.comb$SCC)
#group by year and find total emission of that year
NEI.coal.comb.total <- NEI.coal.comb %>% 
        group_by(year) %>%
        summarize(Total.Coal.Comb = sum(Emissions, na.rm = TRUE))


#store plot in png file
png("plot4.png", width = 480, height = 480)
#plot
ggplot(NEI.coal.comb.total, 
       aes(NEI.coal.comb.total$year, NEI.coal.comb.total$Total.Coal.Comb))+
        geom_line()+
        xlab("Year") +
        ylab("Total Emissions [Tons]") +
        ggtitle("Total Annual Coal Combustion Emissions in the US")
#close connection
dev.off()

