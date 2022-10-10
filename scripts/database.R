library(mongolite)

saveData <- function(data, collectionName) {
  #Conexión a la base de datos
  db <- mongo(collection = collectionName,
              db = "Margaret",
              url = "mongodb://localhost:27017",
              verbose = FALSE,
              options = ssl_options()
              )
  #data <- as.data.frame(data)
  db$drop()
  db$insert(data)
}
