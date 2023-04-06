#1.Regression and Prediction

#The data set attention 
df_attention = read.csv(url('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/attention.csv'))
View(df_attention)
names(df_attention)

#changing attention variable to numerical 
attention_code=c()
for(n in 1:length(df_attention$attention)){
  if(df_attention$attention[n]=="divided"){
    attention_code[n]=1
  }
  
  else{
    attention_code[n]=2
  }
}



df_attention=cbind(df_attention, attention_code)
View(df_attention)

##Problem: we want to predict score variable in the attention data set using a vector of 
#relevant predictors X, such as subject, solution, attention, etc.

#Step 1: check their correlation 
df_attention.sub=data.frame(df_attention$score, df_attention$subject, df_attention$attention_code, df_attention$solutions)
head(df_attention.sub)
names(df_attention.sub)=c("Score", "Subject", "Attention", "Soloutions")
View(df_attention.sub)

dfattention.cor=cor(df_attention.sub)   #correlation matrix
dfattention.cor


install.packages("corrplot")
library(corrplot)

corrplot(dfattention.cor, method = "pie", 
         type="lower")

##Step 2: split the data set into training and test 

nrow(df_attention)
0.7*60

samp=sample(nrow(df_attention), 42)
samp

df_attention.train=df_attention[samp,]
View(df_attention.train)


df_attention.test=df_attention[-samp,]
View(df_attention.test)


#Step 3: Construct the prediction models using df_attention.train
#Step 3.1. Model 0
#Regression and Prediction
names(df_attention.train)

#Predict Score using Subject
cor(df_attention.train$score, df_attention.train$subject)
plot(df_attention.train$score, df_attention.train$subject, col='blue')

#Model0
#Y= Score
#X= Subject

lm0=lm(score~subject, data = df_attention.train)

#Generate the predicted values for Score using the model
score.pred=lm0$fitted.values   #we made predictions 
score.pred

plot(df_attention.train$score, score.pred, 
     col='blue')

#put them together
all.score = data.frame(df_attention.train$score, score.pred)
View(all.score)

#use the model to predict Score using Subject in the test data set
lm0.test=predict(lm0, df_attention.test)
lm0.test

##Sum of Squared Error

SSE0=sum((df_attention.test$score- lm0.test)^2)
SSE0   #34.2

#Model 1
# Add another variable Attention


lm1=lm(score~subject+attention, data = df_attention.train) #creating model 1

lm1.test=predict(lm1, df_attention.test)
lm1.test
SSE1=sum((df_attention.test$score- lm1.test)^2)
SSE1  #36.24

#Model 2
#Add another predictor: Gender

lm2=lm(score~subject+attention+solutions, data = df_attention.train)
lm2.test=predict(lm2, df_attention.test)
lm2.test
SSE2=sum((df_attention.test$score- lm2.test)^2)
SSE2  #33.67
#Hence, the model 2 is the best one becuase it has the lowest SSE(Sum of Squared Error)


