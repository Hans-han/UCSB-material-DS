library(lmtest)

#Durbin-Watson test   check with 0.05
model_145 = lm(DAX ~ CAC + SMI + FTSE, data = EuStockMarkets)
dwtest(model_145)

#
    Durbin-Watson test
data:  model_145
DW = 0.029905, p-value < 2.2e-16
alternative hypothesis: true autocorrelation is greater than 0
#

# Goldfeld-Quandt Test    check with 0.05
model_147 = lm(mpg ~ cyl + disp, data = mtcars)
gqtest(model_147)
