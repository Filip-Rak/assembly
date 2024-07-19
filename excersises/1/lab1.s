.globl _start

.equ	sys_write,	1
.equ	sys_exit,	60
.equ	stdout,	1
.equ	strlen, 	new_line + 1 - str

.data

str:		.ascii	"Hello!"
new_line:	.byte	0x0A

.text

_start:


mov	$sys_write , %eax
mov	$stdout , %edi
mov	$str , %esi
mov	$strlen , %edx
syscall
