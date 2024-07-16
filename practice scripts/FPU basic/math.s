.global main
.data			       
	control_word:	.word 0b1
	x: .float 3.1415926535890
	result: .float 0.0
	
	format: .string "%f\n"
.text
main:

	finit
	#fldcw control_word
	
	flds x
	#flds result
	#fdiv %st(0), %st(0)
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
