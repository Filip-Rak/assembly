.global _start

.data
	.equ size, 6
	str: .string "Hello\n"
	
.text
_start:
	call read
	call print
	call finish

print:	
	mov $1, %rax
	mov $1, %rdi
	mov $str, %rsi
	mov $size, %rdx
	syscall
	ret
finish:
	mov $60, %rax
	mov $0, %rdi
	syscall
	ret
read: 
	mov $0, %rax
	mov $0, %rdi
	mov $str, %rsi
	mov $size, %rdx
	syscall
	ret
