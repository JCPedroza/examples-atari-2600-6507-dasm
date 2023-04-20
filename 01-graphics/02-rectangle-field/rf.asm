    processor 6502

    include "macro.asm"
    include "vcs.asm"

    seg Code
    org $F000

Start:
    CLEAN_START

NewFrame:
    lda #2
    ldx #0

    sta VSYNC
    sta WSYNC
    sta WSYNC
    sta WSYNC
    stx VSYNC

    sta VBLANK
    ldy #37
Prescan:
    sta WSYNC
    dey
    bne Prescan
    stx VBLANK

    ldy #192
Draw:
    sta WSYNC
    dey
    bne Draw

    sta VBLANK
    ldy #30
Overscan:
    sta WSYNC
    dey
    bne Overscan
    stx VBLANK

    jmp NewFrame

    org $FFFC
    .word Start
    .word Start
