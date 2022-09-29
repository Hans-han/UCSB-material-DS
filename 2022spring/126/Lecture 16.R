######## logistic data ##########

sim_logistic_data = function(sample_size = 25, beta_0 = -2, beta_1 = 3){
  x= rnorm(n=sample_size)    
  eta = beta_0 + beta_1 * x
  p = 1/(1+exp(-eta))    # 67 page  p(Xi) function
  y = rbinom(n = sample_size, size = 1, prob = p)
  data.frame(y,x)
}

set.seed(1)
example_data = sim_logistic_data()
head(example_data)


# ordinary linear regression 
fit_lm = lm(y~x, data = example_data)
fit_lm
# logistic regression 
fit_glm = glm(y~x,data = example_data, family = binomial)
fit_glm

glm(y~x,data = example_data)

fit_glm = glm(y~x,data = example_data, family = binomial(link = "logit"))

#plot
plot(y ~ x, data = example_data,
     pch = 20, ylab = "Estimated Probability",
     main = "Ordinaty vs Logistic Regression")
grid()
abline(fit_lm, col = "darkorange")
curve(predict(fit_glm, data.frame(x),type = "response"),
      add = TRUE, col = "dodgerblue", lty = 2)
legend("topleft",c("Ordinary","Logistic","Data"), lty = c(1,2,0),
       pch = c(NA, NA, 20), lwd = 2, col = c("darkorange","dodgerblue","black"))


sim_logistic_data = function(sample_size = 25, beta_0 = -2, bata_1 = 3){
  x = rnorm(n = sample_size)
}


round(coef(fit_glm),1)

###
set.seed(1)
example_data = sim_logistic_data(sample_size = 50, beta_0 = 1, beta_1 = -4)  #sample_size = 5000, 两条线接近重合

fit_glm = glm(y~x, data = example_data, family = binomial)

plot(y ~ x, data = example_data,
     pch = 20, ylab = "Estimated Probability",
     main = " Logistic Regression, Decreasing Probability")
grid()
curve(predict(fit_glm, data.frame(x),type = "response"),
      add = TRUE, col = "dodgerblue", lty = 2)
curve(boot::inv.logit(1 - 4*x), add = TRUE, col = "darkorange", lty = 1)
legend("bottomleft",c("True Probability","Estimated Probability","Data"), lty = c(1,2,0),
       pch = c(NA, NA, 20), lwd = 2, col = c("darkorange","dodgerblue","black"))

## transfromation 
sim_quadratic_logistic_data = function(sample_size = 25){     #
  x = rnorm(n = sample_size)
  eta = -1.5 + 0.5*x + x^2
  p = 1/(1+exp(-eta))
  y = rbinom(n = sample_size, size = 1, prob = p)
  data.frame(y,x)
}

set.seed(42)
example_data = sim_quadratic_logistic_data(sample_size = 50)
fit_glm = glm(y~x + I(x^2), data = example_data, family = binomial)
plot(y ~ x, data = example_data,
     pch = 20, ylab = "Estimated Probability",
     main = " Logistic Regression, Quadratic Relationship")

grid()
curve(predict(fit_glm, data.frame(x),type = "response"),
      add = TRUE, col = "dodgerblue", lty = 2)
curve(boot::inv.logit(-1.5 + 0.5*x + x^2), add = TRUE, col = "darkorange", lty = 1)
legend("bottomleft",c("True Probability","Estimated Probability","Data"), lty = c(1,2,0),
       pch = c(NA, NA, 20), lwd = 2, col = c("darkorange","dodgerblue","black"))

####### dataset 
head(PlantGrowth)

attach(PlantGrowth)
weight.factor <- cut(weight, 2, labels = c('Light','Heavy')) # bonarize weights
plot(table(group, weight.factor))

glm.1 <- glm(weight.factor ~ group, family = binomial)

anova(glm.1, test = 'LRT')

predict(glm.1, type = 'response')

data('Pima.te',package = 'MASS')

detach(PlantGrowth)
glm.2 <- step(glm(type ~., data = Pima.te, family = binomial(link = 'probit')))

summary(glm.2)

