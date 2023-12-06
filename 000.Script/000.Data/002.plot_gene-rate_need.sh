###### Step1,全基因组范围内

### 全基因组的所有基因数目，61217 Genes(gencode.v43)
zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/'|perl -lane 'print $F[3]'|sort -u|wc -l
### 全基因组的编码基因，20013 Genes(gencode.v43)
zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/'|grep 'protein_coding'|perl -lane 'print $F[3]'|sort -u|wc -l

###### Step2,HERV区域

### 全基因组的所有基因数目，21119 Genes(gencode.v43)
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HERV/HG38_HERV_region_need_ALL.bed -wo|perl -lane 'print $F[3] if $F[-1]>=150'|sort -u|wc -l
### 全基因组的编码基因，11665 Genes(gencode.v43)
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HERV/HG38_HERV_region_need_ALL.bed -wo|perl -lane 'print $F[3] if $F[-1]>=150  and /protein_coding/'|sort -u|wc -l

###### Step3,Immunogenetics区域

### 全基因组的所有基因数目，3347 Genes(gencode.v43)
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Immunogenetics/HG38_Immunogenetics_region_need.bed -wo|perl -lane 'print $F[3] if $F[-1]>=150'|sort -u|wc -l
### 全基因组的编码基因，1847 Genes(gencode.v43)
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Immunogenetics/HG38_Immunogenetics_region_need.bed -wo|perl -lane 'print $F[3] if $F[-1]>=150  and /protein_coding/'|sort -u|wc -l

###### Step4,Regulatory区域

### 全基因组的所有基因数目，39888 Genes(gencode.v43)
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/')  -b <(perl -lane 'print "chr$_"' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed) -wo|perl -lane 'print $F[3] if $F[-1]>=150'|sort -u|wc -l
### 全基因组的编码基因，18991 Genes(gencode.v43)
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/')  -b <(perl -lane 'print "chr$_"' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed) -wo|perl -lane 'print $F[3] if $F[-1]>=150  and /protein_coding/'|sort -u|wc -l

###### Step5,HVIDB区域

### 全基因组的所有基因数目，14173 Genes(gencode.v43)
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HVIDB/HVIDB_PPIs_Gene-POS.txt -wo|perl -lane 'print $F[3] if $F[-1]>=150'|sort -u|wc -l
### 全基因组的编码基因，8636 Genes(gencode.v43)
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HVIDB/HVIDB_PPIs_Gene-POS.txt -wo|perl -lane 'print $F[3] if $F[-1]>=150  and /protein_coding/'|sort -u|wc -l

###### Step6,Disease-loci区域

### 全基因组的所有基因数目，29135 Genes(gencode.v43)
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Disease_loci/HG38_Disease-loci_region_need.bed -wo|perl -lane 'print $F[3] if $F[-1]>=150'|sort -u|wc -l
### 全基因组的编码基因，17562 Genes(gencode.v43)
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Disease_loci/HG38_Disease-loci_region_need.bed -wo|perl -lane 'print $F[3] if $F[-1]>=150  and /protein_coding/'|sort -u|wc -l

###### Step7,Highly_Specifically_Gene区域

### 全基因组的所有基因数目，1146 Genes(gencode.v43)
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Highly_Specifically_Gene/HG38_Highly_Specifically_Gene_region_need.bed -wo|perl -lane 'print $F[3] if $F[-1]>=150'|sort -u|wc -l
### 全基因组的编码基因，524 Genes(gencode.v43)
bedtools intersect -a  <(zcat /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/HG38_ANNO/gencode.v43.annotation.gff3.gz|perl -lane 'if(/gene_type=(.*?);/){$gene_type=$1};if(/gene_name=(.*?);/){$gene_name=$1};print  "$F[0]\t$F[3]\t$F[4]\t$gene_name\t$gene_type" if  $F[2]=~/gene/')  -b /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Highly_Specifically_Gene/HG38_Highly_Specifically_Gene_region_need.bed -wo|perl -lane 'print $F[3] if $F[-1]>=150  and /protein_coding/'|sort -u|wc -l

###### Step8，整理长度及基因数目，002.plot_gene-rate_need_genes_number.txt

###### Step9，计算特定区域的基因富集率

perl -le  'chomp($a=<>);print "$a\tNum\tType";chomp($b=<>);@F=split/\s+/,$b;$Genes=$F[2]/$F[1];$Genes_Coding=$F[3]/$F[1];while(<>){chomp;@M=split/\s+/,$_;$Genes_need=$M[2]/$M[1];$Genes_Coding_need=$M[3]/$M[1];$Genes_need_rate=$Genes_need/$Genes;$Genes_Coding_need_rate=$Genes_Coding_need/$Genes_Coding;print "$_\t$Genes_need_rate\tGenes\n$_\t$Genes_Coding_need_rate\tGenes(Coding)";};'  002.plot_gene-rate_need_genes_number.txt >002.plot_gene-rate_need_genes_number_ratio.txt

###### Step10，绘图
