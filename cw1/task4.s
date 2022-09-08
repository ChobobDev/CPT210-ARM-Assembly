		;		implement a small program that parses a string stored in "my_number" into an integer (decimal number):
		;		"555" -> 555;
		;		The integer result should be stored in R8
		;		'5' in ASCII code is represented by 0x35, the example below is "555"
my_number	DCD		0x353535
		
		
		;		*** No negative numbers, my_number will be limited to 1 word long. ***
		adr		r0,my_number
		ldr		r1,[r0]
		
		and		r2,r1,#0xff ;the first digit
		sub		r2,r2,#0x30
		and		r3,r1,#0xff00
		lsr		r3,r3,#8 ;the second digit
		sub		r3,r3,#0x30
		and		r4,r1,#0xff0000
		lsr		r4,r4, #16 ;the third digit
		sub		r4,r4,#0x30
		and		r5,r1,#0xff000000
		lsr		r5,r5,#24 ;the fourth digit
		cmp		r5, #0x30
		movlt	r5,#0
		subge	r5,r5,#0x30
		
		mov		r8,r2 ;get the first digit
		mov		r6,#0
		
loop1	add		r8,r8,r3 ;loop for adding the tens place
		add		r6,r6,#1
		cmp		r6,#10
		bne		loop1
		
		mov		r6,#0
		
loop2	add		r8,r8,r4 ;loop for adding the hundred place
		add		r6,r6,#1
		cmp		r6,#100
		bne		loop2
		
		mov		r6,#0
		
loop3	add		r8,r8,r5 ;loop for adding thousands place
		add		r6,r6,#1
		cmp		r6,#1000
		bne		loop3
