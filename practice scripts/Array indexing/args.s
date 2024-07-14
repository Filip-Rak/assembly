.global main
.data
	tab: .long 5, 4, 3, 2
	format: .string "%d\n"
.text
main:
	sub $8, %rsp

	mov 8(%rsi), %rdi
	call atoi
	
	mov tab(,%rax, 4), %rsi
	
	mov $format, %rdi
	call printf
	
	
	add $8, %rsp
	ret

#mov mov arr(,indeks, bajty), cel;