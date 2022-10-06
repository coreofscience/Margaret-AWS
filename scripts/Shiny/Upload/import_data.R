library(tidyverse)
library(here)
library(stringi)
library(plotly)

source(here("scripts",
            "citations.R"))

articulos_unicos_2016_2020 <- 
  read_csv(here("scripts/Shiny/output",
                "articulos.csv")) |>
  mutate(SJR_Q = ifelse(SJR_Q == '-', "Sin categoria",
                        SJR_Q))

investigadores_general <- 
  read_csv(here("scripts/Shiny/output",
                "investigadores.csv")) 
grupos_general <- 
  read_csv(here("scripts/Shiny/output",
                "grupos_general.csv")) 

paises_general <- articulos_unicos_2016_2020 |> 
  count(pais_revista, sort = TRUE)
paises_general$porcentaje <- round(prop.table(paises_general$n),3)*100 

revistas_actuales <-
  read_csv(here("scripts/Shiny/output", 
                "current_journals.csv")) 

articulos_2016_2020 <- 
  read_csv(here("scripts/Shiny/output",
                "articulos.csv")) 

capitulos_2016_2020 <- 
  read_csv(here("scripts/Shiny/output",
                "capitulos.csv")) 

libros_2016_2020 <- 
  read_csv(here("scripts/Shiny/output",
                "libros.csv")) 

software_2016_2020 <- 
  read_csv(here("scripts/Shiny/output",
                "softwares.csv")) 

trabajo_2016_2020 <- 
  read_csv(here("scripts/Shiny/output",
                "trabajos_dirigidos.csv")) 

innovacion_2016_2020 <- 
  read_csv(here("scripts/Shiny/output",
                "innovaciones_gestion.csv"))

actividades_evaluador <-
  read_csv(here("scripts/Shiny/output",
                "actividades_evaluador.csv"))

actividades_formacion <-
  read_csv(here("scripts/Shiny/output",
                "actividades_formacion.csv"))

apropiacion_social <-
  read_csv(here("scripts/Shiny/output",
                "apropiacion_social_conocimiento.csv"))

conceptos_tecnicos <-
  read_csv(here("scripts/Shiny/output",
                "conceptos_tecnicos.csv"))

consultorias <-
  read_csv(here("scripts/Shiny/output",
                "consultorias.csv"))

cursos <-
  read_csv(here("scripts/Shiny/output",
                "cursos.csv"))

demas_trabajos <-
  read_csv(here("scripts/Shiny/output",
                "demas_trabajos.csv"))
#investigadores
df_researchers <-
  read.csv(here("scripts/Shiny/output",
                "df_researcher.csv"))

divulgacion_publica_contenidos_transmedia <-
  read_csv(here("scripts/Shiny/output",
                "divulgacion_publica_contenidos_transmedia.csv"))

documentos_trabajo <-
  read_csv(here("scripts/Shiny/output",
                "documentos_trabajo.csv"))

ediciones <- 
  read_csv(here("scripts/Shiny/output",
                "ediciones.csv"))

Eliminados_por_grupo <-
  read_csv(here("scripts/Shiny/output",
                "Eliminados_por_grupo.csv"))

espacios_participacion <-
  read_csv(here("scripts/Shiny/output",
                "espacios_participacion.csv"))

estrategias_comunicacion <- 
  read_csv(here("scripts/Shiny/output",
                "estrategias_comunicacion.csv"))

estrategias_pedagogicas <-
  read_csv(here("scripts/Shiny/output",
                "estrategias_pedagogicas.csv"))

eventos_cientificos <-
  read_csv(here("scripts/Shiny/output",
                "eventos_cientificos.csv"))

generacion_contenido_audio <-
  read_csv(here("scripts/Shiny/output",
                "generacion_contenido_audio.csv"))

generacion_contenido_impreso <-
  read_csv(here("scripts/Shiny/output",
                "generacion_contenido_impreso.csv"))

generacion_contenido_virtual <-
  read_csv(here("scripts/Shiny/output",
                "generacion_contenido_virtual.csv"))

generacion_multimedia <-
  read_csv(here("scripts/Shiny/output",
                "generacion_multimedia.csv"))

informes_investigacion <-
  read_csv(here("scripts/Shiny/output",
                "informes_investigacion.csv"))

