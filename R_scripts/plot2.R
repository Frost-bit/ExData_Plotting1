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
png("plot2.png")
#plot the graph of datetime vs. Global_active_power
with(hpc_data, plot(datetime, Global_active_power, type = "l", xlab="", 
                    ylab="Global Active Power (kilowatts)"))
#close device
dev.off()
