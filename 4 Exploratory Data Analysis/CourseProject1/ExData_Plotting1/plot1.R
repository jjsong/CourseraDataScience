
# Goloba Active Power : Histogram

# style(date, time) arranged
Sys.setlocale("LC_TIME", "en_US.UTF-8")

# Read data 
houseData <- read.table('./data/household_power_consumption.txt',
                        sep=';', header=T, 
                        colClasses = c('character', 'character', 'numeric',
                                       'numeric', 'numeric', 'numeric', 
                                       'numeric', 'numeric', 'numeric'),
                        na.strings='?')


# reading and setting Date 
houseData$DateTime <- strptime(paste(houseData$Date, houseData$Time),
                               "%d/%m/%Y %H:%M:%S")

# subsetting the condition (2-day period)
houseData <- subset(houseData, as.Date(DateTime) >= as.Date("2007/02/01") & 
                            as.Date(DateTime) <= as.Date("2007/02/02"))

# open PNG file with 480x480
png("plot1.png", height=480, width=480)

# histogram
hist(houseData$Global_active_power, 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power(kilowatts)")

# close PNG file
dev.off()
