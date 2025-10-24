######SCRIPTS FOR SNAPCLUST
library(ape);
library(adegenet);
library(poppr);
data<-read.table(file="filtered_withpopinfo.str",sep=",",header=FALSE) #a modified structure output
n.ind <- nrow(data)/2;#count the number of samples
n.loci <- ncol(data) - 2;#count the number of loci
#identify loci with shared by less than 80% of the samples
low.cov.loci <- NULL;#create an empty vector
cov.loci <- NULL;#don't really need this; a vector to store the number of coverage per locus
for(iter in 3:ncol(data)){
no.data <- sum(data[,iter] == -9);
if(no.data/2 > n.ind*0.2){
low.cov.loci <- c(low.cov.loci, iter);
}
cov.loci <- c(cov.loci, no.data)
}
newdata <- data[,-low.cov.loci];#a new file with loci less than 20% coverage deleted
write.table(newdata,file='hygr80.str',quote=FALSE,sep= '\t', row.names=FALSE, col.names=FALSE);
datastr <- read.structure('hygr80.str', n.ind = 86, n.loc = 1022, onerowperind = FALSE, col.lab = 1, col.pop = 2, row.marknames = 0, NA.char = '-9'); ####THE MISSING CHARACTER DEPENDS ON WHICH OUTPUT YOU ARE USING (IPYRAD OR STRUCTURE)
X <- scaleGen(datastr, NA.method = 'mean');
mycol <- c("#251F40FF","yellow4","#9E0142FF")
a.aic <- snapclust.choose.k(max=5,datastr, IC = AIC);
a.bic <- snapclust.choose.k(max=5,datastr, IC = BIC);
pdf(file="aic_calc.pdf")
par(mfrow=c(2,1));
plot(1:5,a.aic,xlab='Number of clusters (k)', ylab = 'AIC', type ='b');
plot(1:5,a.bic,xlab='Number of clusters (k)', ylab = 'BIC', type ='b');
dev.off()
my.snapclust <- snapclust(datastr, k=3);
pdf(file="complot_dapc.pdf")
compoplot(my.snapclust, posi='bottomleft', ncol = 1, col = mycol, cleg = 0.8, cex.names = 0.8);
dev.off()
