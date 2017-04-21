# plot2

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

# paste date and time together into a new variable
data$date_time <- dmy_hms(paste(data$Date, data$Time))
# change Date variable to date format
data$Date <- dmy(data$Date)
# filter required dates
data_subset <- filter(data, Date == as.Date("2007-02-01") | 
                              Date == as.Date("2007-02-02"))
# change varaibles class to numeric for numerical varaibles
data_subset[, c(3:9)] <- as.numeric(unlist(data_subset[, c(3:9)]))

# set weekdays labels to english
## Then back to (US) English
Sys.setlocale("LC_TIME", "English")

# Reproduce and write plot
# to .png file width of 480 pixels and a height of 480 pixels
png(filename = "plot2.png", width = 480, height = 480)
with(data_subset, plot(date_time, Global_active_power, type = "l",
                       xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
