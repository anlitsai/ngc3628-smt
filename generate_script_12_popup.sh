#!/bin/bash


file_script='popup_preBase.class'

file_class_in[0]=`ls | grep n3628 | grep smt-f1m | grep preBaseline.smt$`
file_class_in[1]=`ls | grep n3628 | grep smt-fqm | grep preBaseline.smt$`

echo ${file_class_in[@]}


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
#echo ${num[*]}
#echo $num

echo '!-------------------------------------------' > $file_script
echo ' ' >> $file_script

echo 'device image black' >> $file_script
echo ' ' >> $file_script

echo 'set format long' >> $file_script
echo 'set mod x auto' >> $file_script
echo 'set mod y auto' >> $file_script
echo 'set unit v f' >> $file_script
echo ' ' >> $file_script


echo '!===========================================' >> $file_script
echo ' ' >> $file_script

#for j in {0,1};do
j=0

  echo 'file in' ${file_class_in[j]} >> $file_script
  echo 'find;list ' >> $file_script
  echo ' ' >> $file_script

  for k in $num;do

    echo '!-------------------------------------------' >> $file_script
    echo ' ' >> $file_script
    echo 'set source N3628-'$k'; find;list;' >> $file_script
    echo 'stamp;pop' >> $file_script
    echo ' ' >> $file_script

  done

  echo '!===========================================' >> $file_script
  echo ' ' >> $file_script

#done



