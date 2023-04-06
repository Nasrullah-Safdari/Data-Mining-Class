x=read.csv("Assignment.csv")
View(x)
plot(x$Obj..1, x$Obj..2, 
     main = "HTesting", 
     xlab = "work experience", 
     ylab = "Postgraduate", 
     col = "blue", 
     pch = 16, 
     xlim = c(1, 14), 
     ylim = c(0, 2))



points(x_point1, y_point1, cl0_pr, col='green', lwd=3)

x_point1 = c(1,2)
y_point1 = c(1,1)





