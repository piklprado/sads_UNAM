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
#' Esto permite reutilizar el mismo tutorial en dos contextos:
#' - Una página "borrador" con eval = FALSE, que muestra el texto y
#'   el código sin ejecutarlo (rápida de compilar).
#' - Una página "final", con eval = TRUE, que ejecuta todo el código
#'   y muestra los resultados, para publicar a los estudiantes.
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
  ## Guarda las opciones actuales de chunk y las restaura al salir,
  ## para no afectar el resto de la página que llama esta función.
  opts_originales <- knitr::opts_chunk$get()
  on.exit(knitr::opts_chunk$set(opts_originales), add = TRUE)
  knitr::opts_chunk$set(eval = eval)
  knitr::knit_child(text = lineas, quiet = TRUE)
}
