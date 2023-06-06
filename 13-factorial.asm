    .begin
    .org 2048

main:       ld [A], %r1
            ld [B], %r2
            ld %r0, %r3

            add     %r14, -4, %r14
            st      %r1, %r14 
            call factorial
            ld      %r14, %r4 

            add     %r14, -4, %r14
            st      %r2, %r14 
            call factorial
            ld      %r14, %r5

            add     %r14, -4, %r14
            st      %r3, %r14 
            call factorial
            ld      %r14, %r6

            ba fin 


factorial: !;calculates factorial of top stack value, return result on stack top

            ld      %r14, %r8       !;load stack top to r8

            addcc   %r8, %r0, %r0   !;check if non-positive
            bneg f_error            !;return -1 if negative
            be f_retone             !;return 1 if zero

            addcc   %r8, -10, %r10    !;check if >= 10
            bpos f_error

f_forloop:  addcc   %r8, -1, %r8
            be f_return                !;return when r8 reaches 0

            add     %r14, -4, %r14
            st      %r8, %r14          !;push r8 to stack (previous result was on top)

            ba multiply                !;multiply top stack values (partial*next)
            
mult_ret:   ld      %r14, %r10         !;load partial multiplication
            ba f_forloop               !;loop


f_error:    ld      %r0, %r10         
            add 	%r10, -1, %r10     !;load -1 to r10 (error)     
	        ba f_return                !;return it

f_retone:   ld      %r0, %r10
            add     %r10, 1, %r10
            ba f_return

f_return:   add     %r14, -4, %r14     
            st      %r10, %r14         !;push return value to stack
            jmpl    %r15 + 4, %r0      !;return  



multiply: !;multiplies top 2 stack values, return result on stack top

            ld      %r14, %r18
            add     %r14, 4, %r14   !;pop stack top to r18

            ld      %r14, %r19
            add     %r14, 4, %r14   !;pop stack top to r19

            ld      %r0, %r20       !;initialize r20 to 0

m_forloop:  addcc   %r0, %r18, %r18   !;check condition
            be m_return               !;return when r18 reaches 0

            addcc   %r18, -1, %r18     !;decrement r18 by one
            addcc   %r19, %r20, %r20   !;add r19 to the partial sum
            ba m_forloop               !;loop

m_return:   add     %r14, -4, %r14     
            st      %r20, %r14         !;push return value to stack
            ba mult_ret                !;return

A: 5
B: 11


fin:
    .end
