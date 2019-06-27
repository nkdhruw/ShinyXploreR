getDataColNames <- function(data){
  columns <- colnames(data)
  names(columns) <- columns
  columns
}
