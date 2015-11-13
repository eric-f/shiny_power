
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source("global.R")

shinyServer(function(input, output) {


  out <- reactive(power.t.test.wrapper(input))

  output$t.test.power <- renderText({
    out()$power
  })
  output$n <- renderText(
    ceiling(out()$n)
  )

})
