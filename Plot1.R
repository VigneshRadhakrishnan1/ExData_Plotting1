rm(list=ls()) # clear environment
set.seed(6583) # setting seed for reproducibility, in case of random number gen.
library(lubridate)
library("data.table")

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


HEC$Date <- as.Date(HEC$Date, "%d/%m/%Y") #convert to standard date format
str(HEC$Date)  # view variable characteristics
wkday <- wday(HEC$Date) # To extract weekday
HEC$Time <- hms(HEC$Time)
str(HEC$Time)

#Extract for required dates
HEC <- subset(HEC, year(Date) == 2007 & month(Date) == 2 & (day(Date) == 1 | day(Date) == 2))

par(mfrow = c(1,1))
hist(HEC$Global_active_power, col='Red',xlim = c(0,6), ylim=c(0,1200), breaks=12, xaxp=c(0,6,3)
      ,xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main="Global Active Power")

#copy the png file to working directory
dev.copy(png, file="Plot1.png", width=480, height=480)
dev.off()
