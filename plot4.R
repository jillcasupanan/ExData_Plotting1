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

# Composite plot initiation
par(mfrow = c(2,2))

# Calling the basic plot functions
with(sub_pow,
{
  plot(sub_pow$Time,as.numeric(as.character(sub_pow$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(sub_pow$Time,as.numeric(as.character(sub_pow$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(sub_pow$Time,sub_pow$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")

  with(sub_pow,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(sub_pow,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(sub_pow,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  
  plot(sub_pow$Time,as.numeric(as.character(sub_pow$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})