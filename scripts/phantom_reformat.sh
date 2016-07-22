#!/bin/bash

n=$1
rf=$2
NUMBER_ECHOES=$3
R_TYPE=$4
TE=$5

#Calculating the echo time for each TE
for ((te=1; te<=$NUMBER_ECHOES; te++))
do
time[${te}]=`echo "scale=4; ${te}*(${TE})" | bc -l`
done

for ((t=1; t<=${NUMBER_ECHOES}; t++))
do
echo "Unpacking t = ${time[$t]}"
mkdir relaxo/${R_TYPE}_n${n}_rf${rf}_t_${t}/
fslslice relaxo/${R_TYPE}_n${n}_rf${rf}_t_${t}.nii.gz relaxo/${R_TYPE}_n${n}_rf${rf}_t_${t}/${R_TYPE}_n${n}_rf${rf}_t_${t}
done

echo "Mounting relaxometry volumes"
for ((slice=0; slice<=181; slice++))
do
	for ((t=1; t<=${NUMBER_ECHOES}; t++))
	do
	#cd relaxo/${R_TYPE}_n${n}_rf${rf}_t_${t}

	if [ $slice -lt 10 ]; then
	time_t[$t]=./relaxo/${R_TYPE}_n${n}_rf${rf}_t_${t}/${R_TYPE}_n${n}_rf${rf}_t_${t}_slice_000${slice}.nii.gz
	elif [ $slice -lt 100 ] && [ $slice -ge 10 ]; then
	time_t[$t]=./relaxo/${R_TYPE}_n${n}_rf${rf}_t_${t}/${R_TYPE}_n${n}_rf${rf}_t_${t}_slice_00${slice}.nii.gz
	elif [ $slice -lt 10000 ] && [ $slice -ge 100 ]; then
	time_t[$t]=./relaxo/${R_TYPE}_n${n}_rf${rf}_t_${t}/${R_TYPE}_n${n}_rf${rf}_t_${t}_slice_0${slice}.nii.gz
	fi
	done
echo "--> Creating relaxometry time evolution for slice $slice"
	if [ $slice -lt 10 ]; then
	fslmerge -z ./relaxo/MNI152_${R_TYPE}_n${n}_rf${rf}_slice_000${slice} ${time_t[*]}
	elif [ $slice -lt 100 ] && [ $slice -ge 10 ]; then
	fslmerge -z ./relaxo/MNI152_${R_TYPE}_n${n}_rf${rf}_slice_00${slice} ${time_t[*]}
	elif [ $slice -lt 10000 ] && [ $slice -ge 100 ]; then
	fslmerge -z ./relaxo/MNI152_${R_TYPE}_n${n}_rf${rf}_slice_0${slice} ${time_t[*]}
	fi

done

rm -R relaxo/T2*
