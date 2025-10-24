ML.data <- read.table('ML.final.summary', header = TRUE);
HC.data <- read.table('HC.final.summary', header = TRUE);
NT.data <- read.table('NT.final.summary', header = TRUE);
pdf(file="best2.pdf")
plot(NT.data$year,NT.data$Ne_median,col='#8b2d48',type='l', xlim=c(0,1000000),ylim=c(0,800000), xlab='Time (years ago)', ylab='Effective population size', main = 'Estimated demographic history');
points(NT.data$year,NT.data$Ne_97.5,col='#8b2d48',type='l',lty=2);
points(NT.data$year,NT.data$Ne_2.5,col='#8b2d48',type='l',lty=3);
points(ML.data$year,ML.data$Ne_median,col='yellow4',type='l');
points(ML.data$year,ML.data$Ne_97.5,col='yellow4',type='l',lty=2);
points(ML.data$year,ML.data$Ne_2.5,col='yellow4',type='l',lty=3);
points(HC.data$year,HC.data$Ne_median,col='#231d3c',type='l');
points(HC.data$year,HC.data$Ne_97.5,col='#231d3c',type='l',lty=2);
points(HC.data$year,HC.data$Ne_2.5,col='#231d3c',type='l',lty=3);
legend(300000,680000, legend = c('HC', 'ML', 'NT'), col = c('#231d3c', 'yellow4', '#8b2d48'), lty = 1, cex = 1);
dev.off()
