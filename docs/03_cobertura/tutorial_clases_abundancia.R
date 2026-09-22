## ----setup_clases, include=FALSE, eval=TRUE------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE, warning = FALSE, fig.align = "center")
library(sads)


## ----grasslands-head-----------------------------------------------------------------------------
head(grasslands)


## ----grasslands-breakpoints----------------------------------------------------------------------
(grass.brk <- c(0, 1, 3, 5, seq(15, 100, by = 10), 100))


## ----grasslands-hist-----------------------------------------------------------------------------
grass.h <- hist(grasslands$mids, breaks = grass.brk, plot = FALSE)


## ----grasslands-hist-tabla-----------------------------------------------------------------------
str(grass.h)
data.frame(punto_medio = grass.h$mids, N_especies = grass.h$counts)


## ----grasslands-fit-sin-trunc--------------------------------------------------------------------
grass.e <- fitsadC(grass.h, 'exp')      # Exponencial
grass.g <- fitsadC(grass.h, 'gamma')    # Gamma
grass.l <- fitsadC(grass.h, 'lnorm')    # Lognormal
grass.p <- fitsadC(grass.h, 'pareto')   # Pareto
grass.w <- fitsadC(grass.h, 'weibull')  # Weibull


## ----grasslands-aicctab-sin-trunc----------------------------------------------------------------
m.nombres <- c("Exponencial", "Gamma", "Log-normal", "Pareto", "Weibull") 
AICctab(grass.e, grass.g, grass.l, grass.p, grass.w,
        mnames = m.nombres, 
        weights = TRUE, base = TRUE)


## ----grasslands-hist-plot, fig.width=6, fig.height=5---------------------------------------------
plot(grass.h, main = "", xlab = "Clase de abundancia")


## ----grasslands-coverpred------------------------------------------------------------------------
grass.e.p <- coverpred(grass.e)
grass.g.p <- coverpred(grass.g)
grass.l.p <- coverpred(grass.l)
grass.p.p <- coverpred(grass.p)
grass.w.p <- coverpred(grass.w)


## ----grasslands-coverpred-plot, fig.width=6, fig.height=5----------------------------------------
plot(grass.h, main = "", xlab = "Clase de abundancia", xlim = c(0, 40))
points(grass.e.p, col = 1)
points(grass.g.p, col = 2)
points(grass.l.p, col = 3)
points(grass.p.p, col = 4)
points(grass.w.p, col = 5)
legend("topright",
       legend = m.nombres,
       col = 1:5, bty = "n", lty = 1, pch = 1)


## ----grasslands-rad-plot, fig.width=6, fig.height=5----------------------------------------------
plot(rad(grass.h))
lines(radpred(grass.e), col = 1)
lines(radpred(grass.g), col = 2)
lines(radpred(grass.l), col = 3)
lines(radpred(grass.p), col = 4)
lines(radpred(grass.w), col = 5)
legend("topright",
       legend = m.nombres,
       col = 1:5, bty = "n", lty = 1)


## ----grasslands-fit-con-trunc--------------------------------------------------------------------
grass.e.t <- fitsadC(grass.h, 'exp', trunc.max = 100)      # Exponencial
grass.g.t <- fitsadC(grass.h, 'gamma', trunc.max = 100)    # Gamma
grass.l.t <- fitsadC(grass.h, 'lnorm', trunc.max = 100)    # Lognormal
grass.p.t <- fitsadC(grass.h, 'pareto', trunc.max = 100)   # Pareto
grass.w.t <- fitsadC(grass.h, 'weibull', trunc.max = 100)  # Weibull


## ----grasslands-aicctab-con-trunc----------------------------------------------------------------
AICctab(grass.e, grass.g, grass.l, grass.p, grass.w,
        grass.e.t, grass.g.t, grass.l.t, grass.p.t, grass.w.t,
        weights = TRUE, base = TRUE)

