.global _start
.data
	.include "include.s"

.text
_start:
	call hello
	call exit
