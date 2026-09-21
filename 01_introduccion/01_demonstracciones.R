## Curva del colector del modelo de Fisher
## Una funccion para la curva
E.x <- function(N, alfa){
    alfa*log(1+N/alfa)
}

## Tamanos de muestreo (es decir numero de individuos en la muestra)
abunds <- seq(10, 1000, by =10)

## N de especies predicho por el modelo para alfa = 42
y <- E.x(abunds, alfa = 42)
## y alfa = 20
y2<- E.x(abunds, alfa = 20)
## Grafico
plot(abunds, y, type ="l",
     xlab = "N de individuos en la muestra",
     ylab = "Riqueza esperada")
lines(abunds, y2, col=2)

## Log-verissimilitud negativa
## ----logvero-mle---------------------------------------------------------------------------------
moths.ls.ll <- function(A)
    sum( dls(moths, N = sum(moths), alpha = A, log = TRUE) )
## ----alfas-mle-----------------------------------------------------------------------------------
alfas <- seq(n1/2, n1*2, by = 0.5)
## ----calculo-L-mle-------------------------------------------------------------------------------
moths.ls.L <- sapply(alfas, moths.ls.ll)
## log- Verossimilitud negativa
moths.ls.L2 <- -moths.ls.L
## Verossimilitud negativa relativa
moths.ls.L3 <- moths.ls.L2 - min(moths.ls.L2)
## ----grafico-L-mle-------------------------------------------------------------------------------
## Verossimilitud
par(mfrow=c(1,3))
plot(moths.ls.L ~ alfas, type = "l", ylab = "Log-verosimilitud")
## Verossimilitud negativa
plot(moths.ls.L2 ~ alfas, type = "l", ylab = "Log-verosimilitud")
## Verissimilitud negativa relativa
plot(moths.ls.L3 ~ alfas, type = "l", ylab = "Log-verosimilitud")
## inttervalo de plausibilidad
abline(h = 2 , lty =2, col = "red")
par(mfrow=c(1,1))
