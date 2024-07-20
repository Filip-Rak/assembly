global main
.data
	a: .double 1.5
	b: .double 0.5
	
	wynik:	.double 8
	
	format: .string "%lf\n"
.text
main:
	finit
	
	FLDL a	#ST(0) = a
	FSQRT #ST(0) = a + b
	FSTPL wynik
	
	sub $8 ,%rsp
	
	mov $format, %rdi
	mov $1, %rax
	movsd wynik, %xmm0
	call printf
	
	add $8, %rsp
	
ret