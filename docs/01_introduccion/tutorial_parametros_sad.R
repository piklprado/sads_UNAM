## ----setup_params, include=FALSE, eval=TRUE-------------------------------------------------------------------------
library(webexercises)
library(knitr)
knitr::opts_chunk$set(echo = TRUE, eval = FALSE, message = FALSE, warning = FALSE, fig.align = "center")


## ----paquetes, eval=TRUE--------------------------------------------------------------------------------------------
library(sads)
library(dplyr)


## ----prob-basica----------------------------------------------------------------------------------------------------
dls(x = 1, N = 10000, alpha = 20)


## ----prob-suma------------------------------------------------------------------------------------------------------
sum(dls(1:10000, N = 10000, alpha = 20))


## ----prob-plot, fig.width=6, fig.height=4---------------------------------------------------------------------------
x <- 1:15
p <- dls(x, N = 10000, alpha = 20)
barplot(p, names.arg = x, xlab = "Abundancia (individuos)", ylab = "Probabilidad",
        col = "steelblue",
        main = "Log-series: N = 10000, alpha = 20")


## ----prob-tabla-----------------------------------------------------------------------------------------------------
 data.frame(abundancia = 1:10,
                     probabilidad = round(dls(1:10, N = 10000, alpha = 20), 4))


## ----quiz1-opts, echo=FALSE, eval=TRUE------------------------------------------------------------------------------
quiz1 <- c(
  "el número esperado de especies con exactamente 5 individuos",
  answer = "la probabilidad de que una especie elegida al azar tenga exactamente 5 individuos",
  "la proporción de individuos que pertenecen a especies con abundancia 5",
  "la probabilidad de que una especie elegida al azar tenga hasta 5 individuos"
)


## ----tabla-efecto-alpha, echo=FALSE, eval=TRUE----------------------------------------------------------------------
N <- 10000
    data.frame(alpha = c(10, 50, 100)) |>
    mutate(S = alpha*log(1+N/alpha),
           X = N/(N+alpha),
           S1 = alpha*X^1,
           pS1 = 100*S1/S) |>
        select(-X) |>
        kable(digits =c(0,0,0,1), col.names = c("alpha", "Riqueza", "Singletons", "% Singletons"))



## ----quiz2-opts, echo=FALSE, eval=TRUE------------------------------------------------------------------------------
quiz2 <- c(
  "la distribución decae más lentamente: hay relativamente más especies con abundancias intermedias",
  answer="la distribución decae más rápido: hay relativamente más especies con abundancias bajas",
  "la forma de la distribución no cambia en absoluto"
)


## ----alpha-efecto, fig.width=7, fig.height=5------------------------------------------------------------------------

N <- 10000
x <- 1:20
alphas <- c(150, 75, 40, 20)

plot(x, dls(x, N = N, alpha = alphas[1]), type = "l", lwd = 2, col = 1,
     xlab = "Abundancia", ylab = "Probabilidad",
     main = paste0("Efecto de alpha en la log-series (N = ", N, ")"))

for (i in 2:length(alphas)) {
  lines(x, dls(x, N = N, alpha = alphas[i]), lwd = 2, col = i)
}

legend("topright", legend = paste("alpha =", alphas), col = 1:length(alphas), lwd = 2)


## ----alpha-ejercicio-solucion, code_folding=TRUE, fig.width=7, fig.height=5-----------------------------------------

N <- 5000
x <- 1:20
alphas <- c(40, 20, 10)

plot(x, dls(x, N = N, alpha = alphas[1]), type = "l", lwd = 2, col = 1,
     xlab = "Abundancia", ylab = "Probabilidad",
     main = paste0("Efecto de alpha en la log-series (N = ", N, ")"))

for (i in 2:length(alphas)) {
  lines(x, dls(x, N = N, alpha = alphas[i]), lwd = 2, col = i)
}

legend("topright", legend = paste("alpha =", alphas), col = 1:length(alphas), lwd = 2)



## ----octav-plots-dls------------------------------------------------------------------------------------------------

