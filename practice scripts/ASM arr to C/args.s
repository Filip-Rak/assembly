.global main
.data
	arr: .long 1, 2, 3
	size: .int 3
.text
main:
	sub $8, %rsp
	
	mov $arr, %rdi	#przekazujemy wskaznik, nie wartosc - dlatego dolar
	mov size, %rsi
	call func
	
	add $8, %rsp
	ret
	
	