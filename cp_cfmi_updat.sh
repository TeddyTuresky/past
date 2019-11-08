#!/bin/bash

####script searches CFMI directories by date, then looks for any subjects we may be interested in. If a CSL subject is found, then it will copy data to the user's home directory

y=(2006
2005
2005
2005
2004
2004
2005
2004
2004
2004
2004
2005
2006
2005
2005
2005
2005
2005
2005
2005
2006
2005
2004
2006
2004
2004
2004
2004
2006
2005
2005
2005
2005);
m=(08
04
08
08
02
02
08
08
08
08
09
01
07
01
02
02
08
08
07
10
08
07
05
07
08
08
08
09
07
01
02
02
10);
d=(07
16
19
19
16
16
19
24
30
29
17
08
24
25
07
07
09
09
16
22
07
12
24
25
24
30
29
17
24
25
07
07
22);
ID=(10361
17612
77964
89446
55001
55002
63084
14001
14002
14003
14004
34219
102152
10063
14005
14006
39540
52978
53662
10377
84174
99468
26586
66594
45761
90997
66196
54489
55335
62045
81003
85514
21900);

IDn=();

long=33 # number of datapoints
dep=newDirect;


# No need to change below
# take inventory of MRI sessions done on particular date
for ((k=0; k<long; k++)); do
	cd /raw/dicom/data/cfmi/MR/${y[k]}/${m[k]}/${d[k]};
	var=(`ls`)
	len=${#var[*]}

# take inventory of runs in each scan session
	for ((j=0; j<len; j++)); do
		cd ./${var[j]};
			varg=(`ls`)
			leng=${#varg[*]}

# search patnam.txt files for CSL subject IDs provided 			
			for ((i=0; i<leng; i++)); do
				if [[ ${varg[i]} == "patnam.txt" ]]; then
					echo patnam exists
					if grep ${ID[k]} ./patnam.txt; then # if subject ID exists, then copy it to home directory
						echo CSL subject
						mkdir ~/${dep}/${ID[k]} # make a directory with subj ID in which to copy MRI session
						cp -R ../${var[j]} ~/${dep}/${ID[k]}
					else
						echo not CSL
					fi
				else
					echo no patnam	
				fi 
			done
		cd ../
	done
	cd ../../../
done


echo done copying


