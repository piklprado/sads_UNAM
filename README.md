# Análisis y visualización de datos biológicos con R

Sitio web y todo el material utilizado en el taller, dictado en el Instituto de Ecología, UNAM, 21 de Septiembre de 2026.

```bash
.
├── README.md                       # this file
├── _site.yml                       # site config
├── 01_introduccion.Rmd            # landing page
├── 01_introdución/                # subfolder for each class + labs
│   ├── lab.Rmd                     # lab source file
│   ├── lab.html
│   ├── slides.Rmd                  # slides source file
│   ├── slides.html
│   └── xaringan-themer.css
└── theme.css
```

## To deploy this website locally

+ Clone this repository
+ Install `distill`, `xaringanExtra`: 
```
install.packages("distill")
install.packages("xaringanExtra")
```
+ Click on the Build Website button of the Build pane in RStudio or execute `rmarkdown::render_site(encoding = 'UTF-8')`. R may prompt you to install/update some extra packages.

A version of this site will be created in the `docs/` subfolder. Open **index.html** in your web browser. 

## To add slides to each class

Slides are saved in each subfolder, for each class. 

Xaringan slides need xaringan: `install.packages("xaringan")`. These are `.Rmd` files with a special YAML header (you can modify the YAML based on the [sample slides](01_introduccion/slides.Rmd)

You can knit the slides using the knit button, pressing `ctrl+shift+K` in RStudio, or  execute 

```
rmarkdown::render('./[0x_topic]/slides.Rmd',  encoding = 'UTF-8')`.
```

> **Note**  
> Remember to knit your slides and labs before building the site again. 
> Push the `.Rmd` and the `.html` for your slides and labs, the subfolder /libs and `xaringan-themer.css`  
> Push the contents of `/docs` as well, Netlify will build the site from there

