### Start of plot2.R ###
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

# close any open devices
dev.off() 

# create the png file 480x480 pixels
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA, type = c("quartz"))

# create the plot
with(pc2, plot(Date, Global_active_power, type = "l", 
               ylab = "Global Active Power (kilowatts)", 
               xlab = ""))

dev.off() # close the PNG device!

### End of plot2.R  ###