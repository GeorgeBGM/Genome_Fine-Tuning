############### 所有人类DEF（防御素）和OR（嗅觉受体）的BED文件，/home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Highly_Specifically_Gene/HG38_Highly_Specifically_Gene-DEF_region_need.bed;/home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Highly_Specifically_Gene/HG38_Highly_Specifically_Gene-OR_region_need.bed


###################################################   人类DEF（防御素）
cat  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Highly_Specifically_Gene/HG38_Highly_Specifically_Gene-DEF_region_need.bed|bedtools makewindows -b - -w 1000 -i srcwinnum|perl -lane '$L=$F[2]-$F[1];print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]" if $L>=150' >Need_All_Highly_Specifically_DEF-region-10kb_Merge_Anno.bed

###################################################   人类OR（嗅觉受体）
cat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Highly_Specifically_Gene/HG38_Highly_Specifically_Gene-OR_region_need.bed|bedtools makewindows -b - -w 1000 -i srcwinnum|perl -lane '$L=$F[2]-$F[1];print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]" if $L>=150' >Need_All_Highly_Specifically_OR-region-10kb_Merge_Anno.bed

#####################################################  全基因组Non-DEF_OR
######  全基因组的Non-DEF_OR区域
bedtools subtract -a /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.chr.bed  -b <(bedtools slop -i <(cat  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Highly_Specifically_Gene/HG38_Highly_Specifically_Gene-DEF_region_need.bed  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Highly_Specifically_Gene/HG38_Highly_Specifically_Gene-OR_region_need.bed) -g /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/hg38.genome -b 1000000) >/home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Highly_Specifically_Gene/HG38_Highly_Specifically_Gene-Non-DEF_OR_region_need-1Mb.bed

#######  全基因组的Non-DEF_OR序列
bedtools  shuffle -i  <(cat Need_All_Highly_Specifically_DEF-region-10kb_Merge_Anno.bed  Need_All_Highly_Specifically_OR-region-10kb_Merge_Anno.bed )  -incl  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Highly_Specifically_Gene/HG38_Highly_Specifically_Gene-Non-DEF_OR_region_need-1Mb.bed  -excl <(cat  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Highly_Specifically_Gene/HG38_Highly_Specifically_Gene-DEF_region_need.bed  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Highly_Specifically_Gene/HG38_Highly_Specifically_Gene-OR_region_need.bed)  -g  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/hg38.genome  -seed 100 -chrom -noOverlapping  -maxTries 1000000 |perl -lane '$L=$F[2]-$F[1];print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]" if $L>=150' >Need_All_Highly_Specifically_Non-DEF_OR-region-10kb_Merge_Anno.bed


#############
for i in `ls *10kb_Merge_Anno.bed`;do  echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";for j in `ls *10kb_Merge_Anno.bed`;do echo "$i #### $j";bedtools intersect -a $i -b $j -wo|wc -l;done;done

#############
mkdir  -p ./VCF_hprc-1000G/Train_Test  ./VCF_hprc-1000G/Highly_Specifically   ./VCF_hprc-1000G/Non-Highly_Specifically_Random