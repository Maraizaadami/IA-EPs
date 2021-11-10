#Jonas Oliveira 
#Katharina Kang 
#Maraiza Adami Pereira

f <- function(net, epsilon=0.5) {
	if (net > epsilon)
		return (1)
	return (-1)
}

perceptron.train <- function(X, Y, eta=0.1, threshold=1e-2) {

	# w1 w2 w3 w4 theta
	weights = runif(min=-1, max=1, n=ncol(X)+1)

	squaredError = 2*threshold
	while (squaredError > threshold) {
		squaredError = 0
		for (i in 1:nrow(X)) {
			example = as.vector(ts(X[i,]))
			e = Y[i]

			# Sa�da do meu neur�nio
			# example = c(0, 0)
			# c(0, 0, 1) %*% weights
			# c(0, 0, 1) %*% c(w1, w2, theta)
			# net = 0*w1 + 0*w2 + 1*theta
			y = f(c(example, 1) %*% weights)

			# Erro
			E = e - y
			squaredError = squaredError + E^2

			# training...
			# w_1(t+1) = w_1(t) -eta * dE^2/dw_1
			#	dE^2/dw_1 = 2 * (e - y) * -Xp1
			# w_2(t+1) = w_2(t) -eta * dE^2/dw_2
			#	dE^2/dw_2 = 2 * (e - y) * -Xp2
			# theta(t+1) = theta(t) -eta * dE^2/dtheta
			#	dE^2/dtheta = 2 * (e - y) * -1

			dE2dweights = 2 * E * -c(example, 1)
			weights = weights - eta * dE2dweights
		}

		squaredError = squaredError / nrow(X)
		cat("Squared error = ", squaredError, "\n")
	}

	return (weights)
}

perceptron.run <- function(X, Y, weights) {
  
  cat("#esperado\tobtido\n")
  for (i in 1:nrow(X)) {
    example = as.vector(ts(X[i,]))
    #valor esperado
    e = as.numeric(ts(Y[i]))
    
    net = c(example, 1) %*% weights
    # valor obtido da fun��o f
    y = f(net)
    
    cat(e, "\t", y, "\n")
  }
}

perceptron.test <- function(eta=0.1, threshold=1e-2) {
  # ler e exibir dados
  dataset = read.table("imagem.dat", header=TRUE)
  cat("dataset:\n")
  print(dataset)
  
  classId = ncol(dataset)
  # valores esperados
  Y = dataset[,classId]
  cat("Y:\n")
  print(Y)
  
  # base de dados
  X = dataset[,1:(classId-1)]
  cat("X:\n")
  print(X)
  
  # treinamento e obten��o dos pesos
  weights = perceptron.train(X, Y, eta, threshold)
  #chama fun��o principal
  perceptron.run(X, Y, weights)
  
  # exibe pesos
  return (weights)
}






