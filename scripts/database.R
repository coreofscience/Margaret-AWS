library(mongolite)

options(mongodb = list(
  "host" = "localhost:27017",
  #"username" = "myuser",
  #"password" = "mypassword"
))
databaseName <- "MargaretDB"
#collectionName <- "margaret"

saveData <- function(data, collectionName) {
  #Conexión a la base de datos
  db <- mongo(collection = collectionName,
              url = sprintf(
                "mongodb+srv://%s:%s@%s/%s",
                options()$mongodb$host,
                databaseName
              ),
              options = ssl_options(weak_cert_validation = TRUE))
  # Insert the data into the mongo collection as a data.frame
  data <- as.data.frame(t(data))
  db$insert(data)
}