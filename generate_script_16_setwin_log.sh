#!/bin/bash

dir_ps='ps_ave_20171117'
dir_ps_sm1='ps_ave_sm1_20171117'
dir_ps_sm2='ps_ave_sm2_20171117'

rm -rf $dir_ps
rm -rf $dir_ps_sm1
rm -rf $dir_ps_sm2
mkdir $dir_ps
mkdir $dir_ps_sm1
mkdir $dir_ps_sm2

file_script='base_setwin.class'
file_log='ave_base.log'
echo $file_script

file_class_in[0]=`ls | grep n3628 | grep smt-f1m | grep ave_base.smt` 
file_class_in[1]=`ls | grep n3628 | grep fmt-fqm | grep ave_base.smt` 
echo ${file_class_in[@]}

#file_class_root_in[0]=`echo ${file_class_in[0]} | cut -d . -f1` 
#file_class_root_in[1]=`echo ${file_class_in[1]} | cut -d . -f1` 
#echo ${file_class_root_in[@]}

#file_class_out[0]=`echo ${file_class_root_in[0]}'_base.smt'` 
#file_class_out[1]=`echo ${file_class_root_in[1]}'_base.smt'` 
#echo ${file_class_out[@]}
#rm -f ${file_class_out[@]}



scan=`echo $file_class_in[0] | cut -d _ -f2`
scan0=`echo $scan | cut -d - -f1`
scan1=`echo $scan | cut -d - -f2`
#echo $scan0
#echo $scan1

#num1=`echo {01..99}`
#num2=`echo {100..108}`
#num1=`seq -w 2 99`
num1=`seq -w $scan0 99`
num2=`seq -w 100 $scan1`
num=`echo $num1 $num2`
#echo ${num[@]}


echo '!-------------------------------------------' > $file_script
echo ' ' >> $file_script

#echo 'set format long' >> $file_script
echo 'set format brief' >> $file_script
echo 'set mod x auto' >> $file_script
echo 'set mod y auto' >> $file_script
echo 'set unit v f' >> $file_script
echo ' ' >> $file_script
echo 'set source *' >> $file_script
#echo 'set win 400 1300' >> $file_script
#echo 'set win 800 900' >> $file_script
echo ' ' >> $file_script


echo '!===========================================' >> $file_script
echo ' ' >> $file_script

#for j in {0,1};do
j=0

  low=`cat $file_log | grep "WINDOW" | grep "low" | cut -d ":" -f2`
  up=`cat $file_log | grep "WINDOW" | grep "up" | cut -d ":" -f2`
  base=`cat $file_log | grep "base" | cut -d " " -f3`

#   cp ${file_class_in[j]} ${file_class_out[j]}

#  echo 'file in' ${file_class_in[j]} >> $file_script
#  echo 'file out' ${file_class_out[j]} 'mul' >> $file_script
  echo 'file both' ${file_class_in[j]} >> $file_script
  echo 'find;list ' >> $file_script
  echo 'pen /c 0 /w 4 /das 1'>> $file_script
  echo 'greg1\set character 1 ' >> $file_script
  echo ' ' >> $file_script
  echo ' ' >> $file_script

  for i in $num;do
    echo 'get' $i '; plot'>> $file_script
    ll=`echo $low | cut -d " " -f$i`
    uu=`echo $up | cut -d " " -f$i`
    echo 'set win' $ll $uu  >> $file_script
    bb=`echo $base | cut -d " " -f$i`
    echo 'base' $bb '/p; p; w;' >> $file_script
    echo ' ' >> $file_script

    target='n3628-'$i
    outfile='co21_ave_'$target'.eps'
    outfile1='co21_ave_sm1_'$target'.eps'
    outfile2='co21_ave_sm2_'$target'.eps'
    echo ' ' >> $file_script
    echo 'draw molecule 230537.990 " CO(2-1) ->"' >> $file_script
    echo 'hardcopy '$dir_ps'/'$outfile >> $file_script
    echo ' ' >> $file_script
    echo 'smooth;plot'>> $file_script
    echo 'draw molecule 230537.990 " CO(2-1) ->"' >> $file_script
    echo 'hardcopy '$dir_ps_sm1'/'$outfile1 >> $file_script
    echo ' ' >> $file_script
    echo 'smooth;plot'>> $file_script
    echo 'draw molecule 230537.990 " CO(2-1) ->"' >> $file_script
    echo 'hardcopy '$dir_ps_sm2'/'$outfile2 >> $file_script
    echo ' ' >> $file_script

  done

  echo '!===========================================' >> $file_script
  echo 'pen /def'>> $file_script
  echo 'greg1\set character 0.6 ' >> $file_script
  echo 'set format long ' >> $file_script
  echo 'plot ' >> $file_script
  echo ' ' >> $file_script

#  cp $fie_script base_setwin.class


# then manually do pre-baseline
# then manually do pre-baseline
# then manually do pre-baseline
# then manually do pre-baseline

#done



