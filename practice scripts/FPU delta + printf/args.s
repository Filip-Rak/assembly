    .global main
.data
	a: .double 1.0
	b: .double 5.0
	c: .double -4.0
	
	multi: .double 4
	
	wynik:	.double 8.0
	format: .string "%lf\n"
.text
main:
	finit
	
	fldl b
	fmull b		#st(0) = bb
	
	fldl a		#st(0) = a st(1) = bb
	fmull c		#st(0) = ac st(1) = bb
	fmull multi	#st(0) = 4ac st(1) = bb
	
	fsubr %st(1), %st(0)	#st(0) = bb - 4ac 
	
	fstpl wynik



	
    	sub $8, %rsp
    	
    	mov $format, %rdi
    	mov $1, %eax
    	movsd wynik, %xmm0
    	call printf
    
    	add $8, %rsp
ret