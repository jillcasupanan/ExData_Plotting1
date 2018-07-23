# Reading and naming power consumption data
pow <- read.table("household_power_consumption.txt", skip = 1, sep = ";")
names(pow) <- c("Date", "Time",
                "Global_active_power",
                "Global_reactive_power",
                "Voltage",
                "Global_intensity",
                "Sub_metering_1",
                "Sub_metering_2",
                "Sub_metering_3")

# Subset of data taken from 2007-02-01 to 2007-02-02 (2days)
sub_pow <- subset(pow, pow$Date=="1/2/2007" | pow$Date == "2/2/2007")

# Calling the basic plot function (histogram of global active power for 2 days)
#png("plot1.png", width = 480, height = 480)
hist(as.numeric(as.character(sub_pow$Global_active_power)), col = "red", main = "Global Active Power", xlab = "Global Active Power (killowatts)")
