getNumColDescription <- function(data){
  columns <- colnames(data)
  numeric_columns <- columns[(sapply(data, class) == 'numeric') | (sapply(data, class) == 'integer')]
  ncols_numeric <- length(numeric_columns)
  numericData <- as.data.frame(data[, numeric_columns])
  numericDataDescription <- data.frame(matrix(NA, ncol=5, nrow=ncols_numeric))
  colnames(numericDataDescription) <- c('Feature','MissingValuesCount','UniqueValuesCount','Mean','Stdev')
  numericDataDescription$Feature <- numeric_columns
  numericDataDescription$MissingValuesCount <- colSums(is.na(numericData))
  numericDataDescription$UniqueValuesCount <- apply(numericData, 2, function(colData){
    length(unique(colData))
  })
  numericDataDescription$Mean <- round(colMeans(numericData, na.rm = T),2)
  numericDataDescription$Stdev <- apply(numericData, 2, function(colData){
    round(sqrt(var(colData, na.rm = T)),2)
  })
  return(numericDataDescription)
}