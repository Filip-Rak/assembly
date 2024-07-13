.global _start
.data
	text: .ascii "hello\n"
	length: .long 6
.text
_start:
	mov $text, %r8
	movb $' ', 4(%r8)

	mov $1, %eax
	mov $1, %edi
	mov $text, %esi
	mov length, %edx
	syscall

	call exit

exit:
	mov $60, %eax
	mov $0, %edi
	syscall
