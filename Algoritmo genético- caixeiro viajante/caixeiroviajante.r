# Jonas Oliveira
# Katharina Kang
# Maraiza Adami Pereira


fitness <- function(subject, distances) {
  
  sum = 0
  for (i in 1:(length(subject)-1)) {
    sum = sum + distances[subject[i], subject[i+1]]
  }
  sum = sum + distances[subject[length(subject)], subject[1]]
  return (1/sum)
}

organize.children <- function(child) {
  ids = setdiff(1:length(child), child)
  if (length(ids) == 0) return (child)
  
  # ids = [4 6]
  # child = [1 2 3 1 5 1 7]
  # pos = [1 4 6]
  change.positions = c()
  for (i in 1:length(child)) {
    pos = which(child == i)
    if (length(pos) > 1) {
      change.positions = c(change.positions,
                           sample(pos, size=length(pos)-1))
    }
  }
  # change.positions = [1 6]
  # child = [6 2 3 4 5 1 7]
  child[change.positions] = ids
  
  return (child)
}

mutation <- function(child, mutation.prob) {
  
  if (runif(min=0, max=1, n=1) < mutation.prob) {
    ids = sample(1:length(child), size=2)
    aux = child[ids[1]]
    child[ids[1]] = child[ids[2]]
    child[ids[2]] = aux
  }
  
  return (child)
}

ga.model <- function(distances, popsize=100, ngenerations=100, mutation.prob=0.01, elitism= TRUE) {
  
  output = NULL
  ncities = nrow(distances)
  population = NULL
  fitness = rep(0, popsize)
  for (i in 1:popsize) {
    chromossome = sample(1:ncities)
    population = rbind(population, chromossome)
  }
  
  for (i in 1:ngenerations) {
    
    for (j in 1:popsize) {
      fitness[j] = fitness(population[j,], distances)
    }
    
    output = rbind(output, cbind(i, mean(fitness), sd(fitness)))
    
    children = NULL
    for (j in 1:(popsize/2)) {
      parentIds = sample(1:popsize, prob=fitness/sum(fitness), size=2)
      parent1 = population[parentIds[1],]
      parent2 = population[parentIds[2],]
      
      # Crossover
      child1 = numeric(ncities)
      child2 = numeric(ncities)
      bitmap = sample(0:1,10, replace = TRUE)
      i<-0
      for (bit in bitmap) {
        i<-i+1
        if (bit == 1) {
          child1[i] <- parent1[i]
        }
      }
      
      auxElements <- vector()
      for (element in parent2) {
        if (!is.element(element, child1)) {
          auxElements <- c(auxElements, element)
        }
      }
      
      i<-0
      for (element in child1) {
        i<-i+1
        if (element == 0) {
          child1[i] = auxElements[1]
          auxElements = auxElements[-1]
        }
      }
      
      #crossover child2
      
      bitmap = sample(0:1,10, replace = TRUE)
      i<-0
      for (bit in bitmap) {
        i<-i+1
        if (bit == 1) {
          child2[i] <- parent2[i]
        }
      }
      
      auxElements <- vector()
      for (element in parent1) {
        if (!is.element(element, child2)) {
          auxElements <- c(auxElements, element)
        }
      }
      
      i<-0
      for (element in child2) {
        i<-i+1
        if (element == 0) {
          child2[i] = auxElements[1]
          auxElements = auxElements[-1]
        }
      }

      child1 = organize.children(child1)
      child2 = organize.children(child2)
      
      child1 = mutation(child1, mutation.prob)
      child2 = mutation(child2, mutation.prob)
      
      children = rbind(children, child1)
      children = rbind(children, child2)
    }
    
    if (elitism){
      bestFitnessId = which.max(fitness)
      childId = sample(1:popsize, size=1)
      children[childId,] = population[bestFitnessId,] # Elitismo  
    } else {
      childIds = sample(1:popsize, size=popsize/4)
      for (id in childIds) {
        children[id,] = population[id,]
      }
    }
    
    population = children
  }
  
  return (output)
}


dist = matrix(runif(min=0.1, max=10, n=10*10), nrow = 10)
for(i in 1:10) { dist[i,i] = 0 }

output = ga.model(distances = dist, ngenerations = 1000, elitism = TRUE)

View(output)
plot(output[, c(1,2)])
