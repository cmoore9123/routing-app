library(tidyverse)
library(shiny)
library(shinydashboard)
library(sf)
library(sp)
library(nominatim)
library(osrm)
library(leaflet)
library(htmltools)
library(shinycssloaders)

shinyUI(function(session, input, output) {
  
  dashboardPage(
    
    dashboardHeader(disable = TRUE),
    
    dashboardSidebar(disable = TRUE),
    
    dashboardBody(
      
      tags$head((
        tags$style(HTML('
                        .content {
                        padding: 1px;
                        }'))
      )),
      
      column(width = 12,
             
             
             fluidRow(
               
               box(width = 12,
               
               splitLayout(
                   
                   actionButton(inputId = 'update',
                                label = 'Search'),
                   
                   textInput(inputId = 'origin', label = 'Start point'),
                   
                   textInput(inputId = 'dest', label = 'Destination')
                   
               )
               )
                   
               
             ),
             
             fluidRow(
               
               box(width = 12, 
                   
                   shinycssloaders::withSpinner(leafletOutput(outputId = 'leaflet_map'))
                   
                  )
             )
             
             )
    )
    
    
  )
  
})