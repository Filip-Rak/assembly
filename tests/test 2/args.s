.globl main
.data
# Pojemnosci kondensatorow C1, C2 i C3 np. w nF.

C1: .float 330.0
C2: .float 330.0
C3: .float 330.0
Cx: .float 0.0

cw: .word 0
outstr: .string "Cx = %f\n"
.text
main:
sub $8,%rsp

# Wlacz FPU, ustaw pojedyncza precyzje, wylacz wyjatki
finit
fstcw cw
movw $0b0000000001111111, cw
fldcw cw

# Oblicz pojemnosc Cx: 1/Cx = 1/C1 + 1/C2 + 1/C3 #27.915
fld1
fld1
fld1 #st(0) = 1, st(1) = 1, st(2) = 1
fdivs C1 #st(0) = 1/C1, st(1) = 1, st(2) = 1
fxch %st(1) #st(0) = 1, st(1) = 1/C1, st(2) = 1
fdivs C2 #st(0) = 1/C2, st(1) = 1/C1, st(2) = 1
fxch %st(2) #st(0) = 1, st(1) = 1/C1, st(2) = 1/C2
fdivs C3 #st(0) = 1/C3, st(1) = 1/C1, st(2) = 1/C2
fadd %st(1)
fadd %st(2) #st(0) = 1/Cx
fld1 #st(0) = 1, st(1) = 1/Cx
fdiv %st(1) #st(0) = Cx



fsts Cx


# Zapisz wynik i wydrukuj (jako float).

mov $outstr, %rdi
mov $1, %rax
movss Cx, %xmm0
cvtss2sd %xmm0, %xmm0
call printf



add $8,%rsp
ret