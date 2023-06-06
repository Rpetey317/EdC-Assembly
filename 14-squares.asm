    .begin
    .org 2048

    !;register usage
    !;r1, r2 -> input values (success case)
    !;r3, r4 -> input values (failure case)
    !;r5, r6 -> respective outputs
    !;r14 -> stack pointer
    !;r8 -> multiplicand, forloop variable
    !;r9 -> other multiplicand
    !;r10 -> partial sum, return value

!;main
        
        ld [A], %r1     

        addcc %r14, -4, %r14    
        st %r1, %r14            !;push r1 to stack

        call square             !;call subroutine (should return 144)
        ld %r14, %r3            !;load result to r5
        
        sethi 0x1fffff, %r2
        addcc %r2, 1023, %r2    !;load huge constant to r2

        addcc %r14, -4, %r14    
        st %r2, %r14            !;push r2 to stack

        call square             !;call subroutine (should return -1)
        ld %r14, %r4            !;load result to r6
        
        ba fin                  !;end program



square: !;squares top stack value, return result on stack top

        ld      %r14, %r8
        ld      %r14, %r9
        add     %r14, 4, %r14   !;pop stack top to r8 and r9

        ld      %r0, %r10       !;initialize r10 to 0

forloop:addcc   %r0, %r8, %r8   !;check condition
        be return               !;return when r8 reaches 0

        addcc   %r8, -1, %r8       !;decrement r8 by one
        addcc   %r9, %r10, %r10    !;add r9 to the partial sum
        bvs error                  !;return -1 if overflow
        ba forloop                 !;loop

error:  ld      %r0, %r10         
        add 	%r10, -1, %r10     !;load -1 to r10 (error)     
	ba return                  !;return it

return: add     %r14, -4, %r14     
        st      %r10, %r14         !;push return value to stack
        jmpl    %r15 + 4, %r0      !;return

!;constants
A: 12

fin:
    .end 
