library(ggplot2)
library(ggforce)

# 1. Datos de las barras/rectángulos
df_rects <- data.frame(
  etapa = factor(c(
    "1. Recurso Total",
    "2. E1 toma el 50%", "2. E1 toma el 50%",
    "3. E2 toma el 25%", "3. E2 toma el 25%", "3. E2 toma el 25%",
    "4. E3 toma el 12.5%", "4. E3 toma el 12.5%", "4. E3 toma el 12.5%", "4. E3 toma el 12.5%"
  ), levels = c("1. Recurso Total", "2. E1 toma el 50%", "3. E2 toma el 25%", "4. E3 toma el 12.5%")), 
  xmin = c(
    0,
    0, 50,
    0, 50, 75,
    0, 50, 75, 87.5
  ),
  xmax = c(
    100,
    50, 100,
    50, 75, 100,
    50, 75, 87.5, 100
  ),
  rotulo = c(
    "Resto (100%)",
    "Especie 1 (50%)", "Resto (50%)",
    "Especie 1 (50%)", "Especie 2 (25%)", "Resto (25%)",
    "Especie 1 (50%)", "Especie 2 (25%)", "E3 (12.5%)", "Resto..."
  ),
  tipo = c(
    "Resto",
    "E1", "Resto",
    "E1", "E2", "Resto",
    "E1", "E2", "E3", "Resto"
  )
)
y_map <- c("1. Recurso Total" = 4, "2. E1 toma el 50%" = 3, "3. E2 toma el 25%" = 2, "4. E3 toma el 12.5%" = 1)
df_rects$ymin <- y_map[as.character(df_rects$etapa)] - 0.25
df_rects$ymax <- y_map[as.character(df_rects$etapa)] + 0.25
df_rects$x_centro <- (df_rects$xmin + df_rects$xmax) / 2
df_rects$y_centro <- (df_rects$ymin + df_rects$ymax) / 2
# 2. Datos de las flechas dinámicas (partiendo del centro del "Resto")
df_setas <- data.frame(
  x = c(50, 75, 87.5),          # Mitad del espacio restante superior
  y = c(3.70, 2.70, 1.70),       # Borde inferior de la barra de origen
  xend = c(50, 75, 87.5),       # Apunta verticalmente hacia abajo
  yend = c(3.30, 2.30, 1.30)     # Borde superior de la barra destino
)
# 3. Construcción del gráfico
ggplot() +
  geom_rect(data = df_rects, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = tipo),
            color = "black", linewidth = 0.6) +
  geom_text(data = df_rects, aes(x = x_centro, y = y_centro, label = rotulo),
            size = 3.3, fontface = "bold", color = "black") +
  # Dibujar las flechas de división
  geom_segment(data = df_setas, aes(x = x, y = y, xend = xend, yend = yend),
               arrow = arrow(length = unit(0.20, "cm"), type = "closed"),
               linewidth = 0.7, color = "red3") +
  scale_fill_manual(values = c(
    "E1" = "#6baed6",
    "E2" = "#9ecae1",
    "E3" = "#c6dbef",
    "Resto" = "#e0e0e0"
  )) +
  scale_y_continuous(breaks = 1:4, labels = rev(names(y_map))) +
  scale_x_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Serie Geométrica: Preención de Nicho (k = 50%)",
    subtitle = "Las flechas rojas muestran la división iterativa del recurso restante",
    x = "Proporción del Recurso Total (%)",
    y = NULL
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "none",
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_blank(),
    plot.title = element_text(face = "bold", size = 14),
    axis.text.y = element_text(face = "bold", color = "black")
  )


## Grafico de la serie


# 1. Definir parámetros del modelo
k <- 0.50           # Fracción de preención (50%)
rangos <- 1:4      # Rangos de las especies (Especie 1 a 10)
# 2. Calcular la abundancia relativa p_i = k * (1 - k)^(i - 1)
abundancia_relativa <- k * (1 - k)^(rangos - 1)
log10_abundancia <- log10(abundancia_relativa)
# 3. Crear dataframe
df_geom <- data.frame(
  Rango = rangos,
  Abundancia = abundancia_relativa,
  Log_Abundancia = log10_abundancia
)
# 4. Construir el gráfico
ggplot(df_geom, aes(x = Rango, y = Log_Abundancia)) +
  # Línea de tendencia ajustada (recta perfecta)
  geom_line(color = "blue3", linewidth = 1) +
  # Puntos representando cada especie
  geom_point(color = "red2", size = 3) +
  # Etiquetas con el porcentaje real en cada punto
  geom_text(aes(label = paste0(round(Abundancia * 100, 2), "%")), 
            vjust = -0.8, size = 3.2, fontface = "bold") +
  scale_x_continuous(breaks = 1:10) +
  labs(
    title = "Curva de Rango-Abundancia: Serie Geométrica (k = 0,5)",
    x = "Rango de la Especie",
    y = "Log10(Abundancia Relativa)"
  ) +
  theme_classic(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    panel.grid.minor = element_blank()
  )
