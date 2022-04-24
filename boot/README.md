# description
This README file is a log or document during learning.

# doc
The BIOS in modern PCs initializes and tests the system hardware components (Power-on self-test), and loads a boot loader from a mass storage device which then initializes an operating system. The BIOS recognizes the boot device by magic numbers. These numbers are 0x55 and 0xAA, or 85 and 170 in decimal appropriately. Also, these magic numbers must be located exactly in bytes 511 and 512 in our bootable device. When the BIOS finds such a boot sector, it loads it into memory at a specific address — 0x0000:0x7C00.<br/><br/>

Because CPU is in protected mode(16 bits) and qemu uses the legacy BIOS(UEFI BIOS have firmware to set CPU to real mode), our bootloader should be set to 16 bits using assembly instruction "bits 16".<br/><br/>

For now, we build a very simple bootloader which is only able to display "Hello, runOS". The bootloader is loacted on the harddisk's MBR(.bin file follows qemu option -hda).

# use
cd ./boot/
compile: make
run: make run
