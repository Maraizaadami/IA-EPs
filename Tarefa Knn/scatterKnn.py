#Jonas Oliveira 
#Katharina Kang 
#Maraiza Adami Pereira

import pandas as pd
from matplotlib import pyplot as plt
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split
import seaborn as sns
sns.set()

dictionariy= {'Car': 1,'Still': 2, 'Train': 3, 'Bus': 4, 'Walking': 5}

pd.set_option("display.precision", 2)

# Leitura do dataset:
dataset = pd.read_csv('newDataset.csv')
dataset.target = [dictionariy[item] for item in dataset.target]
dataset.head()

# Separação do Dataset (também serão utilizados em todos os modelos posteriores a este):
X = dataset.drop(['target'],axis=1)
y = dataset.target

# Separação de datasets para treino e teste:
X_train, X_test, y_train, y_test = train_test_split(X,y,random_state=42)

plt.figure(figsize=(15,7))


knn = KNeighborsClassifier(n_neighbors=1, metric='manhattan')
knn.fit(X_train,y_train)
y_pred = knn.predict(X_test)    

ax = plt.gca()
graphData = X_test.join(y_test, how='outer')

scatter = plt.scatter(
    X_test['time'],
    X_test['androidSensorAccelerometerMax'],
    c=y_pred,
    cmap='coolwarm',
    alpha=0.7,
)

plt.legend(handles=scatter.legend_elements()[0], labels=dictionariy)
plt.show()

plt.figure(figsize=(15,7))
scatter = plt.scatter(
    X['time'],
    X['androidSensorAccelerometerMax'],
    c=y,
    cmap='coolwarm',
    alpha=0.7,
)
plt.legend(handles=scatter.legend_elements()[0], labels=dictionariy)

plt.show()



