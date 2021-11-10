# Jonas Oliveira
# Katharina Kang
# Maraiza Adami Pereira

hierarchical <- function(similarities, criterion) {
	
	if (nrow(similarities) != ncol(similarities)) 
		return ("Matrix must be squared.")

	dendrogram = list() #retorna o dendograma
	partition = list() # vetor com os pontos
	for (i in 1:nrow(similarities)) partition[[i]] = c(i)

	level = 0
	dendrogram[[paste(level)]] = partition
	while (length(partition) > 1) { #reitera até ter elementos para unir
		min = Inf
		A.id = -1
		B.id = -1
		for (i in 1:(length(partition)-1)) {
			A = partition[[i]]
			for (j in (i+1):length(partition)) {
				B = partition[[j]]
				elements = similarities[A, B]
				value = 0
				if (criterion == "single") {
					value = min(elements)
				} else if (criterion == "complete") {
					value = max(elements)
				} else if (criterion == "average") {
					value = mean(elements)
				}
				if (value < min) {
					min = value
					A.id = i
					B.id = j
				}
			}
		}

		new.partition = list() 
		j = 1
		for (i in 1:length(partition)) {
			if (i != A.id && i != B.id) {
				new.partition[[j]] = partition[[i]]
				j = j + 1
			} else if (i <= A.id && i <= B.id) {
				new.partition[[j]] = c(partition[[A.id]], 
							partition[[B.id]])
				j = j + 1
			}
		}
		level = min
		dendrogram[[paste(level)]] = new.partition
		partition = new.partition
	}
	return (dendrogram)
}

table = as.matrix(read.csv2("C:/Users/jonas/Desktop/archive/matriz.csv", header=TRUE, sep=""))
res = hierarchical(similarities=table, criterion="complete")

dd <- dist(scale(table), method = "euclidean")
hc <- hclust(dd)

plot(hc, labels = NULL, hang = 0.1, 
     main = "Cluster endograma", sub = NULL,
     xlab = NULL, ylab = "Height")
print(res)
