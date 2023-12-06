###########################################  数据集预处理
for i in `ls /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Regulatory/VCF_hprc-1000G/*/*cluster_rep_seq.fasta`;do  seqkit stat  $i >$i.stat;done

###########################################  数据集划分（训练集、测试集）

for j in `ls /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Regulatory/VCF_hprc-1000G/*/*cluster_rep_seq.fasta`;
do
name=`basename $j|sed 's/\.need\_splitN\_cluster\_rep\_seq\.fasta//g'|sed 's/Genome\-Genome\-//g'`
### 测试集
seqkit sample -s100 -p 0.2 -w 0 <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}'  $j) > ./VCF_hprc-1000G/Train_Test/'data_all_'$name'-region-10kb_Test.fa'
### 训练集
seqkit grep -n -w 0 --pattern-file <(grep -v -F -f <(grep '>'  ./VCF_hprc-1000G/Train_Test/data_all_$name-region-10kb_Test.fa|sed 's/>//g') <(perl -lane 'if(/>/){$_=~s/>//g;@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{next;}'  $j))  <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}'  $j) > ./VCF_hprc-1000G/Train_Test/'data_all_'$name'-region-10kb_Train.fa'

done

########################################### 数据格式转换
#### format, 数据标签\t多分类标签\t二分类标签\t序列\t序列功能分类\t序列注释信息

#### 整个数据集(参考Class < 患病Class)

##### train
cat  ./VCF_hprc-1000G/Train_Test/data_all_TF_binding_site-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t1\t1\t$b\tTF_binding_site\t$F[0]($F[1])";}'  >./VCF_hprc-1000G/Train_Test/data_all_Regulatory-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Regulatory_Enhancer-region-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t2\t1\t$b\tEnhancer\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Regulatory-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Regulatory_CTCF_binding_site-region-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t3\t1\t$b\tCTCF_binding_site\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Regulatory-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Promoter-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t4\t1\t$b\tPromoter\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Regulatory-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Open_chromatin_region-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t5\t1\t$b\tOpen_chromatin_region\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Regulatory-Classification_Need.fa
cat ./VCF_hprc-1000G/Train_Test/data_all_Non-Regulatory-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t0\t0\t$b\tNon-Regulatory\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Regulatory-Classification_Need.fa

##### test
cat  ./VCF_hprc-1000G/Train_Test/data_all_TF_binding_site-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t1\t1\t$b\tTF_binding_site\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Regulatory-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Regulatory_Enhancer-region-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t2\t1\t$b\tEnhancer\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Regulatory-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Regulatory_CTCF_binding_site-region-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t3\t1\t$b\tCTCF_binding_site\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Regulatory-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Promoter-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t4\t1\t$b\tPromoter\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Regulatory-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Open_chromatin_region-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t5\t1\t$b\tOpen_chromatin_region\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Regulatory-Classification_Need.fa
cat ./VCF_hprc-1000G/Train_Test/data_all_Non-Regulatory-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t0\t0\t$b\tNon-Regulatory\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Regulatory-Classification_Need.fa