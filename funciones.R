#FUNCIONES

sayHello <- function(){
  print("Hello World")
}

risk2string <- function(risk){
  if(risk <= 5) return ("low")
  ifelse(risk < 7.5, "medium", "high")
}

risk2string(8)
