; CPU is in protected mode(16 bit) after powering on. And qemu initialization
; uses the legacy BIOS that must work in 16-bit mode. So our bootloader is set
; to 16 bit.

org 0x7c00                  ; Tell the compiler this program is start at ox7c00
bits 16                     ; Tell the compiler the program run in 16-bit mode

start:
    cli
    mov si, msg
    mov ah, 0x0e
loop:
    lodsb
    or al, al
    jz pause
    int 0x10
    jmp loop

msg:
    db "Hello runOS", 0
pause:
    jmp $

; Magic numbers for BIOS to identify the
; sector and load the bootloader into memory
times 510 - ($ - $$) db 0
dw 0xaa55                   ; Magic Number
