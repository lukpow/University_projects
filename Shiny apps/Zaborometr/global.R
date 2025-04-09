 roz=function(c1, c2) {
  rgb1 =col2rgb(c1)
  rgb2 = col2rgb(c2)
  dist = sqrt(sum((rgb1 - rgb2)^2))
  return(dist)
 }
 
 avrgb=function(col) {
   kolorki=col2rgb(col)
   r=sqrt(sum(kolorki["red",]^2/length(col)))
   g=sqrt(sum(kolorki["green",]^2/length(col)))
   b=sqrt(sum(kolorki["blue",]^2/length(col)))
   return(c(r,g,b))
 }

color_scale =colorRampPalette(c('#FF0000', '#00FFFF'))
kolz=function(n=runif(16,0,1),l=biblioteki){
  kolz=color_scale(100)[as.numeric(cut(l[[n]], breaks = 100))]
  kolzp=kolz[-c(3,5,6,7,9,10,13)]
  kolzr=kolz[-c(1,2,4,6,8,9,11,12,14,15,16)]
  kzp=avrgb(kolzp)
  kzr=avrgb(kolzr)
  prgb=rgb(kzp[1],kzp[2],kzp[3],maxColorValue =255)
  rrgb=rgb(kzr[1],kzr[2],kzr[3],maxColorValue =255)
  q=roz(prgb,rrgb)
  w=roz("#FF0000","#00FFFF")/4
  if (q>w){
    print("Widać zabory")
  }
  else{ print("Nie widać zaborów")}
  }
#zp=kolz[[1]]
#zr=kolz[[2]]

#prgb=rgb(kzp[1],kzp[2],kzp[3],maxColorValue =255)
#rrgb=rgb(kzr[1],kzr[2],kzr[3],maxColorValue =255)