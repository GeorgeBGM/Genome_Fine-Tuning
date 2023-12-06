rm(list = ls())
library(ggthemes)
library(gridExtra)
library(ggpubr)
library(grid) 
#library(export)

# /opt/app/r/r4.2.2.1/bin/R
### 字体设置
#par(family="Arial")
library(extrafont);font_import()
#font_import(paths = "/home/u20111010010/Project/DNA-Pretraining/Level1/Manuscript/Times_New_Roman", prompt = FALSE)


pdf("003.Figure1_plot_merge_chr-sum_gene-rate_draw_merge.pdf",width = 10, height = 5)

#par(family="Times New Roman")
##### Plot1
gene_anno<-read.table("001.plot_chr-sum_need-draw-chr-sum.txt",head=F)
colnames(gene_anno)=c("Type","Num","Class")
gene_anno$Type=factor(gene_anno$Type,levels=c(seq(22),"X","Y"))
gene_anno$Class=factor(gene_anno$Class,levels=c("Diseases_GWAS","Regulatory","HERV","Immunogenetic","Highly_Specifically_Gene"))
plot1<-ggplot(gene_anno, aes(Type,Num, fill = Class)) +ylim(0,60)+geom_bar(stat = 'identity', lwd = 1.5, position = position_dodge2(padding = 0,preserve = "single"))+labs(x = "", y = "Cumulative length of intervals(Mb)", title=" ")+theme_classic()+theme(axis.text.x = element_text(angle=45,color="black", vjust = 0.5,size=7),axis.title =  element_text(size=10),panel.grid=element_blank(),legend.position = c(0.75,0.85),legend.title = element_blank(),text = element_text(family = "Times New Roman"))

##### Plot2
gene_anno<-read.table("002.plot_gene-rate_need_genes_number_ratio_Non-HVIDB.txt",head=T)
gene_anno$Type=factor(gene_anno$Type,levels=c("Genes","Genes(Coding)"))
gene_anno$Region=factor(gene_anno$Region,levels=c("Diseases_GWAS","Regulatory","HERV","Immunogenetic","Highly_Specifically_Gene"))
plot2<-ggplot(gene_anno, aes(Region,Num, fill = Type)) +ylim(0,16)+geom_bar(stat = 'identity', lwd = 1.5, position = position_dodge2(padding = 0,preserve = "single"))+geom_hline(yintercept = 1, linetype = "dashed", color = "gray",size = 2) +labs(x = "", y = "Enrichment Rate", title=" ")+theme_classic()+theme(axis.text.x = element_text(angle=45, vjust = 0.5,color="black",size=5),axis.title =  element_text(size=10),legend.title = element_blank(),panel.grid=element_blank(),legend.position = c(0.8,0.98),text = element_text(family = "Times New Roman"))

# 创建标签 "A" 和 "B"
#label_A <- textGrob("A", x = 0.05, y = 0.95, just = "left", gp = gpar(fontface = "bold", size = 20,family = "Times New Roman"))
#label_B <- textGrob("B", x = 0.05, y = 0.95, just = "left", gp = gpar(fontface = "bold", size = 20,family = "Times New Roman"))
#,labels = c("A","B")
combined_plot <- ggarrange(plot1,plot2,ncol = 2,align  = "hv",font.label=list(size=18,face="bold"),label.x=0,label.y=0.98,common.legend = FALSE)
ggsave("003.Figure1_plot_merge_chr-sum_gene-rate_draw_merge.png", combined_plot, width = 10, height = 5, dpi = 2000)

dev.off()