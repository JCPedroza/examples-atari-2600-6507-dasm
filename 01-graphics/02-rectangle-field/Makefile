build:
	dasm rf.asm -I../../lib -orf.bin -lrf.lst -srf.sym -f3 -S -v4

clean:
	rm *.out *.bin *.lst *.sym

run:
	make build
	stella rf.bin
	make clean
