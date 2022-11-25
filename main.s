#318778594 Gal Pearl
#ID chosen: mine.
        .data
id:  .int 318778594
	.section 	.rodata                                  #Compiled using gcc main.s -no-pie
format1: .string "%d\n"                        	          #id: 318778594
formatt: .string "True\n"
formatf: .string "False\n"
	.text
.globl	main	                           		#initial point of this program
    .type	main, @function                                    #the main label is a function
main:
    push 	 %rbx
    movq   %rsp, %rbp                                        #for correct debugging					
    lea    format1(%rip), %rdi
    mov    id, %esi
    call   printf
    and    $0, %rdi
    #part 2                 getting the remainder.
    movq   id, %rax
    and    $0x01, %ah				#bitwise AND, and conditional jump
    jz     even

odd:      #If number is odd: mult by 3 and print
    mov    id, %esi
    leal   (%esi, %esi, 2), %esi
    lea    format1(%rip), %rdi
    call   printf
    jmp    cont1
even:      #If number is even: remainder of div by 3
    and    $0x00, %rdx
    and    $0x00, %rax
    movq   id, %rax                                        #insert ID
    mov    $3, %rcx                                        #declare divisor
    idiv   %rcx
    lea    format1(%rip), %rdi
    mov    %edx, %esi
    call   printf
cont1:
    #part 3                 al will be first byte. bl will be 3rd byte.
    movq   id, %rax         #al now has 1st byte
    movq   id, %rbx
    sar    $16, %rbx
    xor    %bl, %al
    cmpb   $127, %al
    jae    great
less:
    lea    formatf(%rip), %rdi
    call   printf
    mov    $0x00, %rax
    jmp    cont2
great:
    lea    formatt(%rip), %rdi
    call   printf
    mov    $0x00, %rax  
cont2:
    #part 4                detect and print number of ON/TRUE/1 bits
    mov   id, %rax
    and   $0x00, %rsi      #hold the num of 1 bits
    shr   $0x18, %rax      #right shift by 24. our value is now at register al
    movb  %al, %bl         #bl holds a copy. rshift it and copy back to al
pre:
    cmpb  $0x00, %al       #if al is zero, then num of bits is 0
    je    cont3
L1:
    movb  %bl, %al
    and   $1, %al
    cmpb  $1, %al
    je    incr
    shr   $1, %bl
    movb  %bl, %al
    ja    pre
    jmp   cont3
incr:
    inc   %rsi
    shr   $1, %bl
    jmp   L1
cont3:
    lea   format1(%rip), %rdi
    call  printf
    pop   %rbx
    ret
