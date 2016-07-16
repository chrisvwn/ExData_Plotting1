library(data.table)
library(lubridate)
library(dplyr)

#The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#  
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, # containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry # room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.


#read the data in. NA is coded with "?" and the separator used is a semicolon
hpc <- fread("household_power_consumption.txt", sep = ";", header = T, na.strings = "?")

#plot 2

#convert the date and time character fields to date types
dt <- as.POSIXct(paste(hpc$Date, hpc$Time, sep=" "), format = "%d/%m/%Y %H:%M:%S")

hpc$Date <- NULL
hpc$Time <- NULL
hpc <- cbind(hpc, "DateTime"=dt)

hpc <- hpc[hpc$DateTime >= as.POSIXct('2007-02-01 00:00:00') & hpc$DateTime <= as.POSIXct('2007-02-02 23:59:00')]

png(filename = "plot3.png")

with(hpc, plot(DateTime, Sub_metering_1, type="l", col="red", ylab = "Energy sub metering"))
with(hpc, lines(DateTime, Sub_metering_2, col="green"))
with(hpc, lines(DateTime, Sub_metering_3, col="blue"))
  legend("topright", col = c("red", "green", "blue"), lwd = "1", cex=0.5, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()