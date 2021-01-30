all: boot.img

boot.img: boot.asm
	nasm boot.asm -o boot.bin
	dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc
qemu: boot.img
	qemu-system-i386 -drive format=raw,file=boot.img
clean:
	rm -f boot.img boot.bin

