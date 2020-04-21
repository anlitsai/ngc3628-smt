#!/bin/bash


file_script='killChan.class'
file_drop0='drop.list0'

file_class_in[0]=`ls | grep n3628 | grep smt-f1m_dropTsys_dropBad.smt` 
file_class_in[1]=`ls | grep n3628 | grep smt-fqm_dropTsys_dropBad.smt` 
echo ${file_class_in[@]}

file_class_root_in[0]=`echo ${file_class_in[0]} | cut -d . -f1` 
file_class_root_in[1]=`echo ${file_class_in[1]} | cut -d . -f1` 
echo ${file_class_root_in[@]}

file_class_out[0]=`echo ${file_class_root_in[0]}'_killChan.smt'` 
file_class_out[1]=`echo ${file_class_root_in[1]}'_killChan.smt'` 
echo ${file_class_out[@]}
rm -f ${file_class_out[@]}


scan=`echo ${file_class_in[0]} | cut -d _ -f2`
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
  cp -f ${file_class_in[j]} ${file_class_out[j]}

#  echo 'file in' ${file_class_in[j]} >> $file_script
#  echo 'file out' ${file_class_out[j]} 'mul' >> $file_script
  echo 'file both' ${file_class_out[j]} >> $file_script
  echo 'set source *' >> $file_script
  echo 'find;list ' >> $file_script
  echo ' ' >> $file_script

  echo ' ' >> $file_script
  echo 'for i 1 to found' >> $file_script
  echo '  get next' >> $file_script
  echo '  write' >> $file_script
  echo 'next' >> $file_script
  echo ' ' >> $file_script

  scan_chan=`cat $file_drop0 | grep channel | awk '{print $1}'`
  chan_kill=`cat $file_drop0 | grep channel | awk '{print $4}'`
#  echo $scan_chan
#  echo $chan_kill
  num_scan=`echo $scan_chan | wc -w`
  echo 'number of channel with bad scan :' $num_scan
  echo ' ' >> $file_script

  for ((i=1;i<=$num_scan;i=i+1));do
    s=`echo $scan_chan | cut -d " " -f$i`
    k=`echo $chan_kill | cut -d " " -f$i`
    echo 'scan =' $s '; bad channel =' $k
    echo 'get' $s' ; draw kill' $k ';draw fill' $k '; write '>> $file_script
    echo 'file both' ${file_class_out[j]} >> $file_script
  done
  echo ' ' >> $file_script


  echo '!===========================================' >> $file_script
  echo ' ' >> $file_script

#done



