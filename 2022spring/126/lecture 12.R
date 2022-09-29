####################  ANOVA ###################
melatonin = read.csv("/Users/yonghengzan/2020_Aug_15_Anova_201_CSV (1).csv")

str(melatonin)

# p-value is 0.1
t.test(sleep ~ group, data = melatonin, var.equal = TRUE)

t.test(sleep ~ group, data = melatonin, var.equal = TRUE)$estimate

boxplot(sleep ~ group, data = melatonin, col = 5:6)

library(faraway)
names(coagulation)

plot(coag ~ diet, data = coagulation, col = 2:5 )

# ANOVA table
coag_aov = aov(coag ~ diet, data = coagulation)  
coag_aov

summary(coag_aov)
