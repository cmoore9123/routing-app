library(tidyverse)
library(shiny)
library(shinydashboard)
library(sf)
library(sp)
library(nominatim)
library(osrm)
library(leaflet)
library(htmltools)

options(osrm.server = 'http://dataconductor.co.uk:5000/')

shinyServer(function(session, input, output) {
  
  leaflet_output <- eventReactive(input$update, {
  
  origin <- nominatim::osm_search(query = input$origin,
                                  country_codes = 'gb',
                                  key = 'zANZRKKEiQRa6GjVIH0tmNgHuofVhv4b') %>% 
    select(lat, lon)
  
  destination <- nominatim::osm_search(query = input$dest,
                                       country_codes = 'gb',
                                       key = 'zANZRKKEiQRa6GjVIH0tmNgHuofVhv4b') %>% 
    select(lat, lon)
  
  route_data <- osrm::osrmRoute(src = c(origin$lon,origin$lat),
                               dst = c(destination$lon,destination$lat),
                               returnclass = 'sp', overview = 'full')
  
  route_metrics <- route_data@data
  
  formatted_time <- paste0(floor(route_metrics$duration / 60),
                           ' Hours ',
                           round(route_metrics$duration %% 60, 0),
                           ' Minutes')
  
  formatted_miles <- paste0(round(route_metrics$distance / 1.60934, 1), ' Miles')
  
  
  leaflet_output <-  leaflet() %>% 
    setView(lng = -2, lat = 52.5, zoom = 7) %>% 
    addTiles() %>% 
    addPolylines(data = route_data, weight = 5, color = 'purple', opacity = 0.75) %>% 
    addPopups(lng = destination$lon,
              lat = destination$lat,
              popup = paste0('Duration: ', formatted_time, '<br/>',
                             'Distance: ', formatted_miles))
  
  })
  
  output$leaflet_map <- renderLeaflet({leaflet_output()})
  
  session$onSessionEnded(stopApp)
  
  
  
})
