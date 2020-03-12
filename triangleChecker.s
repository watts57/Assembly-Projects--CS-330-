

.section .rodata

A: .quad 6
B: .quad 3
C: .quad 3

str0: .string "%d\n"
strA: .string "\nA = "
strB: .string "\nB = "
strC:  .string "\nC = "
strplus: .string " + "
strequals: .string " = "
strvalidtriangle: .string "\nThis is a valid triangle."
strnotvalidtriangle: .string "\nThis is not a valid triangle."

straplusb: .string "\nA +B ="
straplusc: .string "\nA+C = "
strbplusc: .string "\nB+C = "

strcondition1: .string "\nCondition 1: If Valid Triangle, then  A + B > C"
strcondition2: .string "\nCondition 2: If Valid Triangle, then  A + C > B"
strcondition3: .string "\nCondition 3: If Valid Triangle, then  B + C > A"

strpassed: .string "....This condition Check has passed.\n"
strfailed: .string "....This condition check has failed.\n"


.text



.global main
.global aplusbgreaterc
.global apluscgreaterb
.global bpluscgreatera
.global notatriangle
.global validtriangle
.global printr
.global zeroregisters
.global showvars

zeroregisters:
	mov $0, %rax
	mov $0, %rdi
	mov $0, %rsi
	ret

printr:
	mov $str0,%rdi
	xor %rax, %rax
    call printf
	ret
	
showvars:
    call zeroregisters
	mov $strA, %rdi
	call printf
	mov A, %rsi
	call printr
	call zeroregisters
	
	mov $strB, %rdi
	call printf
	mov B, %rsi
	call printr
	call zeroregisters
	
	mov $strC, %rdi
	call printf
	mov C, %rsi
	call printr
	call zeroregisters
	
	ret
	
aplusbgreaterc: #is a+b > c? if yes, jumps to next check (function). if no, it jumps to failure condition function
    mov $strcondition1, %rdi
    call printf
    
    call zeroregisters
    
	mov A, %rax
	addq B, %rax

	cmpq C, %rax #compare result of addition of A+B to C
	
	jg apluscgreaterb #if a+B > C, jump to next function
	
	#otherwise 
	
	call zeroregisters
	mov $strfailed, %rdi
	call printf
	
	jmp notatriangle

apluscgreaterb: #is a+c > b?
    call zeroregisters
	mov $strpassed, %rdi
	call printf
	call zeroregisters
    
    mov $strcondition2, %rdi
    call printf
    
    call zeroregisters
    
	call zeroregisters
	mov A, %rax
	addq C, %rax
	

	cmpq B, %rax #compare result of addition of A+C to B
	jg bpluscgreatera #if A+C > B, jump to next check (is B+C > A)

	#otherwise, did not satisfy this condition, and is not a valid triangle
	call zeroregisters
	mov $strfailed, %rdi
	call printf
	
	jmp notatriangle
	
	ret
	
bpluscgreatera: #is b+c > a?
    call zeroregisters
	mov $strpassed, %rdi
	call printf
	call zeroregisters
	
    mov $strcondition3, %rdi
    call printf
    
    call zeroregisters
	call zeroregisters
	mov B, %rax
	addq C, %rax
	cmpq A, %rax
	jg validtriangle
	
	#otherwise, fails this condition, is not a valid triangle
	call zeroregisters
	mov $strfailed, %rdi
	call printf
	
	jmp notatriangle
	
	ret
	
	

validtriangle:
    call zeroregisters
	mov $strpassed, %rdi
	call printf
	call zeroregisters
	
	call zeroregisters
	mov $strvalidtriangle, %rdi
	call printf
	
	
	call exit
	ret

notatriangle:
	call zeroregisters
	mov $strnotvalidtriangle, %rdi
	call printf
	
	call exit
	ret
	
main:
	
	call showvars
	call zeroregisters
	call aplusbgreaterc
	
	ret
	




