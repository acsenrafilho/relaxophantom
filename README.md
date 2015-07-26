# Relaxometry Phantom Generator

## Description

This software aims to reconstruct brain relaxometry for T2 and T1 phantom images. All the process is based on previously reconstructed brain phantoms by BrainWeb (Montreal Neurological Institute).

The version currently avaliable is relaxophantom-v1.0, where it already done:

* Relaxometry for T2 images with different noise levels and RF distortions (please see the script phantom-build.sh for more details)
* Only phantom with 1 mm of spatial resolution is avaliable

## Requirements

As it is, the software needs FSL (5.0) previously installed on your machine. Please, be sure that FSL are installed and exist a enviroment variable called fsl5.0 in your system.

If you do not have FSL installed, you can download the 5.0 version directly from [http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation]. 
To know more about FSL, see [http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/].

## How to use

Simply download this repository and run the script phantom-build.sh
Note: Make sure that the .sh files have permission to execute. (If not, run chmod a+x <script> to allow the exectution).

## Problems and Bugs?

If you have any problem with this script, please contact me!
acsenrafilho@gmail.com


