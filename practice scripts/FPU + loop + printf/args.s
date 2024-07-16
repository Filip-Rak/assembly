.global main
.data
	a: .double 1.0
	
	wynik:	.double 8.0
	
	format: .string "%lf\n"
.text
main:
    	finit
	fld1	
	
	mov $5, %rcx
	
for:   
	faddl a

	dec	%rcx
	jnz	for  
	
	
	
	
exit:
	fstpl wynik
	
    	sub $8, %rsp
    	
    	mov $format, %rdi
    	mov $1, %eax
    	movsd wynik, %xmm0
    	call printf
    
    	add $8, %rsp
    	
    	mov $0, %eax
    ret