N <- 10000
alphas <- c(150, 75, 40, 20)
## Total de especies para cada valor de alpha
S <- alphas*log(1+N/alphas)

par(mfrow=c(2,2))
for(i in 1:length(alphas)) {
    Octavas <- octavpred(sad = "ls",
              coef = list(N = N, alpha = alphas[i]),
              S = S[i], N = N)
    
       plot(Octavas, prop = TRUE,
             main = paste0("alpha = ", alphas[i], ", S = ",round(S[i])," , N = ", N),
             ylim = c(0,0.25))
}
par(mfrow=c(1,1))



## ----poilog-efecto, fig.width=9, fig.height=4.5---------------------------------------------------------------------

par(mfrow = c(1, 2))

x <- 0:30
sigs <- c(3,1,0.3)
mu <- 1.5
plot(x, dpoilog(x, mu = mu, sig = sigs[1]), type = "l", lwd = 2,
     xlab = "Abundancia", ylab = "Probabilidad",
     main = paste0("Variando sig (mu = ",mu,")"))
for (i in 2:length(sigs)) lines(x, dpoilog(x, mu = mu, sig = sigs[i]), lwd = 2, col = i)
legend("topright", legend = paste("sig =", sigs), col = 1:length(sigs), lwd = 2)

sig <- 0.3
mus <- c(1, 1.5, 2)
plot(x, dpoilog(x, mu = mus[1], sig = sig), type = "l", lwd = 2,
     xlab = "Abundancia", ylab = "Probabilidad",
     main = paste0("Variando mu (sig = ", sig,")"))
for (i in 2:length(mus)) lines(x, dpoilog(x, mu = mus[i], sig = sig), lwd = 2, col = i)
legend("topright", legend = paste("mu =", mus), col = 1:length(mus), lwd = 2)

par(mfrow = c(1, 1))



## ----poilog-ejercicio-solucion, code_folding=TRUE, fig.width=7, fig.height=5----------------------------------------

x <- 0:50
sigs <- c(4, 1, 0.2)
mu <- 3
plot(x, dpoilog(x, mu = mu, sig = sigs[1]), type = "l", lwd = 2,
     xlab = "Abundancia", ylab = "Probabilidad",
     main = paste0("Variando sig (mu = ",mu,")"))
for (i in 2:length(sigs)) lines(x, dpoilog(x, mu = mu, sig = sigs[i]), lwd = 2, col = i)
legend("topright", legend = paste("sig =", sigs), col = 1:length(sigs), lwd = 2)



## ----quiz3-opts, echo=FALSE, eval=TRUE------------------------------------------------------------------------------
quiz3 <- c(
  answer = "aumenta la heterogeneidad: las abundancias entre especies se vuelven más dispares",
  "las abundancias entre especies se vuelven más parecidas entre sí",
  "la forma de la distribución no cambia"
)


## ----matching-plot, echo=FALSE, fig.width=7, fig.height=5, eval=TRUE------------------------------------------------

x <- 1:30
alpha_por_letra <- c(A = 60, B = 5, C = 150, D = 20)
plot(x, dls(x, N = 1000, alpha = alpha_por_letra["A"]), type = "l", lwd = 2, col = 1,
     xlab = "Abundancia", ylab = "Probabilidad", ylim = c(0, 0.45),
     main = "¿Qué valor de alpha corresponde a cada curva?")
lines(x, dls(x, N = 1000, alpha = alpha_por_letra["B"]), lwd = 2, col = 2)
lines(x, dls(x, N = 1000, alpha = alpha_por_letra["C"]), lwd = 2, col = 3)
lines(x, dls(x, N = 1000, alpha = alpha_por_letra["D"]), lwd = 2, col = 4)
legend("topright", legend = names(alpha_por_letra), col = 1:4, lwd = 2)



## ----matching-quiz-opts, echo=FALSE, eval=TRUE----------------------------------------------------------------------
opt_A <- c("5", "20", answer = "60", "150")
opt_B <- c(answer = "5", "20", "60", "150")
opt_C <- c("5", "20", "60", answer = "150")
opt_D <- c("5", answer = "20", "60", "150")

