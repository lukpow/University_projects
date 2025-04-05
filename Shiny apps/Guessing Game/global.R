przest=function(r) {
  if ((r%% 4 == 0 && r%% 100 != 0) || (r %% 400 == 0)) {
    return(29)  
  } else {
    return(28)  
  }
}