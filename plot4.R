#download the file and unzip its contents
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

download.file(url,'zippeddata.txt')

unzip('zippeddata.txt')

#create a database from the new unzipped file
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")


#make the dates more usable for subsetting
data$Date <- as.Date(data$Date, '%d/%m/%Y')

#subset the data for the dates we want
data <- subset(data, Date >= '2007-02-01' & Date <= '2007-02-02')

#convert to posixlt format to make day of the week easier to grab
dateTime   <- as.POSIXlt(paste(as.Date(data$Date, format="%d/%m/%Y"), data$Time, sep=" "))

#initialize a png file to store all this
png(filename='plot4.png',
    width = 480,
    height= 480)

#tell R we want a 2x2 grouping of plots
par(mfrow = c(2,2))

#create the first plot (same as plot2.R)
plot(dateTime, data$Global_active_power,
     type='n',
     xlab=NA,
     ylab='Global Active Power')
lines(dateTime, data$Global_active_power)

#make the second plot
plot(dateTime, data$Voltage, 
     type='n',
     xlab='datetime', 
     ylab='Voltage')
lines(dateTime, data$Voltage)

#make the third plot (same as plot3.R)
plot(dateTime, data$Sub_metering_1,
     type='n',
     xlab=NA,
     ylab='Energy sub metering')
lines(dateTime, data$Sub_metering_1, col='black')
lines(dateTime, data$Sub_metering_2, col='red')
lines(dateTime, data$Sub_metering_3, col='blue')

#make the fourth plot
plot(dateTime, data$Global_reactive_power, 
     type='n',
     xlab= 'datetime',
     ylab= 'Global_reactive_power')
lines(dateTime,data$Global_reactive_power)

#and finally turn the plotting mode off
dev.off()