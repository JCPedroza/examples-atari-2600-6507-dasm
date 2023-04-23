build:
	dasm ply.asm -I../../lib -oply.bin -lply.lst -sply.sym -f3 -S -v4

clean:
	rm *.out *.bin *.lst *.sym

run:
	make build
	stella ply.bin
	make clean
