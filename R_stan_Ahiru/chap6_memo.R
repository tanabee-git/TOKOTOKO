library(ggplot2)
set.seed(1234)
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
data = rbinom(n= 1000, size= 10, prob= 0.3) # nはシミュレーションの回数、sizeはシミュレーションの中での試行回数
data_df <- data.frame(data = data)
ggplot(data = data_df, aes(x = data))+
  geom_histogram(bins = 10,
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
