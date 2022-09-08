		;		Write a program that swaps 5th~11th bits in data_a with 25th~31th bits in data_b
		;		Your program must work for any data given, not just the example below
		;		In this question, we assmue that the positions of bits count from right to left.
		;		That is, the first bit is the least significant bit.
		
		;		**** The first bit is 0th bit (lest significant bit) ****
		
data_a	DCD		0x77FFD1D1
data_b	DCD		0x12345678
		
		
		adr		r0,data_a ;r0 will be the data_a
		adr		r1,data_b ;r1 will be the data_b
		
		mov		r3,#0b00000000000000000000111111100000
		mov		r4,#0b11111110000000000000000000000000
		
		ldr		r6,[r0]
		ldr		r7,[r1]
		
		;		extracting the data we need for swapping as instructed
		and		r8,r6,r3
		and		r9,r7,r4
		bic		r6,r6,r3
		bic		r7,r7,r4
		
		;		shifting the bits to the right place
		lsl		r8,r8, #20
		lsr		r9,r9, #20
		
		;		swaping bits bitwisely
		eor		r6,r6,r8
		eor		r7,r7,r9
		
		;		storing the values obtained in the memory
		str		r6,[r0]
		str		r7,[r1]
