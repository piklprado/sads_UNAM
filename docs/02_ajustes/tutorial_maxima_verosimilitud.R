## ----setup-tutorial-mle, include=FALSE-----------------------------------------------------------
## Este chunk asegura que el tutorial también funcione si se renderiza
## de forma independiente (fuera de incluir_capitulo()), sin depender
## de que la página que lo incluye ya haya cargado sads/webexercises
## y la función html_longmcq() de funciones.R.
if (!exists("html_longmcq", mode = "function")) {
  library(webexercises)
  html_longmcq <- webexercises::longmcq
}
library(sads)


## ----carga-sads----------------------------------------------------------------------------------
library(sads)


## ----logvero-mle---------------------------------------------------------------------------------
moths.ls.ll <- function(A)
    sum( dls(moths, N = sum(moths), alpha = A, log = TRUE) )


## ----logvero-mle-test----------------------------------------------------------------------------
moths.ls.ll(100)


## ----singletons-mle------------------------------------------------------------------------------
(n1 <- sum(moths == 1))


## ----alfas-mle-----------------------------------------------------------------------------------
alfas <- seq(n1/2, n1*2, by = 0.5)


## ----calculo-L-mle-------------------------------------------------------------------------------
moths.ls.L <- sapply(alfas, moths.ls.ll)


## ----grafico-L-mle-------------------------------------------------------------------------------
plot(moths.ls.L ~ alfas, type = "l", ylab = "Log-verosimilitud")


## ----max-L-mle-----------------------------------------------------------------------------------
alfas[moths.ls.L == max(moths.ls.L)]


## ----fitsad-ls-mle-------------------------------------------------------------------------------
moths.ls <- fitsad(moths, sad = "ls")
moths.ls


## ----confint-ls-mle------------------------------------------------------------------------------
confint(moths.ls)


## ----grafico-intervalo-mle-----------------------------------------------------------------------
plot(moths.ls.L ~ alfas, type = "l", ylab = "Log-verosimilitud")
abline(h = max(moths.ls.L) - 2, lty = 2, col = "red")

