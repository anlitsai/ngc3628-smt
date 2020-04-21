#!/bin/bash

file_script='rebin.class'
echo $file_script

file_class_in[0]=`ls | grep n3628 | grep smt-f1m | grep ave_base.smt` 
file_class_in[1]=`ls | grep n3628 | grep fmt-fqm | grep ave_base.smt` 
echo ${file_class_in[@]}

file_class_root_in[0]=`echo ${file_class_in[0]} | cut -d . -f1` 
file_class_root_in[1]=`echo ${file_class_in[1]} | cut -d . -f1` 
echo ${file_class_root_in[@]}

file_class_out[0]=`echo ${file_class_root_in[0]}'_rebin.smt'` 
file_class_out[1]=`echo ${file_class_root_in[1]}'_rebin.smt'` 
echo ${file_class_out[@]}
rm -f ${file_class_out[@]}


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


   cp -r ${file_class_in[j]} ${file_class_out[j]}

#  echo 'file in' ${file_class_in[j]} >> $file_script
#  echo 'file out' ${file_class_out[j]} 'mul' >> $file_script
  echo 'file both' ${file_class_out[j]} >> $file_script
  echo 'find;list ' >> $file_script
  echo ' ' >> $file_script
  echo ' ' >> $file_script

#  for i in $num;do

#    target='n3628-'$i
    echo ' ' >> $file_script
#    target='n3628-'$k
#    echo 'set source' $target ';find;list;plo'>> $file_script
    echo 'for i 1 to found ' >> $file_script
    echo '  get i' >> $file_script
    echo '  plot' >> $file_script
#    echo '  find;list' >> $file_script
    echo '  analyse\resample 261 1 200 5 velocity' >> $file_script
    echo '  plot' >> $file_script
    echo '  write' >> $file_script
    echo 'next' >> $file_script
    echo ' ' >> $file_script
    echo ' ' >> $file_script




#  done

  echo '!===========================================' >> $file_script
  echo 'set source *;find;list ' >> $file_script
  echo ' ' >> $file_script

  echo 'fits filename: ' ${file_class_root_in[j]}'_rebin.fits'
  rm -f ${file_class_root_in[j]}'_rebin.fits'
  echo 'fits write' ${file_class_root_in[j]}'_rebin.fits /mode index'  >> $file_script
  echo ' ' >> $file_script



# then manually do pre-baseline
# then manually do pre-baseline
# then manually do pre-baseline
# then manually do pre-baseline

#done



