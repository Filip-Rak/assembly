.global _start
.data
	buffer: .space 10
	length: .long 10
.text
_start:
	mov $0, %r8
	
	call read
	call loop
	call exit

loop:
	call write
	
	add $1, %r8
	cmp $100, %r8
	jnz loop
	ret

read:
	mov $0, %rax
	mov $0, %rdi
	mov $buffer, %rsi
	mov length, %rdx
	syscall
	ret
	
write:
	mov $1, %rax
	mov $1, %rdi
	mov $buffer, %rsi
	mov length, %rdx
	syscall
	ret
	
exit:
	mov $60, %rax	
	mov $0, %rsi	
	syscall
	ret
