    processor 6502

    include "macro.asm"
    include "vcs.asm"

    ; Uninitialized segment for variable declaration
    seg.u Variables
    org $80
P0Height ds 1           ; Declares one byte for player 0 height
P1Height ds 1           ; Declares one byte for player 1 height

    seg Code
    org $F000

Reset:
    CLEAN_START

    ; Initialize variables
    ldy #10             ; y = 10
    sty P0Height        ; P0Height = y = 10
    sty P1Height        ; P1Height = y = 10

    ; Set colors
    ldy #$80
    sty COLUBK          ; Blue background color

    ldy #%1111
    sty COLUPF          ; White playfield color

    ldy #$40
    sty COLUP0          ; Light red player 0 color

    ldy #$C6
    sty COLUP1          ; Light green player 1 color

    ldy #%00000010      ; Used to indicate that playfield is score
    sty CTRLPF          ; Set playfield color to player color

StartFrame:
    ; Let the TIA output 3 lines of vsync
    lda #2
    sta VBLANK          ; Turn on vblank
    sta VSYNC           ; Turn on vsync

    REPEAT 3
        sta WSYNC       ; Three lines for vsync
    REPEND

    ldx #0
    stx VSYNC           ; Turn off vsync

    ; Let the TIA output the 37 recommended lines of VBLANK
    REPEAT 37
        sta WSYNC       ; Thirty-seven lines for vblank
    REPEND
    stx VBLANK          ; Turn off vblank

    ; Draw 192 visible lines
VisibleScanlines:
    REPEAT 10
        sta WSYNC       ; Draw 10 empty lines at top of frame
    REPEND

    ; Draw 10 lines for scoreboard number
    ldy #0
ScoreboardLoop:
    lda NumberBitmap,Y  ; Pulls data from array of bytes at NumberBitMap
    sta PF1             ; Use playfield 1 to display number
    sta WSYNC
    iny
    cpy #10             ; Compare y with 10 (zero flag set if diference is zero)
    bne ScoreboardLoop

    stx PF1             ; Turn off playfield 1
    REPEAT 50
        sta WSYNC       ; Draw 50 empty lines between scoreboard and player
    REPEND

    ; Draw 10 lines for player 0 graphics
    ldy #0
Player0Loop
    lda PlayerBitmap,Y  ; Pulls data from array of bytes at PlayerBitmap
    sta GRP0
    sta WSYNC
    iny
    cpy P0Height
    bne Player0Loop
    stx GRP0            ; Trurn off player 0 graphics

; Draw 10 lines for player 1 graphics
    ldy #0
Player1Loop:
    lda PlayerBitmap,Y  ; Pulls data from array of bytes at PlayerBitmap
    sta GRP1
    sta WSYNC
    iny
    cpy P1Height
    bne Player1Loop
    stx GRP1            ; Trurn off player 1 graphics

    ; Draw remaining 102 lines (192 - 90)
    REPEAT 102
        sta WSYNC
    REPEND

    ; Output 30 vblank overscan lines to complete the frame
    lda #2
    sta VBLANK
    REPEAT 30
        sta WSYNC
    REPEND
    stx VBLANK

    jmp StartFrame

    ; Bitmap for happy face
    org $FFE8
PlayerBitmap:
    .byte #%01111110    ;  ######
    .byte #%11111111    ; ########
    .byte #%10011001    ; #  ##  #
    .byte #%11111111    ; ########
    .byte #%11111111    ; ########
    .byte #%11111111    ; ########
    .byte #%10111101    ; # #### #
    .byte #%11000011    ; ##    ##
    .byte #%11111111    ; ########
    .byte #%01111110    ;  ######

    ; Bitmap for number two
    org $FFF2
NumberBitmap:
    .byte #%00001110    ; ########
    .byte #%00001110    ; ########
    .byte #%00000010    ;      ###
    .byte #%00000010    ;      ###
    .byte #%00001110    ; ########
    .byte #%00001110    ; ########
    .byte #%00001000    ; ###
    .byte #%00001000    ; ###
    .byte #%00001110    ; ########
    .byte #%00001110    ; ########

    ; Complete ROM size
    org $FFFC
    .word Reset
    .word Reset
