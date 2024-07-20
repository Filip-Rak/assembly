
.global main
.data
	a: 	.double 5.0
	b: 	.double 2.0
	c: 	.double -1.0
	
	four:	.double 4
	two:	.double 2
	zero:	.double 0.0
	
	delta:	.double 8.0
	x1:	.double 0
	x2:	.double 0
	
	format1: .string "Brak wynikow\n"
	format2: .string "Jeden wynik: x0 = %lf\n"
	format3: .string "Dwa wyniki: x1 = %lf, x2 = %lf\n"

.text
main:				#wczytywanie arg z konsoli
	mov %rsi, %rbx		#skopiuj rsi do rbx, zeby funkcja nie usunela
	sub $8, %rsp
	
	xor %rsi, %rsi		#przed wywolaniem strtod trzeba wyczyscic 2-gi argument, bo drugi to powinien byc NULL / 0
	mov 8(%rbx), %rdi
	call strtod
	movsd %xmm0, a		#wynik z funkcji zmiennoprzecinkowej jest zwracany w %xmm0, movsd do przenoszenia double, movss do floata. Z tym sie lepiej nie mylic
	
	xor %rsi, %rsi
	mov 16(%rbx), %rdi
	call strtod
	movsd %xmm0, b
	
	xor %rsi, %rsi
	mov 24(%rbx), %rdi
	call strtod
	movsd %xmm0, c
	
	
			#liczenie delty
	finit
	
	fldl b
	fmull b		#st(0) = bb
	
	fldl a		#st(0) = a st(1) = bb
	fmull c		#st(0) = ac st(1) = bb
	fmull four	#st(0) = 4ac st(1) = bb
	
	fsubr %st(1), %st(0)	#st(0) = bb - 4ac 
	
	fstpl delta	#zapisz delte
	fldl delta	#zaloz delte na stos
	
	fcompl zero	#sprawdza czy st(0) jest rowne zero, zdejmuje delte ze stosu, niestety
	fstsw %ax	
	sahf		#kopiowanie flagi z fpu, ^ tez
	
	
	jb below	#skoki warunkowe
	jg above
	je equal

		
below:	#delta ujemna
	mov $format1, %rdi
	jmp exit_if
	
equal:	#tylko x0
	fldl b		#st(0) = b
	fchs		#st(0) = -b
	fldl a		#st(0) = a st(1) = -b
	fmull two	#st(0) = 2a, st(1) -b
	fdivrp %st(0), %st(1)	#st(0) = -b/2a  st(1)..st(2)...
	
	fstpl x1
	mov $format2, %rdi
	mov $1, %rax
	movsd x1, %xmm0
	
	jmp exit_if

above:	#x0 i x1
	fldl delta	#delta = st(0)
	fsqrt		#st(0) = sqrt(delta)
	fldl b		#st(0) = b, st(1) = sqrt(delta)
	fchs		#st(0) = -b, st(1) = sqrt(delta)
	fsub %st(0), %st(1)	#st(0) = sqrt(delta), st(1) = -b-sqrt(delta)
	fxch %st(1)	#st(0) = -b-sqrt(delta), st(1) = sqrt(delta)
	fldl a		#st(0) = a, st(1) = -b-sqrt(delta), st(2) = sqrt(delta)
	fmull two	#st(0) = 2a, st(1) = -b-sqrt(delta), st(2) = sqrt(delta)
	fxch %st(1)	#st(0) = -b-sqrt(delta), st(1) = 2a, st(2) = sqrt(delta)
	fdiv %st(1)	#st(0) = x1, st(1) = 2a, st(2) = sqrt(delta)
	fstpl x1	#st(0) = 2a, st(1) = sqrt(delta)
	
	
	fldl delta	#delta = st(0)
	fsqrt		#st(0) = sqrt(delta)
	fldl b		#st(0) = b, st(1) = sqrt(delta)
	fchs		#st(0) = -b, st(1) = sqrt(delta)
	fadd %st(0), %st(1)	#st(0) = sqrt(delta), st(1) = -b+sqrt(delta)
	fxch %st(1)	#st(0) = -b+sqrt(delta), st(1) = sqrt(delta)
	fldl a		#st(0) = a, st(1) = -b+sqrt(delta), st(2) = sqrt(delta)
	fmull two	#st(0) = 2a, st(1) = -b+sqrt(delta), st(2) = sqrt(delta)
	fxch %st(1)	#st(0) = -b+sqrt(delta), st(1) = 2a, st(2) = sqrt(delta)
	fdiv %st(1)	#st(0) = x2, st(1) = 2a, st(2) = sqrt(delta)
	fstpl x2	#st(0) = 2a, st(1) = sqrt(delta)
	

	mov $format3, %rdi
	mov $2, %rax
	movsd x1, %xmm0
	movsd x2, %xmm1
	
	jmp exit_if


exit_if:
    	call printf
    	add $8, %rsp
ret