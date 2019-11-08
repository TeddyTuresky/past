#!/bin/bash

####script searches CFMI directories by date, then looks for any subjects we may be interested in. If a CSL subject is found, then it will copy data to the user's home directory

cd /Volumes/y/cfmi_data/csl_pract
for ((k=0; k<=long; k++)); do
	sub=(`ls`) # list files in current directory
	long=${#sub[*]} # number of files in current directory

# take inventory of MRI sessions
	for ((k=0; k<=long; k++)); do
		cd ./${sub[k]} # go into subject folder
		sess=(`ls`)
		len=${#sess[*]}

# take inventory of runs in each scan run
		for ((i=0; i<=len; i++)); do
			cd ./${sess[i]};
			run=(`ls`)
			leng=${#run[*]}

# take inventory of acquisition folders 			
			for ((h=0; h<=leng; h++)); do
				cd ./${run[h]};
				acq=(`ls`)
                        	lengac=${#acq[*]}
# move .nii files to main run folder				
				for ((j=0; j<=lengac; j++)); do
					cd ./${acq[j]}
					mv *.nii ../
				done
				cd ../
			done
			cd ../
		done
		cd ../
	done
	cd ../
done


echo done echoing


