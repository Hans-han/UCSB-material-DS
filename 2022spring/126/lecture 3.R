#least-Square for SLR
x=cars$speed
y=cars$dist

Sxy=sum((x-mean(x))*(y-mean(y)))
Sxx=sum((x-mean(x))^2)

beta_1_hat = Sxy/Sxx
beta_0_hat = mean(y) - beta_1_hat*mean(x)
c(beta_0_hat,beta_1_hat)

#### same as

stop_distance = lm(dist~speed, data=cars)
stop_distance


###########

x = faithful$eruptions
y = faithful$waiting

Sxy=sum((x-mean(x))*(y-mean(y)))
Sxx=sum((x-mean(x))^2)

beta_1_hat = Sxy/Sxx
beta_0_hat = mean(y) - beta_1_hat*mean(x)
c(beta_0_hat,beta_1_hat)

#### same as

stop_distance = lm(faithful ~ eruptions, data= faithfuls)
stop_distance


# confident interval 
stop_distance = lm(dist~speed, data=cars)
stop_distance
speedabc = data.frame(speed=c(16))
predict(stop_distance, newdata = speedabc,
        interval = c("prediction"), level=0.95)







