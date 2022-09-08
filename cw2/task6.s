			;		We consider an array of strings stored in my_data.
			;		Each string ends with a "line feed" character (please search for it in the ASCII table online)
			;		The end of the whole array is signified by the "NULL" character (also mentioned in the ASCII table)
			
			;		Your task: replace all occurrences of "mug" that appear in the middle of a string with "cup".
			;		For example, "My beloved mug" and "Mug falls on the ground" should not be replaced,
			;		but "There's a mug on my desk" or "abcmugcba" should be replaced.
			;		The search should be case insensitive, meaning that "Mug", "mUg" and "MUG" should all be replaced with "cup" (lower case)
			
			;		The final result must be written back to my_data.
			;		You should also indicate how many strings does my_data contain in R8
			;		Failing to do so results in mark deduction
			
			;		In this current "my_data", it stores the two strings:
			;		M  y     b  e  l  o  v  e  d     m  u  g  LF a  b  c  m  u  g  c  b  a  LF NULL
			;		4d 79 20 62 65 6c 6f 76 65 64 20 6d 75 67 0A 61 62 63 6d 75 67 63 62 61 0A 00
			;		you program must work for any valid data created
my_data		DCD		0x4d792062, 0x656c6f76, 0x6564206d, 0x75670A61, 0x62636d75, 0x67636261, 0x0A000000
			
			adr		r12, my_data
			
			mov		r0, r12
			mov		r1, r12
			mov		r8, #1
			bl		reorder_hex
loop
			ldrb		r2, [r1]
			cmp		r2, #00 ;check if my_data is NULL
			beq		exit
			cmp		r1, r12 ;
			beq		skip
			
			ldrb		r2, [r1, #3]
			cmp		r2, #10 ;check the lf
			beq		lf_counter ;call lf counter
			
			ldrb		r2, [r1, #-1]
			cmp		r2, #10
			beq		skip
			
			ldrb		r2, [r1]
			cmp		r2, #109 ;check if its lower case m
			beq		letter_u
			cmp		r2, #77 ; check it its cappital m
			bne		skip ;if its not m or M , skip to the next part
			beq		letter_u ; if its M or m, check if next letter is U or u by calling function
			
			
letter_u
			ldrb		r2, [r1, #1]
			cmp		r2, #117 ;check if its lowercase u
			beq		letter_g ; if capital u move on to letter_g
			cmp		r2, #85 ;check if capital u
			bne		skip ;if not , this means the word is not mug, skip to next part
			beq		letter_g ;if its lower case u, proceed to letter_g
			
letter_g
			ldrb		r2, [r1, #2]
			cmp		r2, #103 ; check if the letter is lower case g
			beq		replace
			cmp		r2, #71 ; check again if the letter is upper case g
			bne		skip ; if both not g or G, the word is not mug so skip
			beq		replace ; if the letter is mug ( case insensitive) proceed to replace process
			
replace
			mov		r5, r1
			mov		r6, #99 ; change the letter to lowercase c
			strb		r6, [r5] ;save the change
			mov		r6, #117 ; change the letter to lowercase u
			strb		r6, [r5, #1] ; save the change
			mov		r6, #112 ; change the letter to locwercase p
			strb		r6, [r5, #2]  ;save the change
			add		r1, r1, #1
			b		loop
			
lf_counter
			add		r8, r8, #1
			add		r1,r1,#1
			b		loop
			
skip
			add		r1, r1, #1
			b		loop
			
reorder_hex
			ldrb		r3, [r0, #2]
			ldrb		r4, [r0, #1]
			strb		r3, [r0, #1]
			strb		r4, [r0, #2]
			ldrb		r3, [r0]
			ldrb		r4, [r0, #3]
			strb		r3, [r0, #3]
			strb		r4, [r0]
			add		r0, r0, #4
			cmp		r3, #0
			moveq	pc, lr
			cmp		r4, #0
			moveq	pc, lr
			b		reorder_hex
			
			
exit
			mov		r0, r12
			bl		reorder_hex
nop
