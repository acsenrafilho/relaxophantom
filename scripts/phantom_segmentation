#!/bin/bash

noise=$1
rf=$2
R_TYPE=$3

sufix="n"$noise"_rf"$rf
mkdir data/${R_TYPE}/${sufix}/temp

echo "--> Generating partial volumes (GM, WM and CSF)"
fast -t 1 -n 3 -H 0.1 -I 4 -l 20.0 -g -o "data/"${R_TYPE}"/"${sufix}"/brainweb_"$sufix"_brain" "data/"${R_TYPE}"/"$sufix"/brainweb_"$sufix"_brain"

cd data/
rm ${R_TYPE}/${sufix}"/temp/brainweb_${sufix}_brain_pveseg.nii.gz"
rm ${R_TYPE}/${sufix}"/temp/brainweb_${sufix}_brain_seg.nii.gz"
rm ${R_TYPE}/${sufix}"/temp/brainweb_${sufix}_brain_mixeltype.nii.gz"

mv ${R_TYPE}"/"${sufix}"/brainweb_"$sufix"_brain_"*.nii.gz ${R_TYPE}/${sufix}/temp
