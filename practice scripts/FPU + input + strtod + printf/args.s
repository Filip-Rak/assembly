.global main
.data
	x: .double 5
	format: .string "%lf\n"
.text
main:
	
	mov 8(%rsi), %rdi
	
	sub $8, %rsp

	call strtod
	movsd %xmm0, x

	
	mov $format, %rdi
	mov $1, %eax
	movsd x, %xmm0
	call printf
	
	add $8, %rsp
	
	
ret