.section .rodata
strvars: .string "\nWilliam Watts\nwatts57@uab.edu\nCS330\n\nA = 16, B = 2\n"
str0: .string "\nResult: %d\n"
A:  .quad   16
B:  .quad   2

#these strings print to give prompt for question
#makes it easier to test/debug and think
#also probably easier to read this way

str1: .string "\nNumber 1: B*3 \n"
str2: .string "\nNumber 2: (A*B) - (A/B)\n"
str3: .string "\nNumber 3: (A-B)+(A*B) \n"



.text
# everything inside .text is read-only
.global main  # required
.global numberone # first problem
.global numbertwo #second problem
.global numberthree #third problem
printr: #TA provided helpful print function in canvas code examples
    mov $str0, %rdi
    xor %rax, %rax #if I understand correctly, this clears it
    call printf
    ret

numberone:  # main calls this...B*3
    mov $strvars, %rdi #string displays hard coded values of A and B
    call printf #print string

    mov $0, %rdi # clear it as a precaution while learning assembly
    mov $0, %rsi # just to be safe...

    mov $str1, %rdi #load string
    call printf #print string
    mov $0, %rdi #clear it
    mov $0, %rsi #clear it

    mov B, %rax #load value of B
    imulq $3,%rax #multiply B by 3
    mov %rax, %rsi #move result to %rsi
    call printr #print value stored at %rsi

    mov $str2, %rdi #this prevents a weird bug skewing number 2 answer
    call printf #for some reason, calling this in number 2 increases answer by one

numbertwo:#(A*B) - (A/B)
    mov $0, %rax # clear %rax
    mov $0, %rsi # clear #rsi
    mov A, %rax #load A into %rax
    mov B, %rsi #load B into %rax
    push %rsi #save B -pops second
    push %rax #save A -pops first
    cqto #book says register %rdi required for division
    idivq %rsi #divide A/B
    pop %rdx    #A popped off stack into %rdx
    pop %rsi #B popped off stack into %rsi
    push %rax #save answer of A/B and free up %rax
    mov %rdx, %rax
    imulq %rsi
    push %rax #save multiplication result A*B
    #stack will pop in order: A*B...then A/B

    pop %rax #rax pops off stack
    pop %rsi #rsi pops off stack....stored values retrieved
    subq %rsi, %rax  #subtract %rsi from %rax

    #rax now contains answer
    mov %rax, %rsi  # so we move it over to the correct parameter reg
    call printr #call helpful TA print function

    #print next question prompt
    mov $str3, %rdi #this prevents a weird bug skewing answer for number 2
    call printf #print it

numberthree:
    #less comments here because it's pretty much the same logic as above
    #make sure registers are "zeroed"
    mov $0, %rax
    mov $0, %rdi
    mov $0, %rsi

    #now calculate (A-B)+(A*B)

    mov A, %rax #A goes in %rax
    mov B, %rsi #B goes in %rsi
    subq %rsi, %rax #calculate (A-B)
    push %rax #save result of rax in stack (will pop 2nd)

    #just to be safe since I am still learning assembly's quirks...
    mov $0, %rax #clear %rax
    mov $0, %rdi #clear %rdi
    mov $0, %rsi #clear %rsi

    mov A, %rax #same as previously (easier to reason through if consistent)
    mov B, %rsi #same as previously (easier if consistent to think)
    cqto #still trying to wrap my head around what this does....
    #textbook says to do it, so I'm doing it. Otherwise, floating pt. error
    idivq %rsi #this divides %rax by %rsi (A/B)
    push %rax # save this calculation's value

    pop %rax #retrieve stored value
    pop %rsi #retrieve stored value

    addq %rsi, %rax #add up the two expressions in problem...(A-B)+(A*B)
    mov %rax, %rsi #move result into %rsi to print

    call printr #print result

    call exit #seems to prevent segmentation fault

main:
    call numberone #calls number one's function
    call numbertwo # calls number two's function
    call numberthree #calls number three's function


    
    
