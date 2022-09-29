###########
num_obs = 100 #number of observations
beta_0 = 10 
beta_1 = -5
beta_2 = 2
sigma =3

set.seed(1)
epsilon = rnorm(n=num_obs,mean = 0,sd=sigma)

x_vals = runif(num_obs,0,10)

z_vals = runif(num_obs,10,20)

y_vals = beta_0 + beta_1 * x_vals + beta_2 * z_vals +epsilon

sim_fit2 = lm(y_vals ~ x_vals + z_vals)

coef(sim_fit2)

summary(sim_fit2)$sigma
