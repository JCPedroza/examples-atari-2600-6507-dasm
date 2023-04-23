build:
	dasm bgc.asm -I../../lib -obgc.bin -sobg.sym -lobg.lst -f3 -v4 -S

clean:
	rm *.out *.bin *.lst *.sym -f

run:
	make build
	stella bgc.bin
	make clean
