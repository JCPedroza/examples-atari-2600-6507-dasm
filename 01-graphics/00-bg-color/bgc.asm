; This program sets the background color to red.

    processor 6502

    include "macro.asm"
    include "vcs.asm"

    seg Code
    org $F000       ; Set code origin to start of ROM

Start:
    CLEAN_START     ; Set zero-page to zeros
    lda #2          ; Number 2 is used to turn on vsync and vblank

    ldx #0          ; Number 0 is used to turn off vsync and vblank
NextFrame:
    ; Generate 3 scanlines of vsync
    sta VSYNC       ; Turn on VSYNC
    sta WSYNC       ; First vsync scanline
    sta WSYNC       ; Second vsync scanline
    sta WSYNC       ; Thid vsync scanline
    stx VSYNC       ; Turn off vsync

    ; Generate 37 top scanlines of vblank
    ldy #37         ; Iterator counter
    ldx #0          ; Number 0 is used to turn off vsync and vblank
    sta VBLANK      ; Turn on vblank
Prescan:
    sta WSYNC       ; Generate vblank scanline
    dey             ; Decrement register
    bne Prescan     ; Go to Prescan if y doesn't equal 0
    stx VBLANK      ; Turn off blank

    ; Draw 192 visible scanlines
    ldy #192        ; Iteration counter
    ldx #66         ; Color red
    stx COLUBK      ; Set background color to red
Draw:
    sta WSYNC       ; Generate visible scanline
    dey             ; Decrement register
    bne Draw        ; Gro to Draw if y doesn't equal 0

    ; Generate 30 bottom scanlines of vblank
    ldy #30         ; Iteration counter
    ldx #0          ; Number 0 is used to turn off vsync and vblank
    sta VBLANK      ; Turn on vblank
Overscan:
    sta WSYNC       ; Generate vblank scanline
    dey             ; Decrement register
    bne Overscan    ; Go to Overscan if y doesn't equal 0
    stx VBLANK      ; Turn off vblank

    jmp NextFrame

    ; Complete ROM size to 4kB
    org $FFFC       ; Set code origin to the last 4 bytes of ROM
    .word Start
    .word Start
