library(mongolite)

loadData <- function(collectionName) {
  #Conexión Base de datos
  db <- mongo(collection = collectionName,
              db = "Margaret",
              url = "mongodb://localhost:27017",
              verbose = FALSE,
              options = ssl_options()
  )
  # Leer todas las entradas
  data <- db$find()
  data
}