## You must address the following questions and tasks 
##in your exploratory analysis. For each question/task 
##you will need to make a single plot. Unless specified, 
##you can use any plotting system in R to make your plot.


## 4. Across the United States, how have emissions from 
##coal combustion-related sources changed from 1999???2008?



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






##### Coal in SCC
SCCCoal <- SCC[SCC$EI.Sector %in% 
                       c(grep("Coal", unique(SCC$EI.Sector), value = TRUE)), ]

##### matching the Coal in SCC and NEI  
NEICoal <- NEI[NEI$SCC %in% SCCCoal$SCC, ]
head(NEICoal)

##### coal : total emissions per year
coalTotalEmiYear <- round(aggregate(Emissions ~ year, 
                                    data=NEICoal, FUN=sum, na.action=na.omit),2)
head(coalTotalEmiYear)

##### ggplot 
library(ggplot2)

png(filename= "plot4.png", width = 700)
g <- ggplot(coalTotalEmiYear, aes(x=year, y=Emissions)) 
g + geom_point(color = "steelblue", size = 4, alpha = 1/2) + 
        geom_line(color = "steelblue") + 
        geom_text(aes(label= Emissions, y = Emissions), size = 5) +
        labs(title = "Total Emmissions in USA from coal combution \n (1999 - 2008)", x = "Year", y="Total Emissions in tons" ) 

dev.off()       


























