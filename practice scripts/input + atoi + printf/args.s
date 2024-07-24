.global main
.data
	format: .string "%d\n"
	a: .long 5
.text
main:
	xor %eax, %eax #zerowanie %eax - wymagane zawsze

	mov 8(%rsi), %rdi #atoi
	call atoi
	mov %eax, a
	
	mov $format, %rdi #printf
	mov a, %rsi
	sub $8, %rsp #uzupelnienie stosu?
	call printf
	
	add $8, %rsp  #tak
	ret