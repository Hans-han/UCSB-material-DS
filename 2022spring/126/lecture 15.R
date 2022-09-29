install.packages("leaps")
library(leaps)
library(faraway)

### AIC ### the smaller AIC have, the more
all_hipcenter_mod = summary(regsubsets(hipcenter ~.,data = seatpos))

all_hipcenter_mod$which

all_hipcenter_mod$rss

all_hipcenter_mod$adjr2

(best_r2_ind = which.max(all_hipcenter_mod$adjr2))

all_hipcenter_mod$which[best_r2_ind,]

M = length(coef(hipcenter_mod)) - 1
N = length(resid(hipcenter_mod))

hipcenter_mod_aic = N * log(all_hipcenter_mod$rss /N) + 2 *(2:(M+1))

best_aic_ind = which.min(hipcenter_mod_aic)
all_hipcenter_mod$which[best_aic_ind, ]

hipcenter_mod_best_aic = lm(hipcenter ~ Age + Ht + Leg, data = seatpos)

extractAIC(hipcenter_mod_best_aic)

extractAIC(hipcenter_mod_back_aic)

extractAIC(hipcenter_mod_forw_aic)

extractAIC(hipcenter_mod_both_aic)


plot(hipcenter_mod_aic ~ I(2:p), ylab = "AIC", xlab = "p, number of parameters",
     pch = 20, col = "dodgerblue", type = "b", cex = 2, 
     main = "AIC vs Model Complexity")


#### BIC #####
hipcenter_mod_bic = N * log(all_hipcenter_mod$rss / N) + log(N) * (2:(M+1))

which.min(hipcenter_mod_bic)

all_hipcenter_mod$which[1, ]

hipcenter_mod_best_bic = lm(hipcenter ~ Ht, data = seatpos)

extractAIC(hipcenter_mod_best_bic, k = log(n))

extractAIC(hipcenter_mod_back_bic, k = log(n))




####### Stepwise regression #######

?mtcars

# define intercept-only model  
intercept_only_model <- lm(mpg ~ 1, data = mtcars)

# define total model
total_model <- lm(mpg~.,data = mtcars)

# perform step wise regression 
step(intercept_only_model, direction = 'both', scope = formula(total_model))












