QEMU=qemu-system-x86_64
NS=nasm
BOOT=boot.bin
MBR=mbr.bin
BIN_FILES=$(subst .asm,.bin,$(wildcard *.asm))
.PHONY: clean run

all:$(BOOT)

$(BOOT):$(BIN_FILES)
	dd if=/dev/zero of=$@ bs=512 count=32
	dd if=./$(MBR) of=$@ conv=notrunc

%.bin:%.asm
	$(NS) $< -f bin -o $@

run:
	$(QEMU) -hda $(BOOT)

clean:
	rm -f $(BIN_FILES)
	rm -f $(BOOT)
