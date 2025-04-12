#rozkład f w warunkach symulacyjnych
Zafunction(k=1,l=5,n){
  F=c()
  for (i in 1:n){
    kk=rchisq(1,k)
    ll=rchisq(1,l)
    F[i]=(kk/k)/(ll/l)
  }
  FF=rf(n,k,l)
  plot(FF,type='l',col='red')
  lines(F,type='l',col='green')
  print(mean(F))
  print((mean(FF)))
  plot(ecdf(F),col='blue')
  lines(ecdf(FF),col='red')
}

Za(k=1,l=5,n=1000)
print(plot(c(10,14,51,5,62,1,5,8,1),c(124,5,51,6,2,62,2,1),type='l',col=c('red','black')))
rt(1,3)
v=seq(from=1, to=40, by=0.5)
print(v)
plot(ecdf(seq(from=1, to=40, by=0.5)))
