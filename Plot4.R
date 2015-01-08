rm(list=ls()) # clear environment
set.seed(6583) # setting seed for reproducibility, in case of random number gen.
library(lubridate)
library(data.table)

#if extracted and saved locally as excel
#HEC <- read.csv("D:/Coursera/ExData_Plotting1/WorkingData/power_consumption_2_day.csv", header = TRUE)

#if it needs to be read from internet into the working directory
url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url, destfile="./rawdata-power.zip")
unzip('./rawdata-power.zip')
#read data with data.table
HEC <- read.table('household_power_consumption.txt', header=TRUE,sep=';', na.strings='?',
                  colClasses=c(rep('character', 2), rep('numeric', 7)))

summary(HEC) # No missing values found, 0's assumed to be correct values
View(HEC) # displays the first 1000 rows


HEC$Date <- dmy(HEC$Date) #convert to standard date format
str(HEC$Date)  # view variable characteristics
wkday <- wday(HEC$Date) # To extract weekday
HEC$Time <- hms(HEC$Time)
str(HEC$Time)

#Extract for required dates
HEC <- subset(HEC, year(Date) == 2007 & month(Date) == 2 & (day(Date) == 1 | day(Date) == 2))

#convert individual variables and convert
DateTime <- HEC$Date+  HEC$Time

#screen split 
par(mfrow = c(2, 2))

#plot1
plot(DateTime, HEC$Global_active_power, type = "l", col='black', ylab = "Global Active Power", xlab = "")
#plot2
plot(DateTime, HEC$Voltage, type = "l", col='darkgrey', ylab = "Voltage", xlab = "datetime")
#plot 3 - multi-plot - plot&lines 
plot(DateTime, HEC$Sub_metering_1, type = "l", col='black', xlab = "", ylab = "Energy sub metering")
lines(DateTime, HEC$Sub_metering_2, type = "l", col = 'red', xlab = "", ylab = "Energy sub metering")
lines(DateTime, HEC$Sub_metering_3, type = "l", col = 'blue',xlab = "", ylab = "Energy sub metering")
legend("topright",  col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=1, bty='n', xjust=1, yjust=1)
#plot4
plot(DateTime, HEC$Global_reactive_power, type = "l",col='darkblue', xlab = "datetime", ylab = "Global_reactive_power", ylim = c(0, 0.5))


#copy the png file to working directory
dev.copy(png, file="Plot4.png", width=480, height=480)
dev.off()
