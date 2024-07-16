.global main
.data			       
	x: .float 3.141592653589
	result: .float 0.0
	
	format: .string "%lf\n"
.text
main:
	flds x
	fsqrt
	fstps result

	sub $8, %rsp	
	
	mov $format, %rdi
	movss result, %xmm0
	cvtss2sd %xmm0 , %xmm0
	mov $1, %eax
	call printf
	
	add $8, %rsp
	
ret