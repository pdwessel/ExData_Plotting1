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
png(file = "plot2.png")
plot(timeline, hpc_sub$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(timeline, hpc_sub$Global_active_power)
dev.off()

