M=read.csv("https://raw.githubusercontent.com/mwaskom/seaborn-data/master/car_crashes.csv")
View(M)
names(M)
dim(M)
###Step 1: check their correlation
M.sub=data.frame(M$speeding, M$alcohol, M$no_previous)
head(M.sub)
names(M.sub)=c("speeding", "alcohol", "not_previous")
View(M.sub)

M.cor=cor(M.sub)
M.cor

install.packages("corrplot")
library(corrplot)
corrplot(M.cor, method = "pie",
         type="lower")
dim(M)

##Step 2: split the dataset into training and test
nrow(M)
0.7*51
S=sample(nrow(M), 36)
S
M.train=M[S,]
View(M.train)
M.test=M[-S,]
View(M.test)
head(M.train)

#Step 3: Construct the prediction models using M.train
#Step 3.1. Model 1
#Regression and Prediction
names(M.train)
#Predict speeding using alcohol
cor(M.train$no_previous, M.train$alcohol)
plot(M$alcohol, M$no_previous,
     col='blue')

#Model1
#Y= not_previous
#X=alcohol
head(M.train)
lm1=lm(no_previous~alcohol, data = M.train)

#Generat the predicted values for no_previous using the model
y.pred=lm1$fitted.values
y.pred
plot(M.train$no_previous, y.pred,
     col='blue')
all.y=data.frame(M.train$no_previous, y.pred)
View(all.y)

#use the model to predict no_previous using alcohol in the test dataset
#We expose our lm1 to NEW DATA and see how it does?

lm1.test=predict(lm1, M.test)
lm1.test #these are the predicted spendings of the 9 objects in the test
#dataset using lm0, the model we have constructed earlier using training dataset

y.test=data.frame(M.test$no_previous, lm1.test,M.test$no_previous-lm1.test)
View(y.test)

sum(y.test$x.test.no_previous...lm1.test)
###########################
##Sum of Squared Error
SSE1=sum((M.test$no_previous- lm1.test)^2)
SSE1 #59.04

##Model2
#Add another predictor:
head(M.train)
lm2=lm(no_previous~alcohol+not_distracted, data = M.train)
lm2.test=predict(lm2, M.test)
lm2.test

SSE1=sum((M.test$no_previous- lm2.test)^2)
SSE1 #172.08
#Model one's SSE is less then Model two's SSE, hence, Model one is the best predictor model
