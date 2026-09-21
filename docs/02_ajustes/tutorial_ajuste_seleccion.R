## ----setup-tutorial-sel, include=FALSE-----------------------------------------------------------
## Este chunk asegura que el tutorial también funcione si se renderiza
## de forma independiente (fuera de incluir_capitulo()), sin depender
## de que la página que lo incluye ya haya cargado sads/webexercises
## y las funciones html_mcq()/html_longmcq() de funciones.R.
if (!exists("html_longmcq", mode = "function")) {
  library(webexercises)
  html_longmcq <- webexercises::longmcq
}
if (!exists("html_mcq", mode = "function")) {
  library(webexercises)
  html_mcq <- webexercises::mcq
}
library(sads)


## ----library-sel---------------------------------------------------------------------------------
library(sads)


## ----bci-top10-sel-------------------------------------------------------------------------------
head(sort(bci, decreasing = TRUE), 10)


## ----bci-nsp-sel---------------------------------------------------------------------------------
length(bci)


## ----bci-octav-sel-------------------------------------------------------------------------------
bci.oc <- octav(bci)
head(bci.oc)


## ----bci-octav-plot-sel--------------------------------------------------------------------------
plot(bci.oc)


## ----fit-lnorm-sel-------------------------------------------------------------------------------
(bci.ln <- fitlnorm(bci, trunc = 0.99))


## ----fit-ls-sel----------------------------------------------------------------------------------
(bci.ls <- fitls(bci))


## ----fit-volkov-sel------------------------------------------------------------------------------
(bci.vk <- fitvolkov(bci))


## ----loglik-lnorm-sel----------------------------------------------------------------------------
logLik(bci.ln)


## ----aic-manual-sel------------------------------------------------------------------------------
as.numeric(-2 * logLik(bci.ln) + 2*2)


## ----aic-funcion-sel-----------------------------------------------------------------------------
AIC(bci.ln)


## ----aictab-sel----------------------------------------------------------------------------------
AICtab(bci.ln, bci.ls, bci.vk,
       mnames = c("Lognormal", "Log-series", "Neutral"))


## ----plot-octav-comp-sel-------------------------------------------------------------------------
plot(bci.oc)
lines(octavpred(bci.ln), col = 1, lwd = 2)
lines(octavpred(bci.ls), col = 2, lwd = 2)
lines(octavpred(bci.vk), col = 3, lwd = 2)
legend("topright", c("Lognormal", "Log-series", "Neutral"),
       lty = 1, pch = 1, col = 1:3, cex = 1.25, bty = "n")


## ----plot-rad-comp-sel---------------------------------------------------------------------------
plot(rad(bci))
lines(radpred(bci.ln), col = 1, lwd = 2)
lines(radpred(bci.ls), col = 2, lwd = 2)
lines(radpred(bci.vk), col = 3, lwd = 2)
legend("topright", c("Lognormal", "Log-series", "Neutral"),
       lty = 1, pch = 1, col = 1:3, cex = 1.25, bty = "n")


## ----confint-volkov-sel--------------------------------------------------------------------------
confint(bci.vk, method = "quad")


## ----apendice-sel--------------------------------------------------------------------------------
bci.pb <- fitpowbend(bci)
bci.pl <- fitpoilog(bci)

AICtab(bci.ln, bci.ls, bci.vk, bci.pb, bci.pl,
       mnames = c("Lognormal", "Log-series", "Neutral", "Power-bend", "Poilog"))

par(mfrow = c(1, 2))
plot(bci.oc)
lines(octavpred(bci.ln), col = 1, lwd = 2)
lines(octavpred(bci.ls), col = 2, lwd = 2)
lines(octavpred(bci.vk), col = 3, lwd = 2)
legend("topright", c("Lognormal", "Log-series", "Neutral"),
       lty = 1, pch = 1, col = 1:3, cex = 1.25, bty = "n")

plot(bci.oc)
lines(octavpred(bci.pl), col = 1, lwd = 2)
lines(octavpred(bci.pb), col = 2, lwd = 2)
lines(octavpred(bci.vk), col = 3, lwd = 2)
legend("topright", c("Poilog", "Power-bend", "Neutral"),
       lty = 1, pch = 1, col = 1:3, cex = 1.25, bty = "n")
par(mfrow = c(1, 1))

