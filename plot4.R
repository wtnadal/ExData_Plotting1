### Start of plot4.R ###
#
# the goal here is simply to examine how household energy usage varies over a 2-day period
# in February, 2007 

# load any necessary libraries
library(datasets)
library(data.table)
library(dplyr)
library(lubridate)

# set the current directory to the source and data files
# read power consumption data set from UC Irvine Machine Learning Repository
# download the data (manually unzip the file)

wd <- getwd()
setwd("~/ExData_Plotting1")

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
tempfile <- "household_power_consumption.zip"
download.file(URL, tempfile, method = "curl", )
unzip(tempfile,exdir = "../ExData_Plotting1")
unlink(tempfile)

# read the file into variable pc = (abbr for power consuption)
# tested fread() versus read.table().  it is 6x faster, but introduced errors.
pc <- read.table("household_power_consumption.txt", 
                 sep = ";", header = TRUE, na.strings=c("NA", "-", "?"))

# extract the dates we are interested in analyzing - filter() is faster then subset()
pc2 <- filter(pc, Date == "1/2/2007" | Date == "2/2/2007" )

# cleanup the date and time cols into proper POSIX classes
pc2$Date <- dmy(pc2$Date)
pc2$Date <- as.character(pc2$Date)
pc2$Time <- as.character(pc2$Time)
pc2$Date <- as.POSIXct(paste(pc2$Date, pc2$Time))

# setup plot4
graphics.off()  # avoid graphic device mismatch

# create the png file 480x480 pixels
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), cex = .6, oma = c(2, 2, 2, 2))

with(pc2, {
        plot(Date, Global_active_power, type = "l", 
             ylab = "Global Active Power", 
             xlab = "")
        plot(Date, Voltage, type = "l", ylab = "Global Active Power", xlab = "datetime")
        plot(Date, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
                lines(Date, Sub_metering_1, col = "black")
                lines(Date, Sub_metering_2, col = "red")
                lines(Date, Sub_metering_3, col = "blue")
                legend("topright", col = c("black", "red", "blue"), bty = "n", lwd = 1, lty = 1,
                        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Date, Global_reactive_power, type = "l", ylab = "Global_reactive_power", 
             xlab = "datetime")        
        })

dev.off() # close the PNG device

### End of plot4.R ###