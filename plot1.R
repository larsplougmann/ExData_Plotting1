plot1 <- function() {
  
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
  
  ## convert date and time strings to date and time variables using lubridate
  powerdata <- transform(powerdata, dat = dmy(Date), tim = hms(Time))
  
  ## Now for the plotting.
  
  ## First specify that we are creating the plot in a PNG file
  png(file = "plot1.png", width = 480, height = 480, units = "px")
  ## Then go ahead and create the plot
  hist(powerdata$Global_active_power, 
       main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)", 
       col="red")
  ## And finish off by closing the device
  dev.off()

}