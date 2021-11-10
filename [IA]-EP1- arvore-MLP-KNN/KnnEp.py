#Jonas Oliveira 
#Katharina Kang 
#Maraiza Adami Pereira

import pandas as pd
from statistics import mean
from matplotlib import pyplot as plt
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import KFold

import seaborn as sns
sns.set()

pd.set_option("display.precision", 2)

# Leitura do dataset:
dataset = pd.read_csv('newDataset.csv')
dataset.head()

# Separação do Dataset
X = dataset.drop(['target'], axis=1)
y = dataset.target

kf = KFold(n_splits=10, random_state=None, shuffle=False)

plt.figure(figsize=(15, 7))

# Ks a serem utilizados pela curva
K = range(1, 11)

# Distâncias
metrics = ['euclidean', 'manhattan', 'chebyshev']

# Testes dos modelos
for m in metrics:
    scores = []
    for k in K:
        knn = KNeighborsClassifier(n_neighbors=k, metric=m)
        currentScores = []
        for train_index, test_index in kf.split(X):
            X_train, X_test = X.iloc[train_index, :], X.iloc[test_index, :]
            y_train, y_test = y[train_index], y[test_index]
            knn.fit(X_train,y_train)
            knn.score(X_test, y_test)
            currentScores.append(knn.score(X_test, y_test))
        scores.append(mean(currentScores))
    sns.lineplot(K, scores)

# Resultados
plt.legend(metrics)
plt.ylabel('Score')
plt.xlabel('K')
plt.show()
