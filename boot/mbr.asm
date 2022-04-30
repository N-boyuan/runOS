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
SETUPLEN equ 4

;org 0x7c00                  ; Tell the compiler this program is start at ox7c00
bits 16                     ; Tell the compiler the program run in 16-bit mode

global _start

_start:
    mov ax,BOOTSEG
    mov ds,ax
    mov ax,INITSEG
    mov es,ax
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
    mov sp,STACKPOS         ; Stack position is es:sp

; Start to setup module
load_setup:
    mov dx,0x0080           ; dl:driver number, dh:magnetic head
    mov cx,0x0002           ; cl:start sector(first sector is our MBR), ch:track number
    mov bx,0x0200           ; setup address offset
    mov ax,0x0200+SETUPLEN  ; al:sector number to be read, ah:function number
    int 0x13                ; read al sectors to es:bx
    jnc load_setup_suc
    mov ax,0x0000
    mov dx,0x0080
    int 0x13                ; reset the hard disk;
    jmp load_setup

; Loading setup succeed
; start to get disk info
load_setup_suc:
    mov dl,0x80             ; dl:driver nr, 0x80 presents hard disk
    mov ax,0x0800           ; function number for int 0x13
    mov ch,0x00
    and cl,0x3f
    int 0x13                ; read hard disk info
    mov [sectors],cx          ; mov cx(nr of sectors per track) to sectors
    mov ax,INITSEG
    mov es,ax               ; reset es

    ;mov ah,0x03
    ;sub bh,bh
    ;int 0x10                ; Get bh=0 page's cursor column and row to DL and DH

print:
    cli
    mov ax,cs
    mov ds,ax
    mov si,msg1
    mov ah,0x0e
lod_char:
    lodsb
    or al,al
    jz print_exit
    int 0x10
    jmp lod_char
print_exit:
    sti
    jmp pause

pause:
    jmp $

sectors dw 0

msg1: db "Loading system...", 0

; Magic numbers for BIOS to identify the
; sector and load the bootloader into memory
times 510 - ($ - $$) db 0
dw 0xaa55                   ; Magic Number
