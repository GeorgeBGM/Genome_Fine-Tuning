###########################################  数据集预处理
###### Non-HERV_Random
#### Coding
### /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Non-HERV_Random/Non-HERV_Coding-region.need_splitN_cluster_rep_seq.fasta
seqkit stat  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Non-HERV_Random/Non-HERV_Coding-region.need_splitN_cluster_rep_seq.fasta > /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Non-HERV_Random/Non-HERV_Coding-region.need_splitN_cluster_rep_seq.fasta.stat

#### Non-Coding
### /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Non-HERV_Random/Non-HERV_Non-Coding-region.need_splitN_cluster_rep_seq.fasta
seqkit stat /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Non-HERV_Random/Non-HERV_Non-Coding-region.need_splitN_cluster_rep_seq.fasta >/home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Non-HERV_Random/Non-HERV_Non-Coding-region.need_splitN_cluster_rep_seq.fasta.stat

###### HERV
#### Coding
### /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/HERV/HERV_Coding-region.need_splitN_cluster_rep_seq.fasta
seqkit stat /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/HERV/HERV_Coding-region.need_splitN_cluster_rep_seq.fasta > /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/HERV/HERV_Coding-region.need_splitN_cluster_rep_seq.fasta.stat

#### Non-Coding
seqkit stat /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/HERV/HERV_Non-Coding-region.need_splitN_cluster_rep_seq.fasta >/home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/HERV/HERV_Non-Coding-region.need_splitN_cluster_rep_seq.fasta.stat

###########################################  数据集划分（训练集、测试集）
#### Coding
### 测试集
seqkit sample -s100 -p 0.2 -w 0 <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}'  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Non-HERV_Random/Non-HERV_Coding-region.need_splitN_cluster_rep_seq.fasta) > /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_Non-HERV_Coding_Test.fa

seqkit sample -s100 -p 0.2 -w 0 <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}'  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/HERV/HERV_Coding-region.need_splitN_cluster_rep_seq.fasta) >/home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_HERV_Coding_Test.fa

### 训练集
seqkit grep -n -w 0 --pattern-file <(grep -v -F -f <(grep '>' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_Non-HERV_Coding_Test.fa|sed 's/>//g') <(perl -lane 'if(/>/){$_=~s/>//g;@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{next;}' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Non-HERV_Random/Non-HERV_Coding-region.need_splitN_cluster_rep_seq.fasta))  <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Non-HERV_Random/Non-HERV_Coding-region.need_splitN_cluster_rep_seq.fasta) > /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_Non-HERV_Coding_Train.fa

seqkit grep -n -w 0 --pattern-file <(grep -v -F -f <(grep '>' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_HERV_Coding_Test.fa|sed 's/>//g') <(perl -lane 'if(/>/){$_=~s/>//g;@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{next;}'  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/HERV/HERV_Coding-region.need_splitN_cluster_rep_seq.fasta))  <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}'  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/HERV/HERV_Coding-region.need_splitN_cluster_rep_seq.fasta) > /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_HERV_Coding_Train.fa

#### Non-Coding
### 测试集
seqkit sample -s100 -p 0.2 -w 0  <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}'  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Non-HERV_Random/Non-HERV_Non-Coding-region.need_splitN_cluster_rep_seq.fasta) > /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_Non-HERV_Non-Coding_Test.fa

seqkit sample -s100 -p 0.2 -w 0 <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/HERV/HERV_Non-Coding-region.need_splitN_cluster_rep_seq.fasta)  >/home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_HERV_Non-Coding_Test.fa

### 训练集
seqkit grep -n -w 0 --pattern-file <(grep -v -F -f <(grep '>' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_Non-HERV_Non-Coding_Test.fa|sed 's/>//g') <(perl -lane 'if(/>/){$_=~s/>//g;@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{next;}' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Non-HERV_Random/Non-HERV_Non-Coding-region.need_splitN_cluster_rep_seq.fasta))  <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Non-HERV_Random/Non-HERV_Non-Coding-region.need_splitN_cluster_rep_seq.fasta) > /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_Non-HERV_Non-Coding_Train.fa

seqkit grep -n -w 0 --pattern-file <(grep -v -F -f <(grep '>' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_HERV_Non-Coding_Test.fa|sed 's/>//g') <(perl -lane 'if(/>/){$_=~s/>//g;@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{next;}' /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/HERV/HERV_Non-Coding-region.need_splitN_cluster_rep_seq.fasta))  <(perl -lane 'if(/>/){@F=split/\s+/,$_;print "$F[0]_ID$.\t$F[1]";}else{print;}'  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/HERV/HERV_Non-Coding-region.need_splitN_cluster_rep_seq.fasta) > /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/data_all_HERV_Non-Coding_Train.fa

