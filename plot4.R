# Download and unzip the dataset
datadir <- "./data/"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfilename <- "household_power_consumption.zip"
datafilename <- "household_power_consumption.txt"
if (!dir.exists(datadir)) {
    dir.create(datadir)
}
if (!file.exists(paste(datadir, zipfilename, sep = ""))) {
    download.file(fileURL, paste(datadir, zipfilename, sep = ""))
}
if (!file.exists(paste(datadir, datafilename, sep = ""))) {
    unzip(paste(datadir,zipfilename, sep = ""), exdir = datadir)
}

# Read the dataset into a data frame
data <- read.table(
    paste(datadir, datafilename, sep = ""),
    header = TRUE,
    sep = ";",
    na.strings = "?"
)
data <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")
data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %T")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

# Create a PNG graphics file
png(filename = "plot4.png", width = 480, height = 480)

# Initialize composite graph with multiple plots
par(
    mfcol = c(2, 2)
)

# Generate the plots
# plot 1
plot(
    data$Time,
    data$Global_active_power,
    xlab = "",
    ylab = "Global Acrive Power (kilowatts)",
    type = "l"
)

# plot 2
plot(
    data$Time,
    data$Sub_metering_1,
    xlab = "",
    ylab = "Energy sub metering",
    type = "l"
)
lines(
    data$Time,
    data$Sub_metering_2,
    col = "red"
)
lines(
    data$Time,
    data$Sub_metering_3,
    col = "blue"
)
legend(
    "topright",
    col = c("black", "red", "blue"),
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty = 1,
    bty = "n"
)

# plot 3
plot(
    data$Time,
    data$Voltage,
    xlab = "datetime",
    ylab = "Voltage",
    type = "l"
)

#plot 4
plot(
    data$Time,
    data$Global_reactive_power,
    xlab = "datetime",
    ylab = "Global_reactive_power",
    type = "l"
)

# Close the graphics device
dev.off()
