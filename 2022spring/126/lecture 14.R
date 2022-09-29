############### categorical variable ###############
?mtcars
View(mtcars)
plot(mpg ~ hp, data = mtcars, cex = 2)

plot(mpg ~ hp, data = mtcars, col = am + 1, pch = am + 1, cex = 2)

legend("topright", c("Automatic","Manual"), col = c(1,2), pch = c(1,2))

mpg_hp_slr = lm(mpg ~ hp, data = mtcars)

plot(mpg ~ hp, data = mtcars, col = am + 1,  pch = am + 1, cex = 2)
abline(mpg_hp_slr, lwd = 3, col = "grey")
legend("topright", c("Automatic","Manual"), col = c(1,2), pch = c(1,2))

mpg_hp_add = lm(mpg ~ hp + am, data = mtcars)
coef(mpg_hp_add)


###########
int_auto = coef(mpg_hp_add)[1]
int_manu = coef(mpg_hp_add)[1] + coef(mpg_hp_add)[3]

slope_auto = coef(mpg_hp_add)[2]
slope_manu = coef(mpg_hp_add)[2]

plot(mpg ~ hp, data = mtcars, col = am + 1,  pch = am + 1, cex = 2)
abline(int_auto, slope_auto, col = 1, lty = 1, lwd = 2)  # add line for auto
abline(int_manu, slope_manu, col = 2, lty = 2, lwd = 2)  # add line for auto
legend("topright", c("Automatic","Manual"), col = c(1,2), pch = c(1,2))


summary(mpg_hp_add)$coefficient["am",]

anova(mpg_hp_slr, mpg_hp_add)

#####################

str(iris)
class(iris$Species)
contrasts(iris$Species) #
fit803 = lm(Sepal.Length ~ Species, data = iris)
summary(fit803)

#######  interaction ##### 
interaction_mod = lm(mpg ~ hp*wt, data = mtcars)
summary(interaction_mod)

########  AIC  ###### 
library(faraway)
hipcenter_mod = lm(hipcenter ~ . , data = seatpos)
coef(hipcenter_mod)

hipcenter_mod_back_aic = step(hipcenter_mod, direction = "backward")
extractAIC(hipcenter_mod)

summary(hipcenter_mod)#$adj.r.squared
summary(hipcenter_mod_back_aic)$adj.r.squared

##
hipcenter_mod_start = lm(hipcenter ~ 1, data = seatpos)

hipcenter_mod_forw_aic = step(hipcenter_mod_start, 
               scope = hipcenter ~ Age + Weight + HtShoes + Ht + Seated + Arm + Thigh + Leg,
                              direction = "forward")
summary(hipcenter_mod_forw_aic)$adj.r.squared

##
hipcenter_mod_both_aic = step(hipcenter_mod_start, 
               scope = hipcenter ~ Age + Weight + HtShoes + Ht + Seated + Arm + Thigh + Leg,
               direction = "both")
summary(hipcenter_mod_both_aic)$adj.r.squared





