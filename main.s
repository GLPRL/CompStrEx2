#() Gal Pearl
#ID chosen: mine.
        .data
id:  .int ()
	.section 	.rodata                                  #Compiled using gcc main.s -no-pie
format1: .string "%d\n"                        	          
format2: .string "True\n"
format3: .string "False\n"
	.text
.globl	main	                           		#initial point of this program
    .type	main, @function                         #the main label is a function
main:						#part 1. simple print.
    push 	 %rbx
    movq   %rsp, %rbp                                        #for correct debugging					
    lea    format1(%rip), %rdi
    mov    id, %esi
    call   printf
    and    $0, %rdi
    #part 2                 			get 2nd byte. if even: print remainder of division by 3.
    						#otherwise, multi by 3 and print
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
    movq   id, %rbx                                        #insert ID
    mov    %bh, %ah                                        #get 2nd byte
    mov    $3, %rcx                                        #declare divisor
    idiv   %rcx
    lea    format1(%rip), %rdi
    mov    %edx, %esi
    call   printf
cont1:
    #part 3                 XOR 1st and 3rd bytes. if unsigned val is higher than 127 print true. otherwise, false.
    #al will be first byte. bl will be 2nd.
    movq   id, %rax         #ah now has 1st byte
    movq   id, %rbx
    shr    $16, %rbx        #bl now has 3rd byte
    xor    %bl, %al         #xor between 1st and 3rd byte
    cmpb   $127, %al        #n:127 ?
    jae    less
less:
    lea    format2(%rip), %rdi
    call   printf
    mov    $0x00, %rax
    jmp    cont2
great:
    lea    format3(%rip), %rdi
    call   printf
    mov    $0x00, %rax

cont2:
    #part 4                 detect and print number of ON/TRUE/1 bits in 4th byte
    mov   id, %rax
    shr   $0x18, %rax      #right shift by 24. our value is now at register al.
    pop   %rbx
    ret
