read_data<-function(file="household_power_consumption.txt"){
require(sqldf)
	sqlSel<-"SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"

	data<-read.csv.sql(file, sqlSel, sep =";")
	return(data)
}

plot1<-function(outputfile="plot1.png"){
	par(mfrow=c(1,1))
	data<-read_data()
	hist(data$Global_active_power, main="Global Active Power", 			col="red", xlab="Global Active Power(kilowatts)", 			ylab="Frequency")
	dev.copy(png, "plot1.png")
	dev.off()
}
