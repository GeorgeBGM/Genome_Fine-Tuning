library("ggplot2")
library(Cairo)
library(tidyr)
library(dplyr)

### 字体设置
#par(family="Arial")
#library(extrafont)
#font_import(paths = "/home/u20111010010/Project/DNA-Pretraining/Level1/Manuscript/Times_New_Roman", prompt = FALSE)
#loadfonts(device = "all")

library(extrafont);font_import()

#Sys.setenv(R_FONTS_USER="/home/u20111010010/Project/DNA-Pretraining/Level1/Manuscript/Times_New_Roman")
### 文件产生
#002.Plot_Test-Set_HERV-Classification_BERT.ipynb

# /opt/app/r/r4.2.2.1/bin/R
## id2label={"0":"Non-HERV_Coding","1":"HERV_Coding","2":"Non-HERV_Non-Coding","3":"HERV_Non-Coding"}
gene_anno<-read.table("/home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_model_HERV-Classification_Need-Test_NEW_Labels.fa",head=F)

gene_anno_all<-read.table("/home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_model_HERV-Classification_Need-ALL_NEW_Labels.fa",head=F)

##################### 占比计算
## "HERV_Non-Coding"
#gene_anno_t[,4]/80373
## "HERV_Coding"
#gene_anno_t[,2]/3302

pdf("run4_plot-high-attention_explain_detail_pie.pdf")
##################### 重叠序列鉴定(Class分类)
gene_anno_t<-table(gene_anno[,c(1,4)])
colnames(gene_anno_t)<-c("Non-HERV_Coding","HERV_Coding","Non-HERV_Non-Coding","HERV_Non-Coding")
gene_anno_df <- as.data.frame.matrix(gene_anno_t)
gene_anno_df <- subset(gene_anno_df, row.names(gene_anno_df) != "Non-HERV" & row.names(gene_anno_df) != "Unfound")

gene_anno_df$HERV_Coding_Proportion <- gene_anno_df$HERV_Coding / sum(gene_anno_df$HERV_Coding)*100
gene_anno_df$HERV_Non_Coding_Proportion <- gene_anno_df[,4] / sum(gene_anno_df[,4])*100
gene_anno_df$Type=row.names(gene_anno_df)

# 绘制数据A的饼图
#ggplot(gene_anno_df, aes(x = "", y = HERV_Coding_Proportion, fill = Type)) +
#  geom_bar(width = 1, stat = "identity") +
#  coord_polar(theta = "y") +
#  labs(title = "HERV_Coding Proportion(HervD Atlas ; HERV Class)",x="",y="") +
#  geom_text(aes(label = sprintf("%.1f%%", HERV_Coding_Proportion)), position = position_stack(vjust = 0.5), color = "black",size=4)

# 绘制数据B的饼图
#ggplot(gene_anno_df, aes(x = "", y = gene_anno_df$HERV_Non_Coding_Proportion, fill = Type)) +
#  geom_bar(width = 1, stat = "identity") +
#  coord_polar(theta = "y") +
#  labs(title = "HERV_Non_Coding Proportions(HervD Atlas ; HERV Class)",x="",y="") +
#  geom_text(aes(label = sprintf("%.1f%%", HERV_Non_Coding_Proportion)), position = position_stack(vjust = 0.5), color = "black",size=4)

# 重塑数据
long_df <- gene_anno_df %>%
  select(Type, HERV_Coding_Proportion, HERV_Non_Coding_Proportion) %>%
  pivot_longer(cols = c("HERV_Coding_Proportion", "HERV_Non_Coding_Proportion"), names_to = "Category", values_to = "Proportion")

# 绘制堆叠条形图
ggplot(long_df, aes(x = Category, y = Proportion, fill = Type)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "", x = "Category", y = "Proportion") +
  geom_text(aes(label = sprintf("%.1f%%", Proportion)), position = position_stack(vjust = 0.5), color = "black", size = 3,family = "Times New Roman") + theme(axis.text.x = element_text(family = "Times New Roman"),axis.title.y = element_text(size = 10,family = "Times New Roman"),text = element_text(family = "Times New Roman")) # 旋转X轴标签以便阅读

dev.off()

##################### 重叠序列鉴定(Group分类)
### Test Database
gene_anno_t<-table(gene_anno[,c(2,4)])
colnames(gene_anno_t)<-c("Non-HERV_Coding","HERV_Coding","Non-HERV_Non-Coding","HERV_Non-Coding")
gene_anno_df <- as.data.frame.matrix(gene_anno_t)
gene_anno_df <- subset(gene_anno_df, row.names(gene_anno_df) != "Non-HERV" & row.names(gene_anno_df) != "Unfound" & row.names(gene_anno_df) != "-")

gene_anno_df$HERV_Coding_Proportion <- gene_anno_df$HERV_Coding / sum(gene_anno_df$HERV_Coding)*100
gene_anno_df$HERV_Non_Coding_Proportion <- gene_anno_df[,4] / sum(gene_anno_df[,4])*100
gene_anno_df$Type=row.names(gene_anno_df)

Need_Test=data.frame(Group=gene_anno_df$Type,R=gene_anno_df$HERV_Non_Coding_Proportion/gene_anno_df$HERV_Coding_Proportion)

