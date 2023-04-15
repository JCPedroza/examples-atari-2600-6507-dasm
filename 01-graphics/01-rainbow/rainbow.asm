; Format is NTSC.

; This program draws the entire NTSC color palette in a rainbow-like pattern.
; Each color is drawn in one scanline: 128 colors, 192 visible scanlines (64
; free scanlines).

    processor 6502

    include "macro.asm"
    include "vcs.asm"

    seg Code
    org $F000

Start:
    CLEAN_START

NextFrame:
    lda #2          ; Number 2 is used to turn on vsync and vblank
    ldx #0          ; Number 0 is used to turn off vsync and vblank

    ; Generate 3 scanlines of vsync
    sta VSYNC       ; Turn on vsync
    sta WSYNC       ; Wait for next scanline
    sta WSYNC       ; Wait for next scanline
    sta WSYNC       ; Wait for next scanline
    stx VSYNC       ; Turn off vsync

    ; Generate 37 top scanlines of vblank (prescan)
    sta VBLANK      ; Turn on vblank
    ldy #37         ; Iteration counter (y = 37)
Prescan:
    sta WSYNC       ; Wait for next scanline
    dey             ; Decrement register (y = y - 1)
    bne Prescan     ; Go to Prescan if y doesn't equal 0
    stx VBLANK      ; Turn off vblank

    ; Draw 192 visible scanlines
    ldy #192        ; Iteration counter (y = 192)
Draw:
    sty COLUBK      ; Set background color
    sta WSYNC       ; Wait for next scanline
    dey             ; Decrement register (y = y - 1)
    bne Draw        ; Go to Draw if y doesn't equal 0

    ; Generate 30 scanlines of vblank (overscan)
    sta VBLANK      ; Turn on vblank
    ldy #30         ; Iteration counter (y = 30)
Overscan:
    sta WSYNC       ; Wait for next scanline
    dey             ; Decrement register (y = y - 1)
    bne Overscan    ; Go to Overscan if y doesn't equal 0

    ; Start next frame
    jmp NextFrame

    ; Complete ROM size to 4kB
    org $FFFC       ; Set code origin to the last 4 bytes of ROM
    .word Start
    .word Start
