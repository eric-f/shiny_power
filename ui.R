
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(navbarPage("Sample size and power calculation", id="whichTest",
  tabPanel("About", value = "about",
           "Some text descriptions to come..."),
  navbarMenu("Two-Sample Comparison",
    ## Panel for Two Sample T-test ---------------------------------------------
    tabPanel("Two-Sample T-test", value = "t.test",
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
         # textOutput("print.input"),
          plotOutput("t.test.power.curve")
        ))),
    ## Panel for Z-test for two proportions ------------------------------------
    tabPanel("Z-test for two proportions", value = "prop.test",
      sidebarLayout(
       sidebarPanel(
         h4("Z-test for two proportions"),
         numericInput("n", "Sample size:", 30, min = 2, max = Inf, step=5),
         numericInput("p1", "Probability in group 1", .4, min=.Machine$double.eps, max=1-.Machine$double.eps, step=.01),
         numericInput("p2", "Probability in group 2", .5, min=.Machine$double.eps, max=1-.Machine$double.eps, step=.01),
         numericInput("alpha", "alpha:", 0.05, min=0, max=1, step=0.01),
         numericInput("power", "Power:", 0.8, min=0, max=1, step=0.05),
         selectInput("solveFor", "Solve for:", c("Power", "Sample size"), selected = "Power"),
         radioButtons("alternative", label = "Alternative",
                      choices = c("Two sided"="two.sided", "One sided"="one.sided"))
       ),
       # Show a plot of the generated distribution
       mainPanel(
         # textOutput("print.input2"),
         plotOutput("prop.test.power.curve")
       )
       ))
  )
))
