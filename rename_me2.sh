#!/bin/bash

for s in {1..69..1}  

if [$s -lt 10]
then
mv /export/w/Graduate_Students/ted/me2/Motor1/f150203093314STD131221107523235052-0023-00001-00000$s-01.hdr /export/w/Graduate_Students/ted/me2/Motor1/motor_0$s.hdr
mv /export/w/Graduate_Students/ted/me2/Motor1/f150203093314STD131221107523235052-0023-00001-00000$s-01.img /export/w/Graduate_Students/ted/me2/Motor1/motor_0$s.img

else

mv /export/w/Graduate_Students/ted/me2/Motor1/f150203093314STD131221107523235052-0023-00001-0000$s-01.hdr /export/w/Graduate_Students/ted/me2/Motor1/motor_$s.hdr
mv /export/w/Graduate_Students/ted/me2/Motor1/f150203093314STD131221107523235052-0023-00001-0000$s-01.img /export/w/Graduate_Students/ted/me2/Motor1/motor_$s.img

fi

end

echo Done renaming
 
