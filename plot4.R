power <- read.csv("household_power_consumption.txt", sep=";")

power$DT <- strptime( paste( as.character(power$Date), 
                             as.character(power$Time)), 
                      "%d/%m/%Y %H:%M:%S")

temp1 <- power$DT >= strptime( c("2007/02/01"), "%Y/%m/%d" )
temp2 <- power$DT < strptime( c("2007/02/03"), "%Y/%m/%d" )

power <- power[temp1 & temp2, ]

toNumeric <- function(f) { as.numeric(levels(f)[f]) }

#power$Global_active_power <- as.numeric(levels(power$Global_active_power)[power$Global_active_power])

power$Global_active_power   <- toNumeric(power$Global_active_power)
power$Global_reactive_power <- toNumeric(power$Global_reactive_power)
power$Sub_metering_1        <- toNumeric(power$Sub_metering_1)
power$Sub_metering_2        <- toNumeric(power$Sub_metering_2)
power$Sub_metering_3        <- toNumeric(power$Sub_metering_3)
power$Voltage               <- toNumeric(power$Voltage)

png("plot4.png")

par(mfrow = c(2, 2))

plot(power$DT, power$Global_active_power, type="l",
     xlab="", ylab="Global Active Power")

plot(power$DT, power$Voltage, type="l",
     xlab="datetime", ylab="Voltage")


with(power, plot(DT, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(power, lines(DT, Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering"))
with(power, lines(DT, Sub_metering_2, type="l", col="red",   xlab="", ylab="Energy sub metering"))
with(power, lines(DT, Sub_metering_3, type="l", col="blue",  xlab="", ylab="Energy sub metering"))

legend("topright", 
       col    = c("black", "red", "blue"), lty=c(1,1),
       legend = c("Sub_Metering_1", "Sub_Metering_3", "Sub_Metering_3"))

plot(power$DT, power$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")


dev.off()
