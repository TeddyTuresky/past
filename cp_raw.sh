#!/bin/csh

foreach s (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46)

   if (${s}<10) then 

     cd a0${s}

   else

     cd a${s}
   
   endif


   cp -R Analysis/MotorL/wrmotor* ../../../conn/Adults/a${s}/MotorL
   cp -R Analysis/MotorR/wrmotor* ../../../conn/Adults/a${s}/MotorR

   cd ../

end