### 序列统计
#seqkit stat  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/*Train.fa
#seqkit stat  /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test/*Test.fa
for i in `ls *.fa`;do  b=`grep  '>' $i|wc -l`;echo  -en  "$i\t$b\n";done

########################################### 数据格式转换
### 全长
#perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t1\t$b\tCoding\t$F[0]($F[1])";}'  data_test_HERV_Coding_Train.fa >data_test_model_HERV_Need.fa
#perl -le 'while(<>){chomp;$_=~s/>//g;chomp($b=<>);print "train\t0\t$b\t$_";}'  data_test_Non-HERV_Coding_Train.fa >>data_test_model_HERV_Need.fa
#perl -le 'while(<>){chomp;$_=~s/>//g;chomp($b=<>);print "test\t1\t$b\t$_";}' data_test_HERV_Coding_Test.fa >>data_test_model_HERV_Need.fa
#perl -le 'while(<>){chomp;$_=~s/>//g;chomp($b=<>);print "test\t0\t$b\t$_";}' data_test_Non-HERV_Coding_Test.fa >>data_test_model_HERV_Need.fa

cd /home/u20111010010/Project/DNA-Pretraining/Level1/001.Genomics_dataset/Dataset_HERV/VCF_hprc-1000G/Train_Test
#### Coding区域(参考Class < 患病Class)
cat data_all_HERV_Coding_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t1\t1\t$b\tCoding\t$F[0]($F[1])";}'  >data_all_model_HERV-Classification_Need.fa
cat data_all_Non-HERV_Coding_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t0\t0\t$b\tCoding\t$F[0]($F[1])";}'  >>data_all_model_HERV-Classification_Need.fa
cat data_all_HERV_Coding_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t1\t1\t$b\tCoding\t$F[0]($F[1])";}'  >>data_all_model_HERV-Classification_Need.fa
cat data_all_Non-HERV_Coding_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t0\t0\t$b\tCoding\t$F[0]($F[1])";}'  >>data_all_model_HERV-Classification_Need.fa

#### Non-Coding区域(参考Class < 患病Class)
cat data_all_HERV_Non-Coding_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t3\t1\t$b\tNon-Coding\t$F[0]($F[1])";}'  >>data_all_model_HERV-Classification_Need.fa
cat data_all_Non-HERV_Non-Coding_Train.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "train\t2\t0\t$b\tNon-Coding\t$F[0]($F[1])";}'  >>data_all_model_HERV-Classification_Need.fa
cat data_all_HERV_Non-Coding_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t3\t1\t$b\tNon-Coding\t$F[0]($F[1])";}'  >>data_all_model_HERV-Classification_Need.fa
cat data_all_Non-HERV_Non-Coding_Test.fa|perl -le 'while(<>){chomp;$_=~s/>//g;@F=split/\s+/,$_;chomp($b=<>);print "test\t2\t0\t$b\tNon-Coding\t$F[0]($F[1])";}'  >>data_all_model_HERV-Classification_Need.fa


chmod 755 data_all_model_HERV-Classification_Need.fa


############################################## 数据集统计与绘图
#less -S ./data_hprc_test/Train_Test/data_test_model_HERV_Need_NonN.fa|perl -lane 'if(($F[0] eq "train") and ($F[1]==1)){$Name="HERV(Train)"}elsif(($F[0] eq "train") and ($F[1]==0)){$Name="Non-HERV(Train)"}elsif(($F[0] eq "test") and ($F[1]==1)){$Name="HERV(Test)"}else{$Name="Non-HERV(Test)"};  print "$Name\t",length($F[2])' >./data_hprc_test/Train_Test/data_test_model_HERV_Need_NonN_stat.txt
#less -S ./data_hprc_test/Train_Test/data_test_model_HERV_Need_NonN.fa|perl -lane 'if(($F[0] eq "train") and ($F[1]==1)){$Name="HERV(Train)"}elsif(($F[0] eq "train") and ($F[1]==0)){$Name="Non-HERV(Train)"}elsif(($F[0] eq "test") and ($F[1]==1)){$Name="HERV(Test)"}else{$Name="Non-HERV(Test)"};if($F[1]==0){$Name1="Non-HERV"}else{$Name1="HERV"};print "$Name\t$Name1\t",length($F[2])' >./data_hprc_test/Train_Test/data_test_model_HERV_Need_NonN_stat.txt

#https://www.jianshu.com/p/95f54a8b1269
