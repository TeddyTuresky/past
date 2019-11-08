#!/bin/csh

foreach s (14 15)

mkdir a${s}/Analysis/MotorL
mkdir a${s}/Analysis/MotorR
mkdir a${s}/Analysis/MPRAGE
cp a${s}/RawData/MotorL/motorL* a${s}/Analysis/MotorL/
cp a${s}/RawData/MotorR/motorR* a${s}/Analysis/MotorR/
cp a${s}/RawData/MPRAGE/MPRAGE* a${s}/Analysis/MPRAGE/

end
echo Done with copy
