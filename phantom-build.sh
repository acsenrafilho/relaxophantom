#!/bin/bash
####################################################################
#Configuration Set:
#--> Basic default phantom parameters
n=0			#Noise level [0,3,9]		(default: 0)
rf=0			#RF field distortion [0,20,40] 	(default: 0)
GM_VALUE=80		#Gray Matter (ms) 		(default: 80)
WM_VALUE=112		#White Matter (ms) 		(default: 112)
CSF_VALUE=200		#CSF (ms) 			(default: 200)
R_TYPE=T2		#Type of relaxometry [T1,T2] 	(default: T2)
NUMBER_ECHOES=12 	#Number of echos 		(default: 12)
TE=0.012 		#Time of echo (seconds) 	(default: 0.012)
#
#--> If you want to change some parameters, please do this wisely
####################################################################

#n=${1:-$def_n}

echo "-- Starting phantom reconstruction --"
echo "#############################################"
echo "Configuration set:"
echo "Noise level                            = ${n}"
echo "RF field distortion                    = ${rf}"
echo "Gray Matter ${R_TYPE}                         = ${GM_VALUE}"
echo "White Matter ${R_TYPE}                        = ${WM_VALUE}"
echo "CSF Matter ${R_TYPE}                          = ${CSF_VALUE}"
echo "Number of echos                        = ${NUMBER_ECHOES}"
echo "Time of echo                           = ${TE}"
echo "#############################################"

echo "Step 1: Volumes segmentation"
./scripts/phantom_segmentation.sh $n $rf $R_TYPE
echo "*** Step 1: Done ***"

echo "Step 2: Phantom reconstruction"
./scripts/phantom_recon.sh $n $rf $GM_VALUE $WM_VALUE $CSF_VALUE $R_TYPE $NUMBER_ECHOES $TE
echo "*** Step 2: Done ***"

echo "Step 3: Reformating relaxometry volumes"
./scripts/phantom_reformat.sh ${n} ${rf} ${NUMBER_ECHOES} ${R_TYPE} ${TE}
echo "*** Step 3: Done ***"

echo "The results are located in the folder ./relaxo"
