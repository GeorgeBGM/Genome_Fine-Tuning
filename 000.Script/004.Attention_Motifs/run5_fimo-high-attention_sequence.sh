################################################# 数据集中Motif寻找(High_attention)
######  HERV_Coding
/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/fimo  --o Fimo_HERV_Coding  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_meme.txt /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_attention_seqs/HERV_Coding_high_attention.fa

######  HERV_Non-Coding
/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/fimo  --o Fimo_HERV_Non-Coding  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_meme.txt /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_attention_seqs/HERV_Non-Coding_high_attention.fa

######  Non-HERV_Coding 
/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/fimo  --o Fimo_Non-HERV_Coding  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_meme.txt /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_attention_seqs/Non-HERV_Coding_high_attention.fa

######  Non-HERV_Non-Coding
/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/fimo  --o Fimo_Non-HERV_Non-Coding  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_meme.txt /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_attention_seqs/Non-HERV_Non-Coding_high_attention.fa

################################################# 数据集中Motif寻找(原始数据集)
######  HERV_Coding
/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/fimo  --o Fimo_HERV_Coding_Raw  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_meme.txt   /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_HERV_Coding_Test.fa

######  HERV_Non-Coding
/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/fimo  --o Fimo_HERV_Non-Coding_Raw  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_meme.txt  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_HERV_Non-Coding_Test.fa

######  Non-HERV_Coding 
/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/fimo  --o Fimo_Non-HERV_Coding_Raw  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_meme.txt  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_Non-HERV_Coding_Test.fa

######  Non-HERV_Non-Coding
/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/fimo  --o Non-HERV_Non-Coding_Raw  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_meme.txt   /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_Non-HERV_Non-Coding_Test.fa

#<(grep '^test' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_model_HERV-Classification_Need.fa|perl -e 'while(<>){chomp;@F=split/\s+/,$_;@FF=split/\_/,$F[-1];print ">$FF[0]\n$F[3]\n" if ($F[1]==2);}')

################################################# 数据集中Motif富集和功能分类
perl -ne 'if(/AC (.+?)\n/){$ac=$1;} if(/ID (.+?)\n/){$id=$1;} if(/CC tax_group:(.+?)\n/){$tax=$1;} if(/CC tf_family:(.+?)\n/){$family=$1;} if(/CC tf_class:(.+?)\n/){$class=$1;} if(/CC pubmed_ids:(.+?)\n/){$pubmed=$1;} if(/CC uniprot_ids:(.+?)\n/){$uniprot=$1;} if(/CC data_type:(.+?)\n/){$data=$1;} if(/\/\//){print "$ac\t$id\t$tax\t$family\t$class\t$pubmed\t$uniprot\t$data\n";}'  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_transfac.txt >/home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_transfac-infor.txt


################################################# 数据集中Motif分组分析
/opt/app/r/r4.2.2.1/bin/Rscript  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run5_fimo-high-attention_sequence-motif.R

################################################# 数据对应至HG38坐标（可在提取Attention的时候对应）
#/home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_model_HERV-Classification_Need.fa
#/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment.txt
#/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_HERV*/fimo.tsv

### HERV_Non-Coding(3)---特异+两者均有部分,/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_HERV_Non-Coding/fimo.tsv
perl -le 'open(IN,$ARGV[0]);open(IN1,$ARGV[1]);while(<IN>){chomp;@F=split/\t+/,$_;$hash{$F[0]}=$F[7];};while(<IN1>){chomp;@F=split/\t+/,$_;next if ($F[-2]>0.05);if(exists($hash{$F[1]})){print "$hash{$F[1]}\t",$_;};};' <(egrep -v 'HERV_Coding|Control'  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment.txt|perl -lane 'print if $F[9]<=0.05')  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_HERV_Non-Coding/fimo.tsv  > /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Non-Coding.txt

perl -le 'open(IN,$ARGV[0]);open(IN1,$ARGV[1]);while(<IN>){chomp;@F=split/\s+/,$_;@HG38=split/\:|\-|\_/,$F[-1];$index=$.-1;$hash{$index}=join("\t",@HG38[0..2]);};while(<IN1>){chomp;@F=split/\s+/,$_;@FF=split/\_/,$F[3];if(exists($hash{$FF[0]})){print "$_\t",$hash{$FF[0]};};}'  <(perl -lane 'print if ($F[1]==3) && ($F[0] eq "test")' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_model_HERV-Classification_Need.fa)   /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Non-Coding.txt >/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Non-Coding_HG38.txt

