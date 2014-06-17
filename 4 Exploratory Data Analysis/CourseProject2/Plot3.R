## You must address the following questions and tasks 
##in your exploratory analysis. For each question/task 
##you will need to make a single plot. Unless specified, 
##you can use any plotting system in R to make your plot.

## 3. Of the four types of sources indicated by the type 
## (point, nonpoint, onroad, nonroad) variable, which of these four sources 
## have seen decreases in emissions from 1999???2008 for Baltimore City? 
## Which have seen increases in emissions from 1999???2008? 
## Use the ggplot2 plotting system to make a plot answer this question.



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


##### total emission per type in Baltimore City 
balEmi <- subset(NEI,NEI$fips == "24510")
head(balEmi)

balEmiYearType <- aggregate(Emissions ~ year + fips + type, 
                            data=balEmi, FUN=sum, na.action=na.omit)
balEmiYearType


##### making plot3 
library(ggplot2)
plot3 <- function () {
        png(filename= "plot3.png", width = 700)
        ima <-qplot(year, Emissions, data=balEmiYearType,
                    color=type, geom='line', 
                    main = "Total Emissions PM2.5 by type in Baltimore City, Maryland(1999-2008)",
                    xlab = "Years", ylab = "PM2.5 (tons)"
        )
        print(ima)
        dev.off()
}
plot3()



















