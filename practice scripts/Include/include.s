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
	
exit:
	mov $60, %eax
	mov $0, %edi
	syscall 
	ret