### HERV_Coding,/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_HERV_Coding/fimo.tsv
perl -le 'open(IN,$ARGV[0]);open(IN1,$ARGV[1]);while(<IN>){chomp;@F=split/\t+/,$_;$hash{$F[0]}=$F[7];};while(<IN1>){chomp;@F=split/\t+/,$_;next if ($F[-2]>0.05);if(exists($hash{$F[1]})){print "$hash{$F[1]}\t",$_;};};' <(egrep -v 'HERV_NonCoding|Control'  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment.txt|perl -lane 'print if $F[9]<=0.05')  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_HERV_Coding/fimo.tsv  > /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Coding.txt

perl -le 'open(IN,$ARGV[0]);open(IN1,$ARGV[1]);while(<IN>){chomp;@F=split/\s+/,$_;@HG38=split/\:|\-|\_/,$F[-1];$index=$.-1;$hash{$index}=join("\t",@HG38[0..2]);};while(<IN1>){chomp;@F=split/\s+/,$_;@FF=split/\_/,$F[3];if(exists($hash{$FF[0]})){print "$_\t",$hash{$FF[0]};};}'   <(perl -lane 'print if ($F[1]==1) && ($F[0] eq "test")' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_model_HERV-Classification_Need.fa)    /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Coding.txt >/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Coding_HG38.txt

### 对应HG38的序列详细检查,/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment*HG38.txt,/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Coding_HG38.txt
# /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_model_HERV-Classification_Need.fa 

#run5_fimo-high-attention_sequence-HG38_Check_Need.sh

### 根据Motif进行合并(重叠区间;10bp以内)
cat  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment*HG38.txt |perl -le 'while(<>){chomp;@F=split/\s+/,$_;@FF=split/\_/,$F[3];$start1=$FF[1]+$F[-2]+$F[4];$end1=$FF[1]+$F[-2]+$F[5];print "$F[-3]\t$start1\t$end1\t$F[2]\t$F[0]";}'|sort -k1,1 -k2,2n -k4,4|perl -ane 'BEGIN{($c, $s, $e, $t)=(0,0,0,""); %n=()} if($F[0] eq $c && $F[1]-$e<=10){$n{$F[3]}++;$e=$F[2]}else{if($e){print"$c\t$s\t$e\t",join(",", keys%n),"\t$t\n"} ($c, $s, $e, $t)=@F[0,1,2,4]; %n=(); $n{$F[3]}++} END{print"$c\t$s\t$e\t",join(",", keys%n),"\t$t\n" if $e}'   >/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed

#bedtools merge -i  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'print  "$F[0]\t$F[3]\t$F[4]" if  $F[2]=~/gene/') -c 2 -o count

### 与全序列重叠区域对比（138,152kb完全重合区域对应高注意力富集区域174,460kb，其中高注意力富集区域累计311,857bp;） ### 4,836,339bp全基因组扫描累计区域
bedtools intersect -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_Raw.bed -wo|perl -lane 'print join("\t",@F[0..2])'|sort -u|perl -le 'while(<>){chomp;@F=split/\s+/,$_;$L+=($F[2]-$F[1]);}END{print $L;}' 

################################################# 数据集中HERV特异Motif富集区段功能分析,数目类型堆叠图（*）
### 调控元件情况
### HERV特异Motif富集区段的功能元件类型及比率
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.gff.gz|perl -lane 'print "chr$F[0]\t$F[3]\t$F[4]\t$F[2]"')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -wo|grep -v 'M'|perl -lane 'print $F[3]'|sort|uniq -c
#perl -le 'while(<>){chomp;@F=split/\s+/,$_;next if $F[-1]<150;$L+=$F[-1];}END{print $L}'

### 重合基因类型占比情况
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_name=(.*?);/){$Gene=$1};if(/gene_type=(.*?);/){$Type=$1};if(/gene_id=(.*?);/){$gene_id=$1;@gene_id_all=split/\./,$gene_id;};print  "$F[0]\t$F[3]\t$F[4]\t$Gene\t$gene_id_all[0]\t$gene_id\t$Type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -wo |grep -v 'M'|perl -lane 'print $F[6]'|sort|uniq -c 

