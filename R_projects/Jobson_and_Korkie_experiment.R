library(quantmod)
probka_ns=function(u,v,n){
  v=0.5*(v+t(v))
  q=eigen(v)$vectors
  w=eigen(v)$values
  c=c()
  for (i in 1:length(w)){
    if (w[i]>=0){
      c[i]=w[i]
    }
    else{ 
      c[i]=0
    }
  }
  
  v=q%*%diag(c)%*%t(q)
  v=v+diag(runif(nrow(v),0,1e-3))  
  z=matrix(rnorm(n*length(u),0,1),nrow=n)
  L=chol(v)
  s=u+L%*%t(z) 
  
  
  return(t(s))
}

automat_mod=function(o){
  danl=list()
  dan=data.frame(matrix(ncol=length(o),nrow=251))
  for (i in 1:length(o)){
    getSymbols(o[i])
    d=get(o[i])["2024-08-28/2025-02-01"]
    danl[[o[i]]]=d[,6]
  }
  dan=do.call(merge,danl)
  
  dan=data.frame(Date=index(dan),coredata(dan))
  dan=na.omit(dan)
  colnames(dan)[2:ncol(dan)]=o
  
  proste=data.frame(matrix(ncol = length(o), nrow =nrow(dan)-1))
  
  logz=data.frame(matrix(ncol = length(o), nrow =nrow(dan)-1))
  
  for (i in 1:length(o)) {
    proste[,i]=(dan[[i+1]][-1]-dan[[i+1]][-nrow(dan)])/dan[[i+1]][-nrow(dan)]
    logz[,i]=log(dan[[i+1]][-1]/dan[[i+1]][-nrow(dan)])
  }
  colnames(proste)=colnames(dan)[2:ncol(dan)]
  
  
  
  colnames(logz)=colnames(dan)[2:ncol(dan)]
  
  
  
  prsrednie=c()
  for(i in 1:length(o)){
    prsrednie[i]=mean(proste[[i]])
  }
  
  
  
  logsrednie=c()
  for(i in 1:length(o)){
    logsrednie[i]=mean(logz[[i]])
  }
  
  zwracacz=list(
    proste=proste,proste_srednie=prsrednie,kowariancja_proste=cov(proste),korelacja_proste=cor(proste),
    log=logz,log_srednie=logsrednie,kowariancja_log=cov(logz),korelacja_log=cor(logz))
  
  
  return(zwracacz)
}


ef=function(u,v,m){
  j=matrix(rep(1,nrow(v)),nrow=1)
  u=matrix(u,nrow=1)
  A=rep(1,nrow(v))%*%solve(v)%*%t(u)
  B=u%*%solve(v)%*%t(u)
  C=j%*%solve(v)%*%t(j)
  gamma=(C%*%m-A)/(B%*%C-A%*%A)
  lambda=(B-A%*%m)/(B%*%C-A%*%A)
  w=gamma%*%u%*%solve(v)+lambda%*%j%*%solve(v)
  sigma=(w%*%v%*%t(w))^(1/2)
  return(list(wagi=w,sd=sigma))
}
dane=automat_mod(c("CDR.WA","BLO.WA","EA"))
length(dane$log[,1])
sr=dane$log_srednie

vv=dane$kowariancja_log
r=seq(min(sr),max(sr),length.out=50)
effront=data.frame(Risk=numeric(),Return=numeric())

for (m in r){
  effront=rbind(effront,data.frame(Risk=ef(sr,vv,m)[2],Return=m))
}

plot(effront,xlim=c(0,0.04),ylim=c(-0.03,0.02),type='l')
#plot(effront,type='l')
kolorki=rainbow(50)
for (j in 1:50){
  proba=probka_ns(sr,vv,100)
  srednie=c()
  for (i in 1:3){
    srednie[i]=mean(proba[,i])
  }
  v=cov(proba)
  #+diag(1e-6, ncol(proba))
  r=seq(min(srednie),max(srednie),length.out=50)
  effront=data.frame(Risk=numeric(),Return=numeric())
  for (m in r){
    effront=rbind(effront,data.frame(Risk=ef(srednie,v,m)[2],Return=m))
  }
  #points(effront,col="red",type='l')
  points(effront,col=kolorki[j],type='l')
}

