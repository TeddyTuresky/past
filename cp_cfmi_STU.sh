#!/bin/bash

####script searches CFMI directories by date, then looks for any subjects we may be interested in. If a CSL subject is found, then it will copy data to the user's home directory

y=(2007
2006
2006);
m=(07
07
05);
d=(23
25
24);
STU=(1.3.12.2.1107.5.2.13.20522.30000007070916474576500000157.STU
1.3.12.2.1107.5.2.13.20522.30000006072415435193700000010.STU
1.3.12.2.1107.5.2.13.20522.30000006050815585504600000073.STU);
ID=(61097
66594
26586);
long=2 # number of datapoints minus 1

cd /raw/dicom/data/cfmi/MR

# go to particular date
for ((k=0; k<=long; k++)); do
	
	mkdir ~/csl_data5/${ID[k]}; # make a directory with subj ID in which to copy MRI session
	cp -R ./${y[k]}/${m[k]}/${d[k]}/${STU[k]} ~/csl_data5/${ID[k]}; # copy scan session files to cfmi home folder

done

echo done copying


