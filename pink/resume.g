; resume.g
; called before a print from SD card is resumed
;
; generated by RepRapFirmware Configuration Tool v3.3.0-LPC-STM32+10 on Sun Dec 19 2021 15:02:45 GMT+0000 (Greenwich Mean Time)
G1 R1 X0 Y0 Z5 F6000 ; go to 5mm above position of the last print move
G1 R1 X0 Y0 Z0       ; go back to the last print move
M83                  ; relative extruder moves
G1 E10 F3600         ; extrude 10mm of filament

