#!/bin/csh

foreach s (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17) 

if (${s}<10) then
cp ./MotorDataAnalysis/Adults/a0${s}/Analysis/MotorL/meanmotorL* ./conn/Adults/a0${s}/MotorL
cp ./MotorDataAnalysis/Adults/a0${s}/Analysis/MotorR/meanmotorR* ./conn/Adults/a0${s}/MotorR

else
cp ./MotorDataAnalysis/Adults/a${s}/Analysis/MotorL/meanmotorL* ./conn/Adults/a${s}/MotorL
cp ./MotorDataAnalysis/Adults/a${s}/Analysis/MotorR/meanmotorR* ./conn/Adults/a${s}/MotorR

endif
end
echo Done making conn adults

