
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Power and Sample Size Calculator"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h4("Two-sample t-test"),
      numericInput("n", "Sample size:", 30, min = 2, max = Inf, step=5),
      numericInput("delta", "Diffence in means:", 1, min=-Inf, max=Inf, step=1),
      numericInput("stdDev", "SD of data:", 1, min=.Machine$double.eps, max=Inf, step=1),
      numericInput("alpha", "alpha:", 0.05, min=0, max=1, step=0.01),
      numericInput("power", "Power:", 0.8, min=0, max=1, step=0.05),
      selectInput("solveFor", "Solve for:", c("Power", "Sample size"), selected = "Power"),
      radioButtons("alternative", label = "Alternative",
                   choices = c("Two sided"="two.sided", "One sided"="one.sided"))
    ),

    # Show a plot of the generated distribution
    mainPanel(
       textOutput("t.test.power"),
       textOutput("n"),
       plotOutput("t.test.power.curve")
    )
  )
))
