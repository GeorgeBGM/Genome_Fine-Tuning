###########################################  数据集预处理
for i in `ls /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Random/VCF_hprc-1000G/Random/*cluster_rep_seq.fasta`;do  seqkit stat  $i >$i.stat;done

###########################################  数据集划分（训练集、测试集）

for j in `ls  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Random/VCF_hprc-1000G/Random/*cluster_rep_seq.fasta`;
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

####################  Set1区域（label2:1；label1:0）、Set2区域（label4:3；label3:2）
##### train
cat  ./VCF_hprc-1000G/Train_Test/data_all_Random_regiono-label1-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t0\t0\t$b\tLabel1\t$F[0]";}'  >./VCF_hprc-1000G/Train_Test/data_all_Random-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Random_region-label2-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t1\t0\t$b\tLabel2\t$F[0]";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Random-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Random_region-label3-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t2\t1\t$b\tLabel3\t$F[0]";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Random-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Random_region-label4-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t3\t1\t$b\tLabel4\t$F[0]";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Random-Classification_Need.fa

##### test
cat  ./VCF_hprc-1000G/Train_Test/data_all_Random_regiono-label1-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t0\t0\t$b\tLabel1\t$F[0]";}' >>./VCF_hprc-1000G/Train_Test/data_all_Random-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Random_region-label2-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t1\t0\t$b\tLabel2\t$F[0]";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Random-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Random_region-label3-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t2\t1\t$b\tLabel3\t$F[0]";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Random-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Random_region-label4-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t3\t1\t$b\tLabel4\t$F[0]";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Random-Classification_Need.fa

#############################################  数据标签进一步随机化
cat  ./VCF_hprc-1000G/Train_Test/data_all_Random-Classification_Need.fa|perl -MList::Util=shuffle -lane 'BEGIN { @col2=(); @col3=(); @first_col=();@Other=();} push @first_col, $F[0];push @Other,"$F[3]\t$F[4]\t$F[5]"; push @col2, $F[1]; push @col3, $F[2]; END { @shuf2 = shuffle(@col2); @shuf3 = shuffle(@col3); for(0..$#col2) { print "$first_col[$_]\t$shuf2[$_]\t$shuf3[$_]\t$Other[$_]"; } }'  >./VCF_hprc-1000G/Train_Test/data_all_Random-Classification_Need_shuffle.fa
