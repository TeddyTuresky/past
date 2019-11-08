#!/bin/bash

for s in {1..46}

do cd /export/w/Graduate_Students/ted/conn2

if [ "$s" -lt 10 ]; then

cp ./Children/c0$s/MotorL/MotorL/* ./Children/c0$s/MotorL
cp ./Children/c0$s/MotorR/MotorR/* ./Children/c0$s/MotorR

else
cp ./Children/c$s/MotorL/MotorL/* ./Children/c$s/MotorL
cp ./Children/c$s/MotorR/MotorR/* ./Children/c$s/MotorR

fi

done
