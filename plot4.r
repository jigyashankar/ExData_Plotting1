read_data<-function(file="household_power_consumption.txt"){
	require(sqldf)
	sqlSel<-"SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"

	data<-read.csv.sql(file, sqlSel, sep =";")
	data$Date<-as.Date(as.character(data$Date), format="%d/%m/%Y")
	data$Time<-as.character(data$Time)
	data$datetime<-as.POSIXct(paste(data$Date, data$Time))
	return(data)
}


plot4<-function(outputfile="plot4.png"){
	par(mfrow=c(2,2))
	data<-read_data()
	with(data, {
		plot(Global_active_power ~ datetime, type="l", col="Black", ylab="Global Active Power", xlab="")
		plot(Voltage ~ datetime, type="l", col="Black", ylab="Voltage")
		plot(datetime,Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
		lines(data$datetime, data$Sub_metering_2, col="Red")
		lines(data$datetime, data$Sub_metering_3, col="Blue")
		legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
		plot(Global_reactive_power ~ datetime, type="l", col="Black")
	})
	dev.copy(png, outputfile)
	dev.off()
}