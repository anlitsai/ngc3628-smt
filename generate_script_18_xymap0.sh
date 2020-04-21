#!/bin/bash

#v1=300
#v2=1400
v1=200
v2=1500

file_script='makeMap_v'$v1'-'$v2'.class'
echo $file_script


file_class_in[0]=`ls | grep n3628 | grep smt-f1m | grep ave_base.smt$`
file_class_in[1]=`ls | grep n3628 | grep smt-fqm | grep ave_base.smt$`
echo ${file_class_in[@]}

file_class_root_in[0]=`echo ${file_class_in[0]} | awk -F"_" '{print $1"_"$2"_"$3}'`
file_class_root_in[1]=`echo ${file_class_in[1]} | awk -F"_" '{print $1"_"$2"_"$3}'`
echo ${file_class_root_in[@]}

file_class_out[0]=`echo ${file_class_root_in[0]}'_offset.smt'`
file_class_out[1]=`echo ${file_class_root_in[1]}'_ofseet.smt'`
echo ${file_class_out[@]}
rm -f ${file_class_out[@]}

cp ${file_class_in[0]} ${file_class_out[0]}
#cp ${file_class_in[1]} ${file_class_out[1]}


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

y_low=-0.05
y_top=0.15

#mapName=co21map
mapName='co21map_v'$v1'-'$v2
rm -f $mapName*


echo '!-------------------------------------------' > $file_script
echo ' ' >> $file_script

echo 'device image black' >> $file_script
echo ' ' >> $file_script

echo 'set format long' >> $file_script
echo 'set mod x auto' >> $file_script
echo 'set mod y auto' >> $file_script
echo 'set ang sec' >> $file_script
#echo 'set weight sigma' >> $file_script
echo 'set weight time' >> $file_script
echo 'set align f' >> $file_script
#echo 'set nomatch' >> $file_script
echo 'set plot histogram' >> $file_script
echo 'set unit v f' >> $file_script
#echo 'set win 400 1300' >> $file_script
echo ' ' >> $file_script


echo '!===========================================' >> $file_script
echo ' ' >> $file_script

#for j in {0,1};do
j=0

#  echo 'file in' ${file_class_in[j]} >> $file_script
  echo 'file both' ${file_class_out[j]} >> $file_script
  echo 'set source *' >> $file_script
  echo 'find;list ' >> $file_script
  echo ' ' >> $file_script

#  for k in $num;do

    echo '!-------------------------------------------' >> $file_script
    echo ' ' >> $file_script
    echo '!' >> $file_script
    echo '! modify the reference position and source name ' >> $file_script
    echo '!' >> $file_script
    echo ' ' >> $file_script
    echo 'find ' >> $file_script
    echo 'for i 1 to found' >> $file_script
    echo '  get next' >> $file_script
    echo '  modify position 11:20:16.984 13:35:20.07  ! ref. pos.' >> $file_script
    echo '  modify source N3628' >> $file_script
    echo '  write' >> $file_script
    echo 'next i' >> $file_script
    echo ' ' >> $file_script

    echo 'find ' >> $file_script
    echo 'consistency' >> $file_script
#    echo 'consistency /nocheck' >> $file_script
    echo ' ' >> $file_script

    echo '!' >> $file_script
    echo '! do a map of spectrum ' >> $file_script
    echo '!' >> $file_script
    echo ' ' >> $file_script
    echo 'clear all ' >> $file_script
    echo 'find ' >> $file_script
#    echo 'set unit f v ' >> $file_script
#    echo 'set mode x 230000 231100 ' >> $file_script
    echo 'set unit v f ' >> $file_script
    echo 'set mode x 100 1500 ' >> $file_script
    echo 'set mode y '$y_low $y_top  >> $file_script
    echo 'map ' >> $file_script
#    echo 'pause ' >> $file_script
    echo ' ' >> $file_script

    echo '!' >> $file_script
    echo '! do the image map' >> $file_script
    echo '!' >> $file_script
    echo ' ' >> $file_script
    echo 'table' $mapName 'new /range' $v1 $v2 'v ! selection of a range in velocity ' >> $file_script
    echo 'let map%tele KITTPEAK ' >> $file_script
    echo 'let map%diam 10 ' >> $file_script
#    echo 'let map%beam 33.47 ' >> $file_script
    echo 'let map%beam 32.79 ' >> $file_script
    echo 'xy_map' $mapName >> $file_script
    echo ' ' >> $file_script

    echo '!' >> $file_script
    echo 'let name' $mapName >> $file_script
    echo 'let type lmv ' >> $file_script
    echo ' ' >> $file_script

    rm -f xy_map_$v1-$v2.eps
    echo 'go view ' >> $file_script
   echo 'hardcopy xy_map_'$v1'-'$v2'.eps /dev eps color ' >> $file_script
#    echo 'pause ' >> $file_script
    echo ' ' >> $file_script

    rm -rf xy_spectrum_$v1-$v2.eps
    echo 'go spectrum ' >> $file_script
    echo 'hardcopy xy_spectrum_'$v1'-'$v2'.eps /dev eps color ' >> $file_script
    echo ' ' >> $file_script

    rm -f pv_map_$v1-$v2-*.eps
    echo 'go 3view ' >> $file_script
    echo 'hardcopy pv_map_'$v1'-'$v2'-1.eps /dev eps color ' >> $file_script
    echo 'go 3view ' >> $file_script
    echo 'hardcopy pv_map_'$v1'-'$v2'-2.eps /dev eps color ' >> $file_script
    echo 'go 3view ' >> $file_script
    echo 'hardcopy pv_map_'$v1'-'$v2'-3.eps /dev eps color ' >> $file_script
    echo 'go 3view ' >> $file_script
    echo 'hardcopy pv_map_'$v1'-'$v2'-4.eps /dev eps color ' >> $file_script
    echo ' ' >> $file_script

    # go bit: each frame is too small can not see detail
    rm -f chan_map_$v1-$v2.eps
    echo 'go bit ' >> $file_script
    echo 'hardcopy chan_map_'$v1'-'$v2'.eps /dev eps color ' >> $file_script
    echo ' ' >> $file_script
#    echo 'go moments ' >> $file_script
#    echo 'go velocity ' >> $file_script

    echo ' ' >> $file_script


    echo 'find' >> $file_script
    echo 'fits' $mapName'.fits from' $mapName'.lmv' >> $file_script
    echo ' ' >> $file_script

#  done

  echo '!===========================================' >> $file_script
  echo ' ' >> $file_script

#done


