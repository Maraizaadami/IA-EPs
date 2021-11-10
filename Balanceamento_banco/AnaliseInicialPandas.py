# Jonas Oliveira
# Katharina Kang
# Maraiza Adami Pereira

import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

pd.set_option("display.precision", 2)

# Leitura do dataset:
dataset = pd.read_csv('dataset_5secondWindow2.csv')
dataset.head()

#verificar se existem valores nulos
dataset.info()

# verificar linhas duplicadas:
dataset.duplicated().sum()

# Excluir as variáveis de desvio padrão:
to_drop = [c for c in dataset.columns if '#std' in c]
dataset.drop(to_drop, axis=1, inplace=True)
dataset.head()


# Verificação da distribuição das variáveis:
plt.figure(figsize=(10,15))

plt.subplot(4,1,1)
sns.distplot(dataset.iloc[:,0])
plt.xlabel('Time')

plt.subplot(4,1,2)
for i in range(1,4):
    sns.distplot(dataset.iloc[:,i])
plt.legend(dataset.iloc[:,1:4].columns)
plt.xlabel('Accelerometer')

plt.subplot(4,1,3)
for i in range(4,7):
    sns.distplot(dataset.iloc[:,i])
plt.legend(dataset.iloc[:,4:7].columns)
plt.xlabel('Gyroscope')

plt.subplot(4,1,4)
for i in range(7,10):
    sns.distplot(dataset.iloc[:,i])
plt.legend(dataset.iloc[:,7:10].columns)
plt.xlabel('Sound')

plt.show()
