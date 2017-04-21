# plot1

# Set up require packages

packages <- c("downloader", "dplyr", "lubridate")
sapply(packages, require, character.only = TRUE, quietly = TRUE)

# download data

setwd("C:/Users/lorel_000/Google Drive/DataScienceJHU/ExploratoryDataAnalysis/w1/project1/ExData_Plotting1")
path <- getwd()
fileName <- "data-set.zip"
if (!file.exists(fileName)) {
        urlFile = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download(urlFile, dest = "./data-set.zip", mode ="wb")
}
if (!file.exists("household_power_consumption.txt")) {
        unzip("data-set.zip")
}

# load data

data <- read.table(file = "household_power_consumption.txt", 
                   sep = ";" , header = TRUE,  stringsAsFactors = FALSE)
data <- tbl_df(data)
# na.strings = "?"
data[data=="?"] <- NA

data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)
data_subset <- filter(data, Date == as.Date("2007-02-01") | 
                              Date == as.Date("2007-02-02"))
data_subset[, c(3:9)] <- as.numeric(unlist(data_subset[, c(3:9)]))

# Reproduce and write histogram
# to .png file width of 480 pixels and a height of 480 pixels
png(filename = "plot1.png", width = 480, height = 480)
hist(data_subset$Global_active_power, xlab = "Global Active Power (kilowatts)",
     xlim = c(0,6), ylim = c(0,1200), main = "Global Active Power", xaxt = "n",
     col = "red")
axis(side = 1, at = c(0,2,4,6), labels = c(0,2,4,6))
dev.off()


