getCharColDescription <- function(data){
  columns <- colnames(data)
  character_columns <- columns[(sapply(data, class) == 'character') | (sapply(data, class) == 'factor')]
  ncols_character <- length(character_columns)
  characterData <- as.data.frame(data[, character_columns])
  characterDataDescription <- data.frame(matrix(NA, ncol=4, nrow=ncols_character))
  colnames(characterDataDescription) <- c('Feature','MissingValuesCount','UniqueValuesCount','MostFrequentValue')
  characterDataDescription$Feature <- character_columns
  characterDataDescription$MissingValuesCount <- colSums(is.na(characterData))
  characterDataDescription$MostFrequentValue <- apply(characterData, 2, getColMode)
  characterDataDescription$UniqueValuesCount <- apply(characterData, 2, function(colData){
    length(unique(colData))
  })
  return(characterDataDescription)
}