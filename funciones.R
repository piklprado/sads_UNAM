## Funciones auxiliares para armar páginas del curso a partir de
## archivos .Rmd que también funcionan como documentos independientes
## (por ejemplo, tutoriales con su propio encabezado YAML).

#' Incluye un archivo .Rmd como "child document" en la página actual
#'
#' Elimina el encabezado YAML del archivo (todo lo que está entre las
#' dos primeras líneas "---") antes de pasarlo a knitr::knit_child(),
#' para que no aparezca como texto suelto en la página final.
#'
#' El argumento `eval` controla si los chunks de código R *dentro*
#' del archivo incluido se ejecutan o no. Esto es independiente del
#' chunk que hace la llamada a incluir_capitulo(), que debe
#' mantenerse siempre con eval = TRUE (si no, ni el texto ni el
#' código del archivo incluido aparecerían en la página).
#'
#' @param archivo ruta al archivo .Rmd a incluir
#' @param eval si TRUE (por defecto), ejecuta los chunks de código
#'   del archivo incluido; si FALSE, los muestra sin ejecutar
incluir_capitulo <- function(archivo, eval = TRUE) {
  lineas <- xfun::read_utf8(archivo)
  marcas_yaml <- which(lineas == "---")
  if (length(marcas_yaml) >= 2) {
    lineas <- lineas[-(marcas_yaml[1]:marcas_yaml[2])]
  }
  opts_originales <- knitr::opts_chunk$get()
  on.exit(knitr::opts_chunk$set(opts_originales), add = TRUE)
  knitr::opts_chunk$set(eval = eval)
  knitr::knit_child(text = lineas, quiet = TRUE)
}

## --------------------------------------------------------------
## Wrappers "blindados" para los widgets de webexercises
## --------------------------------------------------------------
## Problema: mcq()/longmcq() deciden si generan el widget HTML o un
## texto plano (pensado para salidas LaTeX/PDF) consultando
## knitr::is_latex_output(), que a su vez depende de la opción interna
## knitr::opts_knit$get("out.format"). El resaltado de sintaxis del
## sitio (via distill/downlit) parece modificar esa misma opción al
## formatear el código fuente de los chunks, sin restaurarla. Una vez
## que eso ocurre, is_latex_output() queda "pegado" en TRUE por el
## resto del documento, y todo mcq()/longmcq() posterior deja de
## generar el widget interactivo.
##
## Solución: forzar out.format a NULL justo antes de cada llamada,
## para que is_latex_output() vuelva a evaluar correctamente que la
## salida es HTML.
html_mcq <- function(opts) {
  knitr::opts_knit$set(out.format = NULL)
  webexercises::mcq(opts)
}

html_longmcq <- function(opts) {
  knitr::opts_knit$set(out.format = NULL)
  webexercises::longmcq(opts)
}
