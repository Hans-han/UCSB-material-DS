install.packages("bestglm")
install.packages("leaps")

library(bestglm)
#Loading required package: leaps
library(leaps)
data("SAheart")

?SAheart

chd_mod_ldl = glm(chd ~ ldl, data = SAheart, family = binomial)
plot(jitter(chd, factor = 0.1) ~ ldl, data = SAheart, pch = 20, 
     ylab = "Probability of CHD", xlab = "Low Density Lipoprotein Cholesterol")
grid()
curve(predict(chd_mod_ldl, data.frame(ldl = x), type = "response"), 
      add = TRUE, col = "dodgerblue", lty = 2)

coef(summary(chd_mod_ldl))
##               Estimate Std. Error   z value     Pr(>|z|)
## (Intercept) -1.9686681 0.27307908 -7.209150 5.630207e-13
## ldl          0.2746613 0.05163983  5.318787 1.044615e-07

chd_mod_additive = glm(chd ~ ., data = SAheart, family = binomial)
chd_mod_additive
-2 * as.numeric(logLik(chd_mod_ldl) - logLik(chd_mod_additive))  #107 D

anova(chd_mod_ldl, chd_mod_additive, test = "LRT")  # 109 H0 hypothesis
              # Small p value which means we choose model 2 (is more signifi)

chd_mod_selected = step(chd_mod_additive, trace = 0)
coef(chd_mod_selected)

anova(chd_mod_selected, chd_mod_additive, test = "LRT")
              # prefer selected model

# interval
confint(chd_mod_selected, level = 0.99)

new_obs = data.frame(
  sbp = 148.0,
  tobacco = 5,
  ldl = 12,
  adiposity = 31.23,
  famhist = "Present",
  typea = 47,
  obesity = 28.50,
  alcohol = 23.89,
  age = 60
)

eta_hat = predict(chd_mod_selected, new_obs, se.fit = TRUE, type = "link")
eta_hat

z_crit = round(qnorm(0.975), 2)
round(z_crit, 2)

boot::inv.logit(eta_hat$fit + c(-1, 1) * z_crit * eta_hat$se.fit)



## Interactions
#Let’s add an interaction between LDL and family history for the model we selected.

chd_mod_interaction = glm(chd ~ alcohol + ldl + famhist + typea + age + ldl:famhist, 
                          data = SAheart, family = binomial)
summary(chd_mod_interaction)

# add ploy
chd_mod_int_quad = glm(chd ~ alcohol + ldl + famhist + typea + age + ldl:famhist + I(ldl^2),
                       data = SAheart, family = binomial)
summary(chd_mod_int_quad)


##
# install.packages("kernlab")
library(kernlab)
data("spam")
tibble::as.tibble(spam)

set.seed(42)
# spam_idx = sample(nrow(spam), round(nrow(spam) / 2))
spam_idx = sample(nrow(spam), 1000)
spam_trn = spam[spam_idx, ]
spam_tst = spam[-spam_idx, ]


fit_caps = glm(type ~ capitalTotal, 
               data = spam_trn, family = binomial)
fit_selected = glm(type ~ edu + money + capitalTotal + charDollar, 
                   data = spam_trn, family = binomial)
fit_additive = glm(type ~ ., 
                   data = spam_trn, family = binomial)
fit_over = glm(type ~ capitalTotal * (.), 
               data = spam_trn, family = binomial, maxit = 50)

coef(fit_selected)

mean(ifelse(predict(fit_caps) > 0, "spam", "nonspam") != spam_trn$type)
## [1] 0.339
mean(ifelse(predict(fit_selected) > 0, "spam", "nonspam") != spam_trn$type)
## [1] 0.224
mean(ifelse(predict(fit_additive) > 0, "spam", "nonspam") != spam_trn$type)
## [1] 0.066
mean(ifelse(predict(fit_over) > 0, "spam", "nonspam") != spam_trn$type)


#### The best model has the lowest misclassification rate
library(boot)
set.seed(1)

cv.glm(spam_trn, fit_caps, K = 5)$delta[1]
## [1] 0.2166961
cv.glm(spam_trn, fit_selected, K = 5)$delta[1]
## [1] 0.1587043
cv.glm(spam_trn, fit_additive, K = 5)$delta[1]
## [1] 0.08684467
cv.glm(spam_trn, fit_over, K = 5)$delta[1]
## 0.14


make_conf_mat = function(predicted, actual) {
  table(predicted = predicted, actual = actual)
}

#Let’s explicitly store the predicted values of our classifier on the test dataset.

spam_tst_pred = ifelse(predict(fit_additive, spam_tst) > 0, 
                       "spam", 
                       "nonspam")
spam_tst_pred = ifelse(predict(fit_additive, spam_tst, type = "response") > 0.5, 
                       "spam", 
                       "nonspam")

(conf_mat_50 = make_conf_mat(predicted = spam_tst_pred, actual = spam_tst$type))


mean(spam_tst_pred == spam_tst$type)
## [1] 0.921133

mean(spam_tst_pred != spam_tst$type)
## [1] 0.07886698


## Variable Selection and Model Building with Higher-order Terms

autompg = read.table(
  "http://archive.ics.uci.edu/ml/machine-learning-databases/auto-mpg/auto-mpg.data",
  quote = "\"",
  comment.char = "",
  stringsAsFactors = FALSE)
colnames(autompg) = c("mpg", "cyl", "disp", "hp", "wt", "acc", 
                      "year", "origin", "name")
autompg = subset(autompg, autompg$hp != "?")
autompg = subset(autompg, autompg$name != "plymouth reliant")
rownames(autompg) = paste(autompg$cyl, "cylinder", autompg$year, autompg$name)
autompg$hp = as.numeric(autompg$hp)
autompg$domestic = as.numeric(autompg$origin == 1)
autompg = autompg[autompg$cyl != 5,]
autompg = autompg[autompg$cyl != 3,]
autompg$cyl = as.factor(autompg$cyl)
autompg$domestic = as.factor(autompg$domestic)
autompg = subset(autompg, select = c("mpg", "cyl", "disp", "hp", 
                                     "wt", "acc", "year", "domestic"))
str(autompg)

autompg_big_mod = lm(
  log(mpg) ~ . ^ 2 + I(disp ^ 2) + I(hp ^ 2) + I(wt ^ 2) + I(acc ^ 2), 
  data = autompg)

#We’ll try backwards search with both  AIC and   BIC to attempt to find a smaller, more reasonable model.

autompg_mod_back_aic = step(autompg_big_mod, direction = "backward")











