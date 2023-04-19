build:
	dasm rainbow.asm -I../../lib -f3 -S -v4 -orainbow.bin -lrainbow.lst -srainbow.sym

clean:
	rm *.out *.bin *.lst *.sym -f

run:
	make build
	stella -debug rainbow.bin
	make clean
