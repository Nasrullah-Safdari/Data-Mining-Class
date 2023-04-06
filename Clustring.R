#Nasrullah Safdari #41294
#ITC 360
#PROFESSOR ASADULLAH JAWID

data_flights= read.csv(url('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/flights.csv'))
View(data_flights)

library(dplyr)

#################Clustering//H-Clustering#################              
                                              

newData_flight= data_flights %>% select(year, passengers)
View(newData_flight)

h1_ave=hclust(dist(newData_flight), method = "average")
plot(h1_ave)

h1_comp=hclust(dist(newData_flight), method = "complete")
plot(h1_comp)


#creating clusters/groups
yp.cluster=cutree(h1_ave,2 )
yp.cluster


newData_flight=newData_flight %>%
  mutate(yp.cluster)

head(newData_flight)
# Define the colors for each cluster
colors = c("red", "green")

# Plot the data
plot(newData_flight$year, newData_flight$passengers,
     col = colors[newData_flight$yp.cluster],
     xlab = "Year",
     ylab = "Passengers",
     main = "H-clust of Y/P",
     pch = 20)

# Add the legend
legend("topleft",
       legend = paste0("Cluster ", 1:2),
       col = colors,
       pch = 20,
       title = "Clusters",
       cex = 0.70)


############# Clustering//KMeans-Clustering#################
install.packages("factoextra")
library(factoextra)
library(dplyr)

data_flights= read.csv(url('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/flights.csv'))
View(data_flights)

kmeans_data= data_flights %>% select(year, passengers)
View(kmeans_data)

#First: Optimal k
num_clust = fviz_nbclust(kmeans_data, kmeans, method = "silhouette")
num_clust

#k=2
k_m=kmeans(kmeans_data, 2)

y_p_cl=k_m$cluster
y_p_cl
kmeans_data=cbind(kmeans_data, y_p_cl)
head(kmeans_data)
View(kmeans_data)


##++++++++++++++++++++++++++++++++++++++++++++++++##

###Now we have labeled the variables, create a dummy classifier 
newData_flight1=newData_flight %>%
  mutate(YP_Cluster01=ifelse(yp.cluster==1, 0, 1))
View(newData_flight1)
newData_flight1 = newData_flight1  %>%
  rename( cluster=YP_Cluster01)







