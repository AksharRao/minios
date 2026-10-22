; directive to tell the machine to emit codes of 16 bits
bits 16

; directive to tell the machine to place this code beginning at address 0x7c00
org 0x7c00

%define ENDL 0x0D, 0x0A

start: 
	jmp main	

puts:
	; save the registers we will modify
	push si
	push ax
	push bx
.loop:
	cld 	 ; clearning df, so si increments
	lodsb    ; loads char into al

	or al, al ;doesn't change al, but changes flags, esp. ZF
	jz .done  ; if string ends, null character, ZF = 1
	
	mov ah, 0x0e
	mov bh, 0
	
	int 0x10
	
	jmp .loop

.done:
	; return the saved registers
	pop bx
	pop ax
	pop si
	ret

main:

; CS has been initilaised, setup to 0:7c00
; setting up the data segment registers

mov ax, 0
mov ds, ax
mov es, ax

; setting up the stack

mov ss, ax

; setting thr stack pointer to the beggining of our OS
; reason: stack grows downwards

mov sp, 0x7c00 
	
; set SI to point to the string
mov si, msg_hello
call puts

.halt
	hlt
	jmp .halt

msg_hello: db "Hello! I am Akshara!", ENDL, 0


times 510 - ($-$$) db 0
dw 0xaa55 
