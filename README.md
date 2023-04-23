# Atari 2600 6507 DASM Assembly Examples

Examples of how to write programs in assembly language for the Atari 2600.

## Dependencies

- The [dasm 8-bit macro assembler][20] to compile the code.

- The [stella emulator][21] to run the compiled code

## Install Dependencies

Debian-based systems:

```bash
apt install dasm stella
```

## Using Dependencies

```bash
dasm <source file> [options]
stella [options] <ROM file>
```

### Options

```bash
# dasm
-o<name>  # generate output file with name
-l<name>  # generate list file with name
-s<name>  # generate symbol file with name
-f<#>     # output format 1 - 3 (default 1)
-v<#>     # verboseness 0 - 4 (default 0)
-S        # strict syntax checking

# stella
-debug    # start in debug mode
```

## Notes About Registers

### TIA - WSYNC

When written to with any value (it will do its thing regardless of the value it
is set to), the WSYNC register will wait for the leading edge of the horizontal
blank.

## Atari 2600 Programming Resources

- [Atari Age][80] info and forums.
- [8 Bit Workshop][81] online IDE.
- [Javatari][82] online emulator.
- Programming Games for the Atari 2600 course at [Udemy][83] or [Pikuma][84].

---

[20]: https://dasm-assembler.github.io/
[21]: https://stella-emu.github.io/

[80]: https://www.atariage.com
[81]: https://8bitworkshop.com/
[82]: https://javatari.org/
[83]: https://www.udemy.com/course/programming-games-for-the-atari-2600
[84]: https://pikuma.com/courses/learn-assembly-language-programming-atari-2600-games
