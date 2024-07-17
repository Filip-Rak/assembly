.globl	main

# Liczba sumowanych par (+ i -) elementow.

.equ	N , 1000000000  #ilosc iteracji petli

.data

timetab:	.double	0.0, 0.0, 0.0
cw:		.word		0
str1:		.string	" PI_ref =\t%1.20Lf\n PI_com =\t%1.20Lf\n delta  =\t%1.20Lf\n"
str2:		.string	"USER CPU TIME = %lf s\n"

.text

main:                

sub	$8 , %rsp

# Rozpocznij pomiar czasu

call	init_time

mov	$N , %rcx

finit
fld1
fadd %st(0), %st(0)
fldz
fld1
# 1) Ustaw podwojna precyzje obliczen oraz sposob zaokraglania.


fstcw	cw
andw	$0xf0ff , cw
orw	$0x0300 , cw
fldcw	cw



# Obliczanie wartosci PI:
#
# +(1/1) - (1/3) + (1/5) - (1/7) + (1/9) + ... => PI/4
#


for:   

# 2) Oblicz pierwszy element (dodatni) # 1/1 - 1/3 + 1/5 - 1/7  -> pi/4
fld1
fdiv %st(1), %st(0)	#st(0) = st(0) / st(1)
faddp %st(0), %st(2) 	#st(2) = st(2) + st(0), pop st(0)
fadd %st(2), %st(0)

# Oblicz drugi element (ujemny)
fld1
fdiv %st(1), %st(0)	#st(0) = st(0) / st(1)
fsubrp %st(0), %st(2)	#st(2) = st(2) - st(0), pop st(0), st(1) = st(2) - st(0)
fadd %st(2), %st(0)



dec	%rcx
jnz	for    

# 3) Wynik *=4 
fxch %st(1)
fadd %st(0), %st(0)
fadd %st(0), %st(0)
# Roznica miedzy wartoscia obliczona w %st(0) a "dokladna" PI

fldpi
fsub	%st(1) , %st(0)
fabs

# Wrzuc wszystko na stos

sub	$16 , %rsp
fstpt	(%rsp)

sub	$16 , %rsp
fstpt	(%rsp)

fldpi
sub	$16 , %rsp
fstpt	(%rsp)

# Zakoncz pomiar czasu

mov	$timetab , %rdi
call	read_time

# Wydrukuj obliczone wartosci i zmierzony czas

mov	$str1 , %rdi
xor	%eax , %eax
call	printf

mov	$str2 , %rdi
movsd	timetab+8 , %xmm0
xor	%eax , %eax
inc	%eax
call	printf

add	$56 , %rsp
ret
