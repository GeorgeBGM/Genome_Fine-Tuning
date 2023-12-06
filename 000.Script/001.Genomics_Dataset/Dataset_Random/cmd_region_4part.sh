#!/bin/bash

input_file="genome_random_regions-merge.bed"

# 为四个输出文件创建空文件
> $input_file.label1.txt
> $input_file.label2.txt
> $input_file.label3.txt
> $input_file.label4.txt

# 遍历每一个染色体,为每个染色体处理其区间
awk '{print $1}' $input_file | sort -u | while read -r chr; do
    awk -v chr=$chr '$1==chr' $input_file > tmp_${chr}.txt

    # 计算染色体的区域数量
    total_intervals=$(cat tmp_${chr}.txt | wc -l)

    # 计算每个文件的区域数量
    intervals_per_file=$((total_intervals / 4))
    remainder=$((total_intervals % 4))

    start=1
    for i in {1..4}; do
        end=$((start + intervals_per_file - 1))
        if [ $remainder -gt 0 ]; then
            end=$((end + 1))
            remainder=$((remainder - 1))
        fi

        sed -n "${start},${end}p" tmp_${chr}.txt >> $input_file.label${i}.txt
        start=$((end + 1))
    done

    rm tmp_${chr}.txt
done
