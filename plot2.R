#download the file containing the relevant data 
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url,'zippeddata.txt')

#it's in a zipped format so we need to unzip it before we can use it
unzip('zippeddata.txt')

#create a database from the new unzipped file
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")


#make the dates more usable
data$Date <- as.Date(data$Date, '%d/%m/%Y')

#subset the data for the dates we want
data <- subset(data, Date >= '2007-02-01' & Date <= '2007-02-02')

#convert to posixlt format to make day of the week easier to grab
dateTime   <- as.POSIXlt(paste(as.Date(data$Date, format="%d/%m/%Y"), data$Time, sep=" "))

#initialize a png file to store all this
png(filename='plot2.png',
    width = 480,
    height= 480)

#creates a blank plot (without the points)
plot(dateTime, data$Global_active_power,type='n',xlab=NA,ylab='Global Active Power (kilowatts)')

#add a line between the hidden data points
lines(dateTime, data$Global_active_power)

#turn everything off
dev.off()