library(dplyr)
library(data.table)
library(reshape2)


dir<- 'UCI HAR Dataset'
dir.test<-file.path(dir, 'test')
dir.train<-file.path(dir, 'train')

f.label<-file.path(dir, 'activity_labels.txt')
f.fea<-file.path(dir,'features.txt')

f.test.data<- file.path(dir.test,'X_test.txt')
f.test.sub<- file.path(dir.test, 'subject_test.txt')
f.test.lab<-file.path(dir.test, 'y_test.txt')

f.train.data<- file.path(dir.train,'X_train.txt')
f.train.sub<- file.path(dir.train, 'subject_train.txt')
f.train.lab<- file.path(dir.train, 'y_train.txt')

## Get features 
fea<- read.delim(file=f.fea, header = FALSE, sep = ' ',colClasses='character')[,2]

## get test data
x<-readLines(f.test.data)
dat.test <- t(
        sapply(as.list(x), function(a) {
        as.numeric(unlist(strsplit(split=' ',gsub('^ ','',gsub('  ',' ',a)))))          
        })
)


test.sub <-read.csv(f.test.sub, header = F)
dat.test <- as.data.frame(cbind(dat.test, test.sub))
test.lab <-read.csv(f.test.lab, header = F)
dat.test <- as.data.frame(cbind(dat.test, test.lab))
colnames(dat.test) <- c(fea, 'subject','label')

##dat.test$cate <-'test'


x<-readLines(f.train.data)
dat.train <- t(
        sapply(as.list(x), function(a) {
                as.numeric(unlist(strsplit(split=' ',gsub('^ ','',gsub('  ',' ',a)))))          
        })
)


train.sub <-read.csv(f.train.sub, header = F)
dat.train <- as.data.frame(cbind(dat.train, train.sub))
train.lab <-read.csv(f.train.lab, header = F)
dat.train <- as.data.frame(cbind(dat.train, train.lab))
colnames(dat.train) <- c(fea, 'subject', 'label')

##dat.train$cate <-'train'





dat.both<-rbind( dat.train, dat.test)


## step 2, Extrat only the measurements on mean and standard deviation
col.choise<- fea[grep ('mean|std', fea, ignore.case = T)]
col.choise<- c(col.choise, 'subject', 'label')

dat.subset <-dat.both[col.choise]

## step3, use descriptive activity names to name the ativities, 
activity <- read.csv(f.label, header=F, sep = ' ')
names(activity) <- c('label', 'activity')
dat.subset<-merge(x=dat.subset, y = activity)
dat.subset$label=NULL

## step4, varialbe names, done
## step5
result<-dcast(melt(dat.subset, id=c('activity', 'subject')), activity+subject ~ variable, mean)

