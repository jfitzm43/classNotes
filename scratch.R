library(dplyr)
library(ggplot2)
library(stringr)
library(flexdashboard)
library(lubridate)

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

df<-deaths%>%
  filter(str_detect(INCIDENT_DATE,"\\d{8}")==TRUE)%>%
  group_by(INCIDENT_DATE)%>%
  summarize(num_deaths = n())%>%
  mutate(date = ymd(INCIDENT_DATE))%>% #To make a new column during dplyr
  filter(date<='1953-07-27')%>%
  select(INCIDENT_DATE,num_deaths,date)

head(df)
sum(df$num_deaths)
ggplot()+
  geom_line(data = df, aes(x = date, y = num_deaths))+
  scale_x_date(date_breaks = '3 months',date_labels = "%b %y") #strftime linux notation to format a date



# Time series plot where we have the number of soldiers born on the same year and the count.

df<-deaths%>%
  filter(str_detect(BIRTH_YEAR,"\\d{4}")==TRUE)%>%
  group_by(BIRTH_YEAR)%>%
  summarize(num_deaths = n())

strt(df$BIRTH_YEAR)
df$BIRTH_YEAR<-as.numeric(df$BIRTH_YEAR)
str(df$BIRTH_YEAR)

ggplot()+
  geom_line(data=df, aes(x=BIRTH_YEAR, y=num_deaths))


