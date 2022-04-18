#OPERACIONES SOBRE CONJUNTOS

v <- c(5,11,29,37,51)

sapply(v,function(elem){
  if(elem %% 10>3) elem^3
  else 0
})

m <- matrix(1:12,ncol = 3, nrow = 4)

m * 4
apply(m, 1, sum)