rm(list = ls()) #clears the environment
install.packages("nortest")
install.packages("moments")
install.packages("car")
install.packages("emmeans")
install.packages("agricolae")
install.packages("multcompView")
install.packages("lme4")
install.packages("e1071")
install.packages("metafor")
install.packages("Hmisc")
install.packages("outliers")


library(ggplot2)
library(readxl)
library(e1071)
library(tidyverse)
library(hms)
library(moments)
library(car)
library(emmeans)
library(agricolae)
library(multcomp)
library(multcompView)
library(metafor)
library(lme4)
library(nortest)
library(boot)
library(Hmisc)
library(outliers)

updatedREML = read_excel("updated ES w j.xlsx", sheet = "SE")

### 1. TESTING NORMALITY###
theme_set(theme_classic())
hist(updatedREML$Effect_Size_Calc)
m=mean(updatedREML$Effect_Size_Calc)
std=sd(updatedREML$Effect_Size_Calc)
x=updatedREML$Effect_Size_Calc
curve(dnorm(x, mean=m, sd=std), col="darkblue", lwd=2, add=TRUE)
shapiro.test(updatedREML$Effect_Size_Calc)
ad.test(updatedREML$Effect_Size_Calc)

skewness(updatedREML$Effect_Size_Calc)

qqnorm(updatedREML$Effect_Size_Calc)
qqline(updatedREML$Effect_Size_Calc)


## 2. not normal, address effect size normality issue using bootstrap method - for overall effect sizes.
effectsizes <- updatedREML$Effect_Size_Calc
custom_mean <- function(effectsizes, indices) {
  sample_data <- effectsizes[indices]
  mean(sample_data)
}
bootstrap_resultsES <- boot(data = effectsizes, statistic = custom_mean, R= 1000)
bootstrap_meanES <- mean(bootstrap_resultsES$t)
bootstrap_se <- sd(bootstrap_resultsES$t)
bootstrap_ci <- boot.ci(bootstrap_resultsES, type = "basic")

hist(bootstrap_resultsES$t, breaks = 30, col = "lightblue", border = "white", main = "Bootstrap Distribution")
print(bootstrap_resultsES)
print(bootstrap_ci)


#bootstrap for road salts subgroup

roadsaltES = read_excel("updated ES w j.xlsx", sheet = "summary road salts")
RS_effectsizes <- roadsaltES$Effect_Size_Calc
custom_mean <- function(RS_effectsizes, indices) {
  sample_data <- RS_effectsizes[indices]
  mean(sample_data)
}
bootstrap_resultsRS <- boot(data = RS_effectsizes, statistic = custom_mean, R= 1000)
bootstrap_meanRS <- mean(bootstrap_resultsRS$t)
bootstrap_seRS <- sd(bootstrap_resultsRS$t)
bootstrap_ciRS <- boot.ci(bootstrap_resultsRS, type = "basic")

hist(bootstrap_resultsRS$t, breaks = 30, col = "lightblue", border = "white", main = "Bootstrap Distribution")
print(bootstrap_resultsRS)
print(bootstrap_ciRS)


#REML on bootstrap RS

random_effects_model_RS <- rma(yi= bootstrap_meanRS, sei = bootstrap_seRS, data = RS_effectsizes )

#calculate estimated effects and standard errors
estimated_effects <- coef(random_effects_model_RS)
standard_errors <- sqrt(diag(vcov(random_effects_model_RS)))
summary(random_effects_model_RS)


#boxplot VISUALIZING RANDOM EFFECTS MODEL WITH BOOTSTRAPPED ESTIMATES FOR ROAD SALT RESPONSES
bootstrap_samples <- bootstrap_resultsRS$t

boxplot(bootstrap_samples, main= "Random Effects Model- Road Salts", xlab = "Effect", ylab = "Bootstrap Samples")+
  abline(h=0, lty=2, col= "black")




###############MINING




#bootstrap for MINING subgroup

miningES = read_excel("updated ES w j.xlsx", sheet = "summary mining")
mining_effectsizes <- miningES$Effect_Size_Calc
custom_mean <- function(mining_effectsizes, indices) {
  sample_data <- mining_effectsizes[indices]
  mean(sample_data)
}
bootstrap_resultsMINING <- boot(data = mining_effectsizes, statistic = custom_mean, R= 1000)
bootstrap_meanMINING <- mean(bootstrap_resultsMINING$t)
bootstrap_seMINING <- sd(bootstrap_resultsMINING$t)
bootstrap_ciMINING <- boot.ci(bootstrap_resultsMINING, type = "basic")

hist(bootstrap_resultsMINING$t, breaks = 30, col = "lightblue", border = "white", main = "Bootstrap Distribution")
print(bootstrap_resultsMINING)
print(bootstrap_ciMINING)


#REML on bootstrap mining

random_effects_model_mining <- rma(yi= bootstrap_meanMINING, sei = bootstrap_seMINING, data = mining_effectsizes )



#calculate estimated effects and standard errors
estimated_effects <- coef(random_effects_model_mining)
standard_errors <- sqrt(diag(vcov(random_effects_model_mining)))
summary(random_effects_model_mining)




#BOXPLOT - VISUALIZING RANDOM EFFECTS MODEL WITH BOOTSTRAPPED ESTIMATES FOR MINING RESPONSES
bootstrap_samples <- bootstrap_resultsMINING$t

boxplot(bootstrap_samples, main= "Random Effects Model- Mining", xlab = "Effect", ylab = "Bootstrap Samples", ylim= c(-0.7, 0.0))+
  abline(h=0, lty=2, col= "black")
  

##put mining and road salt side by side to show the compared results

# Create a data frame with the bootstrap results for mining and road salt
results_mining <- data.frame(Threat= "Mining", Effects = bootstrap_resultsMINING$t)
results_roadsalt <- data.frame(Threat = "Road Salt", Effects = bootstrap_resultsRS$t)

# Combine the results into a single data frame
results_combined <- rbind(results_mining, results_roadsalt)

# Create a side-by-side boxplot
boxplot(Effects ~ Threat, data = results_combined, 
        main = "Random Effects Model - Mining vs. Road Salt",
        xlab = "Primary Threat", ylab = "Effect Size (Bootstrap Samples)")+  abline(h=0, lty=2, col= "black")
       # ylim = c(-0.6, 0.0))


## ASSESS SIGNIFICANCE OF RESUULTS COMBINED

mod = aov(Effects ~ Threat, data=results_combined)
anova(mod) 
view(anova(mod))
TukeyHSD(mod)
view(TukeyHSD(mod))

mod.nh42x= lm(Effects ~ Threat, data = results_combined)
z = emmeans(mod.nh42x, ~ Threat)
pairs(z, adjust="tukey")
view(pairs(z)) #view contrast data
CLD = cld(z,
          alpha   = 0.05,
          Letters = letters,        
          adjust  = "tukey")
CLD
view(CLD)

