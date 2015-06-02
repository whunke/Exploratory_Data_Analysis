# Retrieve full dataset from file
# Source used is from UC Irvine Machine Learning - https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
power_data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

# Subset the data based on the date range 2/1/07 - 2/2/07
range <- subset(power_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(power_data)

# Converting data to Date/Time class
range$DateTime = paste(range$Date, range$Time)
range$DateTime <- strptime(range$DateTime, "%d/%m/%Y %H:%M:%S")
attach(range)

# Create plot1.png
hist(range$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Save plot1.png to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
