# Relaxometry Phantom Generator

## Description

This software aims to reconstruct brain relaxometry for T2 phantom images. All the process is based on previously reconstructed brain phantoms by BrainWeb (Montreal Neurological Institute) project. See the McGill Neuroscience Institute (<http://brainweb.bic.mni.mcgill.ca/>) website to found out more information about the BrainWeb phantoms.

The version of Relaxo Phantom toolkit currently avaliable is relaxophantom-v1.0.1, where it is already done:

* Relaxometry for T2 images with different noise levels and RF distortions (please see the script phantom-build.sh for more details)
* Only phantom with 1 mm3 of spatial resolution is avaliable

## Requirements

As it is, the software needs FSL (5.0) previously installed on your machine. Please, be sure that FSL are installed and exist a enviroment variable called fsl5.0 in your system.

To check if exist a link for fsl in your machine type "whereis fsl5.0" in a terminal.

If you do not have FSL installed, you can download the 5.0 version directly from  <http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation>. 
To know more about FSL, see more information about it [here](http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/).

This program have a GNU licence, but check first the FSL licence before use it for other purposes. We not have any responsibility for any problem or bad function of the code.

## How to use

Simply download this repository and run the script phantom-build.sh. If you want to change the parameters in order to create different simulated brain objects, you can change it in the header section in the phantom-build.sh file. Please, choose those parameters wisely.

Note: Make sure that the .sh files have permission to execute. (If not, run chmod a+x 'script' to allow the exectution).

## Problems, Bugs and Suggestions

This project is maintained by @acsenrafilho and if you have any problem, bug or suggestion, please contact me by my [email address](mailto:acsenrafilho@gmail.com)

# Website

<http://acsenrafilho.github.io/relaxophantom>


