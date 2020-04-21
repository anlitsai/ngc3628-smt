#!/bin/bash

scan=118
file_script='split_data.class'
file_class_in='class.smt'

file_class_out[0]='n3628_01-'$scan'_smt-f1m.smt'
file_class_out[1]='n3628_01-'$scan'_smt-fqm.smt'
#echo ${file_class_out[@]}

rm -f ${file_class_out[@]}


echo '!-------------------------------------------' > $file_script
echo ' ' >> $file_script


tel=(smt-f1m smt-fqm)
#echo ${tel[@]}

for j in {0,1} ;do

  echo 'file in' $file_class_in >> $file_script
  echo 'file out' ${file_class_out[$j]} 'mul' >> $file_script
  echo 'find;list ' >> $file_script
  echo ' ' >> $file_script

  echo 'set tel' ${tel[$j]}'*' >> $file_script
  echo 'set source N3628*' >> $file_script
  echo 'find;list' >> $file_script
  echo ' ' >> $file_script

  echo 'find /num 3201 *' >> $file_script
  echo ' ' >> $file_script

  echo 'for i 1 to found' >> $file_script
  echo '  get next' >> $file_script
  echo '  write' >> $file_script
  echo 'next' >> $file_script
  #echo 'q' >> $file_script
  echo ' ' >> $file_script

  echo 'file in' ${file_class_out[$j]} >> $file_script
  echo 'set source *' >> $file_script
  echo 'set tel *' >> $file_script
  echo 'find;list ' >> $file_script
  echo ' ' >> $file_script

  echo '!-------------------------------------------' >> $file_script
  echo ' ' >> $file_script

done




