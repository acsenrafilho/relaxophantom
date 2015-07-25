#!/bin/bash

inputFolder=$1
n=$2
rf=$3
GM_VALUE=$4
WM_VALUE=$5
CSF_VALUE=$6
R_TYPE=$7
NUMBER_ECHOES=12
brainPhantom=brainweb_n${n}_rf${rf}_brain

if [ $# -lt 7 ];
then
echo "Wrong parameters set."
echo "Usage: $0 <Input Folder> <Noise Level> <RF Inhomogeneity> <Gray Matter T2 value (ms)> <White Matter T2 value (ms)> <CSF T2 Value (ms)> <T1 or T2> <Number of Echos (default=12)>"
exit
fi

if [ $8 -eq 0 ];
then
echo "Number of echoes must be > 0!"
exit
fi

if [ $# -eq 8 ];
then
	NUMBER_ECHOES=$8
fi


echo "Building relaxometry maps"
echo "Step 1: Crop partial volumes"
echo "--- Partial Volume: White Matter ---"
fsl5.0-fslmaths ${brainPhantom}.nii -mul ${brainPhantom}_pve_0.nii.gz ${brainPhantom}_WM.nii.gz

for ((t=1; t<=$NUMBER_ECHOES; t++))
	do	
	echo "-> Calculating echo time t = $t"
	EXP_WM=`echo "scale=6; e(-(${t}/(0.333*$NUMBER_ECHOES))/(${WM_VALUE}/100))" | bc -l`
	fsl5.0-fslmaths ${brainPhantom}_WM.nii.gz -mul $EXP_WM ${brainPhantom}_WM_t_$t.nii.gz
done

echo "--- Partial Volume: Gray Matter ---"
fsl5.0-fslmaths ${brainPhantom}.nii -mul ${brainPhantom}_pve_1.nii.gz ${brainPhantom}_GM.nii.gz

for ((t=1; t<=$NUMBER_ECHOES; t++))
	do	
	echo "-> Calculating echo time t = $t"
	EXP_GM=`echo "scale=6; e(-(${t}/(0.333*$NUMBER_ECHOES))/(${GM_VALUE}/100))" | bc -l`	
	fsl5.0-fslmaths ${brainPhantom}_GM.nii.gz -mul $EXP_GM ${brainPhantom}_GM_t_$t.nii.gz
done

echo "--- Partial Volume: CSF ---"
fsl5.0-fslmaths ${brainPhantom}.nii -mul ${brainPhantom}_pve_2.nii.gz ${brainPhantom}_CSF.nii.gz

for ((t=1; t<=$NUMBER_ECHOES; t++))
	do	
	echo "-> Calculating echo time t = $t"
	EXP_CSF=`echo "scale=6; e(-(${t}/(0.333*$NUMBER_ECHOES))/(${CSF_VALUE}/100))" | bc -l`	
	fsl5.0-fslmaths ${brainPhantom}_CSF.nii.gz -mul $EXP_CSF ${brainPhantom}_CSF_t_$t.nii.gz
done

rm ${brainPhantom}_WM.nii.gz
rm ${brainPhantom}_GM.nii.gz
rm ${brainPhantom}_CSF.nii.gz

echo "Step 2: Reconstructing each echo time from WM, GM and CSF volumes"

for ((t=1; t<=$NUMBER_ECHOES; t++))
do
echo "--> Merging Gray Matter, White Matter and CSF volumes"
fsl5.0-fslmaths ${brainPhantom}_GM_t_$t.nii.gz -add ${brainPhantom}_WM_t_$t.nii.gz temp_GMpWM_t$t.nii.gz
echo "Done"
echo "--> Creating final volume reconstruction from echo t=$t (GM=$GM_VALUE; WM=$WM_VALUE; CSF=$CSF_VALUE)"
fsl5.0-fslmaths temp_GMpWM_t$t.nii.gz -add ${brainPhantom}_CSF_t_$t.nii.gz temp_GMpWMpWM_t$t.nii.gz
mv temp_GMpWMpWM_t$t.nii.gz ${R_TYPE}_n${n}_rf${rf}_t_$t.nii.gz
echo "Done"
echo "...deleting temporary files"
rm ${brainPhantom}_WM_t_$t.nii.gz ${brainPhantom}_CSF_t_$t.nii.gz ${brainPhantom}_GM_t_$t.nii.gz temp_GMpWM_t$t.nii.gz
echo "Done"
done

mkdir ./relaxo
cd /relaxo
for ((t=1; t<=$NUMBER_ECHOES; t++))
do
mv ${R_TYPE}_n${n}_rf${rf}_t_$t.nii.gz ./relaxo
done 

echo "Relaxometry volumes were reconstructed successfully!"
echo "--> The files with $R_TYPE_<phantom parameters> prefix contains the relaxometry volumes"
