.global _start

.data
	buffer: .space 10
	length: .int 10 

.text
_start:

	call read
	call write
	call exit

read:
	mov $0, %rax
	mov $0, %rdi
	mov $buffer, %rsi
	mov length, %rdx
	syscall
	
write:
	mov $1, %rax
	mov $1, %rdi
	mov $buffer, %rsi
	mov length, %rdx
	syscall

exit:
	mov $60, %rax
	mov $0, %rdi
	syscall
