# main.s
.section .data
hello:
    .ascii "Hello, world!\n\0"

.section .text
.globl main
main:
    # Prepare arguments for printf()
    mov $hello, %rdi  # First argument: pointer to format string
    xor %rax, %rax    # Clear %rax for variadic function call
    call printf       # Call printf()

    # Exit the program
    xor %rax, %rax    # Return 0 from main()
    mov $60, %rax     # System call number for exit
    syscall

