###########################################  数据集预处理
###### Immuno_KIR-region-10kb
seqkit stat  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Immuno/Genome-Immuno_KIR-region-10kb.need_splitN_cluster_rep_seq.fasta > /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Immuno/Genome-Immuno_KIR-region-10kb.need_splitN_cluster_rep_seq.fasta.stat

###### Immuno_Others-region-10kb
seqkit stat /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Immuno/Genome-Immuno_Others-region-10kb.need_splitN_cluster_rep_seq.fasta > /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Immuno/Genome-Immuno_Others-region-10kb.need_splitN_cluster_rep_seq.fasta.stat

###### Non-Immuno-region-10kb
seqkit stat /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Non-Immuno_Random/Genome-Non_Immuno-region-10kb.need_splitN_cluster_rep_seq.fasta >/home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Non-Immuno_Random/Genome-Non_Immuno-region-10kb.need_splitN_cluster_rep_seq.fasta.stat

###########################################  数据集划分（训练集、测试集）
#### Immuno_KIR-region-10kb
### 测试集
seqkit sample -s100 -p 0.2 -w 0 <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}'  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Immuno/Genome-Immuno_KIR-region-10kb.need_splitN_cluster_rep_seq.fasta) > ./VCF_hprc-1000G/Train_Test/data_all_Immuno_KIR-region-10kb_Test.fa

### 训练集
seqkit grep -n -w 0 --pattern-file <(grep -v -F -f <(grep '>'  ./VCF_hprc-1000G/Train_Test/data_all_Immuno_KIR-region-10kb_Test.fa|sed 's/>//g') <(perl -lane 'if(/>/){$_=~s/>//g;@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{next;}' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Immuno/Genome-Immuno_KIR-region-10kb.need_splitN_cluster_rep_seq.fasta))  <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Immuno/Genome-Immuno_KIR-region-10kb.need_splitN_cluster_rep_seq.fasta) > ./VCF_hprc-1000G/Train_Test/data_all_Immuno_KIR-region-10kb_Train.fa

#### Immuno_Others-region-10kb
### 测试集
seqkit sample -s100 -p 0.2 -w 0  <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}'  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Immuno/Genome-Immuno_Others-region-10kb.need_splitN_cluster_rep_seq.fasta) > ./VCF_hprc-1000G/Train_Test/data_all_Immuno_Others-region-10kb_Test.fa

### 训练集
seqkit grep -n -w 0 --pattern-file <(grep -v -F -f <(grep '>' ./VCF_hprc-1000G/Train_Test/data_all_Immuno_Others-region-10kb_Test.fa|sed 's/>//g') <(perl -lane 'if(/>/){$_=~s/>//g;@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{next;}' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Immuno/Genome-Immuno_Others-region-10kb.need_splitN_cluster_rep_seq.fasta))  <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Immuno/Genome-Immuno_Others-region-10kb.need_splitN_cluster_rep_seq.fasta) > ./VCF_hprc-1000G/Train_Test/data_all_Immuno_Others-region-10kb_Train.fa

#### Non_Immuno-region-10kb
### 测试集
seqkit sample -s100 -p 0.2 -w 0  <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}'  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Non-Immuno_Random/Genome-Non_Immuno-region-10kb.need_splitN_cluster_rep_seq.fasta) > ./VCF_hprc-1000G/Train_Test/data_all_Non_Immuno-region-10kb_Test.fa

### 训练集
seqkit grep -n -w 0 --pattern-file <(grep -v -F -f <(grep '>' ./VCF_hprc-1000G/Train_Test/data_all_Non_Immuno-region-10kb_Test.fa|sed 's/>//g') <(perl -lane 'if(/>/){$_=~s/>//g;@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{next;}' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Non-Immuno_Random/Genome-Non_Immuno-region-10kb.need_splitN_cluster_rep_seq.fasta))  <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_Immuno/VCF_hprc-1000G/Non-Immuno_Random/Genome-Non_Immuno-region-10kb.need_splitN_cluster_rep_seq.fasta) > ./VCF_hprc-1000G/Train_Test/data_all_Non_Immuno-region-10kb_Train.fa

###### 序列统计
#seqkit stat  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/*Train.fa
#seqkit stat  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/*Test.fa

for i in `ls  ./VCF_hprc-1000G/Train_Test/*.fa`;do  b=`grep  '>' $i|wc -l`;echo  -en  "$i\t$b\n";done

########################################### 数据格式转换
#### format, 数据标签\t多分类标签\t二分类标签\t序列\t序列功能分类\t序列注释信息

#### 整个数据集(参考Class < 患病Class)
cat  ./VCF_hprc-1000G/Train_Test/data_all_Immuno_KIR-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t1\t1\t$b\tKIR\t$F[0]($F[1])";}'  >./VCF_hprc-1000G/Train_Test/data_all_Immuno-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Immuno_Others-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t2\t1\t$b\tOthers\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Immuno-Classification_Need.fa
cat ./VCF_hprc-1000G/Train_Test/data_all_Non_Immuno-region-10kb_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t0\t0\t$b\tNon_Immuno\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Immuno-Classification_Need.fa


cat  ./VCF_hprc-1000G/Train_Test/data_all_Immuno_KIR-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t1\t1\t$b\tKIR\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Immuno-Classification_Need.fa
cat  ./VCF_hprc-1000G/Train_Test/data_all_Immuno_Others-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t2\t1\t$b\tOthers\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Immuno-Classification_Need.fa
cat ./VCF_hprc-1000G/Train_Test/data_all_Non_Immuno-region-10kb_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t0\t0\t$b\tNon_Immuno\t$F[0]($F[1])";}'  >>./VCF_hprc-1000G/Train_Test/data_all_Immuno-Classification_Need.fa


chmod 755 ./VCF_hprc-1000G/Train_Test/data_all_Immuno-Classification_Need.fa

perl -lane 'print "$F[0]\t$F[1]\t$F[2]\t$F[-2]"' ./VCF_hprc-1000G/Train_Test/data_all_Immuno-Classification_Need.fa|sort|uniq -c
