; CPU is in protected mode(16 bit) after powering on. And qemu initialization
; uses the legacy BIOS that must work in 16-bit mode. So our bootloader is set
; to 16 bit.

; The goal of this program:
; 1. Mov the the program itself to 0x90000;
; 2. Load the module of setup;
; 3. Load the module of system;
; 4. jump to setup and run
BOOTSEG equ 0x07c0
INITSEG equ 0x5000
MOVCOUNT equ 0x100          ; Mov 256 x 2 bytes(MBR is 512 bytes)
STACKPOS equ 0xff00

org 0x7c00                  ; Tell the compiler this program is start at ox7c00
bits 16                     ; Tell the compiler the program run in 16-bit mode

global _start

_start:
    mov ax,BOOTSEG
    mov es,ax
    mov ax,INITSEG
    mov ds,ax
    sub si,si
    sub di,di
    mov cx,MOVCOUNT
    cld                     ; Set DF flag to 0, movw forward transmission
    repe movsw              ; repeat movw for cx times
    jmp INITSEG:setseg

setseg:
    mov ax,cs
    mov ds,ax
    mov es,ax
    mov ss,ax
    mov sp,STACKPOS         ; Stack position is es:sp = 0x9000:0xff00

pause:
    jmp $

; Magic numbers for BIOS to identify the
; sector and load the bootloader into memory
times 510 - ($ - $$) db 0
dw 0xaa55                   ; Magic Number
