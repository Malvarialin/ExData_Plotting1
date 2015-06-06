#download the file containing the relevant data
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

download.file(url,'zippeddata.txt')

#it's in a zipped format so we need to unzip it before we can use it
unzip('zippeddata.txt')

#create a database from the new unzipped file
data <- read.csv("household_power_consumption.txt", sep=";", na.strings="?")


#make the dates usable
data$Date <- as.Date(data$Date, '%d/%m/%Y')

#subset the data for the dates we want
data_subset <- subset(data, Date >= '2007-02-01' & Date <= '2007-02-02')

#initialize a png file to store all this
png(filename='plot1.png',
    width = 480,
    height= 480)

#make the histogram
with(data_subset,hist(Global_active_power,
                    col = 'red', 
                    axes=T, 
                    xlab = 'Global Active Power (kilowatts)', 
                    ylab= 'Frequency',
                    main ='Global Active Power'))

#close the file
dev.off()

