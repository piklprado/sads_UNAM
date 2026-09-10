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
## knitr::is_latex_output(), que a su vez depende de opciones internas
## del knitr (out.format y/o rmarkdown.pandoc.to). En el sitio, algo
## en la cadena de renderizado (posiblemente el resaltado de sintaxis
## de distill/downlit) deja esas opciones en un estado que hace que
## is_latex_output() devuelva TRUE de forma persistente, incluso
## reseteando out.format antes de cada llamada (eso ya se probó y no
## alcanza: probablemente rmarkdown.pandoc.to también queda afectado).
##
## Solución más robusta: en vez de intentar "arreglar" ese estado
## global (cuyo origen exacto no está confirmado), estas funciones
## generan el HTML del widget directamente, replicando la lógica de
## mcq()/longmcq() del paquete webexercises pero sin consultar
## is_latex_output() en absoluto. Así el resultado es siempre HTML,
## sin importar el estado de esas opciones.
html_mcq <- function(opts) {
  ix <- which(names(opts) == "answer")
  if (length(ix) == 0) stop("MCQ has no correct answer")
  options <- sprintf("<option value='%s'>%s</option>", names(opts), opts)
  sprintf("<select class='webex-select'><option value='blank'></option>%s</select>",
          paste(options, collapse = ""))
}

html_longmcq <- function(opts) {
  ix <- which(names(opts) == "answer")
  if (length(ix) == 0) stop("The question has no correct answer")
  opts2 <- gsub("'", "&apos;", opts, fixed = TRUE)
  qname <- paste0("radio_", paste(sample(LETTERS, 10, TRUE), collapse = ""))
  options <- sprintf('<label><input type="radio" autocomplete="off" name="%s" value="%s"></input> <span>%s</span></label>',
                      qname, names(opts), opts2)
  paste0("<div class='webex-radiogroup' id='", qname, "'>",
         paste(options, collapse = ""),
         "</div>\n")
}
