## ----setup_local, include=FALSE-------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE, fig.align = "center")
library(sads)
library(vegan)


## ----bci-load-------------------------------------------------------------------------------------------------------
library(vegan)
library(sads)
data(BCI)


## ----bci-head-------------------------------------------------------------------------------------------------------
head(BCI)


## ----bci-agregado-ejemplo-------------------------------------------------------------------------------------------
apply(BCI[1:2, ], 2, sum)


## ----funcion-muestreo-----------------------------------------------------------------------------------------------
bci.muestreo <- function(n.plots = 50) {
  id <- sample(1:50, size = n.plots)
  apply(BCI[id, ], 2, sum)
}


## ----simulaciones---------------------------------------------------------------------------------------------------
set.seed(42)
bci.1ha <- bci.muestreo(1)
bci.5ha <- bci.muestreo(5)
bci.10ha <- bci.muestreo(10)
bci.50ha <- bci.muestreo(50)


## ----octav-50ha-----------------------------------------------------------------------------------------------------
bci.50ha.o <- octav(bci.50ha)


## ----octav-clase----------------------------------------------------------------------------------------------------
class(bci.50ha.o)


## ----octav-head-----------------------------------------------------------------------------------------------------
head(bci.50ha.o)


## ----octavas-guardar------------------------------------------------------------------------------------------------
bci.o <- bci.50ha.o$octav


## ----octav-submuestras_1ha------------------------------------------------------------------------------------------
bci.1ha.o <- octav(bci.1ha, oct = bci.o)


## ----octav-submuestras_5_10-ha, code_folding=TRUE-------------------------------------------------------------------
bci.5ha.o <- octav(bci.5ha, oct = bci.o)
bci.10ha.o <- octav(bci.10ha, oct = bci.o)


## ----preston-plot, fig.width=8, fig.height=7------------------------------------------------------------------------
par(mfrow = c(2, 2))
plot(bci.1ha.o, main = "1 ha")
plot(bci.5ha.o, main = "5 ha")
plot(bci.10ha.o, main = "10 ha")
plot(bci.50ha.o, main = "50 ha")
par(mfrow = c(1, 1))


## ----ejemplo-preston-true, fig.width=8, fig.height=7----------------------------------------------------------------
bci.1ha |> octav(oct = bci.o, preston = TRUE) |> plot(main = "1 ha")


## ----preston-true, fig.width=8, fig.height=7, code_folding=TRUE-----------------------------------------------------
par(mfrow = c(2, 2))
bci.1ha |> octav(oct = bci.o, preston = TRUE) |> plot(main = "1 ha")
bci.5ha |> octav(oct = bci.o, preston = TRUE) |> plot(main = "5 ha")
bci.10ha |> octav(oct = bci.o, preston = TRUE) |> plot(main = "10 ha")
bci.50ha |> octav(oct = bci.o, preston = TRUE) |> plot(main = "50 ha")
par(mfrow = c(1, 1))

