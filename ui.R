library(shiny)
library(shinymaterial)
library(DT)

ui <- material_page(
  title = "XploreR",
  nav_bar_color = "teal lighten-1",
  material_side_nav(
    fixed = TRUE,
    image_source = 'side_bar.jpg',
    material_row(
      material_column(
        width = 10,
        shiny::tags$h6('Load example dataset'),
        material_dropdown(
          input_id = "example_dataset",
          label = "",
          choices = c('Titanic'='titanic','Housing'='housing','Counties'='counties','Iris'='iris')
        )
      )
    )
  ),
  material_tabs(
    tabs = c(
      'Input Data' = 'input_data_tab',
      'Data Overview' = 'data_overview_tab',
      'Feature distribution' = 'feature_distribution_tab',
      'Explore relationships' = 'explore_relationship_tab'
    )
  ),
  material_tab_content(
    tab_id = 'input_data_tab',
    material_row(
      material_column(width = 12, DTOutput('inputDataTable'))
    )
  ),
  material_tab_content(
    tab_id = 'data_overview_tab',
    material_row(
      material_column(
        width = 12,
        material_card(
          title = 'Numeric features description',
          divider = TRUE,
          DTOutput('numDataDescriptionTable')
        )
      )
    ),
    material_row(
      material_column(
        width = 12,
        material_card(
          title = 'Categorical features description',
          divider = TRUE,
          DTOutput('charDataDescriptionTable')
        )
      )
    )
  ),
  material_tab_content(
    tab_id = 'feature_distribution_tab',
    material_card(
      title = 'Histogram',
      divider = TRUE,
      #uiOutput('data_exploration_UI') 
      #tags$h5('Select Feature'),
      material_dropdown(
        input_id = 'select_feature_histogram',
        label = '',
        choices = c('a'='a')
      ),
      plotlyOutput('featureHistogram')
    )
  ),
  material_tab_content(
    tab_id = 'explore_relationship_tab',
    material_card(
      title = 'Split-Feature-Distribution',
      divider = TRUE,
      material_row(
        material_column(
          width = 6,
          material_dropdown(
            input_id = 'split_histogram_feature',
            label = '',
            choices = c('a'='a')
          )
        ),
        material_column(
          width = 6,
          material_dropdown(
            input_id = 'split_histogram_splitBy',
            label = '',
            choices = c('a'='a')
          )
        )
      ),
      material_row(
        plotlyOutput('splitFeatureHist')
      )
    )
  )
)