.globl	main
.data

liczba_elementow: .int 15
str:	.asciz  "%u elementow zerowych\n"
tab:	.long	6, 4, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 1
.text 
main:
	mov $0, %eax
	mov $0, %r8d
	
loop: 
	cmp liczba_elementow(%rip), %eax
	je finish

	mov tab(,%rax, 4), %edx
	add $1, %eax
	
	cmp $0, %edx
	jne loop
	
	add $1, %r8d
	jmp loop

finish:
	sub $8, %rsp	
	mov $0, %eax
	mov $str, %rdi
	mov %r8d, %esi
	call printf

	add $8, %rsp
	ret

