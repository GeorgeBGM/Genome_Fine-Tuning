############### 所有免疫序列的BED文件，/home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Immunogenetics/HG38_Immunogenetics_region_need.bed

### LRC/KIR免疫区域序列；
bedtools intersect -a <(echo -en "chr19\t54015634\t55094318\tLRC/KIR") -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Immunogenetics/HG38_Immunogenetics_region_need.bed -wo|bedtools makewindows -b - -w 10000 -i srcwinnum|perl -lane '$L=$F[2]-$F[1];print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]" if $L>=150' >Need_All_Immuno_KIR-region-10kb_Merge_Anno.bed

### Non-LRC/KIR免疫区域序列；
bedtools subtract -a /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Immunogenetics/HG38_Immunogenetics_region_need.bed  -b <(echo -en "chr19\t54015634\t55094318\tLRC/KIR")|bedtools makewindows -b - -w 10000 -i srcwinnum|sort -k1,1 -k2,2n|perl -lane '$L=$F[2]-$F[1];print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]" if $L>=150' >Need_All_Immuno_Others-region-10kb_Merge_Anno.bed

### 非免疫区域序列

#### 免疫区域往外拓展1M后(左右)，取全基因组的差集
bedtools slop -i /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Immunogenetics/HG38_Immunogenetics_region_need.bed -g /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/hg38.genome -b 1000000 >/home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Immunogenetics/HG38_Immunogenetics_region_need_1Mb.bed

bedtools subtract -a <(perl -lane 'print "$F[0]\t1\t$F[1]"'  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/hg38.genome|grep -v 'hs38d1')  -b  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Immunogenetics/HG38_Immunogenetics_region_need_1Mb.bed|sort -k1,1 -k2,2n > /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Immunogenetics/HG38_Immunogenetics_region_need_1Mb-Non.bed

#### 全基因组非免疫区域随机选择同免疫区域等长的参考序列(以i的区间长度在基因组范围内随机选取)
bedtools  shuffle -i <(cat /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/Need_All_Immuno_KIR-region-10kb_Merge_Anno.bed  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/Need_All_Immuno_Others-region-10kb_Merge_Anno.bed)   -incl /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Immunogenetics/HG38_Immunogenetics_region_need_1Mb-Non.bed  -excl /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Immunogenetics/HG38_Immunogenetics_region_need_1Mb.bed -g /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/hg38.genome  -seed 100 -noOverlapping|sort -k1,1 -k2,2n|perl -lane '$L=$F[2]-$F[1];print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]" if $L>=150' >Need_All_Non-Immuno-region-10kb_shuffle.bed


chmod 755 Need_All_Immuno_KIR-region-10kb_Merge_Anno.bed Need_All_Immuno_Others-region-10kb_Merge_Anno.bed Need_All_Non-Immuno-region-10kb_shuffle.bed

### 两集合内部无重复且无重叠
#bedtools intersect -a /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Immunogenetics/HG38_Immunogenetics_region_need_1Mb.bed -b  Need_All_Non-Immuno-region-10kb_shuffle.bed -wo

###
for i in `ls  Need_All*.bed`;do echo "*********************************************************************************";for j in `ls  Need_All*.bed`;do echo "$i #### $j";bedtools intersect -a $i -b $j -wo|wc -l;done;done