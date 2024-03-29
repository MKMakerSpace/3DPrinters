; homeall.g
; called to home all axes
;
; This makes use of stall detection to perform sensorless homing.
; The initial position is unknown so we may be up against either end
; of the machine. We need to take care to handle hitting either min or max
; endstops and to try and ensure that stall detect operates correctly. To
; do this and to minimise and damage if we hit the machine we operate at a
; reduced current during these moves.
; prepare

M400          ; Wait for motion to stop
G91           ; Use relative moves
G1 H2 X0.01 Y0.01 Z0.01 ; Move X, Y and Z a small amount to force enable
G4 P200         ; Wait to ensure TMC sees this as stopped state
M915 p0 S0 H200 r0    ; Configure stall detect in case we hit max endstops
M915 p1 S0 H200 r0    ; Configure stall detect
M574 X1 S3        ; Configure X endstop
M574 Y1 S3        ; Configure Y endstop
M913 X70 Y70      ; Lower X, Y, Z power
G4 P200         ; Wait to ensure settings are in place
G1 H2 Z5 F2500      ; lift Z relative to current position

; x
G1 H1 X20 F2000     ; back away from endstop
M400          ; Wait for stop
G4 P200         ; Delay to ensure settings are made
G1 H1 X-325 F4000   ; Move towards endstop until it stalls
M400          ; Wait until all stopped
G4 P200         ; Delay to ensure settings are made
G1 H1 X10 F2000     ; back away from endstop
M400
G4 P200
G1 H1 X-325 F4000   ; Move towards endstop until it stalls
M400
G4 P200

; y
G1 H1 Y20 F2000     ; back away from endstop
M400          ; Wait for stop
G4 P200         ; Delay to ensure settings are made
G1 H1 Y-325 F4000   ; Move towards endstop until it stalls
M400          ; Wait until all stopped
G4 P200         ; Delay to ensure settings are made
G1 H1 Y10 F2000     ; back away from endstop
M400
G4 P200
G1 H1 Y-325 F4000   ; Move towards endstop until it stalls
G4 P200

; z
G1 X1 Y1 F1000      ; Move away from stop and cancel stall
M400          ; wait complete
G4 P500
G1 H2 Z5 F6000      ; drop Z relative to current position
G90           ; Absolute positioning
G1 X100 Y100 F4000      ; go to first bed probe point and home Z
M558 F600       ; set probe feed rate at 600mm/m
G30                 ; probe Z (at high speed)
M558 F220       ; reset probe feed rate to 120mm/m
G30           ; probe Z (low speed)
M913 X100 Y100      ; back to full power
