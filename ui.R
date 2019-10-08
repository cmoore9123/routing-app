library(tidyverse)
library(shiny)
library(shinydashboard)
library(sf)
library(sp)
library(nominatim)
library(osrm)
library(leaflet)
library(htmltools)

shinyUI(function(session, input, output) {
  
  dashboardPage(
    
    dashboardHeader(title = 'Route Planner'),
    
    dashboardSidebar(disable = TRUE),
    
    dashboardBody(
      
      column(width = 12,
             
             fluidRow(
               
               box(width = 2,
                   
                   actionButton(inputId = 'update',
                                label = 'Search')),
                   
               box(width = 4,
                   
                   textInput(inputId = 'origin', label = 'Start point')),
               
               box(width = 4,
                   
                   textInput(inputId = 'dest', label = 'Destination'))
               
             ),
             
             fluidRow(
               
               box(width = 12,
                   
                   leafletOutput(outputId = 'leaflet_map'))
             )
             
             )
    )
  )
  
})