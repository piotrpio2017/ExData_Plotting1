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

#Prepare numeric Global Active Power data for hist function 
firstTwoFebruary2007DaysDataset$Global_active_power <- as.numeric(as.vector(firstTwoFebruary2007DaysDataset$Global_active_power))


###Make plot 1 in PNG file


#Simple histogram function

hist(firstTwoFebruary2007DaysDataset$Global_active_power)

#Add label for x axis
hist(firstTwoFebruary2007DaysDataset$Global_active_power, xlab = "Global Active Power (kilowatts)")

#Add plot main title
hist(firstTwoFebruary2007DaysDataset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#Add colour to fill the bars
hist(firstTwoFebruary2007DaysDataset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

#Save plot to a PNG file with a width of 480 pixels and a height of 480 pixels
png(filename = "plot1.png", width = 480, height = 480)
hist(firstTwoFebruary2007DaysDataset$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()