#### packages main ####

library(tidyverse)
library(rvest)
library(here)
library(openxlsx)
library(scholar)
library(stringi)

#### Load modules with functions ####

## Getting data form GrupLAC with webscraping
source(here("scripts",
            "data_getting.R"))

## Cleaning data for each categorie
source(here("scripts",
            "data_cleaning.R"))

## Drop duplicates with cosine method >70%
source(here("scripts",
            "data_tidying.R"))

## Getting some information from data -> 
##  Numbers of papers, products for researcher
source(here("scripts",
            "data_analysis_descriptive.R"))

## Merge information between articles, Publindex and Scimago's categories 
source(here("scripts",
            "merge_quality_articles.R"))

## Merge researcher's information with institutional data, Kellis info
source(here("scripts",
            "researcher_information.R"))

## Merge data form GoogleSheets about reseacher's ORCID
source(here("scripts",
           "orcid.R"))

## Databse in MONGODB
source(here("scripts",
            "database.R"))

## Some functions that we call in the past modules
##  It's necessary encoding this module cause have a lot of special characters
eval(parse(here("scripts/functions.R"), encoding = "UTF-8"))

##### Main program #####

## Data form GoogleSheets that contains the Name and Link of each group
grupos <- read_csv("https://docs.google.com/spreadsheets/d/1gBaXHFp1NTUTeXodb4JyHqY-P-AWV5yN5-p4L1O09gk/export?format=csv&gid=0") |> 
  mutate(grupo = str_to_upper(grupo),
         grupo = stri_trans_general(str = grupo,
                                    id = "Latin-ASCII"))

## Data about researchers
researchers <- read_csv("https://docs.google.com/spreadsheets/d/1gBaXHFp1NTUTeXodb4JyHqY-P-AWV5yN5-p4L1O09gk/export?format=csv&gid=1846176083") |> 
  select(1,2) |> 
  unique() |> 
  mutate(researcher = str_to_upper(researcher),
         researcher = stri_trans_general(str = researcher,
                                         id = "Latin-ASCII")) |>  
  mutate(h_index = map(id_scholar, safely(get_profile)))|> 
  unnest_wider(h_index)

## Sometime the GoogleScholar packges reject requests and cause error.
##  In this cause we use this conditional

value = researchers$result[1]
  
if(is.na(value)){
  researchers <- researchers |> 
    mutate(h_index = 0) |> 
    select(researcher, id_scholar, h_index)
}else{
researchers <- researchers |> 
  unnest_wider(result) |> 
  select(researcher, id_scholar, h_index) |> 
  mutate(h_index = if_else(is.na(h_index), 0, h_index))
}

## Getting data (Web Scrapping)
grupo_df <- data_getting_ucla(grupos)

## Cleaning data
produccion_grupos <- data_cleaning_ucla(grupo_df)

# source(here("scripts",
#             "report.R"))

## Drop duplicates >70% similarity
produccion_actualizada <- data_tidying_ucla(produccion_grupos)

## Merge with cateogires form publindex and Scimago
produccion_actualizada[[2]][["articulos"]] <- merge_quality_articles_ucla(produccion_actualizada[[2]][["articulos"]]) 

## Statistics data
shiny_data <- data_analysis_descriptive_ucla(produccion_actualizada)

## Merge with institutional data
shiny_data[[3]] <- researcher_information_ucla(shiny_data)

## Merge with orcid data
shiny_data[[3]] <- getting_orcid(shiny_data)


#Data is uploaded to the BD
grupo_general <- as.data.frame(shiny_data[[1]])
investigadores_general <- as.data.frame(shiny_data[[3]])

saveData(grupo_general, "grupo_general")
saveData(investigadores_general, "investigadores_general")

for(i in names(shiny_data[[2]])){
  
  data <- as.data.frame(shiny_data[[2]][[i]])
  saveData(data, i)
  
}
#export_csv(shiny_data)

# # Current Journals categories for flex_dashboard
# source(here("scripts",
#             "current_categories.R"))
