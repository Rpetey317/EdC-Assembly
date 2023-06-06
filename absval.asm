.begin
.org 2048

	ld [A], %r1
	ld [B], %r2
	addcc %r14, -4, %r14
	st %r1, %r14
	call abs
	ld %r14, %r3
	st %r2, %r14
	call abs
	ld %r14, %r4
	ba fin



abs:	ld %r14, %r8
	ld [NEG1], %r9
	xorcc %r8, %r9, %r10
	addcc %r10, 1, %r10
	bpos pshval
	ba exit
	
pshval:	st %r10, %r14
	ba exit

exit:	jmpl %r15 + 4, %r0


NEG1: -1
A: 10
B: -10

fin:
	.end
