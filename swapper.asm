	.begin
	.org 2048
	ld [A], %r1
	st %r1, [C]	
	ld [B], %r1
	st %r1, [A]
	ld [C], %r1
	st %r1, [B]

A: 10
B: 20
C:

.end
	
