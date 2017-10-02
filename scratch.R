library(dplyr)
library(ggplot2)
library(stringr)

deaths<-read.csv('KoreanConflict.csv', header=TRUE, stringsAsFactors=FALSE)
head(deaths)


#This is part of the stringr package to work with regular expressions:

dim(deaths)

sum(str_detect(deaths$INCIDENT_DATE,"\\d{8}"))

for(i in 1:36574){
  incident<-str_detect(deaths$INCIDENT_DATE[i],"\\d{8}")
  fatality<-str_detect(deaths$FATALITY[i],"\\d{8}")
  if(incident==FALSE & fatality==TRUE){
    deaths$INCIDENT_DATE[i]<-deaths$FATALITY[i]
  }
  print(i)
}

sum(str_detect(deaths$INCIDENT_DATE,"\\d{8}"))
