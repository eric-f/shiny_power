require("plyr")
require("dplyr")
require("ggplot2")
require("pwr")

power.wrapper <- function(input){
  x <- input
  if(!is.null(x$delta) &
     !is.null(x$stdDev) &
     !is.null(x$alpha) &
     !is.null(x$power) &
     !is.null(x$n))
    {
    if(x$solveFor=="Power")
      out <- power.t.test(n=x$n, delta=x$delta, sd=x$stdDev,
                          sig.level=min(1,max(x$alpha,1e-10,na.rm=T)),
                          alternative=x$alternative)
    else
      out <- power.t.test(delta=x$delta, sd=x$stdDev,
                          sig.level=min(1,max(x$alpha,1e-10,na.rm=T)),
                          power=min(1.0,max(x$power,0.1,na.rm=T)),
                          alternative=x$alternative)
  }
  return(out)
}


# calc.power.n.curve <- function(input){
#   power <- seq(0.3, 0.99, 0.01)
#   n <- apply(t(power), 2, function(p){
#     power.t.test(delta=input$delta, sd=input$stdDev,
#                  sig.level=input$alpha, power=p,
#                  alternative=input$alternative)$n})
#   n <- switch(input$id,
#   t.test = apply(t(power), 2, function(p){
#     power.t.test(delta=input$delta, sd=input$stdDev,
#                  sig.level=input$alpha, power=p,
#                  alternative=input$alternative)$n}),
#   prop.test = apply(t(power), 2, function(p){
#     power.prop.test(p1=input$p1, p2=input$p2,
#                  sig.level=input$alpha, power=p,
#                  alternative=input$alternative)$n})
#   )
#   return(data_frame(power=power, n=n))
# }

plot.power.n <- function(input){
  power <- seq(0.3, 0.99, 0.01)
  n <- apply(t(power), 2, function(p){
    power.t.test(delta=input$delta, sd=input$stdDev,
                 sig.level=input$alpha, power=p,
                 alternative=input$alternative)$n})
  pwrCurve <- ggplot(data_frame(power=power, n=n)) +
    geom_line(aes(y=power, x=n)) +
    labs(y="Power", x="Number of observations per group") +
    ylim(c(0, 1)) +
    xlim(range(n))
  if(between(input$n, min(n), max(n)))
    pwrCurve <- pwrCurve +
    annotate("segment", x=input$n, xend=input$n,
             y=0, yend=1, col="red", linetype=2)
    pwrCurve <- pwrCurve +
    annotate("segment", x=min(n), xend=max(n),
             y=input$power, yend=input$power, col="red", linetype=2)
  return(pwrCurve)
}
