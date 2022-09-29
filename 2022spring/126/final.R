library(lmtest)
library(broom)
library(tidyverse)
library(MASS)
library(faraway)
######## Question_1 ############
par(mfrow = c(2,2))
Dataset_1 = read.csv("/Users/yonghengzan/2021_May_29_2020_Dec_11_1553_Data_CSV.csv")

Dataset_1_fit = lm(y_val ~ ., data = Dataset_1)
summary(Dataset_1_fit)

plot(y_val ~ ., data = Dataset_1, col = "grey", pch = 20, cex = 1.5)
abline(Dataset_1_fit, col = "darkorange", lwd = 2)

plot(fitted(Dataset_1_fit), resid(Dataset_1_fit), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals")
abline(h = 0, col = "darkorange", lwd = 2)

#####
Dataset_2_log_fit = lm(y_val ~ x_val1 + log(x_val2), data = Dataset_1)
summary(Dataset_2_log_fit)

plot(y_val ~ ., data = Dataset_1, col = "grey", pch = 20, cex = 1.5)
abline(Dataset_2_log_fit, col = "darkorange", lwd = 2)


plot(fitted(Dataset_2_log_fit), resid(Dataset_2_log_fit), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals by log")

abline(h = 0, col = "darkorange", lwd = 2)

qqnorm(resid(Dataset_2_log_fit), main = "Normal Q-Q Plot", col = "darkgrey")
qqline(resid(Dataset_2_log_fit), col = "dodgerblue", lwd = 2)


bptest(Dataset_2_log_fit)

shapiro.test(resid(Dataset_2_log_fit))




######## dataset_2 ############
par(mfrow = c(2,2))

Dataset_2 = read.csv("/Users/yonghengzan/2021_May_29_2020_Dec_11_1508_Data_CSV.csv")
Dataset_2_fit = lm(y ~ x, data = Dataset_2)

summary(Dataset_2_fit)

plot(y ~ x, data = Dataset_2, col = "grey", pch = 20, cex = 1.5)
abline(Dataset_2_fit, col = "darkorange", lwd = 2)

# residuals vs. fitted
plot(fitted(Dataset_2_fit), resid(Dataset_2_fit), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals")
abline(h = 0, col = "darkorange", lwd = 2)


# response and/or predictor variable transformations,
# using the diagnostic tools to decide which regression models appear 
# consistent with the data and which do not

## polynomial
Dataset_2_quad_fit = lm(y ~ x + I(x^2) + I(x^3) + I(x^4) + I(x^5) + I(x^6) + I(x^7) ++ I(x^8) + I(x^9) + + I(x^10), data = Dataset_2)

summary(Dataset_2_quad_fit)

plot(fitted(Dataset_2_quad_fit), resid(Dataset_2_quad_fit), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals by polynomial")

abline(h = 0, col = "darkorange", lwd = 2)

qqnorm(resid(Dataset_2_quad_fit), main = "Normal Q-Q Plot", col = "darkgrey")
qqline(resid(Dataset_2_quad_fit), col = "dodgerblue", lwd = 2)



bptest(Dataset_2_quad_fit)

shapiro.test(resid(Dataset_2_quad_fit))




## log
Dataset_2_log_fit = lm(y ~ log(x), data = Dataset_2)

summary(Dataset_2_log_fit)

plot(fitted(Dataset_2_log_fit), resid(Dataset_2_log_fit), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals by log")

abline(h = 0, col = "darkorange", lwd = 2)

qqnorm(resid(Dataset_2_log_fit), main = "Normal Q-Q Plot", col = "darkgrey")
qqline(resid(Dataset_2_log_fit), col = "dodgerblue", lwd = 2)

bptest(Dataset_2_log_fit)

shapiro.test(resid(Dataset_2_log_fit))


### box
#boxcox(Dataset_2_fit, plotit =TRUE)

Dataset_2_box_fit = boxcox(Dataset_2_fit)

which.max(Dataset_2_box_fit$y)

lambda1 <- Dataset_2_box_fit$x[which.max(Dataset_2_box_fit$y)]
lambda1

z <- y ^ lambda1
m <- lm(z ~ x)
summary(m)

plot(fitted(m), resid(m), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals")
abline(h = 0, col = "darkorange", lwd = 2)


bptest(m)

shapiro.test(resid(m))


# results of statistical hypothesis tests

bptest(Dataset_2_fit)

bptest(Dataset_2_quad_fit)

bptest(Dataset_2_log_fit)

shapiro.test(resid(Dataset_2_fit))

shapiro.test(resid(Dataset_2_quad_fit))

shapiro.test(resid(Dataset_2_log_fit))




?mtcars
car = mtcars[, c("vs","wt","disp")]

# GLM model
car_model = glm(vs ~ wt + disp, data = car, family = "binomial")
summary(car_model)
coef(summary(car_model))

#Predicting probabilities for 0 and 1
x = predict(model,new_data =data.frame(wt = 2.8, disp = 160),type = "response")
y = as.data.frame(x)

y['Prob_0'] = 1 - y$x
colnames(y) = c("Prob_1","Prob_0")
y




















