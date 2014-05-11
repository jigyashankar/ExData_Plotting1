read_data<-function(file="household_power_consumption.txt"){
require(sqldf)
	sqlSel<-"SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"

	data<-read.csv.sql(file, sqlSel, sep =";")
	data$Date<-as.Date(as.character(data$Date), format="%d/%m/%Y")
	data$Time<-as.character(data$Time)
	data$datetime<-as.POSIXct(paste(data$Date, data$Time))
	return(data)
}

plot3 <- function(outputfile="plot3.png"){
	data<-read_data()
	par(mfrow=c(1,1))
	with(data, plot(datetime,Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering"))

	lines(data$datetime, data$Sub_metering_2, col="Red")
	lines(data$datetime, data$Sub_metering_3, col="Blue")
	legend("topright", lwd=c(2,2,2),col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
	
	dev.copy(png,outputfile)
	dev.off()
}