### 饼状图展示
/opt/app/r/r4.2.2.1/bin/Rscript  run5_fimo-high-attention_sequence-overlap_pie.R

### HERV的类型统计情况
bedtools intersect -a  <(perl -le 'while(<>){chomp;next if /^More/ or /Position/;@F=split/\t+/,$_;@FF=split/\:|\-/,$F[2];print join("\t",@FF),"\t",join("\t",@F[0..$#F-1]);}'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HervD_Atlas/HERV_Detail.txt)  -b  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -wo|perl -lane 'print join("\t",@F[0..11]),"\t$F[-2]\t$F[-6]:$F[-5]-$F[-4]\t$F[-3]"'|sort -k12nr|perl -lane  'print "$F[0]\t$F[1]\t$F[2]\t$F[3]\t$F[8]"'|sort -u|perl -lane 'print $F[-1]'|sort |uniq -c

### 累计重合长度
bedtools intersect -a  <(perl -le 'while(<>){chomp;next if /^More/ or /Position/;@F=split/\t+/,$_;@FF=split/\:|\-/,$F[2];print join("\t",@FF),"\t",join("\t",@F[0..$#F-1]);}'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HervD_Atlas/HERV_Detail.txt)  -b  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -wo|perl -le 'while(<>){chomp;@F=split/\s+/,$_;$L+=($F[-4]-$F[-5]);}END{print $L;}'

########################
### 编码基因列表,CNTNAP2、RBFOX1和FHIT有更多的重合Motif片段
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_name=(.*?);/){$Gene=$1};if(/gene_type=(.*?);/){$Type=$1};if(/gene_id=(.*?);/){$gene_id=$1;@gene_id_all=split/\./,$gene_id;};print  "$F[0]\t$F[3]\t$F[4]\t$Gene\t$gene_id_all[0]\t$gene_id\t$Type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -wo |grep -v 'M'|grep 'protein_coding'|perl -lane 'print $F[3] if ($F[-1]>=10)'|sort|uniq -c|sort -k1nr|perl -lane 'print $F[1]' >/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge-Protein_coding-genes.bed

###### 5个以上的多个特异Motif片段重合基因 
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_name=(.*?);/){$Gene=$1};if(/gene_type=(.*?);/){$Type=$1};if(/gene_id=(.*?);/){$gene_id=$1;@gene_id_all=split/\./,$gene_id;};print  "$F[0]\t$F[3]\t$F[4]\t$Gene\t$gene_id_all[0]\t$gene_id\t$Type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -wo |grep -v 'M'|grep 'protein_coding'|perl -lane 'print "$F[3]\t$F[10]" if ($F[-1]>=10)'|sort -u|perl -lane 'print $F[0]'|sort|uniq -c|sort -k1nr|perl -lane 'print $F[1] if $F[0]>=5'

#################################################  保守性
bash run6_fimo-high-attention_motif-converse_primate.sh
bash run6_fimo-high-attention_motif-converse_population.sh
/opt/app/r/r4.2.2.1/bin/Rscript  run6_fimo-high-attention_motif-converse_primate-plot.R
/opt/app/r/r4.2.2.1/bin/Rscript  run6_fimo-high-attention_motif-converse_population-plot.R

#################################################  致病性得分

################################ 致病性SNPs(HERV)
#/home/u20111010010/Project/Complex-genome/001.HERV-Virus/Result/004.Complex-Genome_HERV_Aligned-virus_SNPs_PrimateAI-Overlap_Mean-value.pos
#/home/u20111010010/Project/Complex-genome/001.HERV-Virus/Result/004.Complex-Genome_HERV_Aligned-virus_SNPs_AlphaMissense-Overlap_Mean-value.pos

## PrimateAI_scores
bedtools intersect -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b <(zcat /home/u20111010010/Project/Complex-genome/000.Data/Primate/Primate_AI/PrimateAI_scores_v0.2_hg38.tsv.gz | perl -lane 'print "$F[0]\t$F[1]\t$F[1]\t$_" if $.>12') -wo > /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge-SNPs-PrimateAI_scores.bed

#bedtools intersect -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b  /home/u20111010010/Project/Complex-genome/001.HERV-Virus/Result/004.Complex-Genome_HERV_Aligned-virus_SNPs_PrimateAI-Overlap_Mean-value.pos -wo 

