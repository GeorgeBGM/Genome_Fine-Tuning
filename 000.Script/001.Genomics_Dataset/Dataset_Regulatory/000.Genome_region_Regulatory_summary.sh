############### 所有调控序列的BED文件，/home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed

### CTCF_binding_site区域序列(排除非唯一的功能序列)；
bedtools subtract -a <(grep 'CTCF_binding_site'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed)  -b <(bedtools intersect -a <(grep 'CTCF_binding_site' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed)  -b <(grep -v 'CTCF_binding_site' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed))|perl -lane '$L=$F[2]-$F[1];print "chr$F[0]\t$F[1]\t$F[2]\tCTCF_binding_site" if $L>=150;' >Need_All_Regulatory_CTCF_binding_site_Merge_Anno.bed

### Open_chromatin_region区域序列；
bedtools subtract -a <(grep 'open_chromatin_region'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed)  -b <(bedtools intersect -a <(grep 'open_chromatin_region' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed)  -b <(grep -v 'open_chromatin_region' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed))|perl -lane '$L=$F[2]-$F[1];print "chr$F[0]\t$F[1]\t$F[2]\tOpen_chromatin_region" if $L>=150;' >Need_All_Regulatory_Open_chromatin_region_Merge_Anno.bed

### Enhancer区域序列
bedtools subtract -a <(grep 'enhancer'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed)  -b <(bedtools intersect -a <(grep 'enhancer' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed)  -b <(grep -v 'enhancer' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed))|perl -lane '$L=$F[2]-$F[1];print "chr$F[0]\t$F[1]\t$F[2]\tEnhancer" if $L>=150;' >Need_All_Regulatory_Enhancer_Merge_Anno.bed

### TF_binding_site区域序列
bedtools subtract -a <(grep 'TF_binding_site'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed)  -b <(bedtools intersect -a <(grep 'TF_binding_site' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed)  -b <(grep -v 'TF_binding_site' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed))|perl -lane '$L=$F[2]-$F[1];print "chr$F[0]\t$F[1]\t$F[2]\tTF_binding_site" if $L>=150;' >Need_All_Regulatory_TF_binding_site_Merge_Anno.bed

### Promoter区域序列
bedtools subtract -a <(grep 'promoter'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed)  -b <(bedtools intersect -a <(grep 'promoter' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed)  -b <(grep -v 'promoter' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed))|perl -lane '$L=$F[2]-$F[1];print "chr$F[0]\t$F[1]\t$F[2]\tPromoter" if $L>=150;' >Need_All_Regulatory_Promoter_Merge_Anno.bed


### 功能区域序列往外拓展1M后(左右)，取全基因组的差集
#bedtools slop -i <(perl -lane 'print "chr$_"' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed|egrep -v 'hs38d1|chrGL|chrKI') -g /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/hg38.genome -b 1000000 >/home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need_1Mb.bed

bedtools subtract -a <(perl -lane 'print "$F[0]\t1\t$F[1]"'  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/hg38.genome|egrep -v 'hs38d1|chrGL|chrKI')  -b  <(perl -lane 'print "chr$_"' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed|egrep -v 'hs38d1|chrGL|chrKI')|sort -k1,1 -k2,2n > /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need_Non.bed

#### 全基因组非免疫区域随机选择同免疫区域等长的参考序列(以i的区间长度在基因组范围内随机选取)
bedtools  shuffle -i <(cat /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Regulatory/Need_All_Regulatory_*bed)   -incl /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need_Non.bed  -excl  <(perl -lane 'print "chr$_"' /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed) -g /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/hg38.genome  -seed 100 -noOverlapping  -maxTries 100000000|sort -k1,1 -k2,2n|perl -lane 'print "$F[0]\t$F[1]\t$F[2]\t$F[0]:$F[1]-$F[2]"' >Need_All_Non-Regulatory_Merge_Anno_shuffle.bed

chmod 755 Need_All_Regulatory_*bed  Need_All_Non-Regulatory_Merge_Anno_shuffle.bed

mkdir  -p ./VCF_hprc-1000G/Train_Test  ./VCF_hprc-1000G/Regulatory   ./VCF_hprc-1000G/Non-Regulatory_Random 

### 两集合内部无重复且无重叠
#bedtools intersect -a <(perl -lane 'chr$_'  /home/u20111010010/Project/DNA-Pretraining/Level1/000.Data/Regulatory/homo_sapiens.GRCh38.Regulatory_Build.regulatory_features.20221007.need.bed) -b Need_All_Non-Regulatory_Merge_Anno_shuffle.bed -wo