power.t.test.wrapper <- function(input){
  x <- input
  if(!is.null(x$delta) &
     !is.null(x$stdDev) &
     !is.null(x$alpha) &
     !is.null(x$power) &
     !is.null(x$n))
    {
    if(x$solveFor=="Power")
      out <- power.t.test(n=x$n, delta=x$delta, sd=x$stdDev,
                          sig.level=x$alpha)
    else
      out <- power.t.test(delta=x$delta, sd=x$stdDev,
                          sig.level=x$alpha, power=x$power)
    }
  return(out)
}