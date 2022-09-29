####################  HW3 ####################
library(lmtest)
library(broom)
library(tidyverse)
library(MASS)
Dataset_1 = read.csv("/Users/yonghengzan/2021_May_8_2251_Data_CSV.csv")
par(mfrow = c(2,2))
# X-Y variable graphs
Dataset_1_fit = lm(Y ~ X, data = Dataset_1)

summary(Dataset_1_fit)

plot(Y ~ X, data = Dataset_1, col = "grey", pch = 20, cex = 1.5)
abline(Dataset_1_fit, col = "darkorange", lwd = 2)

# residuals vs. fitted
plot(fitted(Dataset_1_fit), resid(Dataset_1_fit), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals")
abline(h = 0, col = "darkorange", lwd = 2)


# response and/or predictor variable transformations,
# using the diagnostic tools to decide which regression models appear 
# consistent with the data and which do not

## polynomial
Dataset_1_quad_fit = lm(Y ~ X + I(X^2) + I(X^3), data = Dataset_1)

summary(Dataset_1_quad_fit)

plot(fitted(Dataset_1_quad_fit), resid(Dataset_1_quad_fit), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals by polynomial")

abline(h = 0, col = "darkorange", lwd = 2)

## log
Dataset_1_log_fit = lm(log(Y) ~ log(X), data = Dataset_1)

summary(Dataset_1_log_fit)

plot(fitted(Dataset_1_log_fit), resid(Dataset_1_log_fit), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals by log")

abline(h = 0, col = "darkorange", lwd = 2)

## Boxcox
boxcox(Dataset_1_fit, plotit =TRUE)

Dataset_1_box_fit = boxcox(Dataset_1_fit, plotit =TRUE, lambda = seq(-2,3,by = 0.1))

which.max(Dataset_1_box_fit$y)

lambda1 <- Dataset_1_box_fit$x[which.max(Dataset_1_box_fit$y)]
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

bptest(Dataset_1_fit)

bptest(Dataset_1_quad_fit)

bptest(Dataset_1_log_fit)

shapiro.test(resid(Dataset_1_fit))

shapiro.test(resid(Dataset_1_quad_fit))

shapiro.test(resid(Dataset_1_log_fit))


#####################################
Dataset_2 = read.csv("/Users/yonghengzan/2021_May_8_1821_Data_CSV.csv")

par(mfrow = c(3,2))
# X-Y variable graphs
Dataset_2_fit = lm(Y ~ X, data = Dataset_2)

summary(Dataset_2_fit)

plot(Y ~ X, data = Dataset_2, col = "grey", pch = 20, cex = 1.5)
abline(Dataset_2_fit, col = "darkorange", lwd = 2)

# residuals vs. fitted
plot(fitted(Dataset_2_fit), resid(Dataset_2_fit), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals")
abline(h = 0, col = "darkorange", lwd = 2)


# response and/or predictor variable transformations,
# using the diagnostic tools to decide which regression models appear 
# consistent with the data and which do not

## polynomial
Dataset_2_quad_fit = lm(Y ~ X + I(X^2) + I(X^3) + I(X^4) + I(X^5), data = Dataset_2)

summary(Dataset_2_quad_fit)

plot(fitted(Dataset_2_quad_fit), resid(Dataset_2_quad_fit), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals by polynomial")

abline(h = 0, col = "darkorange", lwd = 2)

## log
Dataset_2_log_fit = lm(Y ~ log(X), data = Dataset_2)

summary(Dataset_2_log_fit)

plot(log(Y) ~ log(X), data = Dataset_2, col = "dodgerblue", pch = 20, cex = 1.5)

abline(Dataset_2_log_fit, col = "darkorange", lwd = 2)


plot(fitted(Dataset_2_log_fit), resid(Dataset_2_log_fit), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals by log")

abline(h = 0, col = "darkorange", lwd = 2)

## boxcox
boxcox(Dataset_2_fit, plotit =TRUE)

Dataset_2_box_fit = boxcox(Dataset_2_fit, plotit =TRUE, lambda = seq(-2,3,by = 0.1))

which.max(Dataset_2_box_fit$y)

lambda2 <- Dataset_2_box_fit$x[which.max(Dataset_2_box_fit$y)]
lambda2

z <- y ^ lambda2
m3 <- lm(z ~ X)
summary(m3)

plot(fitted(m3), resid(m3), col = "grey", pch = 20,
     xlab = "Fitted", ylab = "Residuals", main = "Fitted versus Residuals")
abline(h = 0, col = "darkorange", lwd = 2)

bptest(m3)
shapiro.test(resid(m3))

# results of statistical hypothesis tests

bptest(Dataset_2_fit)

bptest(Dataset_2_quad_fit)

bptest(Dataset_2_log_fit)

shapiro.test(resid(Dataset_2_fit))

shapiro.test(resid(Dataset_2_quad_fit))

shapiro.test(resid(Dataset_2_log_fit))









