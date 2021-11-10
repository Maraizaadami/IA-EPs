#Jonas Oliveira 
#Katharina Kang 
#Maraiza Adami Pereira

# Import required libraries
import pandas as pd
from statistics import mean
import matplotlib.pyplot as plt
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import cross_val_score

import seaborn as sns
sns.set()

df = pd.read_csv('newDataset.csv')

# Separação do Dataset
X = df.drop(['target'], axis=1)
y = df.target

plt.figure(figsize=(15, 7))

hiddenLayer = range(3, 15)

scores = []
for h in hiddenLayer:
    mlp = MLPClassifier(
        hidden_layer_sizes=(13, h, 13),
        activation='relu',
        solver='adam',
        max_iter=1000,
    )
    meanScore = mean(cross_val_score(mlp, X, y, cv=10, n_jobs=-1))
    scores.append(meanScore)
    print(meanScore)

print(scores)
sns.lineplot(hiddenLayer, scores)

plt.ylabel('Score')
plt.xlabel('Neurônios da camada escondida')
plt.show()
