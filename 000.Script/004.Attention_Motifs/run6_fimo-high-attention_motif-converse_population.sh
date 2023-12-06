~/Software/Anaconda/mambaforge-pypy3/envs/py3_1/bin/odgi depth -i /home/u20111010010/Project/Pan-genome/000.Data/High/HPRC/hprc-v1.0-pggb.og  -b <(perl -lane 'print "grch38#$F[0]\t$F[1]\t$F[2]\t$F[3]\t$F[4]"'  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed) --threads  5|bedtools sort > /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed.depth.bed

bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_name=(.*?);/){$Gene=$1};if(/gene_type=(.*?);/){$Type=$1};if(/gene_id=(.*?);/){$gene_id=$1;@gene_id_all=split/\./,$gene_id;};print  "$F[0]\t$F[3]\t$F[4]\t$Gene\t$gene_id_all[0]\t$gene_id\t$Type" if  $F[2]=~/gene/')  -b <(perl -le 'while(<>){s/grch38#//g;s/#0//g;@F=split/\s+/,$_;print "$F[0]\t$F[1]\t$F[2]\t$F[0]\t$F[3]";}'  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed.depth.bed) -wo |grep -v 'M' > /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed.depth_gene.bed

### perl -le 'while(<>){chomp;@F=split/\s+/,$_;if(/GRCh38#0#GRCh38.chr(.*)#0/){$CHR=$1;};print "$F[0]\t$1\t$F[1]\t$F[2]\t$F[3]";}'  002.ConsElements_Pangenome_show-ConsElements.bed.depth.bed|grep -v 'M' >002.ConsElements_Pangenome_show-ConsElements.bed.depth_plot.bed

#### 提取 CCDC200基因(chr17:43216941-43305397)内Motifs;chr17:43233447-43299733
## 序列
~/Software/Anaconda/mambaforge-pypy3/envs/py3_1/bin/odgi  extract  -i /home/u20111010010/Project/Pan-genome/000.Data/High/HPRC/hprc-v1.0-pggb.og  -b  <(echo -en "grch38#chr17\t43216941\t43305397\tCCDC200\tCCDC200\n")  -o - -c 0 -d 0 --full-range -t 10 -P |~/Software/Anaconda/mambaforge-pypy3/envs/py3_1/bin/odgi  sort -i - -o - --optimize |~/Software/Anaconda/mambaforge-pypy3/envs/py3_1/bin/odgi viz -i - -o /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed.depth_gene-CCDC200.png -s '#' -t 10 -P


## 交集(和提取的人群体水平结果间)
bedtools intersect -a  <(echo -en "chr17\t43233447\t43299733") -b  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed -wo
grep 'CCDC200' /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Mot
if_visualization-Enrichment-HERV_Merge.bed.depth_gene.bed

## 交集（全基因组的方法)
bedtools intersect -a   <(echo -en "chr17\t43233447\t43299733\tCCDC200\tCCDC200\n")  -b /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge_Raw.bed -wo


### 提取人群和灵长类中差异均很大的Motifs对应基因
# 人群，/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed.depth_gene.bed
# 灵长类，/home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run6_fimo-high-attention_motif-converse_primate.phastCons27way_anno.tab

cat <(grep 'protein_coding' /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed.depth_gene.bed|perl -lane 'print $F[3] if $F[-2]>=90'|sort -u)  <(perl -lane 'print $F[-1] if $F[-2]<=0.3 ' /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run6_fimo-high-attention_motif-converse_primate.phastCons27way_anno.tab|sort -u)|sort|uniq -c|perl -lane 'print $F[1] if $F[0]==2'|grep -v '^ENSG'|perl -e 'while(<>){chomp;@F=split/\s+/,$_;print "$F[0] ";}'
