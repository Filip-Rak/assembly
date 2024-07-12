.data
	text: .ascii "Hello\n"
	length: .long 6
.text

hello:
	mov $1, %eax
	mov $1, %edi
	mov $text, %esi
	mov length, %edx
	syscall
	ret