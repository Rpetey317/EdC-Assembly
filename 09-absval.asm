.begin
.org 2048

	!;register usage
	!;input -> output
	!;r1 	->	r3
	!;r2 	->	r4
	!;r14 -> stack pointer
	!;r8, r9, r10 -> auxiliary registers

	ld [A], %r1
	ld [B], %r2

	addcc %r14, -4, %r14 	!;move stack pointer
	st %r1, %r14			!;push r1 to stack

	call abs 				!;call abs on stack top (r1)
	
	ld %r14, %r3			!;load return value from abs to r3
	st %r2, %r14			!;push r2 to stack

	call abs 				!;call abs on stack top (r2)
	ld %r14, %r4			!;load return value on r4
	
	ba fin 					!;end program


!;subroutines
abs:	ld %r14, %r8 			!;load stack value to r8
		ld [NEG1], %r9			!;load constant -1 to r9
		xorcc %r8, %r9, %r10 	!;flip all bits from r8 and store on r10
		addcc %r10, 1, %r10 	!;add 1 to r10 (now is base-complement of r8)
		bpos pshval 			!;if positive, that is the absolute value, push it
		ba exit 				!;if not, the original was tha absolute value, 
								!;already on top of stack, return that
	
pshval:	st %r10, %r14 			!;push r10 to top of stack
		ba exit 				!;return that

exit:	jmpl %r15 + 4, %r0 	!; return

!;constants
NEG1: -1
A: 10
B: -10

fin:
	.end
