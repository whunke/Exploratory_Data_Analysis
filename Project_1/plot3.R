# Retrieve full dataset from file
# Source used is from UC Irvine Machine Learning - https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
power_data <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                       nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

# Subset the data based on the date range 2/1/07 - 2/2/07
range <- subset(power_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Converting data to Date/Time class
DateTime <- paste(as.Date(range$Date), range$Time)
range$DateTime <- as.POSIXct(DateTime)

# Create plot3.png
with(range, {
    plot(Sub_metering_1~DateTime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~DateTime,col='Red')
    lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=.5)
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
