## You must address the following questions and tasks 
##in your exploratory analysis. For each question/task 
##you will need to make a single plot. Unless specified, 
##you can use any plotting system in R to make your plot.

## 2. Have total emissions from PM2.5 decreased in the Baltimore City,
## Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
## to make a plot answering this question.

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

##### total emission in Baltimore City 
balEmi <- subset(NEI,NEI$fips == "24510")
balEmiYear <- aggregate(Emissions ~ year + fips,
                        data=balEmi, sum, na.action=na.omit)
balEmiYear

##### making plot2
plot2 <- function () {
        png(filename= "plot2.png", width = 480, height = 480)
        plot(balEmiYear$year, balEmiYear$Emissions, type='b',
             xaxt = "n",
             #yaxt = "n",
             xlab = "Years",
             ylab = "PM2.5 (tons)",
             main = "Total Emissions PM2.5 in Baltimore City, Maryland(1999-2008)"
        )
        
        axis(side= 1, at=balEmiYear$year, las=1)
        #axis(side= 2, at=balEmiYear$Emissions, las=2)
        dev.off()
}
plot2()




