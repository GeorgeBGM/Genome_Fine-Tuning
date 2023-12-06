#### A.编码区域的Non-HERV区间

####### 生成限制区间范围
bedtools subtract -a /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gene.bed -b /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/Tissue_All_HERV_Coding-region_Merge_Anno.bed|sort -k1,1 -k2,2n >Tissue_All_Non-HERV_Coding-region.bed

bedtools merge -i Tissue_All_Non-HERV_Coding-region.bed  -d 10 -c 2 -o count >Tissue_All_Non-HERV_Coding-region_Merge.bed

bedtools intersect -a Tissue_All_Non-HERV_Coding-region_Merge.bed -b Tissue_All_Non-HERV_Coding-region.bed -wo|perl -le 'while(<>){chomp;@F=split/\s+/,$_;push @{$hash{"$F[0]\t$F[1]\t$F[2]"}},$F[7];}END{foreach my $key(keys %hash){print "$key\t",join(",",@{$hash{$key}});};}'|sort -k1,1 -k2,2n|perl -lane '$Len=$F[2]-$F[1];print if $Len >= 150;'>Tissue_All_Non-HERV_Coding-region_Merge_Anno.bed

######## 在限制区间内生成和目标区间等长的区间（非随机选取）
#bedtools closest  -a Tissue_All_HERV_Coding-region_Merge_Anno.bed  -b Tissue_All_Non-HERV_Coding-region_Merge_Anno.bed

######## 在限制区间内生成和目标区间等长的区间（随机选取） 
grep -v '_'  /home/u20111010010/Project/Pan-genome/000.Data/REF/refdata-GRCh38-2.1.0/fasta/genome.fa.fai|perl -lane 'print "$F[0]\t$F[1]";' >hg38.genome

### Tissue_All_Non-HERV_Coding-region_Merge_Anno.bed  包含基因注释信息
### Tissue_All_Non-HERV_Coding-region_Merge_Anno_need_shuffle.bed  携带HERV信息

bedtools  shuffle -i /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/Tissue_All_HERV_Coding-region_Merge_Anno.bed  -incl Tissue_All_Non-HERV_Coding-region_Merge_Anno.bed  -excl <(cat  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/Tissue_All_HERV_Coding-region_Merge_Anno.bed  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/Tissue_All_HERV_Non-Coding-region_Merge_Anno.bed) -g hg38.genome  -seed 100 -chrom -noOverlapping -maxTries 100000|sort -k1,1 -k2,2n >Tissue_All_Non-HERV_Coding-region_Merge_Anno_need_shuffle.bed

#### B.非编码区域的Non-HERV区间

####### 生成限制区间范围
bedtools subtract -a /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.chr_Non-gene.bed  -b /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/Tissue_All_HERV_Non-Coding-region_Merge_Anno.bed|sort -k1,1 -k2,2n >Tissue_All_Non-HERV_Non-Coding-region.bed

bedtools merge -i Tissue_All_Non-HERV_Non-Coding-region.bed  -d 10 -c 2 -o count |perl -lane '$Len=$F[2]-$F[1];print if $Len >= 150;'>Tissue_All_Non-HERV_Non-Coding-region_Merge.bed

######## 在限制区间内生成和目标区间等长的区间（随机选取），排除非编码区域的HERV区间和编码区域的Non-HERV区间
bedtools  shuffle -i <(perl -lane 'print "$F[0]\t$F[1]\t$F[2]\t$F[3]"' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/Tissue_All_HERV_Non-Coding-region_Merge_Anno.bed)  -incl Tissue_All_Non-HERV_Non-Coding-region_Merge.bed  -excl <(cat  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/Tissue_All_HERV_Coding-region_Merge_Anno.bed  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/Tissue_All_HERV_Non-Coding-region_Merge_Anno.bed  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/Tissue_All_Non-HERV_Coding-region_Merge_Anno_need_shuffle.bed) -g hg38.genome  -seed 100 -chrom -noOverlapping -maxTries 100000 |sort -k1,1 -k2,2n >Tissue_All_Non-HERV_Non-Coding-region_Merge_Anno_need_shuffle.bed 
#chmod 755 Tissue_All_Non-HERV_Coding-region_Merge_Anno.bed Tissue_All_Non-HERV_NonCoding-region_Merge_Anno.bed

chmod 755 Tissue_All_Non-HERV_Coding-region_Merge_Anno_need_shuffle.bed  Tissue_All_Non-HERV_Non-Coding-region_Merge_Anno_need_shuffle.bed


### 两集合内部无重复且无重叠
#bedtools intersect -a Tissue_All_Non-HERV_Coding-region_Merge_Anno_need_shuffle.bed  -b  Tissue_All_Non-HERV_Non-Coding-region_Merge_Anno_need_shuffle.bed -wo
#cat Tissue_All_Non-HERV_Coding-region_Merge_Anno_need_shuffle.bed|perl -le 'while(<>){chomp;@F=split/\s+/,$_;$b+=($F[2]-$F[1]);}END{print $b;}'