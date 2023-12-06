####  特异性富集Motif区域

###### phyloP
/home/u20111010010/Software/UCSC/bigWigAverageOverBed  /home/u20111010010/Project/Complex-genome/002.Complex-Conserve/primate/phyloP_scores.bw  <(perl -lane 'print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]"'  /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed|sort -u)   run6_fimo-high-attention_motif-converse_primate.phyloP27way.tab
###### phastCons
/home/u20111010010/Software/UCSC/bigWigAverageOverBed /home/u20111010010/Project/Complex-genome/002.Complex-Conserve/primate/phastCons_scores.bw  <(perl -lane 'print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]"' /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/BERT_HERV_Multi_RUN0-Higher_Attention-Motif_visualization-Enrichment-HERV_Merge.bed|sort -u)  run6_fimo-high-attention_motif-converse_primate.phastCons27way.tab

#### 增加注释

###### phyloP
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_name=(.*?);/){$Gene=$1};if(/gene_type=(.*?);/){$Type=$1};if(/gene_id=(.*?);/){$gene_id=$1;@gene_id_all=split/\./,$gene_id;};print  "$F[0]\t$F[3]\t$F[4]\t$Gene\t$gene_id_all[0]\t$gene_id\t$Type" if  $F[2]=~/gene/')  -b <(perl -lane '@M=split/:|-/,$F[0];print join("\t",@M),"\t$_";'  run6_fimo-high-attention_motif-converse_primate.phyloP27way.tab) -wo |grep -v 'M'|perl -lane 'print join("\t",@F[-7..-2]),"\t$F[3]";' > run6_fimo-high-attention_motif-converse_primate.phyloP27way_anno.tab

###### phastCons
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_name=(.*?);/){$Gene=$1};if(/gene_type=(.*?);/){$Type=$1};if(/gene_id=(.*?);/){$gene_id=$1;@gene_id_all=split/\./,$gene_id;};print  "$F[0]\t$F[3]\t$F[4]\t$Gene\t$gene_id_all[0]\t$gene_id\t$Type" if  $F[2]=~/gene/')  -b <(perl -lane '@M=split/:|-/,$F[0];print join("\t",@M),"\t$_";'  run6_fimo-high-attention_motif-converse_primate.phastCons27way.tab) -wo |grep -v 'M'|perl -lane 'print join("\t",@F[-7..-2]),"\t$F[3]";' > run6_fimo-high-attention_motif-converse_primate.phastCons27way_anno.tab

##### Primate高保守是否存在于古人DNA中
## Denisovan,PGAP4
cat  <(perl -lane 'print $F[-1] if $F[-2]>=0.9' /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run6_fimo-high-attention_motif-converse_primate.phastCons27way_anno.tab) <(bedtools intersect -a <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_name=(.*?);/){$Gene=$1};if(/gene_type=(.*?);/){$Type=$1};if(/gene_id=(.*?);/){$gene_id=$1;@gene_id_all=split/\./,$gene_id;};print  "$F[0]\t$F[3]\t$F[4]\t$Gene\t$gene_id_all[0]\t$gene_id\t$Type" if  $F[2]=~/gene/') -b  /home/u20111010010/Project/Complex-genome/002.Complex-Population/002.MaLAdapt/SuppTable7-10_Denisovan-AI_New-hgLiftOver.bed -wo |perl -lane 'print "$F[3]" if ($F[-1]>=150)'|sort -u) |sort|uniq -c|perl -ane 'chomp;print "$F[1]|" if $F[0]==2'

## Neanderthal,PGAP4,
cat  <(perl -lane 'print $F[-1] if $F[-2]>=0.9' /home/u20111010010/Project/DNA-Pretraining/Level1/003.Sequence_Visualization/Dataset_HERV/run6_fimo-high-attention_motif-converse_primate.phastCons27way_anno.tab)   <(bedtools intersect -a <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_name=(.*?);/){$Gene=$1};if(/gene_type=(.*?);/){$Type=$1};if(/gene_id=(.*?);/){$gene_id=$1;@gene_id_all=split/\./,$gene_id;};print  "$F[0]\t$F[3]\t$F[4]\t$Gene\t$gene_id_all[0]\t$gene_id\t$Type" if  $F[2]=~/gene/') -b  /home/u20111010010/Project/Complex-genome/002.Complex-Population/002.MaLAdapt/SuppTable7-10_Neanderthal-AI_New-hgLiftOver.bed -wo |perl -lane 'print "$F[3]" if ($F[-1]>=150)'|sort -u) |sort|uniq -c|perl -ane 'chomp;print "$F[1]|" if $F[0]==2'
