# Ajuste de distribuciones de abundancia de especies

Sitio web y todo el material utilizado en el taller, dictado en el
Instituto de Ecología, UNAM, Ciudad de México, 21 de Septiembre de
2026.

```bash
.
├── README.md                       # este archivo
├── _site.yml                       # configuración del sitio
├── 01_introduccion.Rmd            # página principal
├── 01_introducion/                 # subcarpeta para cada clase + prácticas
│   ├── lab.Rmd                     # archivo fuente de la práctica
│   ├── lab.html
│   ├── slides.Rmd                  # archivo fuente de las diapositivas
│   ├── slides.html
│   └── xaringan-themer.css
└── theme.css
```

## Para compilar este sitio web localmente

+ Clona este repositorio
+ Instala `distill` y `xaringanExtra`: 
```R
install.packages("distill")
install.packages("xaringanExtra")
```
+ Ejecuta `rmarkdown::render_site(encoding = 'UTF-8')` en tu consola de R (ESS). Es posible que R te pida instalar o actualizar algunos paquetes adicionales.

Se creará una versión de este sitio en la subcarpeta `docs/`. Abre **index.html** en tu navegador web. 

## Para agregar diapositivas a cada clase

Las diapositivas se guardan dentro de la subcarpeta correspondiente a cada clase.

Las diapositivas de Xaringan requieren el paquete `xaringan`: `install.packages("xaringan")`. Son archivos `.Rmd` con un encabezado YAML especial (puedes modificar el YAML basándote en las [diapositivas de ejemplo](01_introduccion/slides.Rmd)).

Puedes compilar las diapositivas ejecutando el siguiente comando en la consola de R (ESS):

```R
rmarkdown::render('./[0x_tema]/slides.Rmd', encoding = 'UTF-8')
```

> **Nota**  
> Recuerda compilar tus diapositivas y prácticas antes de volver a construir el sitio completo.  
> Sube (push) los archivos `.Rmd` y `.html` de tus diapositivas y prácticas, la subcarpeta `/libs` y el archivo `xaringan-themer.css`.  
> Sube también el contenido de `/docs` (GitHub Pages o Netlify construirán el sitio a partir de ahí).
