# Instalação dos pacotes necessários (caso ainda não tenha feito)
install.packages("tidyverse")
install.packages("WDI")
install.packages("gganimate")
install.packages("gifski")
install.packages("transformr")

# Carregamento dos pacotes
library(tidyverse)
library(WDI)
library(gganimate)
library(gifski)
library(transformr)

# Definindo países da América Latina
paises_latam <- c("AR", "BO", "BR", "CL", "CO", "CR", "CU", "EC", "SV", 
                  "GT", "HN", "MX", "NI", "PA", "PY", "PE", "DO", "UY", "VE")

# Ano de análise fixado em 2022
ano_final <- 2022
ano_inicial <- 1990

# Importando dados completos de 1990 a 2022
florestas_latam <- WDI(country = paises_latam,
                       indicator = 'AG.LND.FRST.ZS',
                       start = ano_inicial,
                       end = ano_final)

# Corte transversal no ano mais recente disponível
florestas_latam_2022 <- florestas_latam %>% filter(year == ano_final)

# Série temporal Brasil
florestas_brasil <- florestas_latam %>% filter(iso2c == "BR")

# 📊 Gráfico 1: Estático - Evolução da área florestal (vários países latinos)
ggplot(florestas_latam, aes(x = year, y = AG.LND.FRST.ZS, color = country)) +
  geom_line(size = 1) +
  labs(title = "Área florestal (% do território) - América Latina",
       subtitle = "De 1990 a 2022",
       x = "Ano",
       y = "Percentual (%)",
       color = "País") +
  scale_x_continuous(limits = c(ano_inicial, ano_final)) +
  theme_minimal()

# 📊 Gráfico 2: Corte transversal em 2022
ggplot(florestas_latam_2022, aes(x = reorder(country, AG.LND.FRST.ZS), y = AG.LND.FRST.ZS)) +
  geom_col(fill = "forestgreen") +
  coord_flip() +
  labs(title = "Área florestal em 2022 - América Latina",
       x = "País",
       y = "Percentual do território (%)") +
  theme_minimal()

# 📊 Gráfico 3: Série temporal Brasil
ggplot(florestas_brasil, aes(x = year, y = AG.LND.FRST.ZS)) +
  geom_line(color = "darkgreen", size = 1.2) +
  geom_point(color = "darkgreen", size = 2) +
  labs(title = "Área florestal no Brasil (1990–2022)",
       x = "Ano",
       y = "Percentual (%)") +
  scale_x_continuous(limits = c(ano_inicial, ano_final)) +
  theme_minimal()
