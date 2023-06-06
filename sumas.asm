!;Ej 6 - guia 5

.begin
.org 2048

!;Main

	ld [X], %r1
	ld [Y], %r2
	call SUM_1
	st %r3, [RESULT]

	st %r1, [ARR]
	st %r2, [ARR + 4]
	sethi ARR, %r5
	srl %r5, 10, %r5
	call SUM_2
	ld [ARR + 8], %r3
	st %r3, [RESULT+4]

	addcc %r14, -4, %r14
	st %r1, %r14
	addcc %r14, -4, %r14
	st %r2, %r14
	call SUM_3
	ld %r14, %r3
	st %r3, [RESULT+8]
	
	ld [RESULT], %r29
	ld [RESULT+4], %r30
	ld [RESULT+8], %r31


X: 84
Y: 233
ARR: .dwb 3
RESULT: .dwb 3


				!;Suma, param. pasados por registros
				!;%r3 := %r1 + %r2
SUM_1:	addcc %r1, %r2, %r3
	jmpl %r15 + 4, %r0


				!;Suma, param. pasados por stack
				!;ARR[2] := ARR[0] + ARR[1]
SUM_2:	ld %r5, %r8
	ld %r5 + 4, %r9
	addcc %r8, %r9, %r10
	st %r10, %r5 + 8
	jmpl %r15 + 4, %r0


				!;Suma, param. pasados por stack		
SUM_3:	ld %r14, %r10              
	addcc %r14, 4, %r14        
	ld %r14, %r11
	addcc %r14, 4, %r14               
	addcc %r10, %r11, %r12
	addcc %r14, -4, %r14
	st %r12, %r14
	jmpl %r15, 4, %r0  

.end

