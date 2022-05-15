#
# Makefile fragment for the JOS kernel.
# This is NOT a complete makefile;
# you must run GNU make in the top-level directory
# where the GNUmakefile is located.
#
CC = gcc
LD = ld

ifndef QEMU
QEMU := $(shell if which qemu >/dev/null 2>&1; \
	then echo qemu; exit; \
        elif which qemu-system-i386 >/dev/null 2>&1; \
        then echo qemu-system-i386; exit; \
	else \
	qemu=/Applications/Q.app/Contents/MacOS/i386-softmmu.app/Contents/MacOS/i386-softmmu; \
	if test -x $$qemu; then echo $$qemu; exit; fi; fi; \
	echo "***" 1>&2; \
	echo "*** Error: Couldn't find a working QEMU executable." 1>&2; \
	echo "*** Is the directory containing the qemu binary in your PATH" 1>&2; \
	echo "*** or have you tried setting the QEMU variable in conf/env.mk?" 1>&2; \
	echo "***" 1>&2; exit 1)
endif

IMAGES = kernel.img

CFLAGS = -m32 -march=i386  \
	 -fno-builtin -fno-stack-protector -fno-omit-frame-pointer \
	 -Wall  -Os  -fcommon
ASFLAGS = -m32
LDFLAGS = -m elf_i386

BSFILES = $(shell find ./ -name "*.S")
BCFILES = $(shell find ./ -name "*.c")
BOBJS = $(BSFILES:.S=.o) $(BCFILES:.c=.o)

bootloader.bin: $(BOBJS)
	$(LD) $(LDFLAGS) -e start -Ttext 0x7c00 -o bootloader.elf $(BOBJS)
	objcopy -S -O binary -j .text bootloader.elf bootloader.bin
	perl sign.pl  bootloader.bin

img: forTestKernel bootloader.bin
	dd if=/dev/zero of=kernel.img~ count=10000 2>/dev/null
	dd if=bootloader.bin of=kernel.img~ conv=notrunc 2>/dev/null
	dd if=forTestKernel of=kernel.img~ seek=1 conv=notrunc 2>/dev/null
	mv kernel.img~ kernel.img

qemu:  img
	$(QEMU) $(IMAGES)

clean:
	rm -rf $(BOBJS) bootloader.elf bootloader.bin kernel.img


