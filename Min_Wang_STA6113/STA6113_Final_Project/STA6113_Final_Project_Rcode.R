# Brandon Lwowski , Micah Eassa , Santanu Mukherjee
# This is the group project for STA6113

############### NOTE TO RUN THE BAYESIAN PORTION OF THIS CODE YOU NEED A 
# LARGE AMOUNT OF SAMPLES. LINE 135 SHOWS 5,000,000 SAMPLES. THIS IS WHAT WE
# ACTUALLY RAN WITH. THE SMALLER SAMPLE SIZE BELOW IN LINE 136 DOES NOT PRODUCE
# RESULTS. THE ADAPTIVE VARIANCE WAS CRITICAL FOR US
################################################################################
library(caret)
library(ROCR)
library(MASS)
library(coda)

# set working directory to file location, this assume the data files are in
# the same location as the this script
current.path = rstudioapi::getActiveDocumentContext()$path
setwd(dirname(current.path))
print(getwd())


# this is is a list of all the data sets we have for heart disease right now.  
# data from kagle is somewhat questionable so I processed the raw data from
# UCI into a csv using python. 
# cleveland.file was processed into a csv file using the new.data file in the
# UCI repository. This file has more observations than the original data set but
# the first 303 observation are consistent with the original data. All files
# below except for preprocessed.data contain the original 76 attributes and
# need a little more processing, however the python processing gave all missing
# values the correct indication "NA" and should be easier to work with
# preprocessed.file = "heart.csv" # no longer working with set from kaggle
cleveland.file = "manualProcessed.cleveland.data.csv"
longbeach.file = "manualProcessed.long-beach-va.data.csv"
hungarian.file = "manualProcessed.hungarian.data.csv"
swiss.file = "manualProcessed.switzerland.data.csv"

################# begin preprocessing data ####################################
# files with 76 attributes will be reduced to the 14 attributes shown in the
# the literature. Only the first 303 observations from cleveland.file will be
# kept, again consistent with the literature

# Step 1. read in csv files, remove variables and observations as needed
files.to.process = c(cleveland.file, longbeach.file, hungarian.file, swiss.file)
data.names = c("cleveland", "longbeach", "hungarian", "swiss")
vars.to.keep = c("AGE", "SEX", "CHESTPAIN", "TRESTBPS", "CHOL", "FBS",
                 "RESTECG", "THALACH", "EXANG", "OLDPEAK", "SLOPE", "CA",
                 "THAL", "NUM")
if (length(files.to.process) != length(data.names)){
  warning("files to process and data names are not the same length")
} else {
  for (i in 1:length(files.to.process)){
    assign(data.names[i],read.csv(files.to.process[i]))
    assign(data.names[i],
           get(data.names[i])[which(names(get(data.names[i])) %in% vars.to.keep)])
  }
}
cleveland = cleveland[1:303,]

# Step 2. reclass and encode variables so they are more readable
factor.names = c("SEX", "CHESTPAIN", "FBS", "RESTECG", "EXANG", "SLOPE", "CA",
                 "THAL", "NUM")
SEX.code = c(0,1)
SEX.factor = c("F","M")
SEX.ref = SEX.factor[1]
CHESTPAIN.code = c(1,2,3,4)
CHESTPAIN.factor = c("TYPICAL", "ATYPICAL", "NONANGINAL", "ASYMPTOMATIC")
CHESTPAIN.ref = CHESTPAIN.factor[4]
FBS.code = c(0,1)
FBS.factor = c("NORMAL", "HIGH")
FBS.ref = FBS.factor[1]
RESTECG.code = c(0,1,2)
RESTECG.factor = c("NORMAL", "ST", "LVH")
RESTECG.ref = RESTECG.factor[1]
EXANG.code = c(0,1)
EXANG.factor = c("Y","N")
EXANG.ref = EXANG.factor[2]
SLOPE.code = c(1,2,3)
SLOPE.factor = c("UP", "FLAT", "DOWN")
SLOPE.ref = SLOPE.factor[1]
CA.code = c(0,1,2,3)
CA.factor = c("0","1","2","3")
CA.ref = CA.factor[1]
THAL.code = c(3, 6, 7)
THAL.factor = c("NORMAL", "FIXED", "REVERSABLE")
THAL.ref = THAL.factor[1]
NUM.code = c(0,1,2,3,4)
NUM.factor = c("0","1","1","1","1")
NUM.ref = NUM.factor[1]

all.data = data.frame()
for (dataset in data.names){
  df = get(dataset)
  for (name in factor.names){
    code = get(paste(name, "code", sep = "."))
    fact = get(paste(name, "factor", sep = "."))
    ref = get(paste(name, "ref", sep = "."))
    df[[name]][-which(df[[name]] %in% code)] = NA
    for (i in length(code)){
      df[[name]][ df[[name]] == code[i] ] = fact[i]
    }
    df[[name]] = as.factor(df[[name]])
    levels(df[[name]]) = fact
    relevel(df[[name]], ref = ref)
    assign(dataset,df)
  }
  all.data = rbind(all.data,df)
}

# note the original study trained a model using only the cleveland data and 
# tested it using the other three data sets. Because of that, there is some
# some value in processing the data sets individually and then combining rather
# than combining and then processing.
############# end preprocessing data ##########################################


# split data for training
set.seed(1)
complete.data = cleveland[complete.cases(cleveland),]
tr.ind = createDataPartition(complete.data$NUM, p = 0.8, list = F)
data.tr = complete.data[tr.ind,]   # training data
data.te = complete.data[-tr.ind,]  # test data


################################################################################
##########################    Bayesian     #####################################
################################################################################


