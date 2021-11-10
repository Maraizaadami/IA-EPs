# Jonas Oliveira
# Katharina Kang
# Maraiza Adami Pereira

#arvores de decisao : desenham uma espécie de caminho a ser percorrido para alcançar um determinado objetivo.
#https://cienciaenegocios.com/o-que-e-arvore-de-decisao-decision-tree-linguagem-r/


# Pacotes a serem utilizados neste post
library(dplyr)
library(readr)
library(rpart)
library(rpart.plot)
library(xtable)

# Lendo os dados do titanic a partir de repositório, selecionando e tratando variáveis
titanic <- "https://gitlab.com/dados/open/raw/master/titanic.csv" %>%
  read_csv %>% 
  select(survived, embarked, sex, 
         sibsp, parch, fare) %>%  
  mutate(
    survived = as.factor(survived),
    embarked = as.factor(embarked),
    sex = as.factor(sex)) 

### Dicionário dos dados
#variável taget é survived, e indica se o indivíduo sobreviveu (=1), ou não (=0). 
#indivíduo embarcou (embarked)
#o gênero (sex)
#número de irmãos/cônjuges a bordo (sibsp = Number of Siblings/Spouses)
#número de pais/filhos a bordo (parch = Number of Parents/Children) 
#valor da tarifa por passageiro (fare).
###########

# Mostrando o head dos dados
print(xtable(head(titanic)), type = "html", digits = 2, include.rownames=FALSE)

# Separar os dados em treino e teste
set.seed(100)
.data <- c("training", "test") %>%
  sample(nrow(titanic), replace = T) %>%
  split(titanic, .)

# Criar a árvore de decisão
rtree_fit <- rpart(survived ~ ., 
          .data$training
          )
rpart.plot(rtree_fit)
