Document="Dataset_Random"
BED="/home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Random/genome_random_regions-merge.bed.label4.txt"
Fasta_index="Genome-Random_region-label4"

### 参考HG38
bedtools getfasta -fi /home/u20111010010/Project/Pan-genome/000.Data/REF/refdata-GRCh38-2.1.0/fasta/genome.fa -bed $BED -fullHeader -name | perl -le 'while(<>){chomp;if(/>/){@M=split/>|::/,$_;print ">$M[2]\t$M[1]";}else{print;}}' > /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/$Document/VCF_hprc-1000G/Random/Genome-$Fasta_index.need.fa

### 泛基因组
bedtools intersect -a  <(zcat  /home/u20111010010/Project/Pan-genome/000.Data/High/HPRC/hprc-v1.1-mc-grch38.vcfbub.a100k.wave.vcf.gz)  -b $BED -wo |perl -le 'while(<>){chomp;@F=split/\s+/,$_;$L=length($F[4]);$End=$F[1]+$L;print ">$F[0]:$F[1]-$End\t$F[-2]\n$F[4]" if $L>=150;}' >> /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/$Document/VCF_hprc-1000G/Random/Genome-$Fasta_index.need.fa

### 1000Genome
bedtools intersect -a  <(zcat  /home/u20111010010/Project/Pan-genome/000.Data/Low/vggiraffe-sv-2504kgp-raw.vcf.gz)  -b $BED  -wo |perl -le 'while(<>){chomp;@F=split/\s+/,$_;$L=length($F[4]);$End=$F[1]+$L;print ">$F[0]:$F[1]-$End\t$F[-2]\n$F[4]" if $L>=150;}' >> /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/$Document/VCF_hprc-1000G/Random/Genome-$Fasta_index.need.fa

### 根据N进行切割
cat   /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/$Document/VCF_hprc-1000G/Random/Genome-$Fasta_index.need.fa|perl -le 'while(<>){chomp;if(/^>/){$key=$_;}else{@F=split/N{2,}/,$_;for my $i (0..$#F){print "$key.$i","\n",$F[$i];};}}'|seqkit seq -m 150 -w 0 -g >  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/$Document/VCF_hprc-1000G/Random/Genome-$Fasta_index.need_splitN.fa


### 序列去冗余
/home/u20111010010/Software/mmseqs/bin/mmseqs  easy-linclust  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/$Document/VCF_hprc-1000G/Random/Genome-$Fasta_index.need_splitN.fa   /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/$Document/VCF_hprc-1000G/Random/Genome-$Fasta_index.need_splitN_cluster tmp   --threads 10 --cluster-mode 2  --cov-mode 1  --min-seq-id 0.95