informes_tecnicos <-
  read_csv(here("scripts/Shiny/output",
                "informes_tecnicos.csv"))

innovaciones_gestion <-
  read_csv(here("scripts/Shiny/output",
                "innovaciones_gestion.csv"))

innovaciones_procesos <-
  read_csv(here("scripts/Shiny/output",
                "innovaciones_procesos.csv"))

international_journals_2021 <-
  read_csv(here("scripts/Shiny/output",
                "international_journals_2021.csv"))

journals_2016_2020 <-
  read_csv(here("scripts/Shiny/output",
                "journals_2016_2020.csv"))

journals_international_2016_2020 <-
  read_csv(here("scripts/Shiny/output",
                "journals_international_2016_2020.csv"))

jurado <-
  read_csv(here("scripts/Shiny/output",
                "jurado.csv"))

libros_divulgacion <-
  read_csv(here("scripts/Shiny/output",
                "libros_divulgacion.csv"))

libros_formacion <-
  read_csv(here("scripts/Shiny/output",
                "libros_formacion.csv"))

manuales_guias_especializadas <-
  read_csv(here("scripts/Shiny/output",
                "manuales_guias_especializadas.csv"))

notas_cientificas <-
  read_csv(here("scripts/Shiny/output",
                "notas_cientificas.csv"))

nuevos_registros_cientificos <-
  read_csv(here("scripts/Shiny/output",
                "nuevos_registros_cientificos.csv"))

otra_publicacion_divulgativa <- 
  read_csv(here("scripts/Shiny/output",
                "otra_publicacion_divulgativa.csv"))

otros_articulos <-
  read_csv(here("scripts/Shiny/output",
                "otros_articulos.csv"))

otros_libros <-
  read_csv(here("scripts/Shiny/output",
                "otros_libros.csv"))

otros_productos_tencologicos <-
  read_csv(here("scripts/Shiny/output",
                "otros_productos_tencologicos.csv"))

participacion_ciudadana_cti <-
  read_csv(here("scripts/Shiny/output",
                "participacion_ciudadana_cti.csv"))

participacion_comites <-
  read_csv(here("scripts/Shiny/output",
                "participacion_comites.csv"))

produccion_tecnica_tecnologica <-
  read_csv(here("scripts/Shiny/output",
                "produccion_tecnica_tecnologica.csv"))

Producciones_de_contenido_digital <-
  read_csv(here("scripts/Shiny/output",
                "Producciones_de_contenido_digital.csv"))

producciones_digital_audiovisual <-
  read_csv(here("scripts/Shiny/output",
                "Producciones_digital_audiovisual.csv"))

redes_conocimiento <-
  read_csv(here("scripts/Shiny/output",
                "redes_conocimiento.csv"))

reglamentos_tecnicos <-
  read_csv(here("scripts/Shiny/output",
                "reglamentos_tecnicos.csv"))

regulaciones_normas <-
  read_csv(here("scripts/Shiny/output",
                "regulaciones_normas.csv"))

signos_distintivos <-
  read_csv(here("scripts/Shiny/output",
                "signos_distintivos.csv"))

similares_entre_grupo <-
  read_csv(here("scripts/Shiny/output",
                "Similares_entre_grupo.csv"))

traducciones <-
  read_csv(here("scripts/Shiny/output",
                "traducciones.csv"))

## Historico categorias grupos
grupos_historicos <- read_csv("https://docs.google.com/spreadsheets/d/1mAFeuE-Eq6DTSiB6a04uo7jid_LcXt1m/export?format=csv&gid=551509450")

## Historico proyectos
proyectos_historicos_2017 <- read_csv("https://docs.google.com/spreadsheets/d/1Vq_jnUOiBE-_7AsLEIdZnQyOTOuQqWRf/export?format=csv&gid=267659160")

proyectos_historicos_2018 <- read_csv("https://docs.google.com/spreadsheets/d/1Vq_jnUOiBE-_7AsLEIdZnQyOTOuQqWRf/export?format=csv&gid=1864593933")

proyectos_historicos_2019 <- read_csv("https://docs.google.com/spreadsheets/d/1Vq_jnUOiBE-_7AsLEIdZnQyOTOuQqWRf/export?format=csv&gid=298346709")

proyectos_historicos_2020 <- read_csv("https://docs.google.com/spreadsheets/d/1Vq_jnUOiBE-_7AsLEIdZnQyOTOuQqWRf/export?format=csv&gid=466825271")

