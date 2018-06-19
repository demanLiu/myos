all: boot.img

boot.img: boot.asm
	nasm boot.asm -o boot.bin
	dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc
clean:
	rm -f boot.img boot.bin
