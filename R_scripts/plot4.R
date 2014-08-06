#name of the text file with the data
file <- "household_power_consumption.txt"
#number of first line in the text file with date 2007-02-01
first <- 66637
#number of last line in the text file with date 2007-02-02
last <- 69516
#read data with selected dates from the text file
hpc_data <- read.table(file, skip=first, nrows=(last - first + 1), sep=";", 
                       colClasses=c(rep("character", 2), rep("numeric", 7)), 
                       na.strings="?")
#set correct variable names
colnames(hpc_data) <- colnames(read.table(file, nrows=1, header=TRUE, sep=";"))
#convert the "Date" column to class Date
hpc_data$Date <- as.Date(hpc_data$Date, format="%d/%m/%Y")
#create column "datetime" by pasting the corresponding date and time together and 
#converting it to the POSIXlt class
hpc_data$datetime <- strptime(paste(hpc_data$Date, hpc_data$Time), 
                              format="%Y-%m-%d %H:%M:%S")
#open png device
png("plot4.png")
#set mfcol to save four plots in one image
par(mfcol=c(2, 2))
#make multiple plots
with(hpc_data, {
  #new plot of datetime vs. Global_active_power
  plot(datetime, Global_active_power, type = "l", xlab="",ylab="Global Active Power")
  #new plot of datetime vs. Sub_metering_1
  plot(datetime, Sub_metering_1, type="l", xlab="",ylab="Energy sub metering")
  #add to last plot the datetime vs. Sub_metering_2
  lines(hpc_data$datetime, hpc_data$Sub_metering_2, col="red")
  #add to last plot the datetime vs. Sub_metering_3
  lines(hpc_data$datetime, hpc_data$Sub_metering_3, col="blue")
  #add to last plot the legend for each different graph
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, lty=1, col=c("black", "red", "blue"), bty = "n")
  #new plot of datetime vs. Voltage
  plot(datetime, Voltage, type="l")
  #new plot of datetime vs. Global_reactive_power
  plot(datetime, Global_reactive_power, type="l")
})
#close device
dev.off()

