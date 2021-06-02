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

# Create a PNG graphics file
png(filename = "plot1.png", width = 480, height = 480)

# Generate the plot
hist(
    data$Global_active_power,
    main = "Global Active Power",
    xlab = "Global Acrive Power (kilowatts)",
    col = "red"
)

# Close the graphics device
dev.off()