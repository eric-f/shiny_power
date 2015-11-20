
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
source("global.R")

shinyServer(function(input, output, session) {


  out <- reactive(power.t.test.wrapper(input))
  t.test.power.curve <- reactive(plot.power.t.test(input))

  ## update input fields -------------------------------------------------------
  observe({
    if(input$solveFor=="Sample size"){
      updateNumericInput(session, "n", value=ceiling(out()$n))
    }
    if(input$solveFor=="Power"){
      updateNumericInput(session, "power", value=round(out()$power, 3),
                         min=input$alpha)
    }
  })

  ## output --------------------------------------------------------------------
  output$t.test.power.curve <- renderPlot({
    t.test.power.curve()
  })
})
