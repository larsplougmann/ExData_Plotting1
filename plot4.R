plot4 <- function() {
  
  library(lubridate)
  
  ## The plot uses a dataset available at
  ## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip.
  ## The code assumes that the data has been downloaded and extracted in a particular directory.
  
  ## Read data
  orgdir <- getwd()
  setwd("/Users/larsplougmann/Data/ExData_Plotting1")
  
  ## Read the entire data file
  powerdata <- read.csv("household_power_consumption.txt", sep=";", 
                        na.strings="?", 
                        colClasses = c("character", "character", rep("numeric",7)))
  setwd(orgdir)
  
  ## then pare it down to just the two days worth of data we are interested in
  powerdata <- subset(powerdata, powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007")
  
  ## convert date and time strings to a timestamp using lubridate
  powerdata <- transform(powerdata, timestamp = dmy_hms(paste(powerdata$Date, powerdata$Time)))
  
  ## Now for the plotting.
  
  ## First specify that we are creating the plot in a PNG file
  png(file = "plot4.png", width = 480, height = 480, units = "px")
  
  ## Set up the frames for the four plots
  
  par(mfrow = c(2, 2))
  
  ## Create top left plot
  
  with(powerdata, plot(timestamp,Global_active_power, type="l",
                       ylab = "Global Active Power", xlab=""))
  
  ## Create top right plot
  
  with(powerdata, plot(timestamp,Voltage, type="l",
                       xlab="datetime"))
  
  ## Create bottom left plot
  
  with(powerdata, plot(timestamp,Sub_metering_1, type="l",
                       ylab = "Energy sub metering", xlab=""))
  with(powerdata,points(timestamp,Sub_metering_2, type="l", col="red"))
  with(powerdata,points(timestamp,Sub_metering_3, type="l", col="blue"))
  legend("topright", lty=1, bty="n", col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  ## Create bottom right plot
  
  with(powerdata, plot(timestamp,Global_reactive_power, type="l",
                       xlab="datetime"))
  
  ## And finish off by closing the device
  dev.off()

}