################## Step2

### /opt/app/r/r4.2.2.1/bin/R

library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(ggsci)
library(ggrepel)

##
library(extrafont);font_import()
############################### 鉴定地复杂区域
phy <- read_delim("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run6_fimo-high-attention_motif-converse_primate.phyloP27way_anno.tab",delim = "\t",col_names = F)
phy<-phy[,c(1,6,7)]
colnames(phy) <- c("trans", "phy_score","gene")
pha <- read_delim("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run6_fimo-high-attention_motif-converse_primate.phastCons27way_anno.tab", delim = "\t", col_names = F)
pha<-pha[,c(1,6,7)]
colnames(pha) <- c("trans", "pha_score","gene")
ph <- left_join(phy, pha, by = "trans")

x <- 0.75
y <- 0.3

ph$class <- NA
ph$class[ph$phy_score > x & ph$pha_score > y] <- "phy & pha"
ph$class[ph$phy_score > x & ph$pha_score <= y] <- "only phy"
ph$class[ph$phy_score <= x & ph$pha_score > y] <- "only pha"
ph$class[ph$phy_score <= x & ph$pha_score <= y] <- "none"
colnames(ph) <- c("trans", "x","gene.x","y","gene.y","class")


filtered_data <- ph %>% filter(gene.x %in% c("OTUD7A","PEX2","CSGALNACT2","CCDC200","CD200","CD226","CLEC4E","ADCY1","ABL1","ADRA1A","NRG3","RAB3GAP1","CYP27A1","AACS","ALDH3A2","ZEB2","ROR1"))
colnames(filtered_data) <- c("trans", "x","gene.x","y","gene.y","class")

filtered_data <- filtered_data %>%
  group_by(gene.x) %>%                    # 按基因名(V5列)分组
  slice_max(order_by = x, n = 1) %>%      # slice(1) %>% , 选择每组的第一条记录
  ungroup()

filtered_data=subset(filtered_data,gene.x==gene.y)

    #geom_text_repel(data = filtered_data, aes(x = x, y = y, label = gene.x),color = "black", size = 4, nudge_y = 0.05,direction = "y", hjust = 0.5, segment.size = 0.2, segment.color = "grey50",min.segment.length=0.5,force = 2,box.padding = unit(0.5, "lines"), point.padding = unit(0.8, "lines"),family = "Times New Roman") +

pdf("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run6_fimo-high-attention_motif-converse_primate-plot_new_need.pdf")

p<-ggplot(data=ph, aes(x= x, y= y, fill= class, color = class)) + 
    geom_point(shape=21, size=2) +   ###,fill=NA,空心圆
    geom_text_repel(data = filtered_data, 
                    aes(x = x, y = y, label = gene.x),
                    color = "black", size = 3, nudge_y = 1,
                    direction = "y", hjust = 0.5, 
                    segment.size = 0.2, segment.color = "grey50",
                    box.padding=0.5,point.padding=0.8,min.segment.length=0.5,force = 2)+
    scale_fill_aaas(alpha = .6) +
    scale_color_aaas(alpha = .6) +
    geom_vline(xintercept = x, linetype = 2) +
    geom_hline(yintercept = y, linetype = 2) +
    coord_cartesian(xlim = c(-1, 1), ylim = c(0, 1)) +  # 使用coord_cartesian替代xlim和ylim
    labs(x = "phyloP", y = "phastCons") +
    theme_classic() +
    theme(legend.position = c(0.15, 0.84),legend.text = element_text(size = 12),legend.title = element_blank(),text = element_text(family = "Times New Roman"),plot.background = element_rect(fill = "white", color = NA)) 

print(p)
ggsave("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run6_fimo-high-attention_motif-converse_primate-plot_new_need.png",p,dpi = 2000)
dev.off()