# set up data structures
X = model.matrix(NUM ~.,data = data.tr)
X.te = model.matrix(NUM ~.,data = data.te)
y = as.vector(data.tr$NUM)
y[y == "0"] = 0
y[y == "1"] = 1
y = as.numeric(y)
n = nrow(X)
p = ncol(X)
#iter = 5000000 # what made report results, smaller number for testing below
iter = 10000
burn.in = 10000 # time before adaptive variance
adapt = 1000    # adaptation period
thin = 100      # thin out results
Beta = matrix(-99, ncol = p, nrow = iter/thin)
colnames(Beta) = colnames(X)
beta = rep(0,p)
beta.c = beta
Beta[1,] = beta
sigma = 1000
sigma2 = sigma^2
c = rep(100,p)
c.counts = rep(0,p)

# inverse logit
inv.logit = function(x) exp(x)/(1+exp(x))

# posterior log likelihood function
log.lik = function(y,X,beta,sigma){
  y*(X %*% beta) - log(1+exp(X %*% beta)) -sum(beta^2)/2/sigma  
}

# initialize posterior log likelihood
post.ll = log.lik(y,X,beta,sigma)

#Metropolis sampling loop, individual sampling
set.seed(1)
for (t in (thin+1):iter){
  for(i in 1:length(beta)){
    beta.c[i] = rnorm(1,beta[i],c[i]) 
    
    # calculate metropolis ratio
    post.ll.c = log.lik(y,X,beta.c,sigma)
    r = post.ll.c - post.ll
    r = min(exp(r),1)
    
    # check for acceptance
    if(runif(1)<r){
      beta[i] = beta.c[i]
      post.ll = post.ll.c
      c.counts[i] = c.counts[i] + 1
    }
  }
  if(t == burn.in){
    c.counts = rep(0,length(c.counts))
  }
  if(t>burn.in & t %% adapt == 0){
    for(j in 1:length(c.counts)){
      c[j] = c[j]*(1 + (c.counts[j]/adapt > 0.55)*0.75 - (c.counts[j]/adapt < 0.35)*.75)
      c.counts[j] = 0
    }
  }
  if (t %% thin == 0){
    Beta[t/thin,] = beta
  }
  if (t %% 5000 == 0){
    print(t)
  }

}

# mc diagnostics
Beta.mcmc = as.mcmc(Beta)
plot(Beta.mcmc) # this won't work unless algorth runs long enough for data
traceplot(Beta.mcmc[,"FBSHIGH"])
title("Traceplot for FBSHIGH")
plot(density(Beta[,"FBSHIGH"]),main="")
title("Density for coefficient of FBSHIGH")

geweke.diag(Beta.mcmc)
for(name in colnames(Beta.mcmc)){
  traceplot(Beta.mcmc[,name])
  title(paste("Trace plot for coefficient", name))
}


################ roc curve function ###########################################
imp.roc.curve = function(probs.te, true.response, y.type, x.type){
  # output ROC curve and AUC
  labels.te = rep(0, length(true.response))
  labels.te[true.response == "1"] = 1
  pred.roc = prediction(predictions = probs.te, labels = labels.te) 
  perf = performance(pred.roc, y.type , x.type)
  plot(perf,main = "ROC",col = "red")
  rect(0, 1.1, 1, 1.7, xpd=TRUE, col="white", border="white")
  abline(0,1,col = "blue",lty = 2)
  pred.auc = performance(pred.roc,"auc")
  print(paste("AUC =", pred.auc@y.values[[1]]))
}

bayes.coefs = colMeans(Beta[-c(1:2500),])
probs.tr = inv.logit(X %*% bayes.coefs)
probs.te = inv.logit(X.te %*% bayes.coefs)
imp.roc.curve(probs.te, data.te$NUM, "tpr", "fpr")
title("Bayesian Logistic ROC using with Validation Set")

# initialize vector of predictions to "0" for training and test sets, respectively
pred.tr = factor(rep("0", nrow(data.tr)), levels = levels(data.tr$NUM))
pred.te = factor(rep("0", nrow(data.te)), levels = levels(data.te$NUM))

# set prediction to 1 if predicted probability is < threshold
thresh = 0.5
pred.tr[probs.tr > thresh] = "1"
pred.te[probs.te > thresh] = "1"

# output confusion matrices
print(noquote("Training Set Confusion Matrix"))
confusionMatrix(data = pred.tr,
                      reference = data.tr$NUM)
print(noquote("Test Set Confusion Matrix"))
confusionMatrix(data = pred.te,
                      reference = data.te$NUM) 

################################################################################
####################### frequentist ############################################
################################################################################

# logistic fit  and info info
summary(logistic.fit <- glm(NUM ~., data = data.tr, family = "binomial"))


probs.tr = predict(logistic.fit, data.tr, type = "response")
probs.te = predict(logistic.fit, data.te, type = "response")

# initialize vector of predictions to "0" for training and test sets, respectively
pred.tr = factor(rep("0", nrow(data.tr)), levels = levels(data.tr$NUM))
pred.te = factor(rep("0", nrow(data.te)), levels = levels(data.te$NUM))

# set prediction to 1 if predicted probability is < threshold
thresh = 0.5
pred.tr[probs.tr > thresh] = "1"
pred.te[probs.te > thresh] = "1"

# output confusion matrices
print(noquote("Training Set Confusion Matrix"))
confusionMatrix(data = pred.tr,
                      reference = data.tr$NUM)
print(noquote("Test Set Confusion Matrix"))
confusionMatrix(data = pred.te,
                      reference = data.te$NUM) 

#Roc curve
imp.roc.curve(probs.te, data.te$NUM, "tpr", "fpr")
title("ROC for Frequentist with Validation Set")