## AlphaMissense_scores
bedtools intersect -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b  <(zcat /home/u20111010010/Project/Complex-genome/000.Data/Primate/AlphaMissense/AlphaMissense_hg38.tsv.gz | perl -lane 'print "$F[0]\t$F[1]\t$F[1]\t$_" if $.>4') -wo > /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge-SNPs-AlphaMissense_scores.bed

# bedtools intersect -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b /home/u20111010010/Project/Complex-genome/001.HERV-Virus/Result/004.Complex-Genome_HERV_Aligned-virus_SNPs_AlphaMissense-Overlap_Mean-value.pos -wo

perl -lane 'print if $F[-3]>=0.9' /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge-SNPs-AlphaMissense_scores.bed|perl -lane 'print "$F[0]\t$F[1]\t$F[2]\t$F[3]"'|sort|uniq -c

################################# 区间内平均得分
bedtools map -a  <(perl -lane 'print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]"'  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed|sort -k1,1 -k2,2n)  -b <( zcat /home/u20111010010/Project/Complex-genome/001.HERV-Virus/Primate_AI/PrimateAI_scores_v0.2_hg38.tsv.gz |perl -lane 'print "$F[0]\t$F[1]\t$F[1]\t$_" if $.>12'|sort -k1,1 -k2,2n) -c 14 -o mean > /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_PrimateAI_scores-mean.csv

bedtools map -a  <(perl -lane 'print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]"'  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed|sort -k1,1 -k2,2n)  -b <(zcat /home/u20111010010/Project/Complex-genome/000.Data/Primate/AlphaMissense/AlphaMissense_hg38.tsv.gz|perl -lane 'print "$F[0]\t$F[1]\t$F[1]\t$_" if $.>4'|sort -k1,1 -k2,2n) -c 12 -o mean > /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_AlphaMissense_scores-mean.csv

#run6_fimo-high-attention_motif-disease_plot.R

### 区域得分
bedtools intersect -a  <(perl -lane 'next if ($F[-1] eq ".");print if ($F[-1]>=0.5);' /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_AlphaMissense_scores-mean.csv)  -b <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_name=(.*?);/){$Gene=$1};if(/gene_type=(.*?);/){$Type=$1};if(/gene_id=(.*?);/){$gene_id=$1;@gene_id_all=split/\./,$gene_id;};print  "$F[0]\t$F[3]\t$F[4]\t$Gene\t$gene_id_all[0]\t$gene_id\t$Type" if  $F[2]=~/gene/')  -wo|perl -lane 'print "$F[3];$F[8];$F[4]"'

#perl -lane 'next if ($F[-1] eq ".");print;'  /home/u20111010010/Project/Complex-genome/002.Complex-Selection-Test/Human_lineage/Accelerated_regions/science.abn6919_table_s30_human_complex-region_PrimateAI_scores-mean.csv

perl -lane 'next if ($F[-1] eq ".");print if ($F[-1]>=0.7);'  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_PrimateAI_scores-mean.csv

### chr6:36856647-36856674(0.92663;AlphaMissense_scores; ZNF135;MA1587.1)
bedtools intersect -a <(echo -en "chr6\t36856647\t36856674") -b  <(zcat /home/u20111010010/Project/Complex-genome/000.Data/Primate/AlphaMissense/AlphaMissense_hg38.tsv.gz | perl -lane 'print "$F[0]\t$F[1]\t$F[1]\t$_" if $.>4') -wo

### chr2:241335103-241335142 ;DUSP10基因
bedtools intersect -a <(echo -en "chr2\t241335103\t241335142\tchr2:241335103-241335142") -b  <(zcat /home/u20111010010/Project/Complex-genome/000.Data/Primate/AlphaMissense/AlphaMissense_hg38.tsv.gz | perl -lane 'print "$F[0]\t$F[1]\t$F[1]\t$_" if $.>4') -wo

