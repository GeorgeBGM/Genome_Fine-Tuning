library(ggplot2)
library(ggrepel)

# 数据A
data_A <- data.frame(
  gene_type = c("IG_V_gene","lncRNA", "processed_pseudogene", "protein_coding", 
                "transcribed_processed_pseudogene", "transcribed_unitary_pseudogene",
                "transcribed_unprocessed_pseudogene", "TEC", 
                "unprocessed_pseudogene"),
  count = c(1,1976,12,3064,28,9,37,1,68)
)

# 数据B
data_B <- data.frame(
  feature_type = c("CTCF_binding_site", "enhancer", "open_chromatin_region", 
                   "promoter", "TF_binding_site"),
  count = c(235,1351, 214, 95, 95)
)

# 计算数据A的百分比
data_A$percentage <- (data_A$count / sum(data_A$count)) * 100
data_A$label <- ifelse(data_A$percentage > 0.6, sprintf("%.1f%%", data_A$percentage), "")

# 计算数据B的百分比
data_B$percentage <- (data_B$count / sum(data_B$count)) * 100

pdf("run5_fimo-high-attention_sequence-overlap_pie-plotshow.pdf")
# 绘制数据A的饼图
ggplot(data_A, aes(x = "", y = count, fill = gene_type)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  labs(title = "Gene Types Overlap", fill = "Gene Type") +
  geom_text(aes(label = label), position = position_stack(vjust = 0.5), color = "black",size=4)

# 绘制数据B的饼图
ggplot(data_B, aes(x = "", y = count, fill = feature_type)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar(theta = "y") +
  labs(title = "Functional Feature Overlap", fill = "Feature Type") +
  geom_text(aes(label = sprintf("%.1f%%", percentage)), position = position_stack(vjust = 0.5), color = "black",size=4)

dev.off()

