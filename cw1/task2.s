			;		Write a program that finds the minimum value stored in my_numbers
			;		Each number occupies 1 word in the memory.
			;		Assume there are always 5 elements in my_numbers
			;		The result must be stored in R8
my_numbers	DCD		0x77, 0x6, 0x5A, 0xFFFFFFFF, 0xF000001A
			
			
			;		*** Numbers are signed ***
res1			fill		4
res2			fill		4
			adr		r9, my_numbers
			
			mov		r0, r9		; r0 will be the first number's address
			add		r1, r0, #28	; r1 will be the last number's address
			ldr		r8, [r0]		; get the first element, r8 will be the smallest value so far
loop1
			add		r0, r0, #4	; point r0 to the next number;
			
			;		if r0 exceeds the last address
			cmp		r0, r1
			bgt		exit1		;     we will stop.
			
			;		else, check next number and repeat
			ldr		r6, [r0]  	; get the next number
			cmp		r8, r6		; compare against smallest
			
			;		if smallest (r8) is smaller than current (r6), next loop
			blt		loop1
			;		else, update the smallest (r8), then next loop
			mov		r8, r6
			b		loop1
			
exit1
			adr		r0, res1
			str		r8, [r0]
