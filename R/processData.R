processData <- function(data){
  features <- colnames(data)
  nrows <- nrow(data)
  for(feature in features){
    nunique_values <- length(unique(data[, feature]))
    if((nunique_values < 0.01 * nrows) & (nunique_values < 20)){
      data[, feature] <- as.character(data[, feature])
    }
  }
  return(data)
}