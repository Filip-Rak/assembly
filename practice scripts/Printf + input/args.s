.global main
.data
	text: .string "%s\n"
	a: .long 5
.text
main:
	mov $text, %rdi
	#mov a, %rsi
	mov 8(%rsi), %rsi
	xor %eax, %eax
	sub $8,%rsp
	
	
	call printf
	
	add $8, %rsp
	
	ret