### Train(Vaild;test)
gene_anno_tt<-table(gene_anno_all[,c(2,4)])
colnames(gene_anno_tt)<-c("Non-HERV_Coding","HERV_Coding","Non-HERV_Non-Coding","HERV_Non-Coding")
gene_anno_dft <- as.data.frame.matrix(gene_anno_tt)
gene_anno_dft <- subset(gene_anno_dft, row.names(gene_anno_dft) != "Non-HERV" & row.names(gene_anno_dft) != "Unfound" & row.names(gene_anno_dft)!="-")

gene_anno_dft$HERV_Coding_Proportion <- gene_anno_dft$HERV_Coding / sum(gene_anno_dft$HERV_Coding)*100
gene_anno_dft$HERV_Non_Coding_Proportion <- gene_anno_dft[,4] / sum(gene_anno_dft[,4])*100
gene_anno_dft$Type=row.names(gene_anno_dft)

Need_All=data.frame(Group=gene_anno_dft$Type,R=gene_anno_dft$HERV_Non_Coding_Proportion/gene_anno_dft$HERV_Coding_Proportion)

### Plot数据,Relative Enrichment Rate (相对富集率)
Need=data.frame(rbind(Need_Test,Need_All),Type=c(rep("HervD_Atlas(Test)",dim(Need_Test)[1]),rep("HervD_Atlas",dim(Need_All)[1])))
Need=subset(Need,R!="Inf")

# 合并数据框
merged_df <- merge(Need, unique(gene_anno_all[, c(1, 2)]), by.x = "Group", by.y = "V2", all.x = TRUE)
merged_df$V1 <- factor(merged_df$V1, levels = c('ERV3', 'ERV2', 'ERV1', 'ERVL-MaLR'))
merged_df <- merged_df[order(merged_df$V1), ]
merged_df$Group <- factor(merged_df$Group, levels = unique(merged_df$Group))

#par(mar = c(0.1, 0.95, 0.1, 0.95)) 
pdf("run4_plot-high-attention_explain_detail_line.pdf",width = 10, height = 5)
#par(family = "Times New Roman")
plot<-ggplot(data = merged_df, aes(x = Group, y = R, color = Type)) +
  geom_line(aes(group = Type), size = 1) + geom_point(size = 1.5) + 
  geom_hline(yintercept = 1/3, linetype = "dashed", color = "grey") + 
  geom_hline(yintercept = 3, linetype = "dashed", color = "red") + 
  annotate("text", x = Inf, y = 1/3, label = "HERV_Non_Coding(%)=1/3*HERV_Coding(%)", hjust = 1.5,vjust = 1, color = "black",size = 3,family = "Times New Roman") + annotate("text", x = Inf, y = 3, label = "HERV_Non_Coding(%)=3*HERV_Coding(%)", hjust = 1.5,vjust = -1.2, color = "red",size = 3,family = "Times New Roman") + coord_fixed(ratio = 2) + theme_classic()

# 准备一个数据框来确定每个V1类别的高亮区域
highlight_limits <- merged_df %>% group_by(V1) %>% summarize(start = first(Group), end = last(Group)) %>%ungroup()%>%mutate(color = case_when(
    V1 == "ERV1" ~ "red",V1 == "ERV2" ~ "blue",V1 == "ERV3" ~ "green",V1 == "ERVL-MaLR" ~ "purple",TRUE ~ "black"))
# 添加每个V1类别的高亮区域
for(i in 1:nrow(highlight_limits)) {
  plot <- plot + annotate("rect", xmin = as.numeric(highlight_limits$start[i])-0.2, xmax = as.numeric(highlight_limits$end[i])+0.2,ymin = 3.8, ymax = 4,fill=highlight_limits$color[i],alpha=0.5) + geom_text(data = highlight_limits,aes(x = (as.numeric(start) + as.numeric(end)) / 2, y = 4.1, label = V1),vjust = -0.5,color ="black",size=3,family = "Times New Roman") + labs(title = "",x="HERV Category(Class/Group)",y="Relative Enrichment Rate")
} 
#legend.title=element_text(face = "bold",size=9)
plot=plot+scale_y_continuous(breaks = c(seq(0, 5, 1), 1/3), labels = c(seq(0, 5, 1), "1/3"))+ expand_limits(y = 5)+theme(axis.text.x = element_text(angle=45,vjust = 0.6,color = "black"),plot.margin = margin(0, 0, 0, 0)) + theme(axis.title.x = element_text(size = 10),axis.title.y = element_text(size = 10),panel.grid=element_blank(),legend.position = c(0.1,0.95),plot.background = element_rect(fill = "white"),panel.background = element_rect(fill = "white"),plot.title = element_text(hjust = 0.5),legend.title = element_blank(),text = element_text(family = "Times New Roman"),plot.margin = margin(t = 0.05, r = 0.05, b = 0.1, l = 0.1, "cm"))   ### 
print(plot)
ggsave("run4_plot-high-attention_explain_detail_line.png",plot,dpi=2000,width = 10, height = 5)
dev.off()

#Sys.setenv(R_FONTS_USER="/home/u20111010010/Project/DNA-Pretraining/Level1/Manuscript/Times_New_Roman")
#CairoPNG("run4_plot-high-attention_explain_detail_line.png", width = 10, height = 5, units = "in", res = 300, family = "Nimbus Roman")
#print(plot)
#dev.off()


#pdftoppm -f 1 -l 2 -r 2000  -png run4_plot-high-attention_explain_detail_line.pdf run4_plot-high-attention_explain_detail_line
#plt.subplots_adjust(left=0.1, right=0.95, bottom=0.1, top=0.95)