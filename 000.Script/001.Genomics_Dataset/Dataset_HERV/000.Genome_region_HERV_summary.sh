#### HERV在不同组织间的表达区域（合并区间 + >=150bp）

cat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HERV/SERVE/Annotation/*gtf|perl -le 'while(<>){chomp;@F=split/\s+/,$_;if(/gene_id \"(.*?)\"\;/){$transcript_id=$1;};print "$F[0]\t$F[3]\t$F[4]\t$transcript_id" if $F[2] eq "transcript"}'|sort -k1,1 -k2,2n >Tissue_All_HERV_Coding-region.bed

bedtools merge -i Tissue_All_HERV_Coding-region.bed  -d 10 -c 2 -o count >Tissue_All_HERV_Coding-region_Merge.bed
bedtools intersect -a Tissue_All_HERV_Coding-region_Merge.bed -b Tissue_All_HERV_Coding-region.bed -wo|perl -le 'while(<>){chomp;@F=split/\s+/,$_;push @{$hash{"$F[0]\t$F[1]\t$F[2]"}},$F[7];}END{foreach my $key(keys %hash){print "$key\t",join(",",@{$hash{$key}});};}'|sort -k1,1 -k2,2n|perl -lane '$Len=$F[2]-$F[1];print if $Len >= 150;'>Tissue_All_HERV_Coding-region_Merge_Anno.bed

cat Tissue_All_HERV_Coding-region_Merge_Anno.bed|perl -le 'while(<>){chomp;@F=split/\s+/,$_;$b+=($F[2]-$F[1]);}END{print $b;}'    ### 20.514Mb

#### 非编码区域的HERV
#/home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HERV/SERVE/Annotation/HERV_noncoding.bed.gz

zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HERV/SERVE/Annotation/HERV_noncoding.bed.gz|perl -le 'while(<>){chomp;@F=split/\s+/,$_;$b+=($F[2]-$F[1]);}END{print $b;}'   ### 326.69Mb

#### HERV的区间重合情况（编码区域；非编码区域）
bedtools merge -i <(bedtools subtract -a <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HERV/SERVE/Annotation/HERV_noncoding.bed.gz) -b Tissue_All_HERV_Coding-region_Merge_Anno.bed|sort -k1,1 -k2,2n) | perl -lane '$Len=$F[2]-$F[1];print if $Len >= 150;' >Tissue_All_HERV_Non-Coding-region_Merge.bed

bedtools intersect -a Tissue_All_HERV_Non-Coding-region_Merge.bed -b <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HERV/SERVE/Annotation/HERV_noncoding.bed.gz) -wo|perl -le 'while(<>){chomp;@F=split/\s+/,$_;push @{$hash{"$F[0]\t$F[1]\t$F[2]"}},$F[6];}END{foreach my $key(keys %hash){print "$key\t",join(",",@{$hash{$key}});};}'|sort -k1,1 -k2,2n|perl -lane '$Len=$F[2]-$F[1];print if $Len >= 150;'>Tissue_All_HERV_Non-Coding-region_Merge_Anno.bed

cat Tissue_All_HERV_Non-Coding-region_Merge_Anno.bed|perl -le 'while(<>){chomp;@F=split/\s+/,$_;$b+=($F[2]-$F[1]);}END{print $b;}'    ### 282.363Mb

chmod 755 Tissue_All_HERV_Coding-region_Merge_Anno.bed Tissue_All_HERV_Non-Coding-region_Merge_Anno.bed

### 两集合内部无重复且无重叠
#bedtools intersect -a Tissue_All_HERV_Coding-region_Merge_Anno.bed    -b  Tissue_All_HERV_Non-Coding-region_Merge_Anno.bed -wo

for i in `ls Tissue_All_Non-HERV*Merge_Anno_need_shuffle.bed  Tissue_All_HERV_*-region_Merge_Anno.bed`;do  echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";for j in `ls Tissue_All_Non-HERV*Merge_Anno_need_shuffle.bed  Tissue_All_HERV_*-region_Merge_Anno.bed`;do echo "$i #### $j";bedtools intersect -a $i -b $j -wo|wc -l;done;done