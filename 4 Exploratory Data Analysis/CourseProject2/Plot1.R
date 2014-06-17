## You must address the following questions and tasks 
##in your exploratory analysis. For each question/task 
##you will need to make a single plot. Unless specified, 
##you can use any plotting system in R to make your plot.

## 1. Have total emissions from PM2.5 decreased in the United States 
##from 1999 to 2008? Using the base plotting system, 
##make a plot showing the total PM2.5 emission from all sources 
##for each of the years 1999, 2002, 2005, and 2008.


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


##### total emmisions 
emiYear <- aggregate(Emissions ~ year, data=NEI, FUN=sum)
emiYear

##### making plot
plot1 <- function () {
        png(filename= "plot1.png", width = 480, height = 480)
        plot(emiYear$year, emiYear$Emissions, type='b',
             xaxt = "n",
             #yaxt = "n",
             xlab = "Years",
             ylab = "PM2.5 (tons)",
             main = "Total Emissions PM2.5 in USA (1999-2008)"
        )
        
        axis(side= 1, at=emiYear$year, las=1)
        #axis(side= 2, at=emiYear$Emissions, las=2)
        dev.off()
}
plot1()










