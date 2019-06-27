getSplitByFeatures <- function(data){
  features <- colnames(data)
  splitByFeatures <- c()
  nrows <- nrow(data)
  for(feature in features){
    nunique_values <- length(unique(data[, feature]))
    if((nunique_values < 20)){
      splitByFeatures <- c(splitByFeatures, feature)
    }
  }
  return(splitByFeatures)
}