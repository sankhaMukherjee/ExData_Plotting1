

power <- read.csv("household_power_consumption.txt", sep=";")

power$DT <- strptime( paste( as.character(power$Date), 
                             as.character(power$Time)), 
                      "%d/%m/%Y %H:%M:%S")

temp1 <- power$DT >= strptime( c("2007/02/01"), "%Y/%m/%d" )
temp2 <- power$DT < strptime( c("2007/02/03"), "%Y/%m/%d" )

power <- power[temp1 & temp2, ]

power$Global_active_power <- as.numeric(levels(power$Global_active_power)[power$Global_active_power])

png("plot1.png")
hist(power$Global_active_power, xlab="Global Active Power (kilowatts)",
          ylab="Frequency",
          col = "red",
          main = "Global Active Power")
dev.off()