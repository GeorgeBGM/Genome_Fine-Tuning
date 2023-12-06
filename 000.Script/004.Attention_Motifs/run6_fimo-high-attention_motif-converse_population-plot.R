library("ggplot2")
library("dplyr")
library(ggrepel)

#/opt/app/r/r4.2.2.1/bin/R

gene_anno<-read.csv("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed.depth_gene.bed",head=F,sep="\t")  
gene_anno=gene_anno[,c(1,2,3,4,7,11,12)]
colnames(gene_anno)=c("Class","Start","End","Gene","Type","CHR","Num")
gene_anno$CHR1 <- gsub("chr", "", gene_anno$CHR)
gene_anno$CHR <- factor(gene_anno$CHR1,levels=c(seq(22),"X","Y"))

#CCDC200, CD200；CD226；CLEC4E, ADCY1；ABL1；ADRA1A；NRG3；RAB3GAP1, CYP27A1；AACS；ALDH3A2, ZEB2, ROR1
filtered_data <-subset(gene_anno, (gene_anno$Gene %in% c("OTUD7A","PEX2","CSGALNACT2","CCDC200","CD200","CD226","CLEC4E","ADCY1","ABL1","ADRA1A","NRG3","RAB3GAP1","CYP27A1","AACS","ALDH3A2","ZEB2","ROR1")))
#filtered_data <-subset(gene_anno, (gene_anno$Num > 90 | gene_anno$Num<2) & (gene_anno$Type == "protein_coding"))

filtered_data <- filtered_data %>%
  group_by(Gene) %>%         # 按基因名(V5列)分组
  slice(1) %>%              # 选择每组的第一条记录(Motifs),选取倒数第二列数值最大的
  ungroup()

pdf("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run6_fimo-high-attention_motif-converse_population-plot_raw.pdf")
#p <- ggplot(gene_anno, aes(CHR, Num, fill = Type,color=Type)) +geom_point()+coord_cartesian(ylim = c(NA, 1500))+geom_text(data = filtered_data, label = filtered_data$Gene,color="black",size=3,vjust=-1, hjust=1,nudge_y = 1) +labs(x = "Chromosomes (Hg38)", y = "Aligned Depth", title = " ") +theme_classic() +theme(legend.position = c(0.85,0.85))      
par(family="Times New Roman")
p <- ggplot(gene_anno, aes(CHR, Num, fill = Type, color = Type)) +geom_point() +coord_cartesian(ylim = c(NA, 1600)) +
  # 使用 geom_text_repel 替换 geom_text
  geom_text_repel(data = filtered_data,aes(label = Gene),color = "black",size = 3,nudge_y = 1,direction = "y",hjust = 0.5, segment.size = 0.2,segment.color = "grey50",box.padding=0.5,point.padding=0.8,min.segment.length=0.5,family = "Times New Roman") +  # 箭头颜色
  labs(x = "Chromosomes (Hg38)", y = "Aligned Depth", title = " ") +
  theme_classic() +
  theme(legend.position = c(0.3, 0.84),
        legend.text = element_text(size = 12),legend.title = element_blank(),text = element_text(family = "Times New Roman"))   # 调整图例文本大小
print(p)
ggsave("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run6_fimo-high-attention_motif-converse_population-plot_raw_new_need.png",p,dpi = 2000)
dev.off()

#ggsave("/home/u20111010010/Project/Pan-genome/001.Merge_Pan_V1/Merge-V1_phastConsElements/002.ConsElements_Pangenome_show-ConsElements.bed.depth_plot_raw.png",
#  plot = p,device = "png",width = 8, height = 6,limitsize = FALSE)