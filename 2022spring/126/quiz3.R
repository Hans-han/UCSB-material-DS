library(leaps)
library(faraway)

#1
# define intercept-only model  
intercept_only_model <- lm(disp ~ mpg + hp + wt, data = mtcars)

# define total model
total_model <- lm(disp~mpg + hp + wt,data = mtcars)

# perform step wise regression 
step(intercept_only_model, direction = 'both', scope = formula(total_model))

#2

#3

#4
car_mod = lm(mpg ~ ., data = mtcars) 

car_mod_start = lm(mpg ~ 1, data = mtcars)

car_mod_both_aic = step(
  car_mod_start,
  scope =  mpg ~ wt + drat + disp + qsec,
  direction = "both")



n = length(resid(car_mod))

car_mod_both_bic = step(
  car_mod_start,
  scope = mpg ~ wt + drat + disp + qsec,
  direction = "both", k = log(n))













