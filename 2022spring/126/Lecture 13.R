################ More polynomial regression model######################

econ = read.csv("/Users/yonghengzan/2020_Aug_19_mpg_mph_E_CSV_2.csv")

plot_econ_curve = function(model){
    plot( mpg ~ mph, data = econ, xlab = "Speed (Miles per Hour)",
          ylab = "Fuel Effiviency (Miles per Gallon)", col = "dodgerblue",
          pch = 20, cex = 2)
    xplot = seq(10, 75, by = 0.1)
    lines(xplot, predict(model, newdata = data.frame(mph = xplot)),
          col = "darkorange", lwd = 2, lty =1)
}

######
fit1 = lm(mpg ~ mph, data = econ)
summary(fit1)

par(mfrow = c(1,2))
plot_econ_curve(fit1)
plot(fitted(fit1), resid(fit1), xlab = "Fitted", ylab = "Residuals",
     col = "dodgerblue", pch =20, cex = 2)
abline(h= 0, col = "darkorange", lwd =2)

######
fit2 = lm(mpg ~ mph + I(mph^2), data = econ)
summary(fit2)

par(mfrow = c(1,2))
plot_econ_curve(fit2)
plot(fitted(fit2), resid(fit2), xlab = "Fitted", ylab = "Residuals",
     col = "dodgerblue", pch =20, cex = 2)
abline(h= 0, col = "darkorange", lwd =2)

######
fit3 = lm(mpg ~ mph + I(mph^2) + I(mph^3), data = econ)
summary(fit3)

par(mfrow = c(1,2))
plot_econ_curve(fit3)
plot(fitted(fit3), resid(fit3), xlab = "Fitted", ylab = "Residuals",
     col = "dodgerblue", pch =20, cex = 2)
abline(h= 0, col = "darkorange", lwd =2)

######
fit4 = lm(mpg ~ mph + I(mph^2) + I(mph^3) + I(mph^4), data = econ)
summary(fit4)

par(mfrow = c(1,2))
plot_econ_curve(fit4)
plot(fitted(fit4), resid(fit4), xlab = "Fitted", ylab = "Residuals",
     col = "dodgerblue", pch =20, cex = 2)
abline(h= 0, col = "darkorange", lwd =2)

########
fit5 = lm(mpg ~ mph + I(mph^2) + I(mph^3) + I(mph^4) + I(mph^5) , data = econ)
summary(fit5)

par(mfrow = c(1,2))
plot_econ_curve(fit5)
plot(fitted(fit5), resid(fit5), xlab = "Fitted", ylab = "Residuals",
     col = "dodgerblue", pch =20, cex = 2)
abline(h= 0, col = "darkorange", lwd =2)

########
fit6 = lm(mpg ~ mph + I(mph^2) + I(mph^3) + I(mph^4) + I(mph^5) +I(mph^6), data = econ)
summary(fit6)

par(mfrow = c(1,2))
plot_econ_curve(fit6)
plot(fitted(fit6), resid(fit6), xlab = "Fitted", ylab = "Residuals",
     col = "dodgerblue", pch =20, cex = 2)
abline(h= 0, col = "darkorange", lwd =2)


########
fit8 = lm(mpg ~ mph + I(mph^2) + I(mph^3) + I(mph^4) + I(mph^5) +I(mph^6)+ I(mph^7)+I(mph^8), data = econ)
summary(fit8)

par(mfrow = c(1,2))
plot_econ_curve(fit8)
plot(fitted(fit8), resid(fit8), xlab = "Fitted", ylab = "Residuals",
     col = "dodgerblue", pch =20, cex = 2)
abline(h= 0, col = "darkorange", lwd =2)

######### easy way 
fit6_alt2 = lm(mpg ~ poly(mph, 6, raw = TRUE), data = econ)
summary(fit6_alt2)

#######
anova(fit4, fit6)

anova(fit4, fit8)


