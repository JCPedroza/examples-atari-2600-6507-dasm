; This program iterates using the <y> register as a counter, decrementing <y>
; by one each iteration, and branching to <Loop> if <y> doesn't equal zero.
; Each iteration the <y> register is copied to <a>, and subtracted by 5.

    processor 6502
    seg Code
    org $F000   ; Set origin at first ROM address

Start:
    cld         ; Deactivate decimal mode

    ldy #10     ; Use <y> register as iteration counter (y = 5)
Loop:
    tya         ; Transfer value at <y> register to <a> register
    sbc #5      ; Subtract 5 from <a> register
    dey         ; Decrement <y> register by one (y = y - 1)
    bne Loop    ; Go to <Start> if <y> register doesn't equal zero

    org $FFFC   ; Set the last four bytes of ROM
    .word Start ; Set reset ROM address
    .word Start ; Set interrupt ROM  address
