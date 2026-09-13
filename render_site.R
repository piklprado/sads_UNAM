library(xaringan)
library(xaringanExtra)
library(distill)
library(rmarkdown)

## rmarkdown::render(
##   input = "01_introduccion/slides.Rmd",
##   output_file = "slides.html",
##   output_dir = "01_introduccion",
##   encoding = "UTF-8"
##   )

## rmarkdown::render(
##   input = "02_ajustes/slides.Rmd",
##   output_file = "slides.html",
##   output_dir = "02_ajustes",
##   encoding = "UTF-8"
## )

rmarkdown::render_site(encoding = 'UTF-8')
