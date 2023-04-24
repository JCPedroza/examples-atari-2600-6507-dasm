    processor 6502

    include "vcs.asm"
    include "macro.asm"

    seg.u Variables
    org $80
P0Height byte           ; Player sprite height
P0YPos byte             ; Player sprite 'y' coordinate

    seg Code
    org $F000

Reset:
    CLEAN_START         ; Macro to clean zero page

    ldx #$00            ; Black background color
    stx COLUBK

    lda #180
    sta P0YPos

    lda #9
    sta P0Height

StartFrame:
    lda #2
    sta VBLANK          ; Turn vblank on
    sta VSYNC           ; Turn vsync on

    REPEAT 3
        sta WSYNC       ; First three vsync scanlines
    REPEND
    lda #0
    sta VSYNC           ; Turn vsync off

    REPEAT 37
        sta WSYNC
    REPEND

    lda #0
    sta VBLANK          ; Turn vblank off

    ldx #192

Scanline:
    txa
    sec
    sbc P0YPos
    cmp P0Height        ; Are we inside the sprite height bounds?
    bcc LoadBitmap      ; If result < SpriteHeight, call subroutine
    lda #0              ; Else, set index to 0

LoadBitmap:
    tay
    lda P0Bitmap,y      ; Load player bitmap slice of data
    sta WSYNC           ; Wait for next scanline
    sta GRP0            ; Set graphics for player 0 slice
    lda P0Color,Y       ; Load player color from lookup table
    sta COLUP0          ; Set color for player 0 slice
    dex
    bne Scanline        ; Repeat next scanline until finished

Overscan:
    lda #2
    sta VBLANK          ; Turn VBLANK on again for overscan
    REPEAT
        sta WSYNC
    REPEND

    dec P0YPos

    jmp StartFrame

    ; Player bitmap array
P0Bitmap:
    byte #%00000000
    byte #%00101000
    byte #%01110100
    byte #%11111010
    byte #%11111010
    byte #%11111010
    byte #%11111110
    byte #%01101100
    byte #%00110000

    ; Player colors array
P0Color:
    byte #$00
    byte #$40
    byte #$40
    byte #$40
    byte #$40
    byte #$42
    byte #$42
    byte #$44
    byte #$D2

    org $FFFC
    word Reset
    word Reset
