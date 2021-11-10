#Jonas Oliveira 
#Katharina Kang 
#Maraiza Adami Pereira


#Probabilidade condicional: probabilidade de A dado que B ocorreu
#Bayes: P(h|D) = P(D|h).P(h)/P(D) --> h é a hipotese e D o conjunto de dados
#h map --> maxímo para hipotese 
#bayes ---> vmap = arg Max P(a1...an/vj). P(vj)/ P(a1...an)
# naives Bayes ( calcula a variavel independentemente --> Vnb = arg Max P(vj).P(ai/vj)


#recebe um conjunto de dados e um ponto de consulta onde se calcula probabilidade
naive <- function(dataset, query) {
	colId = ncol(dataset) #numero de colunas
	classes = unique(dataset[,colId]) #pega as opçoes de classe da ultima coluna

	#calculo das probabilidades
	
	P = rep(0, length(classes)) #vetor
	
	#modificao proposta para o nosso conjunto de dados : 1 linha e o 1:6 as variáveis
	#for(i in 1:nrow(teste)){
    		#naive.bayes(teste, teste[i,1:6])}

	for (i in 1:length(classes)) {
	#aplicar argmax para cada classe
	#prod_j (P( Atrr_j|SIM)) P(SIM)---> se tiver muito atributos posso aplicar log para poder somar
	#prod_j (P( Atrr_j|NÃO)) P(NÃO)
	#P_classe =suma da ultima coluna do dataset que é igual a classe que estou analisando divido pelo numero de classe do dataset
		P_classe_i = sum(dataset[,colId] == classes[i]) / nrow(dataset)
		#probabilities [i]= probabilities [i] *P_classe
		prod = 1

		for (j in 1:length(query)) { #comprimento da consulta (query)
			#Attr_j = query[j] --> atributo j recebe a consulta 

			if (query[j] != "?") {# ser diferente de nada, ou seja, tem um valor no atributo

#probabilidade de uma classe, dado o atributo
#soma da coluna do dataset quando na linha é igual ao atributo query e o conjunto de dados na coluna de classe é igual a classe que estou analisando  divido pelo numero de ve\es que a classe aparece no dataset
				P_aj_given_classe_i = sum(dataset[,j] == query[j] & dataset[,colId] == classes[i])/sum(dataset[,colId] == classes[i])
				prod = prod * P_aj_given_classe_i#Probabilidade do atributo dado uma certa classe --> resultado: #prod_j (P( Atrr_j|SIM)) P(SIM)
			}
		}
		prod = prod * P_classe_i
		P[i] = prod
	}

	ret = list() # lista de retorno
	ids = sort.list(classes)#classes
	ret$classes = classes[ids] #vetor de classes 
	ret$prob = P[ids] / sum(P[ids]) #vetor de probabilidades

	return (ret)
}

dataset = as.matrix(read.table("tenis.dat", header=T)) #primeira linha cabeçalho
r = naive(dataset, dataset[1,])# chama a função com os parametros

