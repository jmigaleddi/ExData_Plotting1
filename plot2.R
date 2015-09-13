## Load necessary packages
library(data.table)
library(lubridate)
library(dplyr)

## Check for an existing "data" directory
if(!file.exists("./data")){dir.create("./data")}


## Define the location of the data to be downloaded
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download the zip file into the created folder, then extract the files
download.file(fileURL, destfile="./data/HHpowerconsumption.zip")
unzip(".//data/HHpowerconsumption.zip", exdir=".//data")

## Read in the data
hhpower.data <- fread(".//data/household_power_consumption.txt", sep = ";")

## Manipulate the data set
hhpower.data <- mutate(hhpower.data, date_time = paste(Date, Time))     ## Combine the dates and times into 1 field
hhpower.data$Date <- dmy(hhpower.data$Date)                             ## Convert the dates to the proper format
hhpower.data$Time <- hms(hhpower.data$Time)                             ## Convert the times to the proper format
hhpower.data$date_time <- dmy_hms(hhpower.data$date_time)               ## Convert the dates/times to the proper format

## Filter the data to only keep data for February 1st and 2nd
date1 <- hhpower.data$Date[67000]                                       ## Index February 1st
date2 <- hhpower.data$Date[69000]                                       ## Index February 2nd
hhpower.data2 <- hhpower.data[(hhpower.data$Date == date1) |            ## Subset using the indices
                                      (hhpower.data$Date == date2), ]

## Create the line chart
png(filename = "plot2.png")                                                   ## Initialize the PNG graphics device
plot(hhpower.data2$date_time, as.numeric(hhpower.data2$Global_active_power),  ## Create the plot
        type = "l",
        main = " ",
        ylab = "Global Active Power (kilowatts)",
        xlab = " ")
dev.off()
