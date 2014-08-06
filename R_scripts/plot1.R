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
#open png device
png("plot1.png")
#plot histogram of the Global_active_power variable
hist(hpc_data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col="orangered")
#close device
dev.off()

