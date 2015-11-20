library(pwr)
#
# input <- list()
# input$alpha=0.05
# input$delta=1
# input$stdDev=1
# power <- seq(0.5, 0.99, 0.01)
# n <- apply(t(power), 2, function(p){
#   power.t.test(delta=input$delta, sd=input$stdDev,
#                sig.level=input$alpha, power=p)$n})
#
# power.t.test(n=2, delta=1, sd=1,
#              sig.level=0.05)


out <- pwr.2p.test(ES.h(0.2,0.1), power=0.8)
str(out)

