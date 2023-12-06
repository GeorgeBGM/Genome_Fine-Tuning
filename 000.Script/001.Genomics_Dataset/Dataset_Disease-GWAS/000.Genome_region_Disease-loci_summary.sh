############### 确定的潜在疾病关联BED文件，/home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Disease_loci/HG38_Disease-loci_region_need.bed

################################################### 编码区Disease-loci
bedtools merge -i <(bedtools intersect -a /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Disease_loci/HG38_Disease-loci_region_need.bed -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gene.bed|sort -k1,1 -k2,2n) -d 10 -c 2 -o count|bedtools makewindows -b - -w 10000 -i srcwinnum|perl -lane '$L=$F[2]-$F[1];print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]" if $L>=150' >Need_All_Disease-loci_Coding-region-10kb_Merge_Anno.bed

#######  编码区的Non-Disease-loci序列
bedtools  shuffle -i  Need_All_Disease-loci_Coding-region-10kb_Merge_Anno.bed  -incl  <(bedtools subtract -a  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gene.bed  -b Need_All_Disease-loci_Coding-region-10kb_Merge_Anno.bed)  -excl /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Disease_loci/HG38_Disease-loci_region_need.bed  -g  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/hg38.genome  -seed 100 -chrom -noOverlapping  -maxTries 1000000 |sort -k1,1 -k2,2n >Need_All_Non_Disease-loci_Coding-region-10kb_Merge_Anno.bed

##################################################### 非编码区Disease-loci
bedtools intersect -a /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Disease_loci/HG38_Disease-loci_region_need.bed  -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.chr_Non-gene.bed|bedtools makewindows -b - -w 10000 -i srcwinnum|perl -lane '$L=$F[2]-$F[1];print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]" if $L>=150' >Need_All_Disease-loci_Non-Coding-region-10kb_Merge_Anno.bed

#######  非编码区的Non-Disease-loci区域序列
bedtools  shuffle -i  Need_All_Disease-loci_Non-Coding-region-10kb_Merge_Anno.bed  -incl  <(bedtools subtract -a  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.chr_Non-gene.bed  -b Need_All_Disease-loci_Non-Coding-region-10kb_Merge_Anno.bed)  -excl <(cat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Disease_loci/HG38_Disease-loci_region_need.bed  Need_All_Non_Disease-loci_Coding-region-10kb_Merge_Anno.bed)  -g  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/hg38.genome  -seed 100 -chrom -noOverlapping  -maxTries 1000000 |sort -k1,1 -k2,2n >Need_All_Non_Disease-loci_Non-Coding-region-10kb_Merge_Anno.bed

###### 区域检查
for i in `ls *10kb_Merge_Anno.bed`;do echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";for j in `ls *10kb_Merge_Anno.bed`;do echo "$i #### $j";bedtools intersect -a $i -b $j -wo|wc -l;done;done

######
mkdir  -p ./VCF_hprc-1000G/Train_Test  ./VCF_hprc-1000G/Disease-loci   ./VCF_hprc-1000G/Non-Disease-loci_Random