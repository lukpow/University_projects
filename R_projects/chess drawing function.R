szachownica=function(n) {
  if (n>=1 && n<=26 ){
  plot(1, type = "n",xlim = c(-1, n), ylim = c(-1, n), asp = 1, xaxt = "n", yaxt = "n")
  for (i in 1:n) {
    for (j in 1:n) {
      if ((i+j)%% 2==0){
        q="purple"
      }
      else {q="black"}
      qx=c(i - 1, i, i, i - 1)
      qy=c(j - 1, j - 1, j, j)
      polygon(x=qx, y =qy,col=q, border = "black")
    }
    
  }
  w=LETTERS[1:n]
  for (i in 1:n) {
    text(i - 0.5, -0.5, labels = w[i], cex = 1.1)
  }
  e=1:n
  for (j in 1:n) {
    text(-1,j-0.5, labels = e[j], cex = 1.2)
  }
  }
  else{print("Zły zakres n!")}
}

szachownica(26)
