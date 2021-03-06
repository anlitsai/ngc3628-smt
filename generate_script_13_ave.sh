#!/bin/bash

#dir_ps='ps_ave_20170826'
#dir_ps_sm1='ps_ave_sm1_20170826'
#dir_ps_sm2='ps_ave_sm2_20170826'
#dir_ps_sm3='ps_ave_sm3_20170826'
#rm -rf $dir_ps
#rm -rf $dir_ps_sm1
#rm -rf $dir_ps_sm2
#rm -rf $dir_ps_sm3
#mkdir $dir_ps
#mkdir $dir_ps_sm1
#mkdir $dir_ps_sm2
#mkdir $dir_ps_sm3


file_script='ave.class'

file_class_in[0]=`ls | grep n3628 | grep smt-f1m | grep preBase.smt$`
file_class_in[1]=`ls | grep n3628 | grep smt-fq  | grep preBase.smt$`
echo ${file_class_in[@]}

file_class_root_in[0]=`echo ${file_class_in[0]} | cut -d . -f1`
file_class_root_in[1]=`echo ${file_class_in[1]} | cut -d . -f1`
echo ${file_class_root_in[@]}

file_class_out[0]=`echo ${file_class_root_in[0]}'_ave.smt'`
file_class_out[1]=`echo ${file_class_root_in[1]}'_ave.smt'`
echo ${file_class_out[@]}
rm -f ${file_class_out[@]}


scan=`echo $file_class_in[0] | cut -d _ -f2`
scan0=`echo $scan | cut -d - -f1`
scan1=`echo $scan | cut -d - -f2`
#echo $scan0
#echo $scan1

#num1=`echo {01..99}`
#num2=`echo {100..108}`
num1=`seq -w $scan0 99`
num2=`seq -w 100 $scan1`
num=`echo $num1 $num2`
#echo ${num[@]}



echo '!-------------------------------------------' > $file_script
echo ' ' >> $file_script

echo 'device image black' >> $file_script
echo ' ' >> $file_script

echo 'set format long' >> $file_script
echo 'set mod x auto' >> $file_script
echo 'set mod y auto' >> $file_script
echo 'set unit v f' >> $file_script
#echo 'set win 400 1300' >> $file_script
echo ' ' >> $file_script


echo '!===========================================' >> $file_script
echo ' ' >> $file_script

#for j in {0,1};do
j=0

  echo 'file in' ${file_class_in[j]} >> $file_script
  echo 'file out' ${file_class_out[j]} 'mul' >> $file_script
  echo 'set source *' >> $file_script
  echo 'find;list ' >> $file_script
  echo ' ' >> $file_script

  for k in $num;do

    echo '!-------------------------------------------' >> $file_script
    echo ' ' >> $file_script
    target='n3628-'$k
    outfile='ave_'$target'.eps'
#    outfile1='ave_sm1_'$target'.eps'
#    outfile2='ave_sm2_'$target'.eps'
    echo 'set source' $target ';find;'>> $file_script
    echo 'find;list' >> $file_script
    echo 'average /resample;plot'>> $file_script
    echo 'draw molecule 230537.990 " CO(2-1) ->"' >> $file_script
#    echo 'draw win' >> $file_script
#    echo 'hardcopy '$dir_ps'/'$outfile >> $file_script
    echo 'write; ' >> $file_script
    echo ' ' >> $file_script
#    echo 'smooth;plot'>> $file_script
#    echo 'draw molecule 115271.204 " CO(-0) ->"' >> $file_script
#    echo 'hardcopy '$dir_ps_sm1'/'$outfile1 >> $file_script
#    echo ' ' >> $file_script
#    echo 'smooth;plot'>> $file_script
#    echo 'draw molecule 115271.204 " CO(-0) ->"' >> $file_script
#    echo 'hardcopy '$dir_ps_sm2'/'$outfile2 >> $file_script
    echo ' ' >> $file_script

  done

  echo '!===========================================' >> $file_script
  echo ' ' >> $file_script

#done


