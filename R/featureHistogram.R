featureHistogram <- function(data, feature, splitBy){
  print(splitBy)
  if(!is.null(splitBy)){
    if(splitBy == 'None'){
      splitBy = NULL
    }
  }
  errorMessage <- NULL
  if(is.null(splitBy)){
    x <- data[, feature]
    p <- plot_ly(x = x, type = 'histogram', histnorm = 'probability')
    return(list(errorMessage = errorMessage, p = p))
  } else {
    splitByClass <- class(data[,splitBy])
    splitByFactors <- unique(data[, splitBy])
    if(length(splitByFactors) > 50){
      errorMessage <- 'No. of factors in the splitBy column should be less than 50'
      return(list(errorMessage = errorMessage))
    }else{
      p <- plot_ly(type='histogram') %>%
        layout(xaxis = list(title = feature),
               yaxis = list (title = "Probability"))

      for(i in 1:length(splitByFactors)){
        x <- data[data[,splitBy]==splitByFactors[i], feature]
        print(length(x))
        p <- add_trace(p, x = x, name = splitByFactors[i], type = 'histogram', histnorm = 'probability')
      }
      return(list(errorMessage = errorMessage, p = p))
    }
  }

}
