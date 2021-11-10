#Jonas Oliveira 
#Katharina Kang 
#Maraiza Adami Pereira

# Load libraries
import pandas as pd
from statistics import mean
from sklearn.tree import DecisionTreeClassifier # Import Decision Tree Classifier
from sklearn.model_selection import cross_val_score, cross_val_predict, KFold
from sklearn import metrics #Import scikit-learn metrics module for accuracy calculation

from sklearn.tree import export_graphviz
from matplotlib import pyplot as plt
from six import StringIO
from IPython.display import Image  
import time
import pydotplus

import seaborn as sns
sns.set()
plt.figure(figsize=(15, 7))

df = pd.read_csv('newDataset.csv')

feature_cols = [
    'time',
    'androidSensorAccelerometerMean',
    'androidSensorAccelerometerMin',
    'androidSensorAccelerometerMax',
    'androidSensorAccelerometerStd',
    'androidSensorGyroscopeMean',
    'androidSensorGyroscopeMin',
    'androidSensorGyroscopeMax',
    'androidSensorGyroscopeStd',
    'soundMean',
    'soundMin',
    'soundMax',
    'soundStd',
]

X = df.drop(['target'], axis=1)
y = df.target

kf = KFold(n_splits=10, random_state=None, shuffle=False)


def generateGraph(clf, name):
    train_indexes = next(kf.split(X), None)

    X_train = X.iloc[train_indexes[1]]
    y_train = y.iloc[train_indexes[1]]
    clf = clf.fit(X_train, y_train)

    dot_data = StringIO()
    export_graphviz(
        clf,
        out_file=dot_data,
        filled=True,
        rounded=True,
        special_characters=True,
        feature_names=feature_cols,
        class_names=['Car', 'Still', 'Train', 'Bus', 'Walking'],
    )

    graph = pydotplus.graph_from_dot_data(dot_data.getvalue())
    graph.write_png(name+time.strftime("%Y%m%d-%H%M%S")+'.png')
    Image(graph.create_png())


criterions = ['gini', 'entropy']
maxDepthValues = range(4, 10)
minSamplesLeafValues = range(1, 6)

for c in criterions:
    scores = []
    for depthValue in maxDepthValues:
        clf = DecisionTreeClassifier(criterion=c, max_depth=depthValue)
        scores.append(mean(cross_val_score(clf, X, y, cv=10)))
        generateGraph(clf, c+' depth '+str(depthValue))
    sns.lineplot(maxDepthValues, scores)

plt.legend(criterions)
plt.ylabel('Score')
plt.xlabel('Max depth')
plt.show()

sns.set()
plt.figure(figsize=(15, 7))

for c in criterions:
    scores = []
    for minSamplesLeafValue in minSamplesLeafValues:
        clf = DecisionTreeClassifier(
            criterion=c, min_samples_leaf=minSamplesLeafValue
        )
        scores.append(mean(cross_val_score(clf, X, y, cv=10)))
        generateGraph(clf, c+' samples '+str(minSamplesLeafValue))
    sns.lineplot(minSamplesLeafValues, scores)

plt.legend(criterions)
plt.ylabel('Score')
plt.xlabel('min samples leaf')
plt.show()





