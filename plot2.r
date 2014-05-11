
read_data<-function(file="household_power_consumption.txt"){
require(sqldf)
	sqlSel<-"SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"

	data<-read.csv.sql(file, sqlSel, sep =";")
	data$Date<-as.Date(as.character(data$Date), format="%d/%m/%Y")
	data$Time<-as.character(data$Time)
	data$datetime<-as.POSIXct(paste(data$Date, data$Time))
	return(data)
}
plot2<-function(outputfile="plot2.png"){
	par(mfrow=c(1,1))
	data<-read_data()
	with(data, plot(Global_active_power ~ datetime, type="l", 			col="Black", ylab="Global Active Power(kilowatts)", 			xlab=""))
	dev.copy(png, outputfile)
	dev.off()
}
