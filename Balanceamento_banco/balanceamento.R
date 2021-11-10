#Coluna time
#1)ordenar a base com a coluna desejada:
#dataset_1 <- dataset_1[order(dataset_1$time),]
#View(dataset_1)

#2)verificar se tem outlier na coluna:
#quando Z>+3 ou Z<-3 eu retiro da coluna
#ztime <- scale(dataset_1$time)
#View(ztime)

#3)retirar os outliers da coluna
#dataset_1 <- dataset_1[-5773:-5893,] 
#View(dataset_1)
#repetir o procedimento para as demais colunas
#-------------------------------------------------------
#Coluna androidSensorAccelerometerMean
#1)
#dataset_1 <- dataset_1[order(dataset_1$androidSensorAccelerometerMean),]
#View(dataset_1)

#2)
#ztime <- scale(dataset_1$androidSensorAccelerometerMean)
#View(ztime)

#3)
#dataset_1 <- dataset_1[c(-1:-5,-5614:-5772),]
#View(dataset_1)
#-------------------------------------------------------------------------------
#Coluna androidSensorAccelerometerMin
#1)
#dataset_1 <- dataset_1[order(dataset_1$androidSensorAccelerometerMin),]
#View(dataset_1)

#2)
#z2 <- scale(dataset_1$androidSensorAccelerometerMin)
#View(z2)

#3)
#dataset_1 <- dataset_1[-1:-86,]
#View(dataset_1)
#-------------------------------------------------------------------------------
#Coluna androidSensorAccelerometerMax
#1)
#dataset_1 <- dataset_1[order(dataset_1$androidSensorAccelerometerMax),]
#View(dataset_1)

#2)
#z3 <- scale(dataset_1$androidSensorAccelerometerMax)
#View(z3)

#3)
#dataset_1 <- dataset_1[-5404:-5522,]
#View(dataset_1)
#-------------------------------------------------------------------------------
#Coluna androidSensorAccelerometerStd
#1)
#dataset_1 <- dataset_1[order(dataset_1$androidSensorAccelerometerStd),]
#View(dataset_1)

#2)
#z4 <- scale(dataset_1$androidSensorAccelerometerStd)
#View(z4)

#3)
#dataset_1 <- dataset_1[-5282:-5403,]
#View(dataset_1)
#-------------------------------------------------------------------------------
#Coluna androidSensorGyroscopeMean
#1)
#dataset_1 <- dataset_1[order(dataset_1$androidSensorGyroscopeMean),]
#View(dataset_1)

#2)
#z5 <- scale(dataset_1$androidSensorGyroscopeMean)
#View(z5)

#3)
#dataset_1 <- dataset_1[-5081:-5281,]
#View(dataset_1)
#-------------------------------------------------------------------------------
#Coluna androidSensorGyroscopeMin
#1)
#dataset_1 <- dataset_1[order(dataset_1$androidSensorGyroscopeMin),]
#View(dataset_1)

#2)
#z6 <- scale(dataset_1$androidSensorGyroscopeMin)
#View(z6)

#3)
#dataset_1 <- dataset_1[-4966:-5080,]
#View(dataset_1)
#-------------------------------------------------------------------------------
#Coluna androidSensorGyroscopeMax
#1)
#dataset_1 <- dataset_1[order(dataset_1$androidSensorGyroscopeMax),]
#View(dataset_1)

#2)
#z7 <- scale(dataset_1$androidSensorGyroscopeMax)
#View(z7)

#3)
#dataset_1 <- dataset_1[-4838:-4965,]
#View(dataset_1)
#-------------------------------------------------------------------------------
#Coluna androidSensorGyroscopeStd
#1)
#dataset_1 <- dataset_1[order(dataset_1$androidSensorGyroscopeStd),]
#View(dataset_1)

#2)
#z8 <- scale(dataset_1$androidSensorGyroscopeStd)
#View(z8)

#3)
#dataset_1 <- dataset_1[-4749:-4837,]
#View(dataset_1)
#-------------------------------------------------------------------------------
#Coluna soundMean
#1)
#dataset_1 <- dataset_1[order(dataset_1$soundMean),]
#View(dataset_1)

#2)
#z9 <- scale(dataset_1$soundMean)
#View(z9)

#3)
#nao tem outlier
#-------------------------------------------------------------------------------
#Coluna soundMin
#1)
#dataset_1 <- dataset_1[order(dataset_1$soundMin),]
#View(dataset_1)

#2)
#z10 <- scale(dataset_1$soundMin)
#View(z10)

#3)
#nao tem outlier
#-------------------------------------------------------------------------------
#Coluna soundMax
#1)
#dataset_1 <- dataset_1[order(dataset_1$soundMax),]
#View(dataset_1)

#2)
#z11 <- scale(dataset_1$soundMax)
#View(z11)

#3)
#nao tem outlier
#-------------------------------------------------------------------------------
#Coluna soundStd
#1)
#dataset_1 <- dataset_1[order(dataset_1$soundStd),]
#View(dataset_1)

#2)
#z12 <- scale(dataset_1$soundStd)
#View(z12)

#3)
#dataset_1 <- dataset_1[-4648:-4748,]
#View(dataset_1)
#-------------------------------------------------------------------------------
# target = variável qualitativa, logo não faz z-score
#
#instalar packages xlsx
write.xlsx2(dataset_1, file = "/home/actantes/Downloads/newdataset.xlsx", sheetName="Sheet1", col.names=TRUE, row.names=TRUE, append=FALSE)
