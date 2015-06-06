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
png(filename='plot3.png',
    width = 480,
    height= 480)
#create the plot
plot(dateTime, data$Sub_metering_1,
     type='n',
     xlab=NA,
     ylab='Energy sub metering')
#add the nice lines
lines(dateTime, data$Sub_metering_1, col='black')
lines(dateTime, data$Sub_metering_2, col='red')
lines(dateTime, data$Sub_metering_3, col='blue')

#create the legend
legend('topright',
       lwd =1, 
       col=c('black','red','blue'),
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
#close the graph
dev.off()

