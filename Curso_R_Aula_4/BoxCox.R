require(MASS)
require(ExpDes)

setwd("C:\\Users\\...")

dados=read.table("var1.txt", h=T)
dados$Ambiente=as.factor(dados$Ambiente)
dados$Tratamento=as.factor(dados$Tratamento)
dados$Placa=as.factor(dados$Placa)
dados$Tecido=as.factor(dados$Tecido)
str(dados)

oz1 = lm(CAT ~ Placa + Ambiente * Tratamento * Tecido, dados)

plot(oz1)

boxplot(dados$CAT) # � poss�vel observar muitos outlier

##### Testando boxcox

boxcox(oz1, lambda = seq(0.1, 0.5, by = 0.01))

dados$CATtrans = (dados$CAT^0.38)/0.38 # 0.38 = resultado do boxcox neste caso. # Op��es para as transforma��es em: https://www.statisticshowto.datasciencecentral.com/box-cox-transformation/

boxplot(dados$CATtrans) # a distribui��o n�o apresenta outlier

oz2 = lm(CATtrans ~ Placa + Ambiente * Tratamento * Tecido, dados)

plot(oz2)  # apesar do boxplot n�o apresentar outlier, a parcela 14 ainda � um poss�vel problema

fat3.rbd(dados$Ambiente, dados$Tratamento, dados$Tecido, dados$Placa, dados$CATtrans, quali = c(TRUE, TRUE, TRUE), mcomp = "sk", fac.names = c("Ambiente", "Tratamento", "Tecido"), sigT = 0.05, sigF = 0.05)

##### Testando substitui��o da parcela 14

dados$CATtrans[14] = mean(dados$CATtrans) # vamos substituir o trat 14 pela m�dia geral da vari�vel 

fat3.rbd(dados$Ambiente, dados$Tratamento, dados$Tecido, dados$Placa, dados$CATtrans, quali = c(TRUE, TRUE, TRUE), mcomp = "sk", fac.names = c("Ambiente", "Tratamento", "Tecido"), sigT = 0.05, sigF = 0.05) # agora sim!