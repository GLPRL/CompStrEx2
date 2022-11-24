    .data
id:  .int 318778594
	.section 	.rodata
format1: .ascii "%d\n"                        	          #id: 318778594
	.text
.globl	main	                           		#initial point of this program
    .type	main, @function                                    #the main label is a function
main:
    movq   %rsp, %rbp #for correct debugging
    push 	 %rbx					#start of main
    lea    format1(%rip), %rdi
    mov    id, %esi
    call   printf
    #part 2
    movq   id, %rax
    and    $0x01, %ah				#bitwise AND, and conditional jump
    jz     .even
    jmp    .odd

.odd:       #If number is odd: mult by 3 and print
    mov    id, %esi
    leal   (%esi, %esi, 2), %esi
    lea    format1(%rip), %rdi
    call   printf
    jmp    .cont1
    
.even:      #If number is even: remainder of div by 3
    and    $0x00, %rdx
    and    $0x00, %rax
    movq   id, %rbx                                        #insert ID
    mov    %bh, %ah                                        #get 2nd byte
    mov    $3, %rcx                                        #declare divisor
    idiv   %rcx
    lea    format1(%rip), %rdi
    mov    %edx, %esi
    call   printf
.cont1:
    #part 3
    pop    %rbx
    ret
