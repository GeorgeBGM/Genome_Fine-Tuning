library(dplyr)
library(ggplot2)
library(tidyr)
library(UpSetR)
library(VennDiagram)
library(aplot) 
#/opt/app/r/r4.2.2.1/bin/R

####### 注释信息读入
info<-read.csv("/home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_transfac-infor.txt",sep="\t",header=F)
colnames(info)<-c("ac","id","tax","family","class","pubmed","uniprot","data")

####### 文件合并及读入，并添加标注符
A <- read.table("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_HERV_Coding_Raw/fimo.tsv", header=TRUE)
B <- read.table("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_HERV_Non-Coding_Raw/fimo.tsv", header=TRUE)
C <- read.table("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_Non-HERV_Coding_Raw/fimo.tsv", header=TRUE)
D <- read.table("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_Non-HERV_Non-Coding_Raw/fimo.tsv", header=TRUE)
### 第一分组
A$Group1 <- "HERV_Coding"
B$Group1 <- "HERV_Non-Coding"
C$Group1 <- "Non-HERV_Coding"
D$Group1 <- "Non-HERV_Non-Coding"
### 第二分组
A$Group <- "HERV"
B$Group <- "HERV"
C$Group <- "Non-HERV"
D$Group <- "Non-HERV"

## 合并所有的数据
all_data <- rbind(A, B, C, D)
all_data<-subset(all_data,q.value<=0.05)

######## 1、不同分组间的交集
HERV_Coding=unique(subset(all_data,Group1=="HERV_Coding")$motif_alt_id)
HERV_Non_Coding=unique(subset(all_data,Group1=="HERV_Non-Coding")$motif_alt_id)
Non_HERV_Coding=unique(subset(all_data,Group1=="Non-HERV_Coding")$motif_alt_id)
Non_HERV_Non_Coding=unique(subset(all_data,Group1=="Non-HERV_Non-Coding")$motif_alt_id)

#### HERV相对于Non-HERV的特异序列
specific_motifs_HERV_NonHERV <- setdiff(unique(HERV_Coding,HERV_Non_Coding),unique(Non_HERV_Coding,Non_HERV_Non_Coding))

gene_lists <- list(A=HERV_Coding, B=Non_HERV_Coding, C=HERV_Non_Coding,D=Non_HERV_Non_Coding)

venn.plot <- venn.diagram(
  x = gene_lists,
  category.names = c("HERV_Coding","Non-HERV_Coding","HERV_Non-Coding","Non-HERV_Non-Coding"),
  filename = NULL,
  col = "transparent",
  fill = c("green","blue", "red","yellow"),
  category.cex = 0.8,
  category.dist = 1.3,  # 进一步增加标签的位置距离
  category.pos = c(0, 2, 1, 3),
  category.just = c("right", "right", "middle", "middle"),  # 调整标签的对齐方式
  width = 25,  # 增大图像宽度
  height = 20  # 增大图像高度
)

venn.plot1 <- venn.diagram(
  x = gene_lists,
  category.names =c("","","",""),
  filename = NULL,
  col = "transparent",
  fill = c("green","blue", "red","yellow"),
  category.cex = 0.8,
  category.dist = 1.3,  # 进一步增加标签的位置距离
  category.pos = c(0, 2, 1, 3),
  category.just = c("right", "right", "middle", "middle"),  # 调整标签的对齐方式
  width = 25,  # 增大图像宽度
  height = 20  # 增大图像高度
)

pdf("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Overlap_Raw.pdf")
grid.draw(venn.plot)
grid.newpage()
grid.draw(venn.plot1)
dev.off()

######## 2. 每个Motif水平的富集分析
#  计算Motif的出现次数
motif_counts <- all_data %>%
  count(motif_alt_id, Group, Group1) %>%   # 在这里我们同时计数Group和Group1的组合
  group_by(motif_alt_id) %>%
  mutate(
    HERV = sum(n[Group == "HERV"]),
    HERV_NonCoding = sum(n[Group1 == "HERV_Non-Coding"]),
    Non_HERV = sum(n[Group == "Non-HERV"])
  ) %>%
  select(motif_alt_id, HERV, HERV_NonCoding, Non_HERV) %>%
  unique()

