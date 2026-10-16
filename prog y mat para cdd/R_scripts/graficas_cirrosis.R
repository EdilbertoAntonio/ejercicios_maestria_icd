library(tidyverse)
library(scales)

# carga de datos y procesamiento de datos ----
setwd("D:/papeles maestria/ejercicios_maestria_icd")
datos_cirrosis <- read_csv("prog y mat para cdd/datos/cirrosis.csv")

nrow(datos_cirrosis)

colnames(datos_cirrosis)

datos_limpios <- datos_cirrosis %>% drop_na()

# error en el procesamiento pero en python, la columna Cholesterol tienen otros tipos de NAN como NANN cuando los lee desde 
# la api, pero es CSV si solo aparacen como NAN, por lo que quitarlos, aqui tenemos menos datos que en el script de python
nrow(datos_limpios)

datos_limpios$Age_years <- as.integer((datos_limpios$Age) / 365)
mujeres <- datos_limpios %>% filter(Sex == "F")
hombres <- datos_limpios %>% filter(Sex == "M")

# tema base ----

tema_base <- theme_minimal() +
  theme(
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "#F7F9FC", color = NA),
    panel.grid.major.y = element_line(color = "white", linewidth = 1.2),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.x = element_blank(),
    axis.line.x = element_line(color = "#CCCCCC", linewidth = 0.8),
    axis.line.y = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(size = 11, face = "bold", color = "#2D3142", 
                              margin = margin(b = 10), hjust = 0.5),
    axis.title.x = element_text(size = 9, color = "#2D3142", margin = margin(t = 5)),
    axis.title.y = element_text(size = 9, color = "#2D3142", margin = margin(r = 5)),
    axis.text.x = element_text(size = 8, color = "#2D3142"),
    axis.text.y = element_text(size = 8, color = "#666666"),
    legend.position = "none" # Ocultar leyenda globalmente
  )

# primera gráfica ----

datos_resumen_sexo <- datos_limpios %>%
  count(Sex) %>%
  mutate(
    Sex = factor(Sex, levels = c("F", "M"), labels = c("Femenino", "Masculino")),
    porcentaje = n / sum(n),
    etiqueta = sprintf("%d (%.1f%%)", n, porcentaje * 100)
  )

grafico_1 <- ggplot(datos_resumen_sexo, aes(x = Sex, y = n, fill = Sex)) +
  geom_bar(stat = "identity", width = 0.45, color = "white", linewidth = 1.5) +
  geom_text(aes(label = etiqueta, y = n + sum(n) * 0.015), 
            vjust = 0, size = 3, fontface = "bold", color = "#333333") +
  scale_fill_manual(values = c("Femenino" = "#FF6A6A", "Masculino" = "#7CCD7C")) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Distribución de pacientes por sexo",
    x = "Sexo",
    y = "Número de pacientes"
  ) +
  tema_base

print(grafico_1)

# segundo gráfico ----

etiquetas_edad <- c('<40', '40–49', '50–59', '60–69', '70+')

mujeres_mod <- mujeres %>%
  mutate(
    Grupo_edad = cut(Age_years, breaks = c(0, 40, 50, 60, 70, 80), 
                     labels = etiquetas_edad, right = FALSE)
  )

conteos_muj <- mujeres_mod %>% count(Grupo_edad)
etiquetas_x_muj <- paste0(conteos_muj$Grupo_edad, "\n(n=", conteos_muj$n, ")")
names(etiquetas_x_muj) <- conteos_muj$Grupo_edad

paleta_roja <- colorRampPalette(c("white", "#FF6A6A"))(length(etiquetas_edad) + 1)[-1]

grafico_2 <- ggplot(mujeres_mod, aes(x = Grupo_edad, y = Bilirubin, fill = Grupo_edad)) +
  geom_boxplot(width = 0.5, outlier.shape = NA, linewidth = 0.8, color = "#4d4d4d") +
  geom_jitter(color = "#2D3142", size = 2.5, alpha = 0.4, width = 0.2, height = 0) +
  scale_fill_manual(values = paleta_roja) +
  scale_x_discrete(labels = etiquetas_x_muj) +
  scale_y_log10(labels = label_number()) +
  labs(
    title = 'Bilirrubina por grupo de edad en pacientes mujeres',
    x = 'Grupo de edad (años)',
    y = 'Bilirrubina (mg/dL)'
  ) +
  tema_base

print(grafico_2)

# tercer gráfico ----

hombres_mod <- hombres %>%
  mutate(
    Grupo_edad = cut(Age_years, breaks = c(0, 40, 50, 60, 70, 80), 
                     labels = etiquetas_edad, right = FALSE)
  )

conteos_hom <- hombres_mod %>% count(Grupo_edad)
etiquetas_x_hom <- paste0(conteos_hom$Grupo_edad, "\n(n=", conteos_hom$n, ")")
names(etiquetas_x_hom) <- conteos_hom$Grupo_edad

paleta_verde <- colorRampPalette(c("white", "#7CCD7C"))(length(etiquetas_edad) + 1)[-1]

grafico_3 <- ggplot(hombres_mod, aes(x = Grupo_edad, y = Bilirubin, fill = Grupo_edad)) +
  geom_boxplot(width = 0.5, outlier.shape = NA, linewidth = 0.8, color = "#4d4d4d") +
  geom_jitter(color = "#2D3142", size = 2.5, alpha = 0.4, width = 0.2, height = 0) +
  scale_fill_manual(values = paleta_verde) +
  scale_x_discrete(labels = etiquetas_x_hom) +
  scale_y_log10(limits = c(0.2, 35), labels = label_number()) +
  labs(
    title = 'Bilirrubina por grupo de edad en pacientes hombres',
    x = 'Grupo de edad (años)',
    y = 'Bilirrubina (mg/dL)'
  ) +
  tema_base

print(grafico_3)

# cuarto gráfico ----

datos_resumen_drug <- datos_limpios %>%
  filter(Drug %in% c("D-penicillamine", "Placebo")) %>%
  count(Drug) %>%
  mutate(
    Drug = factor(Drug, levels = c("D-penicillamine", "Placebo"), 
                        labels = c("D-penicilamina", "Placebo")),
    porcentaje = n / sum(n),
    etiqueta = sprintf("%d (%.1f%%)", n, porcentaje * 100)
  )

grafico_4 <- ggplot(datos_resumen_drug, aes(x = Drug, y = n, fill = Drug)) +
  geom_bar(stat = "identity", width = 0.45, color = "white", linewidth = 1.5) +
  geom_text(aes(label = etiqueta, y = n + sum(n) * 0.015), 
            vjust = 0, size = 3, fontface = "bold", color = "#333333") +
  scale_fill_manual(values = c("D-penicilamina" = "#5B9BD5", "Placebo" = "#F4B183")) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Distribución de pacientes por tratamiento",
    x = "Tratamiento",
    y = "Número de pacientes"
  ) +
  tema_base

print(grafico_4)