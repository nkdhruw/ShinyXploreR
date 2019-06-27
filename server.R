library(shiny)
library(shinymaterial)
library(DT)

sapply(list.files("R/", full.names = TRUE), source)

server <- function(input, output, session){
  
  rv <- reactiveValues()

  observeEvent(input$example_dataset, {
    inputDataFile <- paste0(file.path('data',input$example_dataset), '.rds')
    inputData <- readRDS(inputDataFile)
    rv$processedData <- processData(inputData)
    rv$spliByFeatures <- getSplitByFeatures(rv$processedData)
    
    update_material_dropdown(
      session,
      input_id = 'select_feature_histogram',
      value = getDataColNames(rv$processedData)[1],
      choices = getDataColNames(rv$processedData)
    )
    update_material_dropdown(
      session,
      input_id = 'split_histogram_feature',
      value = getDataColNames(rv$processedData)[1],
      choices = getDataColNames(rv$processedData)
    )
    update_material_dropdown(
      session,
      input_id = 'split_histogram_splitBy',
      value = 'None',
      choices = c('None',rv$spliByFeatures)
    )
  })
  
  output$splitFeatureHist <- renderPlotly({
    fH <- featureHistogram(rv$processedData, input$split_histogram_feature, input$split_histogram_splitBy)
    if(!is.null(fH[['errorMessage']])){
      return(NULL)
    }
    fH[['p']]
  })
  
  output$inputDataTable <- renderDT({
    rv$processedData
  })
  
  output$numDataDescriptionTable <- renderDT({
    getNumColDescription(rv$processedData)
  })
  
  output$charDataDescriptionTable <- renderDT({
    getCharColDescription(rv$processedData)
  })
  
  output$data_exploration_UI <- renderUI({
    material_dropdown(
      input_id = 'feature_select_distribution',
      label = NULL,
      choices = getDataColNames(rv$processedData)
    )
  })

  output$featureHistogram <- renderPlotly({
    fH <- featureHistogram(rv$processedData, input$select_feature_histogram, NULL)
    if(!is.null(fH[['errorMessage']])){
      print(fH[['errorMessage']])
      return(NULL)
    }
    fH[['p']]
  })
}