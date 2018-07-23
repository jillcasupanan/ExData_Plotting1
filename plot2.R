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

# Transforming Date and Time from characters into type Date and POSIXlt
sub_pow$Date <- as.Date(sub_pow$Date, format="%d/%m/%Y")
sub_pow$Time <- strptime(sub_pow$Time, format="%H:%M:%S")
sub_pow[1:1440, "Time"] <- format(sub_pow[1:1440, "Time"], "2007-02-01 %H:%M:%S")
sub_pow[1441:2880, "Time"] <- format(sub_pow[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

# Calling the basic plot function
plot(sub_pow$Time, as.numeric(as.character(sub_pow$Global_active_power)), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Additional grapgh annotation
title(main = "Global Active Power Vs Time")

#exporting
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
