#Jonas Oliveira 
#Katharina Kang 
#Maraiza Adami Pereira


library(arules)

error_metric=function(CM) {
  TN =CM[1,1]
  TP =CM[2,2]
  FP =CM[1,2]
  FN =CM[2,1]
  precision =(TP)/(TP+FP)
  accuracy_model  =(TP+TN)/(TP+TN+FP+FN)
  print(paste("Precision value of the model: ",round(precision,2)))
  print(paste("Accuracy of the model: ",round(accuracy_model,2)))
}

naive <- function(dataset, query) {
	colId = ncol(dataset)
	classes = unique(dataset[,colId])

	P = rep(0, length(classes))
	for (i in 1:length(classes)) {
		P_classe_i = sum(dataset[,colId] == classes[i]) / nrow(dataset)
		prod = 1
		for (j in 1:length(query)) {
			if (query[j] != "?") {
				P_aj_given_classe_i = sum(dataset[,j] == query[j] & dataset[,colId] == classes[i])/sum(dataset[,colId] == classes[i])
				prod = prod * P_aj_given_classe_i
			}
		}
		prod = prod * P_classe_i
		P[i] = prod
	}
	ret = list()
	ids = sort.list(classes)
	ret$classes = classes[ids]
	ret$prob = P[ids] / sum(P[ids])

	return (ret)
}

treino = read.table("treino.dat", header=T)
teste = read.table("teste.dat", header=T)
 
alldata <- rbind(treino, teste)

dataDisc <- discretizeDF(alldata, methods = list(
  Temperatura = list(method = "interval", breaks = 4, 
                     labels = c("baixo","medio", "alto", "muitoAlto"))),
  default = list(method = "none")
)


discretizedTreino = discretizeDF(treino, methods = dataDisc)
discretizedTeste = discretizeDF(teste, methods = dataDisc)

testeMatrix = as.matrix(discretizedTeste)
treinoMatrix = as.matrix(discretizedTreino)

responseTable = matrix(0, 2, 2)

for(i in 1:nrow(testeMatrix)){
  res = naive(treinoMatrix[,2:7], testeMatrix[i,2:6])
  print(testeMatrix[[i,1]])
  print(paste("Esperado: ",testeMatrix[[i, 7]], sep=""))
  expected_value = ifelse(testeMatrix[[i, 7]] == "DENGUE", 1 , 0)
  predicted_value = ifelse(as.numeric(res$prob[[1]]) > as.numeric(res$prob[[2]]), 1, 0)
  print(paste("Obtido: ",ifelse(predicted_value == "1", "DENGUE", "OUTRA"), sep=""))
  
  if (predicted_value ==1  && expected_value == 1) {
    responseTable[2,2] = responseTable[2,2] + 1
  }
   
  if (predicted_value == 0 && expected_value == 0) {
    responseTable[1,1] = responseTable[1,1] + 1
  } 
  
  if (predicted_value == 1 && expected_value == 0) {
    responseTable[1,2] = responseTable[1,2] + 1
  } 
  
  if (predicted_value == 0 && expected_value == 1) {
    responseTable[2,1] = responseTable[2,1] + 1
  } 
}
print(responseTable)
error_metric(responseTable)

