.global main
.text
main:
	sub $8, %rsp
	call exec
	add $8, %rsp
	
exit:
	ret