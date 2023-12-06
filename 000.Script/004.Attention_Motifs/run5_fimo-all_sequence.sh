################################################# 数据集中Motif寻找(原始数据集)
######  HERV_Coding
/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/fimo  --o Fimo_HERV_Coding_Raw  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_meme.txt   /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_HERV_Coding_Test.fa

######  HERV_Non-Coding
/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/fimo  --o Fimo_HERV_Non-Coding_Raw  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_meme.txt  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_HERV_Non-Coding_Test.fa

######  Non-HERV_Coding 
/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/fimo  --o Fimo_Non-HERV_Coding_Raw  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_meme.txt  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_Non-HERV_Coding_Test.fa

######  Non-HERV_Non-Coding
/home/u20111010010/Software/Anaconda/mambaforge-pypy3/bin/fimo  --o  Fimo_Non-HERV_Non-Coding_Raw  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_meme.txt   /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_Non-HERV_Non-Coding_Test.fa

#<(grep '^test' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_model_HERV-Classification_Need.fa|perl -e 'while(<>){chomp;@F=split/\s+/,$_;@FF=split/\_/,$F[-1];print ">$FF[0]\n$F[3]\n" if ($F[1]==2);}')

################################################# 数据集中Motif富集和功能分类
perl -ne 'if(/AC (.+?)\n/){$ac=$1;} if(/ID (.+?)\n/){$id=$1;} if(/CC tax_group:(.+?)\n/){$tax=$1;} if(/CC tf_family:(.+?)\n/){$family=$1;} if(/CC tf_class:(.+?)\n/){$class=$1;} if(/CC pubmed_ids:(.+?)\n/){$pubmed=$1;} if(/CC uniprot_ids:(.+?)\n/){$uniprot=$1;} if(/CC data_type:(.+?)\n/){$data=$1;} if(/\/\//){print "$ac\t$id\t$tax\t$family\t$class\t$pubmed\t$uniprot\t$data\n";}'  /home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_transfac.txt >/home/u20111010010/Software/MEME/JASPAR2022_CORE_non-redundant_pfms_transfac-infor.txt

################################################# 未筛选区域鉴定的高致病性（Score>=0.7）的Motif区域在全基因组范围内情况
bedtools intersect -a <(echo -en "chr1\t221706465\t221706499\tDUSP10\nchr2\t241335103\t241335142\tSEPTIN2\nchr6\t36856647\t36856679\tPPIL1\n") -b <(cat ./Fimo_HERV*_Raw/fimo.tsv|perl -le 'while(<>){chomp;next if /^motif_id/ or /^$/ or /^#/;@F=split/\s+/,$_;@FF=split/\:|\-|\_/,$F[2];$start=$FF[1]+$F[3];$end=$FF[1]+$F[4];print "$FF[0]\t$start\t$end\t$_";}') -wo|egrep 'KLF9|DOF3.6|ZNF135'

################################################# 数据集中Motif分组分析
/opt/app/r/r4.2.2.1/bin/Rscript  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run5_fimo-all_sequence-motif.R

egrep 'KLF9|DOF3.6|ZNF135' BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment_Raw.txt

################################################# 根据富集的Motif类别提取其基因组正常比对情况
### HERV_Non-Coding(3)---特异+两者均有部分,/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_HERV_Non-Coding_Raw/fimo.tsv
perl -le 'open(IN,$ARGV[0]);open(IN1,$ARGV[1]);while(<IN>){chomp;@F=split/\t+/,$_;$hash{$F[0]}=$F[7];};while(<IN1>){chomp;@F=split/\t+/,$_;next if ($F[-2]>0.05);if(exists($hash{$F[1]})){print "$hash{$F[1]}\t",$_;};};' <(egrep -v 'HERV_Coding|Control'  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment_Raw.txt|perl -lane 'print if $F[9]<=0.05')  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_HERV_Non-Coding_Raw/fimo.tsv  > /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Non-Coding_Raw.txt

### HERV_Coding,/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_HERV_Coding_Raw/fimo.tsv
perl -le 'open(IN,$ARGV[0]);open(IN1,$ARGV[1]);while(<IN>){chomp;@F=split/\t+/,$_;$hash{$F[0]}=$F[7];};while(<IN1>){chomp;@F=split/\t+/,$_;next if ($F[-2]>0.05);if(exists($hash{$F[1]})){print "$hash{$F[1]}\t",$_;};};' <(egrep -v 'HERV_NonCoding|Control'  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment_Raw.txt|perl -lane 'print if $F[9]<=0.05')  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/Fimo_HERV_Coding_Raw/fimo.tsv  > /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Coding_Raw.txt


################################################# 根据Motif进行合并(重叠区间;10bp以内)
cat  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV*Raw.txt |perl -le 'while(<>){chomp;@F=split/\s+/,$_;@FF=split/\_|\:|\-/,$F[3];$start1=$FF[1]+$F[4];$end1=$FF[1]+$F[5];print "$FF[0]\t$start1\t$end1\t$F[2]\t$F[0]";}'|sort -k1,1 -k2,2n -k4,4|perl -ane 'BEGIN{($c, $s, $e, $t)=(0,0,0,""); %n=()} if($F[0] eq $c && $F[1]-$e<=10){$n{$F[3]}++;$e=$F[2]}else{if($e){print"$c\t$s\t$e\t",join(",", keys%n),"\t$t\n"} ($c, $s, $e, $t)=@F[0,1,2,4]; %n=(); $n{$F[3]}++} END{print"$c\t$s\t$e\t",join(",", keys%n),"\t$t\n" if $e}'   >/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_Raw.bed
