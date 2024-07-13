# sum.asm
.global _start

.extern printf
.extern sum

.section .data
format:
    .asciz "Sum: %d\n"

.section .text
_start:
    # Call sum(1, 2) and print the result
    mov $1, %edi    # First argument to sum()
    mov $2, %esi    # Second argument to sum()
    call sum
    mov %eax, %esi  # Move result to second argument for printf()
    mov $format, %edi  # First argument to printf()
    xor %eax, %eax  # Clear %eax for variadic function call
    call printf

    # Exit the program
    mov $60, %eax
    mov $0, %edi
    syscall

