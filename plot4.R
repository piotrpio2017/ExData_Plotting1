###Loading the data


#Reading data set only for first two days of Februrary 2007 (after observation first rows of original data set)
rowsPerDay <- 1440
SixteenthDecember2006Rows <- 397
December2006Days <- 15
January2007Days <- 31
firstTwoFebruary2007DaysDataset <- read.table("household_power_consumption.txt", nrows = rowsPerDay*2, skip = SixteenthDecember2006Rows + (December2006Days+January2007Days) * rowsPerDay)


##Make data tidy

#Divide column to 9 columns according to delimiter “;”
library(stringr)
firstTwoFebruary2007DaysDataset <- as.data.frame(str_split_fixed(firstTwoFebruary2007DaysDataset$V1, ";", 9))

#Add columns names from original data set
firstTwoFebruary2007DaysDatasetFirstRow <- read.table("household_power_consumption.txt", nrows = 1)
names(firstTwoFebruary2007DaysDataset) <- as.vector(str_split_fixed(firstTwoFebruary2007DaysDatasetFirstRow$V1, ";", 9))

#Prepare numeric Global Active Power data for plot function 
firstTwoFebruary2007DaysDataset$Global_active_power <- as.numeric(as.vector(firstTwoFebruary2007DaysDataset$Global_active_power))

#Prepare numeric Voltage data for plot function 
firstTwoFebruary2007DaysDataset$Voltage <- as.numeric(as.vector(firstTwoFebruary2007DaysDataset$Voltage))

#Prepare numeric Sub_metering_1...Sub_metering_3 data for plot function 
firstTwoFebruary2007DaysDataset$Sub_metering_1 <- as.numeric(as.vector(firstTwoFebruary2007DaysDataset$Sub_metering_1))
firstTwoFebruary2007DaysDataset$Sub_metering_2 <- as.numeric(as.vector(firstTwoFebruary2007DaysDataset$Sub_metering_2))
firstTwoFebruary2007DaysDataset$Sub_metering_3 <- as.numeric(as.vector(firstTwoFebruary2007DaysDataset$Sub_metering_3))

#Prepare numeric Global_reactive_power data for plot function 
firstTwoFebruary2007DaysDataset$Global_reactive_power <- as.numeric(as.vector(firstTwoFebruary2007DaysDataset$Global_reactive_power))


###Make plot 4 in PNG with a width of 480 pixels and a height of 480 pixels

#Start PNG graphics device with desired width and height
png(filename = "plot4.png", width = 480, height = 480)

#Prepare environment for plot four graphs
par(mfrow=c(2,2))


##Plot topleft graph
plot(firstTwoFebruary2007DaysDataset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", axes = FALSE)

#Add frame to plot
box(lty = 'solid', col = 'black')

#Add X axis
points <- c(50, 1500, 2900)
x_axis_labels <- c("Thu", "Fri", "Sat")
axis(1, at = points, labels = x_axis_labels)

#Add Y axis
axis(side=2, at=seq(0,8,2), labels=seq(0,8,2))


##Plot topright graph
plot(firstTwoFebruary2007DaysDataset$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", axes = FALSE)

#Add frame to plot
box(lty = 'solid', col = 'black')

#Add X axis
points <- c(50, 1500, 2900)
x_axis_labels <- c("Thu", "Fri", "Sat")
axis(1, at = points, labels = x_axis_labels)

#Add Y axis
axis(side=2, at=seq(234,248,2), labels=seq(234,248,2))


##Plot bottom left graph
plot(firstTwoFebruary2007DaysDataset$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", axes = FALSE)

#Set font type and family for final plot (to avoid change font parameters by par() occurred before legend) 
par(font = 1, family = "sans")

#Add frame to plot
box(lty = 'solid', col = 'black')

#Add X axis
points <- c(50, 1500, 2900)
x_axis_labels <- c("Thu", "Fri", "Sat")
axis(1, at = points, labels = x_axis_labels)

#Add Y axis
axis(side=2, at=seq(0,40,10), labels=seq(0,40,10))

#Plot remain two variables (Sub_metering_1, Sub_metering_2) as lines
lines(firstTwoFebruary2007DaysDataset$Sub_metering_2, col = "red")
lines(firstTwoFebruary2007DaysDataset$Sub_metering_3, col = "blue")

#Add legend with font type and family
par(font = 1, family = "sans")
legend("topright", inset=.02, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, cex=0.9, pt.cex = 5, box.lty=0)


##Plot bottom left graph
plot(firstTwoFebruary2007DaysDataset$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", xaxt = 'n')

#Add frame to plot
#box(lty = 'solid', col = 'black')

#Add X axis
x_points <- c(50, 1500, 2900)
x_axis_labels <- c("Thu", "Fri", "Sat")
axis(1, at = x_points, labels = x_axis_labels)

#Close PNG graphics device 
dev.off()
