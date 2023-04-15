build:
	dasm loop.asm -oloop.bin -lloop.lst -sloop.sym -f3 -v4 -S

clean:
	rm *.out *.bin *.lst *.sym -f

run:
	make build
	stella -debug loop.bin
	make clean
