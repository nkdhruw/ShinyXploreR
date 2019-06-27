getColMode <- function(colData){
  return(names(which.max(table(colData))))
}