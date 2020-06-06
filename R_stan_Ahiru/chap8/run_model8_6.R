library(rstan)

d <- read.csv('input/data-salary-3.txt')
N <- nrow(d)
K <- 30
G <- 3
K2G <- unique(d[ , c('KID','GID')])$GID
data5 <- list(N=N, G=G, K=K, X=d$X, Y=d$Y, KID=d$KID, GID=d$GID, K2G=K2G)
fit6_mine <- stan(file ='../../TOKOTOKO/R_stan_Ahiru/chap8/model8_6.stan',data = data5, seed = 12345)
