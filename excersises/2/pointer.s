.global _start
.data
	text: .ascii "hello\n"
	length: .long 6
	number: .long 1,6
.text
_start:
	mov $number, %r8

	mov $1, %eax
	mov $1, %edi
	mov $text, %esi
	mov 4(%r8), %edx
	syscall
	
	mov $60, %eax
	mov $ 0, %edi
	syscall
