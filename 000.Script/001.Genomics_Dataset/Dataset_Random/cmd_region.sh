#!/bin/bash

###############################################################################################################  基因组随机区域生成

# 定义总的reads数量和每个read的长度
TOTAL_READS=$((200000000 / 10000))
READ_LENGTH=10000
HG38="/home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/hg38.genome"

# 初始化输出文件
echo -n > genome_random_regions.bed

# 计算全基因组的总长度
TOTAL_GENOME_LENGTH=$(awk '{sum+=$2} END {print sum}'   $HG38)

# 对于每条染色体，基于其长度计算需要生成的reads数量，然后使用bedtools随机生成这些reads

while read -r chr length; do
  # 计算这条染色体应该提供的reads数量

  echo -en "$chr\t$length\t$TOTAL_GENOME_LENGTH\t$TOTAL_READS\n"
  CHROM_READS=$(echo "scale=20; ($length/$TOTAL_GENOME_LENGTH*$TOTAL_READS)+0.5/1" | bc)
 
  # 使用bedtools random为该染色体生成随机区域
  bedtools random -seed 42 -l $READ_LENGTH -n $CHROM_READS -g <(echo -e "$chr\t$length") >> genome_random_regions.bed
done < $HG38


############################################################################################################### 基因组随机区域合并
bedtools merge -i  <(sort -V -k1 -k2,2n genome_random_regions.bed) -d 1 -c 2 -o count|sort -V -k1 > genome_random_regions-merge.bed
