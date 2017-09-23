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


###Make plot 2 in PNG with a width of 480 pixels and a height of 480 pixels

#Start PNG graphics device with desired width and height
png(filename = "plot2.png", width = 480, height = 480)

#Simple plot function
plot(firstTwoFebruary2007DaysDataset$Global_active_power)

#Change plot type to lines
plot(firstTwoFebruary2007DaysDataset$Global_active_power, type = "l")

#Set X and Y axis labels
plot(firstTwoFebruary2007DaysDataset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

#Remove original axes from the plot
plot(firstTwoFebruary2007DaysDataset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", axes = FALSE)

#Add frame to plot
box(lty = 'solid', col = 'black')

#Add X axis
points <- c(50, 1500, 2900)
x_axis_labels <- c("Thu", "Fri", "Sat")
axis(1, at = points, labels = x_axis_labels)

#Add Y axis
axis(side=2, at=seq(0,8,2), labels=seq(0,8,2))

#Close PNG graphics device 
dev.off()
