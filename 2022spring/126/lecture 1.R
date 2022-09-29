data()

?cars
View(cars)

str(cars)

head(cars)

dim(cars)

nrow(cars)

ncol(cars)

plot(dist~speed, data=cars,
     pch=20,
     cex=2,
     col='grey')

stop_distance=lm(dist~speed,data=cars)
stop_distance

confint(stop_distance,level=0.95)


summary(stop_distance)
summary(stop_distance)$sigma  #

c(beta_0_hat, beta_1_hat)

plot(dist~speed, data=cars,
     pch=20,
     cex=2,
     col='grey')
abline(stop_distance, lwd=3, col='darkorange')

fitted(stop_distance)

predict(stop_distance)



View(faithful)

wait = lm(eruptions ~ waiting, data=faithful)
wait

summary(wait)$sigma

plot(eruptions ~ waiting, data=faithful,
     pch=20,
     cex=2,
     col='grey')

abline(wait,lwd=3)




