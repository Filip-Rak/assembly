.global main
.data
	text: .string "%d %d"
	a: .long 5
	b: .long 10
.text
main:
	mov $text, %rdi
	mov a, %esi
	mov b, %edx
	xor %eax, %eax
	sub $8,%rsp
	
	
	call printf
	
	add $8, %rsp
	
	ret