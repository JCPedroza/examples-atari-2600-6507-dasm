# Atari 2600 6507 DASM Assembly Examples

Examples of how to write programs, in assembly language, for the Atari 2600.

## Dependencies

The [dasm 8-bit macro assembler][20] to compile the code.

The [stella emulator][21] to run the compiled code.

## Install Dependencies

Debian-based systems:

```bash
apt install dasm stella
```

## Notes About Registers

### WSYNC

When written to with any value, the WSYNC register will wait for the leading
edge of the horizontal blank.

---

[20]: https://dasm-assembler.github.io/
[21]: https://stella-emu.github.io/
