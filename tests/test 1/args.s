.global main
.data
	arg_1: .int 0
	arg_2: .int 0
	arg_3: .int 0
	arg_4: .int 0
	
	result: .int 0
	format: .string "Wynik: %d\n"
.text
main:
	sub $8, %rsp

	cmp $5, %edi
	jne exit

	mov %rsi, %rbx	#wazne. rsi zostanie stracone przy wywolaniu atoi

	mov 8(%rbx), %rdi	#atoi 1
	call atoi
	mov %rax, arg_1
	
	mov 16(%rbx), %rdi	#atoi 2
	call atoi
	mov %rax, arg_2
	
	mov 24(%rbx), %rdi	#atoi 3
	call atoi	
	mov %rax, arg_3
	
	mov 32(%rbx), %rdi	#atoi 4
	call atoi
	mov %rax, arg_4
	
	
	mov arg_1, %rdi		#sum	
	mov arg_2, %rsi
	mov arg_3, %rdx
	mov arg_4, %rcx
	call add
	mov %eax, result
	
	mov $format, %rdi	#printf
	mov result, %rsi
	call printf
	
exit:
	add $8, %rsp
	ret
