#################################################################
#
# Laboratorium 3. Konwersja liczby calkowitej bez znaku (8 - 64 bitow)
# do postaci ciagu tekstowego (system szesnastkowy)

.globl _start

#################################################################
#
# alokacja pamieci - zmienne statyczne, 8/16/32/64 bitowe,
# z nadana wartoscia poczatkowa

.data

var8:	.byte	93
var16:	.word	51966
var32:	.long	3735927486
var64:	.quad	18369548392556473261

outstr:	.ascii	"value = 0x0000000000000000\n"
.equ	strlen, . - outstr

#################################################################
#
# program glowny
  
 .text
	
_start:

	xor	%eax,%eax
	
# Przekaz tylko niezbedne argumenty do funkcji konwertujacej:
#
# w akumulatorze - liczbe podlegajaca konwersji
# w rejestrze %edi - adres bufora (pozycji odpowiadajacej cyfrze jednosci)

	mov	var64,%rax
	mov	$outstr+24,%rdi

# oraz, w przypadku konwersji typow wielobajtowych
# w rejestrze %ecx - rozmiar konwertowanego typu danych w bajtach (1,2,4,8)

	mov	$8,%ecx

# wywolaj funkcje konwertujaca

	call	convert	

# wyswietl wynik (system call 1)

	mov	$1,%eax
	mov	$1,%edi
	mov	$outstr,%rsi
	mov	$strlen,%edx
	syscall

# zakoncz program i wyjdz z kodem bledu = 0 (system call 60)

	mov	$60,%eax
	xor	%edi,%edi
	syscall

#################################################################
#
# Zadanie --- 3 ---
#
# Konwertuj wielobajtowy typ danych (16, 32, 64 bit)
#
# argumenty: liczba w rejestrze "%a" (odpowiedniej dlugosci), adres zapisu w %edi
# liczba bajtow do konwersji w %ecx
# funkcja powinna wykorzystywac procedure "convert_byte"
# zwracana wartosc: -
# niszczone rejestry:

convert:
	mov %rax, %rdx
	call	convert_byte
	mov %rdx, %rax
	shr $8, %rax
	sub $2, %rdi
	dec %ecx
	jnz convert

	ret

#################################################################
#
# Zadanie --- 2 ---
#
# konwertuj pojedynczy bajt
# argumenty: dane w rejestrze %al, adres zapisu (dwoch bajtow) w %edi
# zwracana wartosc: -
# niszczone rejestry:

convert_byte:
	mov %al, %bl
	AND $0x0F, %al
	call convert_nibble
	mov %al, %ah
	mov %bl, %al
	shr $4, %al

	call	convert_nibble

	mov %ax, (%rdi)

	ret

#################################################################
#
# Zadanie --- 1 ---
#
# Konwertuj czterobitowa liczbe (nizszy polbajt, nizsza tetrade, lower nibble...)
# na odpowiadajacy jej kod znaku tablicy ASCII.
#
# argument:
# 4 mlodsze bity w rejestrze %al (4 starsze musza byc wyzerowane)
# zwracana wartosc: w %al - nr znaku wg tablicy ASCII
#
# wykonywane dzialanie: if (%al < 10) %al += 48; else %al += 55;
#
# realizacja - dowolna
	
convert_nibble:

	cmp $9, %al
	ja above_9
	add $48, %al
	ret
	
above_9:
	add $55, %al

	ret
		
#################################################################