proyectos_historicos_2021 <- read_csv("https://docs.google.com/spreadsheets/d/1Vq_jnUOiBE-_7AsLEIdZnQyOTOuQqWRf/export?format=csv&gid=1317016133")

proyectos_historicos_2022 <- read_csv("https://docs.google.com/spreadsheets/d/1Vq_jnUOiBE-_7AsLEIdZnQyOTOuQqWRf/export?format=csv&gid=1766552935") 

## Jovenes investigadores
jovenes_i <- read_csv("https://docs.google.com/spreadsheets/d/1hplBDfYY_eaJx3yU2b_A62JrcQ__UGcY/export?format=csv&gid=428920444")

jovenes_i <- na.omit(jovenes_i)

## Semilleros
estudiantes_semilleros <- read_csv("https://docs.google.com/spreadsheets/d/1VJB_5oj_YGIyVHe4VObsgPni72EPMVVd/export?format=csv&gid=858320991")

semilleros_historicos_2017 <- read_csv("https://docs.google.com/spreadsheets/d/1lyybfY6EZPjFdw7ZWF8p1L7kaS6dBajQ/export?format=csv&gid=771049243")
semilleros_historicos_2018 <- read_csv("https://docs.google.com/spreadsheets/d/1lyybfY6EZPjFdw7ZWF8p1L7kaS6dBajQ/export?format=csv&gid=1134238589")
semilleros_historicos_2019 <- read_csv("https://docs.google.com/spreadsheets/d/1lyybfY6EZPjFdw7ZWF8p1L7kaS6dBajQ/export?format=csv&gid=1127688177")
semilleros_historicos_2020 <- read_csv("https://docs.google.com/spreadsheets/d/1lyybfY6EZPjFdw7ZWF8p1L7kaS6dBajQ/export?format=csv&gid=1152962755")
semilleros_historicos_2021 <- read_csv("https://docs.google.com/spreadsheets/d/1lyybfY6EZPjFdw7ZWF8p1L7kaS6dBajQ/export?format=csv&gid=1291737582")
semilleros_historicos_2022 <- read_csv("https://docs.google.com/spreadsheets/d/1lyybfY6EZPjFdw7ZWF8p1L7kaS6dBajQ/export?format=csv&gid=92570379")

semilleros_historicos <- merge(semilleros_historicos_2017, semilleros_historicos_2018, all = TRUE)
semilleros_historicos <- merge(semilleros_historicos, semilleros_historicos_2019, all = TRUE)
semilleros_historicos <- merge(semilleros_historicos, semilleros_historicos_2020, all = TRUE)
semilleros_historicos <- merge(semilleros_historicos, semilleros_historicos_2021, all = TRUE)
semilleros_historicos <- merge(semilleros_historicos, semilleros_historicos_2022, all = TRUE)
rm(semilleros_historicos_2017,semilleros_historicos_2018,semilleros_historicos_2019,semilleros_historicos_2020,
   semilleros_historicos_2021,semilleros_historicos_2022)

## Trabajos de grado
tg_2016 <- read_csv("https://docs.google.com/spreadsheets/d/1dlci5TT6Raqj6IKPMz3CiCu_W5K_y8QJ/export?format=csv&gid=1553280182") |>
  mutate('Ano' = 2016)
tg_2017 <- read_csv("https://docs.google.com/spreadsheets/d/1dlci5TT6Raqj6IKPMz3CiCu_W5K_y8QJ/export?format=csv&gid=1462223049") |> 
  mutate('Ano' = 2017)
tg_2018 <- read_csv("https://docs.google.com/spreadsheets/d/1dlci5TT6Raqj6IKPMz3CiCu_W5K_y8QJ/export?format=csv&gid=2137854493") |> 
  mutate('Ano' = 2018)
tg_2019 <- read_csv("https://docs.google.com/spreadsheets/d/1dlci5TT6Raqj6IKPMz3CiCu_W5K_y8QJ/export?format=csv&gid=183846486") |> 
  mutate('Ano' = 2019)
tg_2020 <- read_csv("https://docs.google.com/spreadsheets/d/1dlci5TT6Raqj6IKPMz3CiCu_W5K_y8QJ/export?format=csv&gid=627163141") |> 
  mutate('Ano' = 2019)
