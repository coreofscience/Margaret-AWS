library(tidyverse)
library(rvest)
library(here)
library(openxlsx)
library(scholar)
library(stringi)


source(here("scripts",
            "data_getting.R"))
source(here("scripts",
            "data_cleaning.R"))
source(here("scripts",
            "data_tidying.R"))
source(here("scripts/data_analysis_descriptive.R"))
source(here("scripts",
            "merge_quality_articles.R"))
source(here("scripts",
            "researcher_information.R"))
source(here("scripts",
           "orcid.R"))

eval(parse(here("scripts/functions.R"), encoding = "UTF-8"))
# Data outside

grupos <- read_csv("https://docs.google.com/spreadsheets/d/1gBaXHFp1NTUTeXodb4JyHqY-P-AWV5yN5-p4L1O09gk/export?format=csv&gid=0") |> 
  mutate(grupo = str_to_upper(grupo),
         grupo = stri_trans_general(str = grupo,
                                    id = "Latin-ASCII"))

researchers <- read_csv("https://docs.google.com/spreadsheets/d/1gBaXHFp1NTUTeXodb4JyHqY-P-AWV5yN5-p4L1O09gk/export?format=csv&gid=1846176083") |> 
  select(1,2) |> 
  unique() |> 
  mutate(researcher = str_to_upper(researcher),
         researcher = stri_trans_general(str = researcher,
                                         id = "Latin-ASCII")) |>  
  mutate(h_index = map(id_scholar, safely(get_profile))) |> 
  unnest_wider(h_index) |> 
  unnest_wider(result) |> 
  select(researcher, id_scholar, h_index) |> 
  mutate(h_index = if_else(is.na(h_index), 0, h_index))


#nuevo <- getting_scholar_h_index(researchers |> select(researcher,id_scholar))

grupo_df <- data_getting_ucla(grupos)
produccion_grupos <- data_cleaning_ucla(grupo_df)

# source(here("scripts",
#             "report.R"))

produccion_actualizada <- data_tidying_ucla(produccion_grupos)

produccion_actualizada[[2]][["articulos"]] <- merge_quality_articles_ucla(produccion_actualizada[[2]][["articulos"]]) 

shiny_data <- data_analysis_descriptive_ucla(produccion_actualizada)

shiny_data[[3]] <- researcher_information_ucla(shiny_data)
shiny_data[[3]] <- getting_orcid(shiny_data)
#Data is uploaded to the BD
source(here("scripts",
            "database.R"))

grupo_general <- as.data.frame(shiny_data[[1]])
investigadores_general <- as.data.frame(shiny_data[[3]])

saveData(grupo_general, "grupo_general")
saveData(investigadores_general, "investigadores_general")

collectionName <- list("trabajos_dirigidos","eventos_cientificos","articulos","proyectos","capitulos","jurado","cursos","otros_articulos","consultorias","libros","participacion_comites","demas_trabajos","informes_investigacion","innovaciones_gestion","generacion_multimedia","otra_publicacion_divulgativa","documentos_trabajo","ediciones","estrategias_pedagogicas","redes_conocimiento","generacion_contenido_virtual","espacios_participacion","softwares","innovaciones_procesos","otros_libros","estrategias_comunicacion","generacion_contenido_impreso","informes_tecnicos","participacion_ciudadana_cti","regulaciones_normas","actividades_evaluador","actividades_formacion","apropiacion_social_conocimiento","produccion_tecnica_tecnologica","generacion_contenido_audio","conceptos_tecnicos","reglamentos_tecnicos","otros_productos_tecnologicos","traducciones","signos_distintivos","nuevos_registros_cientificos","notas_cientificas","Producciones_de_contenido_digital","libros_divulgacion","libros_formacion","Producciones_digital_audiovisual","manuales_guias_especializadas","divulgacion_publica_contenidos_trasmedia","grupo_researcher_cleaned")

for(j in length(shiny_data[[2]])){
  
  data <- as.data.frame(shiny_data[[2]][[j]])
  saveData(data, collectionName[[j]])
  
}
#export_csv(shiny_data)

# Current Journals categories for flex_dashboard
source(here("scripts",
            "current_categories.R"))


# This code save produccion_grupos in an excel file

wb <- createWorkbook()
lapply(seq_along(produccion_actualizada[[2]]), 
       function(i){
         addWorksheet(wb=wb, 
                      sheetName = names(produccion_actualizada[[2]][i]))
         writeData(wb, 
                   sheet = i, 
                   produccion_actualizada[[2]][[i]])
       })

#Save Workbook

saveWorkbook(wb, 
             here("output","grupos_produccion.xlsx"), 
             overwrite = TRUE)
