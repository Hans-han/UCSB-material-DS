sim_1 = function(sample_size = 500) {
  x = runif(n = sample_size) * 5
  y = 3 + 5 * x + rnorm(n = sample_size, mean = 0, sd = 1)
  data.frame(x, y)
}

sim_2 = function(sample_size = 500) {
  x = runif(n = sample_size) * 5
  y = 3 + 5 * x + rnorm(n = sample_size, mean = 0, sd = x)
  data.frame(x, y)
}

sim_3 = function(sample_size = 500) {
  x = runif(n = sample_size) * 5
  y = 3 + 5 * x ^ 2 + rnorm(n = sample_size, mean = 0, sd = 5)
  data.frame(x, y)
}


set.seed(42)
sim_data_1 = sim_1()
plot(y ~ x, data = sim_data_1, col = "grey", pch = 20,
     main = "Data from Model 1")
fit_1 = lm(y ~ x, data = sim_data_1)
abline(fit_1, col = "darkorange", lwd = 3)

plot(fitted(fit_1), resid(fit_1), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Data from Model 1")
abline(h = 0, col = "darkorange", lwd = 2)


### Model 2: Y=3+5x+e , e~N(0,x^2) ###
set.seed(42)
sim_data_2 = sim_2()
fit_2 = lm(y ~ x, data = sim_data_2)
plot(y ~ x, data = sim_data_2, col = "grey", pch = 20,
     main = "Data from Model 2")
abline(fit_2, col = "darkorange", lwd = 3)

plot(fitted(fit_2), resid(fit_2), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Data from Model 2")
abline(h = 0, col = "darkorange", lwd = 2)



### Model 3: Y=3+5x^2+e, e~N(0,25) ###
set.seed(42)
sim_data_3 = sim_3()
fit_3 = lm(y ~ x, data = sim_data_3)
plot(y ~ x, data = sim_data_3, col = "grey", pch = 20,
     main = "Data from Model 3")
abline(fit_3, col = "darkorange", lwd = 3)

plot(fitted(fit_3), resid(fit_3), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Data from Model 3")
abline(h = 0, col = "darkorange", lwd = 2)
# 


par(mfrow = c(1, 3))
hist(resid(fit_1),
     xlab = 'Residuals',
     main = 'Histogram of Residuals, fit_1',
     col = 'darkorange',
     border = 'dodgerblue',
     breaks = 20)

hist(resid(fit_2),
     xlab = 'Residuals',
     main = 'Histogram of Residuals, fit_2',
     col = 'darkorange',
     border = 'dodgerblue',
     breaks = 20)

hist(resid(fit_3),
     xlab = 'Residuals',
     main = 'Histogram of Residuals, fit_3',
     col = 'darkorange',
     border = 'dodgerblue',
     breaks = 20)


qqnorm(resid(fit_1), main = "Normal Q-Q Polt, fit_1",col = "darkgrey")
qqline(resid(fit_1), col = "dodgerblue", lwd = 2)

qqnorm(resid(fit_2), main = "Normal Q-Q Polt, fit_2",col = "darkgrey")
qqline(resid(fit_2), col = "dodgerblue", lwd = 2)

qqnorm(resid(fit_3), main = "Normal Q-Q Polt, fit_3",col = "darkgrey")
qqline(resid(fit_3), col = "dodgerblue", lwd = 2)



mpg_hp_am = lm(mpg ~ hp + am, data= mtcars)
plot(fitted(mpg_hp_am),resid(mpg_hp_am), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residual",
     main = "mtcars: Fitted versus Residuals")
abline(h=0, col = "darkorange", lwd = 2)



