#Zad.4.

Krzywa=function(r_0=1,omega=1,k=1){
  t=seq(from=0,to=2*pi,by=0.05)
  plot(r_0*sin(k*t)*cos(omega*t),r_0*sin(k*t)*sin(omega*t),xlab="x",ylab="y",type='l',asp = 1)
}
Krzywa(r=10,omega=-31,k=2)