### HERV交集
bedtools intersect -a <(echo -en "chr6\t36856647\t36856674") -b <(cat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HERV/SERVE/Annotation/*gtf|perl -le 'while(<>){chomp;@F=split/\s+/,$_;if(/gene_id \"(.*?)\"\;/){$transcript_id=$1;};print "$F[0]\t$F[3]\t$F[4]\t$transcript_id" if $F[2] eq "transcript"}'|sort -k1,1 -k2,2n)  -wo

################################################# 三种特异性富集情况，
#### 47.759kb与HervD_Atlas存在交集
bedtools intersect -a  <(perl -le 'while(<>){chomp;next if /^More/ or /Position/;@F=split/\t+/,$_;@FF=split/\:|\-/,$F[2];print join("\t",@FF),"\t",join("\t",@F[0..$#F-1]);}'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HervD_Atlas/HERV_Detail.txt)  -b  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -wo|perl -lane '@F=split/\s+/,$_;print join("\t",@F[-6..-4]);'|perl -le 'while(<>){chomp;@F=split/\s+/,$_;$L+=($F[2]-$F[1]);}END{print $L;}'


######################### 1. 区间内平均得分与HERV的类型关系（两者均存在）
#### PrimateAI_scores ### chr10:4844040-4845480;chr10:4853677-4856881
bedtools intersect -a <(bedtools intersect -a  <(perl -le 'while(<>){chomp;next if /^More/ or /Position/;@F=split/\t+/,$_;@FF=split/\:|\-/,$F[2];print join("\t",@FF),"\t",join("\t",@F[0..$#F-1]);}'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HervD_Atlas/HERV_Detail.txt)  -b  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -wo|perl -lane 'print join("\t",@F[0..11]),"\t$F[-2]\t$F[-6]:$F[-5]-$F[-4]\t$F[-3]"'|sort -k12nr) -b /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_PrimateAI_scores-mean.csv -wo|perl -lane 'next if ($F[-2] eq ".");print;'
#### AlphaMissense_scores ### chr10:4844040-4845480(chr10:4842696-4854223) ; chr10:4853677-4856881(chr10:4842696-4854223) 
bedtools intersect -a <(bedtools intersect -a  <(perl -le 'while(<>){chomp;next if /^More/ or /Position/;@F=split/\t+/,$_;@FF=split/\:|\-/,$F[2];print join("\t",@FF),"\t",join("\t",@F[0..$#F-1]);}'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HervD_Atlas/HERV_Detail.txt)  -b  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -wo|perl -lane 'print join("\t",@F[0..11]),"\t$F[-2]\t$F[-6]:$F[-5]-$F[-4]\t$F[-3]"'|sort -k12nr) -b /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_AlphaMissense_scores-mean.csv -wo|perl -lane 'next if ($F[-2] eq ".");print;'

#### 上述区域内SNP致病性
## PrimateAI_scores
bedtools intersect -a <(echo -en "chr10\t4842696\t4854223\n") -b <(zcat /home/u20111010010/Project/Complex-genome/000.Data/Primate/Primate_AI/PrimateAI_scores_v0.2_hg38.tsv.gz | perl -lane 'print "$F[0]\t$F[1]\t$F[1]\t$_" if $.>12') -wo|perl -lane 'print if $F[-2]>=0.6'

## AlphaMissense_scores
bedtools intersect -a <(echo -en "chr10\t4842696\t4854223\n") -b  <(zcat /home/u20111010010/Project/Complex-genome/000.Data/Primate/AlphaMissense/AlphaMissense_hg38.tsv.gz | perl -lane 'print "$F[0]\t$F[1]\t$F[1]\t$_" if $.>4') -wo|perl -lane 'print if $F[-3]>=0.7'

################
#chr10   4842696 4854223 chr10   4847157 4847157 chr10   4847157 T       C       hg38    Q96JD6  ENST00000298375.12      F283L   0.9169  likely_pathogenic       0
#chr10   4842696 4854223 chr10   4847158 4847158 chr10   4847158 T       C       hg38    Q96JD6  ENST00000298375.12      F283S   0.719   likely_pathogenic       0
#chr10   4842696 4854223 chr10   4847159 4847159 chr10   4847159 T       A       hg38    Q96JD6  ENST00000298375.12      F283L   0.9169  likely_pathogenic       0
#chr10   4842696 4854223 chr10   4847164 4847164 chr10   4847164 T       C       hg38    Q96JD6  ENST00000298375.12      L285S   0.9537  likely_pathogenic       0
################
#chr10   4842696 4854223 chr10   4847157 4847157 chr10   4847157 T       C       F       L       1       TTT     uc001ihi.4      68.26   0.634524285793  0
#chr10   4842696 4854223 chr10   4847158 4847158 chr10   4847158 T       G       F       C       1       TTT     uc001ihi.4      68.35   0.628159463406  0

####  是否存在于全序列筛选（存在多个）,两者共有Motifs(AT3G46070,BPC1,BPC5,BPC6,KLF17,NR2C2,SP2,SP8)
cat  <(bedtools intersect  -a  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed  -b <(echo -en "chr10\t4825000\t4850000") -wo|perl -lane '@M=split/,/,$F[3];print join("\n",@M);'|sort -u)  <(bedtools intersect  -a  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_Raw.bed  -b <(echo -en "chr10\t4825000\t4850000") -wo|perl -lane '@M=split/,/,$F[3];print join("\n",@M);'|sort -u) |sort|uniq -c|perl -lane 'print if ($F[0]==2)'

#### 共有Motifs的集中程度
bedtools intersect  -a  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed  -b <(echo -en "chr10\t4825000\t4850000") -wo|egrep  'AT3G46070|BPC1|BPC5|BPC6|KLF17|NR2C2|SP2|SP8'

#### 共有Motifs的集中程度,与HervD_Atlas数据库交集,chr10:4844040-4845480(chr10_ERV1_01040);chr10:4,825,000-4,850,000
bedtools intersect -a <(bedtools intersect -a  <(perl -le 'while(<>){chomp;next if /^More/ or /Position/;@F=split/\t+/,$_;@FF=split/\:|\-/,$F[2];print join("\t",@FF),"\t",join("\t",@F[0..$#F-1]);}'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HervD_Atlas/HERV_Detail.txt)  -b  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -wo|perl -lane 'print join("\t",@F[0..11]),"\t$F[-2]\t$F[-6]:$F[-5]-$F[-4]\t$F[-3]"'|sort -k12nr) -b  <(echo -en "chr10\t4844040\t4845480") -wo|egrep  'AT3G46070|BPC1|BPC5|BPC6|KLF17|NR2C2|SP2|SP8'


######################### 2.高致病性（全序列特异）;DUSP10无
egrep 'KLF9|DOF3.6|ZNF135' BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment_Raw.txt   ### 全序列
egrep 'KLF9|DOF3.6|ZNF135' BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment.txt       ### 高注意力序列

### 与数据库中HERV无交集
bedtools intersect -a  <(perl -le 'while(<>){chomp;next if /^More/ or /Position/;@F=split/\t+/,$_;@FF=split/\:|\-/,$F[2];print join("\t",@FF),"\t",join("\t",@F[0..$#F-1]);}'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HervD_Atlas/HERV_Detail.txt)  -b <(echo -en "chr1\t221706465\t221706499\tDUSP10\tKLF9\nchr2\t241335103\t241335142\tSEPTIN2\tDOF3.6\nchr6\t36856647\t36856679\tPPIL1\tZNF135\n")  -wo

#### 上述区域内SNP致病性
## PrimateAI_scores
bedtools intersect -a <(echo -en "chr6\t36856647\t36856679\tPPIL1\tZNF135\n") -b <(zcat /home/u20111010010/Project/Complex-genome/000.Data/Primate/Primate_AI/PrimateAI_scores_v0.2_hg38.tsv.gz | perl -lane 'print "$F[0]\t$F[1]\t$F[1]\t$_" if $.>12') -wo|perl -lane 'print if $F[-2]>=0.6'

## AlphaMissense_scores
bedtools intersect -a <(echo -en "chr6\t36856647\t36856679\tPPIL1\tZNF135\n") -b  <(zcat /home/u20111010010/Project/Complex-genome/000.Data/Primate/AlphaMissense/AlphaMissense_hg38.tsv.gz | perl -lane 'print "$F[0]\t$F[1]\t$F[1]\t$_" if $.>4') -wo|perl -lane 'print if $F[-3]>=0.7'

################
chr6    36856647        36856679        PPIL1   ZNF135  chr6    36856648        36856648        chr6    36856648        C       A       hg38    Q9Y3C6  ENST00000373699.6       G73V    0.993   likely_pathogenic 0
chr6    36856647        36856679        PPIL1   ZNF135  chr6    36856649        36856649        chr6    36856649        C       G       hg38    Q9Y3C6  ENST00000373699.6       G73R    0.9959  likely_pathogenic 0
chr6    36856647        36856679        PPIL1   ZNF135  chr6    36856651        36856651        chr6    36856651        C       G       hg38    Q9Y3C6  ENST00000373699.6       R72P    0.9915  likely_pathogenic 0
chr6    36856647        36856679        PPIL1   ZNF135  chr6    36856654        36856654        chr6    36856654        C       G       hg38    Q9Y3C6  ENST00000373699.6       G71A    0.9888  likely_pathogenic 0

################
chr6    36856647        36856679        PPIL1   ZNF135  chr6    36856649        36856649        chr6    36856649        C       G       G       R       0       AGG     uc003omu.2      56.24   0.883895576       0
chr6    36856647        36856679        PPIL1   ZNF135  chr6    36856648        36856648        chr6    36856648        C       T       G       D       0       GGT     uc003omu.2      56.26   0.886844158173    0
chr6    36856647        36856679        PPIL1   ZNF135  chr6    36856654        36856654        chr6    36856654        C       T       G       D       0       GGT     uc003omu.2      55.78   0.910633683205    0


### 全序列筛选
bedtools intersect -a <(echo -en "chr1\t221706465\t221706499\tDUSP10\tKLF9\nchr2\t241335103\t241335142\tSEPTIN2\tDOF3.6\nchr6\t36856647\t36856679\tPPIL1\tZNF135\n")  -b   /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_Raw.bed  -wo

### 高注意力得分部分筛选
bedtools intersect -a <(echo -en "chr1\t221706465\t221706499\tDUSP10\tKLF9\nchr2\t241335103\t241335142\tSEPTIN2\tDOF3.6\nchr6\t36856647\t36856679\tPPIL1\tZNF135\n")  -b   /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed  -wo

bedtools intersect -a <(echo -en "chr1\t221706465\t221706499\tDUSP10\tKLF9\nchr2\t241335103\t241335142\tSEPTIN2\tDOF3.6\nchr6\t36856647\t36856679\tPPIL1\tZNF135\n")  -b <( cat  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment*HG38.txt |perl -le 'while(<>){chomp;@F=split/\s+/,$_;@FF=split/\_/,$F[3];$start1=$FF[1]+$F[-2]+$F[4];$end1=$FF[1]+$F[-2]+$F[5];print "$F[-3]\t$start1\t$end1\t$F[2]\t$F[0]\t$_";}')  -wo


######################### 3.注意力得分特异，与HervD_Atlas存在交集
## chr9_ERV2_01861 LTR13(全序列未鉴定出来)
#########################
####  注意力得分特异富集区域
bedtools subtract -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b <(bedtools intersect -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_Raw.bed -wo|perl -lane 'print join("\t",@F[0..2])'|sort -u)|sort -k1,1 -k2,2n

####  注意力得分特异富集区域，与HervD_Atlas存在交集
bedtools intersect -a  <(perl -le 'while(<>){chomp;next if /^More/ or /Position/;@F=split/\t+/,$_;@FF=split/\:|\-/,$F[2];print join("\t",@FF),"\t",join("\t",@F[0..$#F-1]);}'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HervD_Atlas/HERV_Detail.txt)  -b  <(bedtools subtract -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b <(bedtools intersect -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_Raw.bed -wo|perl -lane 'print join("\t",@F[0..2])'|sort -u)|sort -k1,1 -k2,2n) -wo|perl -lane 'print join("\t",@F[0..11]),"\t$F[-2]\t$F[-6]:$F[-5]-$F[-4]\t$F[-3]"'|sort -k12nr

####  注意力得分特异富集区域，与HervD_Atlas存在交集，并且Fimo统计数值显著（尽量选择单Motifs区间）

###  注意力得分特异富集区域，与HervD_Atlas存在交集(注意力得分序列鉴定Motifs);q-value
bedtools intersect -a <(bedtools intersect -a  <(perl -le 'while(<>){chomp;next if /^More/ or /Position/;@F=split/\t+/,$_;@FF=split/\:|\-/,$F[2];print join("\t",@FF),"\t",join("\t",@F[0..$#F-1]);}'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HervD_Atlas/HERV_Detail.txt)  -b  <(bedtools subtract -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b <(bedtools intersect -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_Raw.bed -wo|perl -lane 'print join("\t",@F[0..2])'|sort -u)|sort -k1,1 -k2,2n) -wo|perl -lane 'print  "$F[-6]\t$F[-5]\t$F[-4]\t",join("\t",@F[0..11]),"\t$F[-2]\t$F[-6]:$F[-5]-$F[-4]\t$F[-3]"'|sort -k12nr)  -b <( cat  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment*HG38.txt |perl -le 'while(<>){chomp;@F=split/\s+/,$_;@FF=split/\_/,$F[3];$start1=$FF[1]+$F[-2]+$F[4];$end1=$FF[1]+$F[-2]+$F[5];print "$F[-3]\t$start1\t$end1\t$F[2]\t$F[0]\t$_";}')  -wo|perl -lane 'print if $F[-6]<=0.0005'|grep 'CTCF'

###  注意力得分特异富集区域，与HervD_Atlas存在交集(全长序列鉴定Motifs)
bedtools intersect -a <(bedtools intersect -a <(bedtools intersect -a  <(perl -le 'while(<>){chomp;next if /^More/ or /Position/;@F=split/\t+/,$_;@FF=split/\:|\-/,$F[2];print join("\t",@FF),"\t",join("\t",@F[0..$#F-1]);}'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HervD_Atlas/HERV_Detail.txt)  -b  <(bedtools subtract -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b <(bedtools intersect -a /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -b  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_Raw.bed -wo|perl -lane 'print join("\t",@F[0..2])'|sort -u)|sort -k1,1 -k2,2n) -wo|perl -lane 'print  "$F[-6]\t$F[-5]\t$F[-4]\t",join("\t",@F[0..11]),"\t$F[-2]\t$F[-6]:$F[-5]-$F[-4]\t$F[-3]"'|sort -k12nr)  -b <( cat  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment*HG38.txt |perl -le 'while(<>){chomp;@F=split/\s+/,$_;@FF=split/\_/,$F[3];$start1=$FF[1]+$F[-2]+$F[4];$end1=$FF[1]+$F[-2]+$F[5];print "$F[-3]\t$start1\t$end1\t$F[2]\t$F[0]\t$_";}')  -wo|perl -lane 'print if $F[-6]<=0.0005')  -b <(cat  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV*Raw.txt |perl -le 'while(<>){chomp;@F=split/\s+/,$_;@FF=split/\_|\:|\-/,$F[3];$start1=$FF[1]+$F[4];$end1=$FF[1]+$F[5];print "$FF[0]\t$start1\t$end1\t$F[2]\t$F[0]\t$_";}')  -wo

bedtools intersect -a <(echo -en "chr9\t76665837\t76666844\tchr9_ERV2_01861\nchr9\t76666118\t76666151\tCTCF\n") -b <(cat  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV*Raw.txt |perl -le 'while(<>){chomp;@F=split/\s+/,$_;@FF=split/\_|\:|\-/,$F[3];$start1=$FF[1]+$F[4];$end1=$FF[1]+$F[5];print "$FF[0]\t$start1\t$end1\t$F[2]\t$F[0]\t$_";}')  -wo

#### 上述区域内SNP致病性
## PrimateAI_scores
bedtools intersect -a <(echo -en "chr9\t76665837\t76666844\tchr9_ERV2_01861\nchr9\t76666118\t76666151\tCTCF\n") -b <(zcat /home/u20111010010/Project/Complex-genome/000.Data/Primate/Primate_AI/PrimateAI_scores_v0.2_hg38.tsv.gz | perl -lane 'print "$F[0]\t$F[1]\t$F[1]\t$_" if $.>12') -wo|perl -lane 'print if $F[-2]>=0.6'

## AlphaMissense_scores
bedtools intersect -a <(echo -en "chr9\t76665837\t76666844\tchr9_ERV2_01861\nchr9\t76666118\t76666151\tCTCF\n") -b  <(zcat /home/u20111010010/Project/Complex-genome/000.Data/Primate/AlphaMissense/AlphaMissense_hg38.tsv.gz | perl -lane 'print "$F[0]\t$F[1]\t$F[1]\t$_" if $.>4') -wo|perl -lane 'print if $F[-3]>=0.7'

################ 无
################ 无