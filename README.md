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

When written to with any value, the WSYNC register will wait for the leading
edge of the horizontal blank.

## Atari 2600 Learning Resources

- [Atari Age][80]

---

[20]: https://dasm-assembler.github.io/
[21]: https://stella-emu.github.io/

[80]: https://www.atariage.com
