.global main
.text
	format: .string "%d\n"
main:

	mov 8(%rsi), %rdi
	call atoi
	
	cmp $1, %rax
	je c1
	cmp $2, %rax
	je c2
	cmp $3, %rax
	je c3
	jne c_default
	
	
		
c1:
	mov $1, %rsi
	jmp exit
	
c2:
	mov $2, %rsi
	jmp exit
	
c3:
	mov $3, %rsi
	jmp exit
	
c_default:
	mov $4, %rsi
	jmp exit
	
	
exit:
	sub $8, %rsp

	mov $format, %rdi
	call printf
	
	add $8, %rsp
	
	
	ret