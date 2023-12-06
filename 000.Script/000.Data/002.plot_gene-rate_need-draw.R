library("ggplot2")

# /opt/app/r/r4.2.2.1/bin/R
# grep -v 'HVIDB' 002.plot_gene-rate_need_genes_number_ratio.txt  >002.plot_gene-rate_need_genes_number_ratio_Non-HVIDB.txt
### 字体设置
#par(family="Arial")
library(extrafont)
font_import(paths = "/home/u20111010010/Project/DNA-Pretraining/Level1/Manuscript/Times_New_Roman", prompt = FALSE)
par(family = "Times New Roman")

gene_anno<-read.table("002.plot_gene-rate_need_genes_number_ratio_Non-HVIDB.txt",head=T)
gene_anno$Type=factor(gene_anno$Type,levels=c("Genes","Genes(Coding)"))
gene_anno$Region=factor(gene_anno$Region,levels=c("Disease_GWAS","Regulatory","HERV","Immunogenetics","Highly_Specifically_Gene"))
#gene_anno$Region=factor(gene_anno$Region,levels=c("Disease_loci","Regulatory","HVIDB","HERV","Immunogenetics","Highly_Specifically_Gene"))

pdf("002.plot_gene-rate_need_genes_number_ratio_detail.pdf")
ggplot(gene_anno, aes(Region,Num, fill = Type)) +ylim(0,16)+geom_bar(stat = 'identity', lwd = 1.5, position = position_dodge2(padding = 0,preserve = "single"))+labs(x = "Chromosomes(Hg38)", y = "Enrichment Rate", title=" ")+theme_classic()+theme(axis.text.x = element_text(angle=45, vjust = 0.5,face = "bold",size=7),axis.title =  element_text(size=15,face = "bold"),legend.title=element_text(face = "bold"),panel.grid=element_blank(),legend.position = c(0.75,0.8))

#axis.text.y = element_text(size = 1.5)
dev.off()