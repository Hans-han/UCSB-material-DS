num_obs = 100  #number of observations
beta_0 = 10 
beta_1 = -5
sigma =3

set.seed(1)
epsilon = rnorm(n=num_obs,mean = 0,sd=sigma)

x_vals=runif(num_obs,0,10)

y_vals=beta_0 + beta_1 * x_vals + epsilon

sim_fit = lm(y_vals~x_vals)
coef(sim_fit)

y_vals
fitted(sim_fit)
residuals(sim_fit)

######################

View(USJudgeRatings)
JudgeRatings = lm(FAMI ~ WRIT, data= USJudgeRatings)
JudgeRatings

plot(FAMI ~ WRIT, data= USJudgeRatings,
     pch=20,
     cex=2,
     col='grey')
abline(JudgeRatings, lwd=3, col='darkorange')







