build:
	dasm loop.asm -f3 -S -v4 -oloop.bin -lloop.lst -sloop.sym

clean:
	rm *.out *.bin *.lst *.sym -f

run:
	make build
	stella -debug loop.bin
	make clean
