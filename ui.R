
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  titlePanel("Sample size and power calculation"),
  fluidRow(
    plotOutput("power.curve")
  ),
  fluidRow(
    column(4,
      selectInput("whichTest", "Analysis Type:",
                  choices = c("Two-sample T-test" = "t.test",
                              "Two-sample Z-test for proportions" = "prop.test")),
      numericInput("n", "Sample size:", 30, min = 2, max = Inf, step=5)),
    column(4,
      conditionalPanel(condition = "input.whichTest == 't.test'",
                       numericInput("delta", "Diffence in means:", 1, min=-Inf, max=Inf, step=1),
                       numericInput("stdDev", "SD of data:", 1, min=.Machine$double.eps, max=Inf, step=1)),
      conditionalPanel(condition = "input.whichTest == 'prop.test'",
                       numericInput("p1", "Probability in group 1", .3, min=.Machine$double.eps, max=1-.Machine$double.eps, step=.01),
                       numericInput("p2", "Probability in group 2", .7, min=.Machine$double.eps, max=1-.Machine$double.eps, step=.01))),
    column(4,
           numericInput("alpha", "alpha:", 0.05, min=0, max=1, step=0.01),
           numericInput("power", "Power:", 0.8, min=0, max=1, step=0.05))
  ),
  fluidRow(
    column(4,
      radioButtons("alternative", label = "Alternative",
                   choices = c("Two sided"="two.sided", "One sided"="one.sided"))),
    column(4,
      selectInput("solveFor", "Solve for:", c("Power", "Sample size"), selected = "Power")),
    column(4,
           p("Solve for:"),
           bsButton(inputId = "solveForPower", label = "Power"),
           bsButton(inputId = "solveForSampleSize", label = "Sample Size"))
  )
))
