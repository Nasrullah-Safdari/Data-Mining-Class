#Decision Tree classification

g=read.csv("grades1.csv")
head(g)
#install.packages("rpart")
#install.packages("rpart.plot")
library(rpart)
library(rpart.plot)

g_sub=data.frame(g$Q,g$Oral, g$Grade)
head(g_sub)
colnames(g_sub)=c("Q","Oral", "Grade")
head(g_sub)
View(g_sub)
g_sub$Q[g_sub$Q<80]
g_sub[g_sub$Q<80,]
##Split the dataset into train and test 

s=sample(nrow(g_sub), floor(0.8*nrow(g_sub)))
g.train=g_sub[s, ]
g.test=g_sub[-s,]

head(g.train)
fit=rpart(Grade~., data = g.train, method = "class")
rpart.plot(fit, extra = 106)


pred=predict(fit, g.test, type = "class")
table(g.test$Grade, pred)

Err.rate=2/NROW(g.test)
Err.rate


####New Dataset 

Q=c(90, 87, 30)
Oral=c(88, 86, 90)
new.st=data.frame(cbind(Q, Oral))
pred.new=predict(fit, new.st, type = "class")
pred.new
