all:
	dasm rainbow.asm -orainbow.bin -lrainbow.lst -srainbow.sym -f3 -S

rainbow:
	dasm rainbow.asm -orainbow.bin -lrainbow.lst -srainbow.sym -f3 -S

rainbow-run:
	dasm rainbow.asm -orainbow.bin -lrainbow.lst -srainbow.sym -f3 -Iincludes//
	stella rainbow.bin

clean:
	rm *.out -f
	rm *.bin -f
	rm *.lst -f
	rm *.sym -f
