;   +-----------------------------------+
;   |                                   |
;   |          Disassembled by:         |
;   |         Mast3rPlan & maxss        |
;   |                                   |
;   +-----------------------------------+

!to "rpcboot.bin", plain
* = $400

;Command        ; byte code      ;PC

SEC             ; 38             - 00
XCE             ; fb             - 01        ; init

LDA $00         ; a5 00          - 02 03
MMU #$00        ; ef 00          - 04 05     ; set bus to floppy id

REP $30         ; c2 30          - 06 07     ; reset flags

LDA $0300       ; a9 00 30       - 08 09 0A
MMU #$01        ; ef 01          - 0B 0C     ; set bus offset to 0x0300

MMU #$02        ; ef 02          - 0D 0E     ; enable bus    

STZ $02         ; 64 02          - 0F 10     ; set 0x02 to zero

LDA #$0500      ; a9 00 05       - 11 12 13  ; set a to 0x0500

STA $04         ; 85 04          - 14 15     ; sets 0x04 to a

L4:
LDA $02         ; a5 02          - 16 17     ; sets a to the value of 0x02
                                             ; a = currentSector

STA #$0380      ; 8d 80 03       - 18 19 1A  ; sets 0x0380 to a
                                             ; floppy sector to 0

SEP #$20        ; e2 20          - 1B 1C     ; set all flags?

LDA #$8d04      ; a9 04 8d       - 1D 1E 1F  ; set a to 0x8d04

L1:
RER $03         ; 82 03          - 20 21     ; push PC + 3 (+ 1)

WAI             ; cb             - 22        ; wait for interupt

CMP $0382       ; cd 82 03       - 23 24 25  ; compare a to the value at 0x0382
                                             ; compare a to cmdreg

BEQ $fa         ; f0 fa          - 26 27     ; loops if values don't match

LDA $0382       ; ad 82 03       - 28 29 2A  ; set a to the value at 0x0382
                                             ; set a to cmdreg

BEQ $09         ; f0 09          - 2B 2C     ; loop if not zero

SEP #$30        ; e2 30          - 2D 2E     ; set all flags?
CLC             ; 18             - 2F        ; clear carry flag
XCE             ; fb             - 30        ; exchange c and e flags (cleanup)
JMP #$0500      ; 4c 00 05       - 31 32 33  ; jmp to disk entrypoint (0x0500)

L2:
REP #$20        ; c2 20          - 34 35     ; reset flags
LDX #$0300      ; a2 00 03       - 36 37 38  ; set x to 0x0300 (sector offset)

L3:
TXI             ; 5c             - 39        ; set (i) to (x + i)

LDY #$0040      ; a0 40 00       - 3A 3B 3C  ; set y to 0x0040 (128 sector size)
NXA             ; 42 92 04       - 3D 3E 3F  ; increment i, set a to i

INC $04         ; e6 04          - 40 41     ; increments value at 0x04
INC $04         ; e6 04          - 42 43     ; increments value at 0x04

DEY             ; 88             - 44        ; decrement y (bytes remaining)
BNE $f6         ; d0 f6          - 45 46     ; loop until all read
INC $02         ; e6 02          - 47 48     ; increment currentSector
JMPABS  $0416   ; 4c 16 04       - 49 4A 4B  ; start over again