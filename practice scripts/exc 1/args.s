.global main
.data
	tab: .long 5, 4, 3, 2
	format: .string "%d\n"
.text
main:
	sub $8, %rsp 	#prep
		
	cmp $2, %edi	#sprawdza czy ilosc arg ok
	jne exit

	mov 8(%rsi), %rdi	#bierze arg z rsi i konwertuje na liczbe
	call atoi
	
	cmp $4, %rax	#sprsawdza czy indeks nie jest za duzy
	jge exit
		
	cmp $0, %rax
	jl exit
	
	mov tab(,%rax, 4), %rsi	#przechodzi do tab[%rax] i zapisuje %rsi
	
	mov $format, %rdi	#wypisz tab[%rax]
	call printf

	
exit:

	add $8, %rsp
	ret