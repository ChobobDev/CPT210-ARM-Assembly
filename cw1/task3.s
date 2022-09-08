		;		given two arrays of 5 numbers stored in data_a and data_b.
		;		write a program that zips these two arrays and store the result in data_c.
		
		;		Zip means the first element of data_a is appended to data_c first,
		;		then followed by the first element of data_b,
		;		then followed by the second element of data_a,
		;		then followed by the second element of data_b
		;		... until all numbers are added into data_c
		
		;		In the example below, the result in data_c should be
		;		11, 21, 12, 22, 13, 23, 14, 24, 15, 25
		
data_a	DCD		11, 12, 13, 14, 15
data_b	DCD		21, 22, 23, 24, 25
data_c	FILL		40
		
		adr		r0, data_a ;r0 will be data_a
		adr		r1, data_b ;r1 will be data_b
		adr		r2,data_c
		mov		r3,#0 ;r3 as a flag for the looping
loop		ldr		r4,[r0],#4 ;get the element of data_a
		ldr		r5,[r1],#4 ;get the element of data_b
		str		r4,[r2],#4 ;save the element of data_a to data_c
		str		r5,[r2],#4 ;save the element of data_b to data_c
		add		r3,r3,#1 ;increase the flag
		cmp		r3,#5 ;compate the flag if the loop has reached the last element
		bne		loop
