QEMU=qemu-system-x86_64
BOOT=boot.bin
NS=nasm
BIN_FILES=$(subst .asm,.bin,$(wildcard *.asm))
.PHONY: clear run

all:$(BIN_FILES)

%.bin:%.asm
	$(NS) $< -f bin -o $@

run:
	$(QEMU) -hda $(BOOT)

clear:
	rm $(BIN_FILES)
