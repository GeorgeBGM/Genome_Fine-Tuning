library(ggplot2)
library(ggpubr)
library(png)
library(grid)
library(gridExtra)

#/opt/app/r/r4.2.2.1/bin/R
#/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/R
#/home/u20111010010/micromamba/envs/pdftools/bin/R

Raw_pca <-"/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/linkage_matrix.npy_PCA_visualization.png"
Raw_svd <-"/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/linkage_matrix.npy_TruncatedSVD_visualization.png"
Bert_pca <-"/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0_pca_visualization.png"
Bert_tsne <-"/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0_tsne_visualization.png"


# 第一步：将PDF转换为R中的图像对象
# Convert the images to raster grobs
grob_a <- rasterGrob(img_a, interpolate = TRUE)
grob_b <- rasterGrob(img_b, interpolate = TRUE)
grob_c <- rasterGrob(img_c, interpolate = TRUE)
grob_d <- rasterGrob(img_d, interpolate = TRUE)

# 创建标签 "A" 和 "B"
label_A <- textGrob("A", x = 0.05, y = 0.95, just = "left", gp = gpar(fontface = "bold", size = 20,family = "Times New Roman"))
label_B <- textGrob("B", x = 0.05, y = 0.95, just = "left", gp = gpar(fontface = "bold", size = 20,family = "Times New Roman"))
label_C <- textGrob("C", x = 0.05, y = 0.95, just = "left", gp = gpar(fontface = "bold", size = 20,family = "Times New Roman"))
label_D <- textGrob("D", x = 0.05, y = 0.95, just = "left", gp = gpar(fontface = "bold", size = 20,family = "Times New Roman"))

##### Merge
combined_plot <- ggarrange(plotlist = [grob_a,grob_b,grob_c,grob_d], ncol = 2,nrow=2,align  = "hv",labels = c("A","B","C","D"),font.label=list(size=18,face="bold",family = "Times New Roman"),label.x=0,label.y=0.98,common.legend = TRUE)  ###font.label=list(size=28,face="bold")

#+ theme(legend.position = "none")

# 保存合并后的图为 PDF 文件
ggsave("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Merge_plot_feature_visualization-HERV_Figure.pdf", combined_plot, width = 10, height = 10)
# 保存相同的图像为 PNG，可以通过更改文件扩展名来自动更改设备类型
ggsave("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Merge_plot_feature_visualization-HERV_Figure.png", combined_plot, width = 10, height = 10, dpi = 1200)
#ggsave("Merge_plot_feature_visualization-HERV_Figure.pdf", combined_plot, width = 20, height = 20)