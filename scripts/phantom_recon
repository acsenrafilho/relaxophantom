#!/bin/bash

n=$1
rf=$2
GM_VALUE=$3
WM_VALUE=$4
CSF_VALUE=$5
R_TYPE=$6
NUMBER_ECHOES=$7
TE=$8
brainPhantom=brainweb_n${n}_rf${rf}_brain

echo "Building relaxometry maps"
echo "Step 1: Crop partial volumes"
echo "--- Partial Volume: White Matter ---"
cd data/${R_TYPE}/n${n}_rf${rf}
fslmaths ${brainPhantom}.nii -mul temp/${brainPhantom}_pve_0.nii.gz temp/${brainPhantom}_WM.nii.gz

#Calculating the echo time for each TE
for ((te=1; te<=$NUMBER_ECHOES; te++))
do
t[${te}]=`echo "scale=4; ${te}*(${TE})" | bc -l`
done

for ((t=1; t<=$NUMBER_ECHOES; t++))
	do
	echo "-> Calculating echo time t = ${t[$t]}"
	EXP_WM=`echo "scale=6; e(-(${t[$t]})/(${WM_VALUE}/1000))" | bc -l`
	fslmaths temp/${brainPhantom}_WM.nii.gz -mul $EXP_WM temp/${brainPhantom}_WM_t_$t.nii.gz
done

echo "--- Partial Volume: Gray Matter ---"
fslmaths ${brainPhantom}.nii -mul temp/${brainPhantom}_pve_1.nii.gz temp/${brainPhantom}_GM.nii.gz

for ((t=1; t<=$NUMBER_ECHOES; t++))
	do
	echo "-> Calculating echo time t = ${t[$t]}"
	EXP_GM=`echo "scale=6; e(-(${t[$t]})/(${GM_VALUE}/1000))" | bc -l`
	fslmaths temp/${brainPhantom}_GM.nii.gz -mul $EXP_GM temp/${brainPhantom}_GM_t_$t.nii.gz
done

echo "--- Partial Volume: CSF ---"
fslmaths ${brainPhantom}.nii -mul temp/${brainPhantom}_pve_2.nii.gz temp/${brainPhantom}_CSF.nii.gz

for ((t=1; t<=$NUMBER_ECHOES; t++))
	do
	echo "-> Calculating echo time t = ${t[$t]}"
	EXP_CSF=`echo "scale=6; e(-(${t[$t]})/(${CSF_VALUE}/1000))" | bc -l`
	fslmaths temp/${brainPhantom}_CSF.nii.gz -mul $EXP_CSF temp/${brainPhantom}_CSF_t_$t.nii.gz
done

echo "Step 2: Reconstructing each echo time from WM, GM and CSF volumes"

for ((t=1; t<=$NUMBER_ECHOES; t++))
do
echo "--> Merging Gray Matter, White Matter and CSF volumes"
fslmaths temp/${brainPhantom}_GM_t_$t.nii.gz -add temp/${brainPhantom}_WM_t_$t.nii.gz temp/temp_GMpWM_t$t.nii.gz
echo "Done"

if [ ! -d ../../../relaxo ]; then
  mkdir ../../../relaxo
fi

echo "--> Creating final volume reconstruction from echo t=$t (GM=$GM_VALUE; WM=$WM_VALUE; CSF=$CSF_VALUE)"
fslmaths temp/temp_GMpWM_t$t.nii.gz -add temp/${brainPhantom}_CSF_t_$t.nii.gz temp/temp_GMpWMpWM_t$t.nii.gz
mv temp/temp_GMpWMpWM_t$t.nii.gz ../../../relaxo/${R_TYPE}_n${n}_rf${rf}_t_$t.nii.gz
echo "Done"

echo "...deleting temporary files"
echo "Done"
done

# Deleting temporary files
rm -R temp/

echo "Relaxometry volumes were reconstructed successfully!"
echo "--> The files with ${R_TYPE}_<phantom parameters> prefix contains the relaxometry volumes"
