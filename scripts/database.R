library(mongolite)

saveData <- function(data, collectionName) {
  #Conexión a la base de datos
  db <- mongo(collection = collectionName,
              db = "MargaretDB",
              url = "mongodb://localhost:27017",
              verbose = FALSE,
              options = ssl_options()
              )
  #data <- as.data.frame(data)
  db$insert(data)
}