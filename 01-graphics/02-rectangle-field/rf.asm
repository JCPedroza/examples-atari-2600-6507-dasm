    processor 6502

    include "macro.asm"
    include "vcs.asm"

    seg Code
    org $F000

Reset:
    CLEAN_START

    lda #2              ; Constant for turning on vsync and vblank
    ldx #0              ; Constant for turning off stuff

    ldy #$80
    sty COLUBK          ; Blue background color

    ldy #$1C
    sty COLUPF          ; Yellow playfield color

StartFrame:
    ; Let the TIA output 3 lines of vsync
    sta VSYNC           ; Turn on vsync
    REPEAT 3
        sta WSYNC       ; Three lines for vsync
    REPEND
    stx VSYNC           ; Turn off vsync

    ; Let the TIA output the 37 recommended lines of VBLANK
    sta VBLANK          ; Turn on vblank
    REPEAT 37
        sta WSYNC       ; Thirty-seven lines for vblank
    REPEND
    stx VBLANK          ; Turn off vblank

    ; Set playfield reflect on
    ldy #%00000001
    sty CTRLPF

    ; Draw 192 visible lines, starting with 7 lines of no playfield
    stx PF0
    stx PF1
    stx PF2
    REPEAT 7
        sta WSYNC       ; Seven lines with no playfield
    REPEND

    ; Draw upper wall for 7 lines
    ldy #%11100000      ; The four less significant bits are ignored
    sty PF0
    ldy #%11111111
    sty PF1
    sty PF2
    REPEAT 7
        sta WSYNC       ; Seven lines of upper wall
    REPEND

    ; Draw 164 lines lines of right and left wall
    ldy #%00100000
    sty PF0
    stx PF1
    stx PF2
    REPEAT 164
        sta WSYNC
    REPEND

    ; Draw lower wall for 7 lines
    ldy #%11100000      ; The four less significant bits are ignored
    sty PF0
    ldy #%11111111
    sty PF1
    sty PF2
    REPEAT 7
        sta WSYNC       ; Seven lines of lower wall
    REPEND

    ; Draw 7 lines of no playfield
    stx PF0
    stx PF1
    stx PF2
    REPEAT 7
        sta WSYNC       ; Seven lines with no playfield
    REPEND

    ; Output 30 vblank overscan lines to complete the frame
    sta VBLANK
    REPEAT 30
        sta WSYNC
    REPEND
    stx VBLANK

    jmp StartFrame

    org $FFFC
    .word Reset
    .word Reset
