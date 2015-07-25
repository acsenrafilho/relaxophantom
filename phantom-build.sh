#!/bin/bash
####################################################################
#Configuration Set:
#--> Basic Phantom Characteristics
n=0			#Noise level [0,3,9](default: 0)
rf=0			#RF field distortion [0,20,40] (default: 0)
GM_VALUE=80		#Gray Matter (ms) (default: 80)
WM_VALUE=112		#White Matter (ms) (default: 112)
CSF_VALUE=200		#CSF (ms) (default: 200)
R_TYPE=T2		#Type of relaxometry [T1,T2] (default: T2)
NUMBER_ECHOES=12 	#Number of echos (default: 12)
#
#--> 
#Change wisely the parameters above to build your own relaxometry volumes
####################################################################

outputFolder=$1

if [ $# -eq 0 ];
then
echo "Set a folder where the relaxometry volumes will be placed"
echo "Usage: $0 <Folder output>"
exit
fi

echo "-- Starting phantom reconstruction --"

echo "Step 1: Volumes segmentation"
#./scripts/phantom_segmentation.sh $n $rf $R_TYPE
echo "*** Step 1: Done ***"

echo "Step 2: Phantom reconstruction"
./scripts/phantom_recon.sh $outputFolder $n $rf $GM_VALUE $WM_VALUE $CSF_VALUE $R_TYPE $NUMBER_ECHOES
echo "*** Step 2: Done ***"

echo "The results are located in the folder:  ${outputFolder}/relaxo"
