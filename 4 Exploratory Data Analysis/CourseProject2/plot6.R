## You must address the following questions and tasks 
##in your exploratory analysis. For each question/task 
##you will need to make a single plot. Unless specified, 
##you can use any plotting system in R to make your plot.


# 6. Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County,
# California (fips == "06037"). Which city has seen greater changes 
# over time in motor vehicle emissions?
 


##### Download source file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile="./exdata-data-NEI_data.zip")
if(!file.exists("./data")){dir.create("./data")}
unzip("exdata-data-NEI_data.zip", exdir = "./data")


##### Reading the files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Checking 
dim(NEI); head(NEI)
dim(SCC); head(SCC)
names(SCC)







##### total emissions in Baltimore City (NEI) 
balEmi <- subset(NEI,NEI$fips == "24510")
head(balEmi)

##### emissions in Baltimore - motor vehicle : ON-ROAD
balEmiOnRoad <- subset(balEmi, balEmi$type == "ON-ROAD")
balEmiOnRoadYear <- round(aggregate(Emissions ~ year, 
                                    data=balEmiOnRoad, FUN=sum, na.action=na.omit),2)
balEmiOnRoadYear$city <- c("Baltimore")
balEmiOnRoadYear




##### total emissions in California  City (NEI) 
calEmi <- subset(NEI,NEI$fips == "06037")
head(calEmi)

##### emissions in California - motor vehicle : ON-ROAD
calEmiOnRoad <- subset(calEmi, calEmi$type == "ON-ROAD")
calEmiOnRoadYear <- round(aggregate(Emissions ~ year, 
                                    data=calEmiOnRoad, FUN=sum, na.action=na.omit),2)
calEmiOnRoadYear$city <- c("California")
calEmiOnRoadYear

##### make one dataset 
balCalEmiOnRoadYear <- as.data.frame(rbind(balEmiOnRoadYear,calEmiOnRoadYear))
balCalEmiOnRoadYear



##### comparing the emissions
png(filename= "plot6.png", width = 500)
g <- qplot(year, Emissions, data = balCalEmiOnRoadYear, color = city, geom = c("point","line"))
g + geom_point(size = 4)+
        labs(x = "Year") +
        labs(y = "Total Emissions in tons") +
        labs(title = "Comparing total emissions in Balimore vs. California \n from moter vehicle (1999 ~ 2008)")
dev.off()






