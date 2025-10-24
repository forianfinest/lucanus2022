#####STEP 1: FILTERING

#####WE TOOK THE OG SCRIPTS AND FUNCTIONS FROM: https://github.com/jdalapicolla/LanGen_pipeline_version2

pacman::p_load(r2vcftools, tidyverse, vcfR, SNPRelate, dartR, poppr, adegenet, LEA, pcadapt, qvalue, psych, tess3r, VennDiagram, sf)
vcf_file="populations.all.vcf"
snps_raw =  vcfLink(vcf_file, overwriteID=T)
snps = Filter(snps_raw, filterOptions(max.alleles=2, min.alleles=2), indels="remove")
snps_unind = snps
genotypes = GenotypeMatrix(snps_unind)
Missing = apply(GenotypeMatrix(snps_unind), 2, function(x) sum(x < 0)/length(x)*100)
summary(Missing) ## Max missing = 54.9%
hist(Missing)
#D. Missing per individual
Missing_ind = apply(GenotypeMatrix(snps_unind),1, function(x) sum(x<0)/length(x)*100)
summary(Missing_ind) 
hist(Missing_ind)
Missingind.df = Missing_ind %>%
as.data.frame() %>%
rownames_to_column(., var = "ID_original") %>%
mutate (ID = str_remove(ID_original, pattern="_sorted")) %>%
setNames(., c("ID_original", "Missing_data", "ID"))
Missing.df = Missing %>%
as.data.frame() %>%
rownames_to_column(., var = "ID_original") %>%
mutate (ID = str_remove(ID_original, pattern="_sorted")) %>%
setNames(., c("ID_original", "Missing", "ID"))
View(Missing.df)
df_cov<-site.depth[!(site.depth$MEAN_DEPTH<20),]
View(df2)
View(df_cov)
snps_missinglocilessthan20 = Subset(snps_unind, sites = df2$ID)
Save(snps_missinglocilessthan20, paste0("filtered_less20.vcf"))
savehistory("/run/media/brcuser/MDVBook/nu_lucanus_m3M4n4/test_conversion/filtering.Rhistory")
