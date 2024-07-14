.global main
.data
	arg_1: .int 0
	arg_2: .int 0
	arg_3: .int 0
	
	result: .int 0
	format: .string "Max = %d\n"
.text
main:

	cmp $4, %edi 		#exit if not enough args
	jne exit
	
	mov %rsi, %rbx  	#setup
	xor %eax, %eax
	sub $8, %rsp
	
	mov 8(%rbx), %rdi  	#atoi 1
	call atoi
	mov %rax, arg_1
	
	mov 16(%rbx), %rdi	#atoi 2
	call atoi
	mov %rax, arg_2
	
	mov 24(%rbx), %rdi	#atoi 3
	call atoi
	mov %rax, arg_3
	
	mov arg_1, %rdi		#max
	mov arg_1, %rsi
	mov arg_1, %rdx
	call max
	mov %eax, result
	
	mov $format, %rdi	#printf
	mov result, %rsi
	call printf
	
	
	add $8, %rsp	
	
exit:
	ret