tg_2021 <- read_csv("https://docs.google.com/spreadsheets/d/1dlci5TT6Raqj6IKPMz3CiCu_W5K_y8QJ/export?format=csv&gid=1179613430") |> 
  mutate('Ano' = 2021)
tg_2022 <- read_csv("https://docs.google.com/spreadsheets/d/1dlci5TT6Raqj6IKPMz3CiCu_W5K_y8QJ/export?format=csv&gid=1963658115") |> 
  mutate('Ano' = 2022)

tg <- merge(tg_2016, tg_2017, all = TRUE)
tg <- merge(tg, tg_2018, all = TRUE)
tg <- merge(tg, tg_2019, all = TRUE)
tg <- merge(tg, tg_2020, all = TRUE)
tg <- merge(tg, tg_2021, all = TRUE)
tg <- merge(tg, tg_2022, all = TRUE)
rm(tg_2016, tg_2017, tg_2018, tg_2019, tg_2020, tg_2021, tg_2022)

## Eventos academicos
eva_estudiantes <- read_csv("https://docs.google.com/spreadsheets/d/14EGepMiiewyb2PJ3rvEhu2i1sSi5NIwj/export?format=csv&gid=1384748556")

eva_docentes <- read_csv("https://docs.google.com/spreadsheets/d/14EGepMiiewyb2PJ3rvEhu2i1sSi5NIwj/export?format=csv&gid=1055913532")

### Fin lectura
margaret <- list("grupos_general"=grupos_general,"investigadores"=investigadores_general,"articulos"=articulos_unicos_2016_2020,
                 "actividades_evaluador"=actividades_evaluador,"actividades_formacion"=actividades_formacion,
                 "apropiacion_social_conocimiento"=apropiacion_social,
                 "capitulos"=capitulos_2016_2020,"conceptos_tecnicos"=conceptos_tecnicos,"consultorias"=consultorias,
                 "cursos"=cursos,"demas_trabajos"=demas_trabajos,
                 "divulgacion_publica_contenidos_transmedia"=divulgacion_publica_contenidos_transmedia,
                 "documentos_trabajo"=documentos_trabajo,"ediciones"=ediciones,
                 "espacios_participacion"=espacios_participacion,"estrategias_comunicacion"=estrategias_comunicacion,
                 "estrategias_pedagogicas"=estrategias_pedagogicas,"eventos_cientificos"=eventos_cientificos,
                 "generacion_contenido_audio"=generacion_contenido_audio,
                 "generacion_contenido_impreso"=generacion_contenido_impreso,"generacion_contenido_virtual"=generacion_contenido_virtual,
                 "generacion_multimedia"=generacion_multimedia,"informes_investigacion"=informes_investigacion,"informes_tecnicos"=informes_tecnicos,
                 "innovaciones_gestion"=innovaciones_gestion,"innovaciones_procesos"=innovaciones_procesos,
                 "jurado"=jurado,"libros_divulgaciones"=libros_divulgacion,"libros_formacion"=libros_formacion,"libros"=libros_2016_2020,
                 "manuales_guias_especializadas"=manuales_guias_especializadas,"notas_cientificas"=notas_cientificas,
                 "nuevos_registros_cientificos"=nuevos_registros_cientificos,"otra_publicacion_divulgativa"=otra_publicacion_divulgativa,
                 "otros_articulos"=otros_articulos,"otros_libros"=otros_libros,"otros_productos_tecnologicos"=otros_productos_tencologicos,
                 "participacion_ciudadana_cti"=participacion_ciudadana_cti,"participacion_comites"=participacion_comites,
                 "produccion_tecnica_tecnologia"=produccion_tecnica_tecnologica,"producciones_de_contenido_digital"=Producciones_de_contenido_digital,
                 "producciones_digital_audiovisual"=producciones_digital_audiovisual,"redes_conocimiento"=redes_conocimiento,
                 "reglamentos_tecnicos"=reglamentos_tecnicos,"regulaciones_normas"=regulaciones_normas,"signos_distintivos"=signos_distintivos,
                 "software"=software_2016_2020,"trabajos_dirigidos"=trabajo_2016_2020,"traducciones"=traducciones,
                 "similares_entre_grupo"=similares_entre_grupo,"eliminados_por_grupo"=Eliminados_por_grupo)