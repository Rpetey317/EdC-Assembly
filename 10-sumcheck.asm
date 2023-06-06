.begin
.org 2048

    !;register usage
    !;r1, r2 -> input values (success case)
    !;r3, r4 -> input values (failure case)
    !;r5, r6 -> respective outputs
    !;r14 -> stack pointer
    !;r8, r9, r10 -> aux pointers for subroutine

    ld [A], %r1     
    ld [B], %r2     !;load inputs

    addcc %r14, -4, %r14    
    st %r1, %r14            !;push r1 to stack

    addcc %r14, -4, %r14
    st %r2, %r14            !;push r2 to stack

    call sumcheck           !;call subroutine (should return 0)
    ld %r14, %r5            !;load result to r5
    
    sethi 0x1fffff, %r3
    addcc %r3, 1023, %r3    !;load huge constant to r3
    ld [C], %r4             !;load 1000 to r4

    addcc %r14, -4, %r14    
    st %r3, %r14            !;push r3 to stack

    addcc %r14, -4, %r14
    st %r4, %r14            !;push r4 to stack

    call sumcheck           !;call subroutine (should return -1)
    ld %r14, %r6            !;load result to r6
    
    ba fin                  !;end program


!;subroutines
sumcheck: !;returns 0 if sum of top 2 stack values (as signed ints) can be represented, -1 if not
    ld %r14, %r8
    addcc %r14, 4, %r14     !;pop stack top to r8

    ld %r14, %r9
    addcc %r14, 4, %r14     !;pop stack top to r9

    ld %r0, %r10            !;initialize r10 to 0

    addcc %r8, %r9, %r0     !;do the sum
    bvs seterror            !;if overflow, set error value for return
    ba return               !;if not, return

seterror: 
    ld [NEGONE], %r10       !;load -1 to r10
    ba return               !;return

return: addcc %r14, -4, %r14    
        st %r10, %r14       !;push r10 to stack
        jmpl %r15 +4, %r0   !;return

!;constants
A: 30
B: 25
C: 1000
NEGONE: -1

fin:
.end
