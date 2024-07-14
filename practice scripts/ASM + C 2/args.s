.global main
.data 
	text: .space 10
	number: .int 0
	#format: .string "%s\n"
.text
main:
	xor %eax, %eax	#preparation
	mov %rsi, %rbx
	sub $8, %rsp
	
	mov 8(%rbx), %rax  #get text
	mov %rax, text
	
	mov 16(%rbx), %rdi  #get number
	call atoi
	mov %rax, number
	
	mov text, %rdi	#call loop
	mov number, %rsi
	call loop
	
	add $8, %rsp
	ret