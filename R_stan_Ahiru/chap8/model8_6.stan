data {
  int N; # num of person
  int G; # num of industory
  int K; # num of company
  real X[N];
  real Y[N];
  int<lower=1, upper=K> KID[N]; # 人が属する会社
  int<lower=1, upper=G> K2G[K]; # 会社が属する業界
  int<lower=1, upper=G> GID[N];
}

parameters {
  real a0;
  real b0;
  real a1[G];
  real b1[G];
  real a[K];
  real b[K];
  real<lower = 0>s_ag;
  real<lower = 0>s_bg;
  real<lower = 0>s_a[G];
  real<lower = 0>s_b[G];
  real<lower = 0>s_Y[G];
}

model{
  # 業界ごとの切片と傾きを正規分布から生成する
  for (g in 1:G){
    a1[g] ~ normal(a0, s_ag); # 
    b1[g] ~ normal(b0, s_bg); #
  }
  # 会社kが属する業界G(K2G)を平均として、標準偏差s_*の正規分布で会社ごとの切片と傾きを生成
  for (k in 1:K){
    a[k] ~ normal(a1[K2G[k]], s_a[K2G[k]]);
    b[k] ~ normal(b1[K2G[k]], s_b[K2G[k]]);
  }
  # 上記で推定したa,bを下に、正規分布から個人の年収が決まるとして、パラメータを推定していく
  for (n in 1:N)
    Y[n] ~ normal(a[KID[n]] + b[KID[n]]*X[n], s_Y[GID[n]]);
}



