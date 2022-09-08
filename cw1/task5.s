		;		In this task, we will implement the repeated subtraction method of square roots
		
		;		The method relies on the following sequence of steps:
		;		Step 1: Subtract consecutive odd numbers from the number for which we are finding the square root.
		;		Step 2: Repeat step 1 until a value of 0 is attained.
		;		Step 3: The number of times step 1 is repeated is the required square root of the given number.
		
		;		For instance, for the number 16, the method works as follows:
		;		16 – 1 = 15
		;		15 – 3 = 12
		;		12 – 5 = 7
		;		7 - 7 = 0
		;		The process is repeated 4 times. Thus,√16 = 4.
		
		;		Note that this method can be used only for perfect squares. (like 9, 16, 25 etc.)
		;		As a result, your work will be evaluated based on perfect squares only.
		
		;		The register r7 stores a number that we want to find the square root of.
		;		The result of the square root should be stored in r8.
		
		mov		r7, #16
		mov		r8,#0 ;register for storing repetion
		mov		r1,#1 ;first odd number
loop		sub		r7,r7,r1 ;subtract odd number , loop this
		add		r1,r1,#2 ; add 2 to get next odd number
		add		r8,r8,#1 ; add 1 to the repetition
		cmp		r7,#0 ; compare if the value is 0
		bne		loop
