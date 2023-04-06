library(dplyr)

#The dataset smoker
df_Flights = read.csv(url('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/flights.csv'))
View(df_Flights)
names(df_Flights)

#data manipulation with dplyr package
  ##filter
flightMnths = filter(df_Flights, month=='May')
flightMnths
head(flightMnths)

#logical operators &, |, !
months_flights=filter(df_Flights, month=='January'| month=='May')
head(months_flights)

flights_Mnt_year=filter(df_Flights, (month=='February'|month=='October') & (year=='1949' | year=='1956'))
head(flights_Mnt_year)                        
#flights in all months except for June
months_notJ =filter(df_Flights, month != 'June')
View(months_notMJ)

#for numerical >, <, ==
filter(df_Flights, passengers<=120)
#++++++++++++++++++++++++++++++++++++++++#

#select
select(df_Flights, c(year, month))
select(df_Flights, passengers, everything())
select(df_Flights, -(year))

#++++++++++++++++++++++++++++++++++++++++#
#rename
names(df_Flights)
df_Flights1=rename(df_Flights,num_Passengers = passengers)
head(df_Flights1)

#++++++++++++++++++++++++++++++++++++++++#
#sample_n
sampledf_Flights=sample_n(df_Flights, 50)
head(sampledf_Flights)
View(sampledf_Flights)

#++++++++++++++++++++++++++++++++++++++++#
#summarize
summarise(df_Flights, mean(passengers), median(passengers))

months=group_by(df_Flights, month)
summarise(months, mean(passengers),median(passengers), sd(passengers))
