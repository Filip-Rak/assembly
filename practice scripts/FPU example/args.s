.global main
.data
	cw: 	.word 	0
	a: 	.float	2.0
	b: 	.float	0
	
	
	wynik:	.float 	0
	
	format:	.string	"%f\n"
.text
main:
	finit				#defaultujemy FPU
	fstcw cw 			#zapisujemy ustawienia FPU do zmiennej cw -> cw: .word 0
	#movw $0b0000001101111111, cw	#zapisujemy nowa maske do cw. Instrukcja robienia maski nizej
	fldcw cw			#wczytujemy maske z cw do FPU	
	
	flds a
	fdivs b
	fstps wynik
	
	
	sub $8, %rsp
	mov $format, %rdi
	mov $1, %rax
	movss wynik, %xmm0
	cvtss2sd %xmm0, %xmm0
	call printf
	
	
	add $8, %rsp
	
	ret