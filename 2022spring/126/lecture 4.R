num_obs = 100  #number of observations
beta_0 = 10 
beta_1 = -5
sigma =3

set.seed(1)
epsilon = rnorm(n=num_obs,mean = 0,sd=sigma)

x_vals=runif(num_obs,0,10)

y_vals=beta_0 + beta_1 * x_vals* x_vals + epsilon

sim_fit = lm(y_vals~x_vals)
summary(sim_fit)

plot(y_vals ~ x_vals,
     pch=20,
     cex=2,
     col='grey')


#################### multiple linear regression

head(mtcars)
str(mtcars)

mpg_model = lm(mpg ~ wt + hp, data = mtcars)
coef(mpg_model)
summary(mpg_model)

mpg_model2 = lm(mpg ~ wt + hp +disp, data = mtcars)
coef(mpg_model2)
summary(mpg_model2)

mpg_model3 = lm(mpg ~ wt + hp + qsec + disp + cyl, data = mtcars)
coef(mpg_model3)
summary(mpg_model3)

###
?EuStockMarkets
head(EuStockMarkets)
str(EuStockMarkets)



#######
?pressure
pp = lm(temperature ~ pressure, data=pressure)
pp
plot(temperature ~ pressure, data=pressure,
     pch=20,
     cex=2,
     col='grey')

confint(pp,level = 0.9)

summary(pp)
residuals(pp)





