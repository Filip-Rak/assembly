.global main
.extern sum
.data
	arg_1: .long 0
	arg_2: .long 0
	result: .long 0
	
	format: .string "Sum = %d\n"
.text
main:
	xor %rax, %rax  #setup
	sub $8, %rsp
	mov %rsi, %rbx
	
	mov 8(%rbx), %rdi  #atoi
	call atoi
	mov %eax, arg_1
	
	mov 16(%rbx), %rdi
	call atoi
	mov %rax, arg_2
	
	mov arg_1, %rdi   #sum
	mov arg_2, %rsi
	call sum
	mov %eax, result
	
	mov $format, %rdi  #printf
	mov result, %rsi
	call printf
	
	add $8, %rsp  #restore stack pointer
	ret
