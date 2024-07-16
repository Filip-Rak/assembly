.global main
.data
	arr: .double 0.0, 1.0, 2.0	
.text
main:
	mov $arr, %rdi
	mov $3, %rsi
	
	sub $8, %rsp
	call exec
	add $8, %rsp
	
	ret