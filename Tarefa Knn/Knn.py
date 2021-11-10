#Jonas Oliveira 
#Katharina Kang 
#Maraiza Adami Pereira

import pandas as pd
from matplotlib import pyplot as plt
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split
import seaborn as sns
sns.set()

pd.set_option("display.precision", 2)

# Leitura do dataset:
dataset = pd.read_csv('newDataset.csv')
dataset.head()

# Separação do Dataset (também serão utilizados em todos os modelos posteriores a este):
X = dataset.drop(['target'],axis=1)
y = dataset.target

# Separação de datasets para treino e teste:
X_train, X_test, y_train, y_test = train_test_split(X,y,random_state=42)

plt.figure(figsize=(15,7))

# Ks a serem utilizados pela curva
K = range(1,11)

# Distâncias
metrics = ['euclidean','manhattan','chebyshev']

# Testes dos modelos
for m in metrics:
    scores = []
    for k in K:
        knn = KNeighborsClassifier(n_neighbors=k, metric=m)
        knn.fit(X_train,y_train)
        scores.append(knn.score(X_test,y_test))
    sns.lineplot(K, scores)
    
for p in [1.5,3,5]:
    scores = []
    for k in K:
        knn = KNeighborsClassifier(n_neighbors=k,metric='minkowski',p=p)
        knn.fit(X_train,y_train)
        scores.append(knn.score(X_test,y_test))
    metrics.append('minkowski, p={}'.format(p))
    sns.lineplot(K, scores)

# Resultados
plt.legend(metrics)
plt.ylabel('Score')
plt.xlabel('K')
plt.show()


