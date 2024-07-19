#################################################################
#
# Laboratorium 4a. Konwersja liczby calkowitej bez znaku (8 - 64 bitow)
# do postaci ciagu tekstowego (system szesnastkowy)

.globl _start

#################################################################
#
# alokacja pamieci - zmienne statyczne, 8/16/32/64 bitowe,
# z nadana wartoscia poczatkowa

.data

lut16bit:
lut_0:	.ascii	"00","01","02","03","04","05","06","07","08","09","0A","0B","0C","0D","0E","0F"
lut_1:	.ascii	"10","11","12","13","14","15","16","17","18","19","1A","1B","1C","1D","1E","1F"
lut_2:	.ascii	"20","21","22","23","24","25","26","27","28","29","2A","2B","2C","2D","2E","2F"
lut_3:	.ascii	"30","31","32","33","34","35","36","37","38","39","3A","3B","3C","3D","3E","3F"
lut_4:	.ascii	"40","41","42","43","44","45","46","47","48","49","4A","4B","4C","4D","4E","4F"
lut_5:	.ascii	"50","51","52","53","54","55","56","57","58","59","5A","5B","5C","5D","5E","5F"
lut_6:	.ascii	"60","61","62","63","64","65","66","67","68","69","6A","6B","6C","6D","6E","6F"
lut_7:	.ascii	"70","71","72","73","74","75","76","77","78","79","7A","7B","7C","7D","7E","7F"
lut_8:	.ascii	"80","81","82","83","84","85","86","87","88","89","8A","8B","8C","8D","8E","8F"
lut_9:	.ascii	"90","91","92","93","94","95","96","97","98","99","9A","9B","9C","9D","9E","9F"
lut_A:	.ascii	"A0","A1","A2","A3","A4","A5","A6","A7","A8","A9","AA","AB","AC","AD","AE","AF"
lut_B:	.ascii	"B0","B1","B2","B3","B4","B5","B6","B7","B8","B9","BA","BB","BC","BD","BE","BF"
lut_C:	.ascii	"C0","C1","C2","C3","C4","C5","C6","C7","C8","C9","CA","CB","CC","CD","CE","CF"
lut_D:	.ascii	"D0","D1","D2","D3","D4","D5","D6","D7","D8","D9","DA","DB","DC","DD","DE","DF"
lut_E:	.ascii	"E0","E1","E2","E3","E4","E5","E6","E7","E8","E9","EA","EB","EC","ED","EE","EF"
lut_F:	.ascii	"F0","F1","F2","F3","F4","F5","F6","F7","F8","F9","FA","FB","FC","FD","FE","FF"

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
	mov	$outstr+8,%rdi

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
# Zadanie --- 1 ---
#
# Konwertuj wielobajtowy typ danych (16, 32, 64 bit)
# wykorzystujac Look Up Table.
#
# argumenty: liczba w rejestrze "%a" (odpowiedniej dlugosci), adres zapisu w %edi
# liczba bajtow do konwersji w %ecx
# funkcja powinna wykorzystywac procedure "convert_byte"
# zwracana wartosc: -
# niszczone rejestry:

convert:

	mov %rax, %rdx
	and $0xFF, %rax
	mov lut16bit( ,%rax, 2), %ax
	mov %ax, outstr+8( ,%ecx, 2)
	mov %rdx, %rax
	shr $8, %rax
	dec	%ecx
	jnz	convert

	ret

#################################################################
