###########################################  数据集预处理
for i in `ls /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Highly_Specifically/VCF_hprc-1000G/*/*cluster_rep_seq.fasta`;do  seqkit stat  $i >$i.stat;done

###########################################  数据集划分（训练集、测试集）
for j in `ls /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Highly_Specifically/VCF_hprc-1000G/*/*cluster_rep_seq.fasta`;
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
cat  ./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically_OR_region-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t1\t1\t$b\tOR\t$F[0]($F[1])";}'  >./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically_DEF_region-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t2\t1\t$b\tDEF\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically-Classification_Need.fa
cat ./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically_Non-DEF_OR_region-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t0\t0\t$b\tNon-DEF_OR\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically-Classification_Need.fa

cat  ./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically_OR_region-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t1\t1\t$b\tOR\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically_DEF_region-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t2\t1\t$b\tDEF\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically-Classification_Need.fa
cat ./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically_Non-DEF_OR_region-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t0\t0\t$b\tNon-DEF_OR\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically-Classification_Need.fa


chmod 755 ./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically-Classification_Need.fa
perl -lane 'print "$F[0]\t$F[1]\t$F[2]\t$F[-2]"' ./VCF_hprc-1000G/Train_Test/data_all_Highly_Specifically-Classification_Need.fa|sort|uniq -c
