#Code to generate png1 by pdwessel

#This code assumes that the text data file in in the same directory as this R script

#Load relevant packages
library(data.table)
library(dtplyr)

#Read in the data
datafile <- "household_power_consumption.txt"
sdata <- fread(datafile, sep = ";", nrows = 5) #read in first 5 rows
classes <- sapply(sdata, class) #strip out the column classes

hpc <- fread(datafile, sep = ";", colClasses = classes, na.strings = "?")

hpc$Time <- paste(hpc$Date, hpc$Time)

#Convert Date column from character to date class
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

#Subset the data to the desired date range
hpc_sub <- subset(hpc, Date >= "2007-02-01" & Date <= "2007-02-02")

#Create a time vector
timeline <- strptime(hpc_sub$Time, "%d/%m/%Y %H:%M:%S") 

#Create the plot
png(file = "plot3.png")
plot(timeline, hpc_sub$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(timeline, hpc_sub$Sub_metering_1, col = "black")
lines(timeline, hpc_sub$Sub_metering_2, col = "red")
lines(timeline, hpc_sub$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), cex = 0.75)
dev.off()