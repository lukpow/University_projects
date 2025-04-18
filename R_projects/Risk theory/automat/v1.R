library(quantmod)

automat=function(o){
  danl=list()
  dan=data.frame(matrix(ncol=length(o),nrow=251))
  for (i in 1:length(o)){
    getSymbols(o[i])
    d=get(o[i])["2024-02-01/2025-02-01"]
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
o=c("MSFT","KO","AMN")
qq=automat(o)
qq
