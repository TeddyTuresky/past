#!/bin/bash

hm=/Volumes/FunTown/allAnalyses/BangRS/segs_for_ted 
new=(`cat ~/Dropbox/scripts/shell/subBang`)
dep=/Volumes/FunTown/allAnalyses/BangRS/segs-rename2


var=(`ls $hm`)
long=${#var[*]}

for ((i=0; i<long; i++)); do

	cp -R $hm/${var[i]} $dep/${new[i]}

done

