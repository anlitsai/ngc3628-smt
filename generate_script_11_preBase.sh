#!/bin/bash

echo "================================="
echo "Be Carefule!! Don't Delete file!!"
echo "================================="
exit

file_script='preBase.class'
file_drop0='drop.list0'

file_class_in[0]=`ls | grep n3628 | grep smt-f1m | grep base0.smt` 
file_class_in[1]=`ls | grep n3628 | grep fmt-fqm | grep base0.smt` 
echo ${file_class_in[@]}

file_class_root_in[0]=`echo ${file_class_in[0]} | cut -d . -f1` 
file_class_root_in[1]=`echo ${file_class_in[1]} | cut -d . -f1` 
echo ${file_class_root_in[@]}

file_class_out[0]=`echo ${file_class_root_in[0]}'_preBase.smt'` 
file_class_out[1]=`echo ${file_class_root_in[1]}'_preBase.smt'` 
echo ${file_class_out[@]}
# rm -f ${file_class_out[@]}



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

echo 'set format long' >> $file_script
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

   cp ${file_class_in[j]} ${file_class_out[j]}

#  echo 'file in' ${file_class_in[j]} >> $file_script
#  echo 'file out' ${file_class_out[j]} 'mul' >> $file_script
  echo 'file both' ${file_class_out[j]} >> $file_script
  echo 'find;list ' >> $file_script
  echo ' ' >> $file_script

  cat $file_drop0 | egrep 'pre-order' 
  scan_drop=`cat $file_drop0 | egrep 'pre-order' | awk '{print $1}'`

  for k in $scan_drop;do
    echo 'get '$k  '; plot' >> $file_script
  done




#done

# then manually do pre-baseline
# then manually do pre-baseline
# then manually do pre-baseline
# then manually do pre-baseline
# then manually do pre-baseline
# then manually do pre-baseline





