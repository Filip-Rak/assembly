.global main
.data
	formatT: .string "True\n"
	formatF: .string "False\n"
.text
main:

	JE true
	
	sub $8, %rsp
	mov $formatF, %rdi
	call printf
	add $8, %rsp
	
	ret
	
true:
	sub $8, %rsp
	mov $formatT, %rdi
	call printf
	add $8, %rsp
	
	ret
