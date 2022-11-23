    .data
id: .int 318778594
	.section 	.rodata
format1: .ascii "%d\n"                        	          #id: 318778594
	.text
.globl	main	                           		#initial point of this program
    .type	main, @function                                    #the main label is a function
    
    
main:
    push 	%rbx					#start of main
    lea    format1(%rip), %rdi
    mov    $318778594, %esi
    call   printf
    #part 2															#end of part 1
    movq   $318778594, %rax
    and    $1, %ah				#bitwise AND, and conditional jump
    #jz     .even
    jmp    .odd

.odd:       #If number is odd: mult by 3 and print
####EVERYTHING WORKS####
    mov    $318778594, %esi
    leal   (%esi, %esi, 2), %esi
    lea    format1(%rip), %rdi
    call   printf
        
    
.even:      #If number is even: remainder of div by 3
    ####NEED TO MAKE####

.cont1:
    pop    %rbx
    ret
