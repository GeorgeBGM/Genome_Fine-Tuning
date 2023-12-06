library("ggplot2")
library("dplyr")

# /opt/app/r/r4.2.2.1/bin/R
### 字体导入
library(extrafont);font_import()

REF=read.csv("/home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/hg38.genome",sep="\t",head=F)
gene_anno<-read.table("001.plot_chr-sum_need-draw-chr-sum.txt",head=F)
colnames(REF)<-c("Type","Pos")
colnames(gene_anno)=c("Type","Num","Class")
REF$Type <- gsub("chr", "", REF$Type)

gene_anno <- merge(REF, gene_anno, by.x="Type", by.y="Type")
gene_anno$Ratio <- gene_anno$Num*1000000 / gene_anno$Pos*100
gene_anno <- gene_anno %>% group_by(Class) %>% mutate(Percentage = Num / sum(Num) * 100)

gene_anno$Type=factor(gene_anno$Type,levels=c(seq(22),"X","Y"))
#gene_anno$Class=factor(gene_anno$Class,levels=c("Disease_loci","Regulatory","HVIDB","HERV","Immunogenetics","Highly_Specifically_Gene"))
gene_anno$Class=factor(gene_anno$Class,levels=c("Diseases_GWAS","Regulatory","HERV","Immunogenetics","Highly_Specifically_Gene"))


pdf("001.plot_chr-sum_need-draw-chr-sum_detail.pdf")
par(family = "Times New Roman")
ggplot(gene_anno, aes(Type,Num, fill = Class)) +ylim(0,60)+geom_bar(stat = 'identity', lwd = 1.5, position = position_dodge2(padding = 0,preserve = "single"))+labs(x = "Chromosomes(Hg38)", y = "Cumulative length of intervals(Mb)", title=" ")+theme_classic()+theme(axis.text.x = element_text(angle=45, vjust = 0.5,face = "bold",size=7),axis.title =  element_text(size=15,face = "bold"),legend.title=element_text(face = "bold"),panel.grid=element_blank(),legend.position = c(0.75,0.8),text = element_text(family="Times New Roman"))

dev.off()

pdf("001.plot_chr-sum_need-draw-chr-sum-ratio_detail.pdf")
par(family = "Times New Roman")
p<-ggplot(gene_anno, aes(Type,Ratio, fill = Class)) +ylim(0,60)+geom_bar(stat = 'identity', lwd = 1.5, position = position_dodge2(padding = 0,preserve = "single"))+labs(x = "Chromosomes(Hg38)", y = "Cumulative length of intervals Ratio", title=" ")+theme_classic()+theme(axis.text.x = element_text(angle=45, vjust = 0.5,face = "bold",size=7),axis.title =  element_text(size=15,face = "bold"),legend.title=element_text(face = "bold"),panel.grid=element_blank(),legend.position = c(0.75,0.8),text = element_text(family="Times New Roman"))
print(p)
ggsave("001.plot_chr-sum_need-draw-chr-sum-ratio_detail.png",p,dpi = 2000)
dev.off()

pdf("001.plot_chr-sum_need-draw-chr-sum-Percentage_detail.pdf")
par(family = "Times New Roman")
p<-ggplot(gene_anno, aes(Type,Percentage, fill = Class)) +ylim(0,50)+geom_bar(stat = 'identity', lwd = 1.5, position = position_dodge2(padding = 0,preserve = "single"))+labs(x = "Chromosomes(Hg38)", y = "Cumulative length of intervals(%)", title=" ")+theme_classic()+theme(axis.text.x = element_text(angle=45, vjust = 0.5,face = "bold",size=7),axis.title =  element_text(size=15,face = "bold"),legend.title=element_text(face = "bold"),panel.grid=element_blank(),legend.position = c(0.75,0.8),text = element_text(family="Times New Roman"))
print(p)
ggsave("001.plot_chr-sum_need-draw-chr-sum-Percentage_detail.png",p,dpi = 2000)
dev.off()