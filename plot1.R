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

dt <- as.POSIXct(paste(hpc$Date, hpc$Time, sep=" "), format = "%d/%m/%Y %H:%M:%S")

hpc$Date <- NULL
hpc$Time <- NULL
hpc <- cbind(hpc, "DateTime"=dt)

hpc <- hpc[hpc$DateTime > as.POSIXct('2007-02-01') & hpc$DateTime < as.POSIXct('2007-02-02')]

#plot 1
#open the png device
png(filename = "plot1.png")

#histogram of Global_active_power
hist(hpc$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()