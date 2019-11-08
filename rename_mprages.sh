#!/bin/bash

cd /Volumes/TKT/dyslexiaAnalysis/dysped

i=(2	1	2	2	1	1	3	1	2	1	1	1	1	2	1	3	1	1	1	1	1	1	1	1	1	1	1	2	2	2	1	3	2	1	1	1	3	1	2	2	1);
long=41;

for ((s=1; s<=long; s++)); do
	if [ ${s} -lt "10" ]; then
		mv dp0${s}/analysis/mprage${i[s-1]} dp0${s}/analysis/mprage_go
	else
		mv dp${s}/analysis/mprage${i[s-1]} dp${s}/analysis/mprage_go
	fi
done

echo done renaming

