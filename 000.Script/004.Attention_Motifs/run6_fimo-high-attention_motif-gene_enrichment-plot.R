library(dplyr) 
library(ggplot2)
library(aplot) 

#/opt/app/r/r4.2.2.1/bin/R
###################################  类似气泡图

### 功能富集
out1<-read.csv("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Motif_Enrichment/Functional_enrichment-disease-merge_analysis.txt",sep="\t",head=T)
out1$Trait <- factor(out1$Trait, levels = out1$Trait[!duplicated(out1$Trait)])

pdf("/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run6_fimo-high-attention_motif-gene_enrichment-plot.pdf")

Chromosome <- out1$Trait %>% as.data.frame() %>%
  mutate(group=out1$Class) %>%
  mutate(p="")%>%
  ggplot(aes(p,.,fill=group))+
  geom_tile() + 
  scale_y_discrete(position="right") +
  theme_minimal()+xlab(NULL) + ylab(NULL) +
   theme(axis.text.y = element_blank(),legend.position = "right",legend.text = element_text(size=5),legend.title = element_text(size=7),
        axis.text.x =element_text(
          angle =90,hjust =0.5,vjust = 0.5))+
  labs(fill = "Class")


p1<-ggplot(out1, aes(Count,Trait)) +
  geom_point(aes(color=LogP, size=Count))+theme_bw()+
  theme(panel.grid = element_blank(),
        axis.text.x=element_text(angle=90,hjust = 1,vjust=0.5))+
  scale_color_gradient(low='#6699CC',high='#CC3333')+
  labs(x="Gene_InTerm",y=NULL)+guides(size=guide_legend(order=1))+
  theme(legend.direction = "vertical", legend.position = "right",axis.text.y=element_text(vjust=1,size=5,lineheight=10),axis.text.x=element_text(angle=45),legend.text = element_text(size=5),legend.title = element_text(size=7))+#legend水平置于顶部
  scale_y_discrete(position = "right")#y轴文字放右侧

p1
p1%>%
  insert_left(Chromosome, width =0.05)

dev.off()