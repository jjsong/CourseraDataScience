## You must address the following questions and tasks 
##in your exploratory analysis. For each question/task 
##you will need to make a single plot. Unless specified, 
##you can use any plotting system in R to make your plot.


## How have emissions from motor vehicle sources changed 
## from 1999???2008 in Baltimore City?



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






##### total emission in Baltimore City (NEI) 
balEmi <- subset(NEI,NEI$fips == "24510")
head(balEmi)

##### emission - motor vehicle : ON-ROAD
balEmiOnRoad <- subset(balEmi, balEmi$type == "ON-ROAD")
balEmiOnRoadYear <- round(aggregate(Emissions ~ year, 
                                    data=balEmiOnRoad, FUN=sum, na.action=na.omit),2)
balEmiOnRoadYear

##### ggplot
library(ggplot2)

png(filename= "plot5.png", width = 700)
g <- ggplot(balEmiOnRoadYear, aes(x=year, y=Emissions)) 
g + geom_point(color = "steelblue", size = 4, alpha = 1/2) + 
        geom_line(color = "steelblue") + 
        geom_text(aes(label= Emissions, y = Emissions), size = 5) +
        labs(title = "Total Emmissions in Baltimore from motor vehicle \n (1999 - 2008)")+
        labs(x = "Year") +
        labs(y="Total Emissions in tons" ) 

dev.off()  







