library(ggplot2)
library(tidyr)
set.seed(12)
## cheat sheet:https://github.com/rstudio/cheatsheets/blob/master/data-visualization-2.1.pdf
## 参考URL:http://cse.naro.affrc.go.jp/takezawa/r-tips/r/60.html
## 一様分布
data = runif(n = 1000, min = 0, max = 1)
data_df <- data.frame(data = data)
ggplot(data = data_df, aes(x = data))+
  geom_histogram(
    #bins = 20, # binsはX軸を何個の区画に分けるかを指定。X軸の定義域で区画内幅は変化する
    binwidth = 0.02 # binwitdhは区画内幅を指定する。何個に分けるかはその後に決まる
    )
## ベルヌーイ
data = sample(x = c(0,1), size = 1000, replace = TRUE, prob= c(0.9, 0.1))
data_df <- data.frame(data = data)
ggplot(data = data_df, aes(x = data))+
  geom_histogram(bins = 3,
  )
  
## 二項分布
data = rbinom(n= 10000, size= 10, prob= 0.3) # nはシミュレーションの回数、sizeはシミュレーションの中での試行回数
data_df <- data.frame(data = data)
ggplot(data = data_df, aes(x = data))+
  geom_histogram(bins = 10
  )+
  scale_x_continuous(
    limits = c(0,10),
    expand = c(0,0) # mult, と　add の引数
  )
## ベータ分布
### 山型
data = rbeta(n= 1000, shape1 = 3, shape2 = 9 ,ncp = 0) # 山型分布
data_df <- data.frame(data = data)
ggplot(data = data_df, aes(x = data))+
  geom_histogram(bins = 100,
  )
### U字型
data = rbeta(n= 1000, shape1 = 0.5, shape2 = 0.5 ,ncp = 0) # 山型分布
data_df <- data.frame(data = data)
ggplot(data = data_df, aes(x = data))+
  geom_histogram(bins = 100,
  )

## カテゴリカル分布
data = sample.int(n=5, size=1000, replace=TRUE, prob=c(0.1, 0.2, 0.25, 0.35, 0.1)) #sample.intで乱数生成
data_df <- data.frame(data = data)
ggplot(data = data_df, aes(x = data))+
  geom_histogram(bins = 5)+
   scale_x_continuous(
        limits = c(0,5),
        expand = c(0,0) # mult, と　add の引数
    )

## 多項分布
data = rmultinom(n= 10, size = 20, prob = c(0.1, 0.2, 0.3, 0.4))
data_df <- data.frame(data = data)
data_df
### 同時確率計算
data = dmultinom(x= c(0,1,3,6), size = 10, prob = c(0.1, 0.2, 0.3, 0.4))
data_df <- data.frame(data = data)
data_df

## 指数分布
data = rexp(n= 10000, rate = 3)
data_df <- data.frame(data = data)
ggplot(data = data_df, aes(x = data))+
  geom_histogram(bins = 30,
  )

## ポワソン分布
data = rpois(n= 10000, lambda = 10)
data_df <- data.frame(data = data)
ggplot(data = data_df, aes(x = data))+
  geom_histogram(bins = 30)+
  scale_x_continuous(
    limits = c(0,30),
    expand = c(0,0) # mult, と　add の引数
    )

## ガンマ分布
data = rgamma(n= 10000, shape = 3, scale = 3)
data_df <- data.frame(data = data)
ggplot(data = data_df, aes(x = data))+
  geom_histogram(bins = 30,
  )

## 正規分布
## ref:https://stats.biopapyrus.jp/r/ggplot/geom_histogram.html
data1 = rnorm(n= 10000, mean = 3, sd = 1)
data2 = rnorm(n= 10000, mean = 8, sd = 3)
data_df <- data.frame(data1 = data1, data2 = data2)
df <- tidyr::gather(data_df)  ## tidyrのgather関数でdata1,data2を２列のデータに変形
ggplot(data = df, aes(x = value, fill = key))+
  geom_histogram(bins = 30, position = "identity", alpha = 0.8
  )

## 対数正規分布
data1 = rlnorm(n= 10000, mean = 0, sd = 1)
data2 = rlnorm(n= 10000, mean = 3, sd = 0.4)
data3 = rlnorm(n= 10000, mean = 4, sd = 0.8)
data_df <- data.frame(data1 = data1, data2 = data2,data3 = data3)
df <- tidyr::gather(data_df)  ## tidyrのgather関数でdata1,data2を２列のデータに変形
ggplot(data = df, aes(x = value, fill = key))+
  geom_histogram(bins = 30, position = "identity", alpha = 0.4
  )+
  scale_x_continuous(
    limits = c(-10,200),
    expand = c(0,0) # mult, と　add の引数
  )
## 多変量正規分布
mu <- c(10, 20) ## X、Y軸の平均
cov <- matrix(c(2.0, 0.5, 0.5, 1.0), ncol = 2) ## 分散共分散行列
data <- mvtnorm::rmvnorm(n = 100, mean = mu, sigma = cov)
df <- data
colnames(df) <- c('X1', 'X2')
ggplot(data = as.data.frame(df), aes(x = X1, y= X2))+
  geom_point(position = "identity", alpha = 0.4
  )

## コーシー分布
data1 = rcauchy(n= 10000, location = 0, scale = 10)
data2 = rcauchy(n= 10000, location = 0, scale = 30)
data_df <- data.frame(data1 = data1, data2 = data2)
df <- tidyr::gather(data_df)  ## tidyrのgather関数でdata1,data2を２列のデータに変形
ggplot(data = df, aes(x = value, fill = key))+
  geom_histogram(bins = 100, position = "identity", alpha = 0.4
  )+
  scale_x_continuous(
    limits = c(-100,100),
    expand = c(0,0) # mult, と　add の引数
  )

## Studentのt分布
data1 = rt(n= 1000, df = 20, ncp = 0)　## 自由度大きいほど、裾は短い
data2 = rt(n= 1000, df = 1, ncp = 0) ## 自由度は１以下の小数も入力できるが、定義上どうなんだろう。
data_df <- data.frame(data1 = data1, data2 = data2)
df <- tidyr::gather(data_df)  ## tidyrのgather関数でdata1,data2を２列のデータに変形
ggplot(data = df, aes(x = value, fill = key))+
  geom_histogram(bins = 100, position = "identity", alpha = 0.4
  )+
  scale_x_continuous(
    limits = c(-40,40),
    expand = c(0,0) # mult, と　add の引数
  )

## 2重指数分布・ラプラス分布
rlaplace <- function(n) {  ## 用意された関数はないので定義する
  u <- log(runif(n))
  v <- ifelse(runif(n)>1/2, 1, -1)
  return(u*v)
}
data1 <- rlaplace(1000)
data2 <- rlaplace(1000)
data_df <- data.frame(data1 = data1, data2 = data2)
df <- tidyr::gather(data_df)  ## tidyrのgather関数でdata1,data2を２列のデータに変形
ggplot(data = df, aes(x = value, fill = key))+
  geom_histogram(bins = 100, position = "identity", alpha = 0.4
  )+
  scale_x_continuous(
    limits = c(-10,10),
    expand = c(0,0) # mult, と　add の引数
  )
