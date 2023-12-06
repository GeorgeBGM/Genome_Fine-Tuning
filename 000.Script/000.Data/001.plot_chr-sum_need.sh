#cat ../*/*chr-sum.bed >001.plot_chr-sum_need-draw-chr-sum.txt
cat ../*/*chr-sum.bed|egrep -v 'Complex_Region|HVIDB|M'|sed 's/Disease_loci/Disease_GWAS/g' >001.plot_chr-sum_need-draw-chr-sum.txt