#  归一化
motif_counts_norm <- motif_counts %>%
  group_by(motif_alt_id) %>% 
  summarise(
    Case_total = sum(HERV, na.rm = TRUE),
    Case1_total = sum(HERV_NonCoding, na.rm = TRUE),
    Control_total = sum(Non_HERV, na.rm = TRUE)
  ) %>% 
  mutate(
    Case_norm = ifelse(Case_total == 0, 0, Case_total / sum(Case_total)),
    Control_norm = ifelse(Control_total == 0, 0, Control_total / sum(Control_total)),
    Case_Rate = Case_norm/(Control_norm+Case_norm),   #Case Proportion
    Category = case_when(
      Case_total == 0 ~ "Control",
      Case_total == Case1_total ~ "HERV_NonCoding",
      Case1_total == 0 ~ "HERV_Coding",
      TRUE ~ "HERV_Both"
    )
  )  

#  超几何分布测试
total_motifs <- nrow(all_data)
total_case <- sum(motif_counts_norm$Case_total)
total_control <- sum(motif_counts_norm$Control_total)

# 使用phyper函数计算超几何分布的P值
motif_counts_norm$p_hyper <- mapply(function(k, m) {
  phyper(k-1, m, total_motifs-m, total_case, lower.tail = FALSE)
}, k = motif_counts_norm$Case_total, m = motif_counts_norm$Case_total + motif_counts_norm$Control_total)
motif_counts_norm$p_hyper_adjust<-p.adjust(motif_counts_norm$p_hyper, "BH")

motif_counts_norm_infor <- merge(data.frame(motif_counts_norm), info, by.x = "motif_alt_id", by.y = "id", all = FALSE)

write.table(motif_counts_norm_infor, file = "/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment_Raw.txt", sep = "\t", row.names = FALSE,quote=FALSE)

### 富集结果展示
# motif_alt_id,tax,family
# Case_total
# single,both
# p
# Case_Rate
motif_counts_norm_infor=subset(motif_counts_norm_infor,p_hyper_adjust<=0.05 & Case_Rate>=0.5 & Case_total>10)
out1=data.frame(Class=paste(motif_counts_norm_infor$motif_alt_id,motif_counts_norm_infor$tax,motif_counts_norm_infor$class,sep=","),HERV_Number=motif_counts_norm_infor$Case_total,Category=motif_counts_norm_infor$Category,P_adjust=motif_counts_norm_infor$p_hyper_adjust,HERV_Rate=motif_counts_norm_infor$Case_Rate)

out1=out1[order(out1$P_adjust),]
out1=out1[order(out1$Category),]
out1$Category<-factor(out1$Category,levels =c("HERV_NonCoding","HERV_Coding","HERV_Both"))
out1$Class <- factor(out1$Class, levels = out1$Class[!duplicated(out1$Class)])
# 对每个Category选取最多20行
out1<-out1 %>% group_by(Category) %>% slice_head(n = 20)

pdf("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment_Raw.pdf")

Category <- out1$Class %>% as.data.frame() %>%
  mutate(group=out1$Category) %>%
  mutate(p="")%>%
  ggplot(aes(p,.,fill=group))+
  geom_tile() + 
  scale_y_discrete(position="right") +
  theme_minimal()+xlab(NULL) + ylab(NULL) +
   theme(axis.text.y = element_blank(),legend.position = "right",legend.text = element_text(size=5),legend.title = element_text(size=7),
        axis.text.x =element_text(
          angle =90,hjust =0.5,vjust = 0.5))+
  labs(fill = "Category")


p1<-ggplot(out1, aes(HERV_Rate,Class)) +
  geom_point(aes(color=P_adjust, size=HERV_Number))+theme_bw()+
  theme(panel.grid = element_blank(),
        axis.text.x=element_text(angle=90,hjust = 1,vjust=0.5))+
  scale_color_gradient(low='#6699CC',high='#CC3333')+
  labs(x="HERV_Rate",y=NULL)+guides(size=guide_legend(order=1))+
  theme(legend.direction = "vertical", legend.position = "right",axis.text.y=element_text(vjust=1,size=7,lineheight=10),axis.text.x=element_text(angle=45),legend.text = element_text(size=5),legend.title = element_text(size=7))+#legend水平置于顶部
  scale_y_discrete(position = "right")#y轴文字放右侧

p1
p1%>%
  insert_left(Category, width =0.05)

dev.off()


