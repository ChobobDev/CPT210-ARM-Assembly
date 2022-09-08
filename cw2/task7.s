				;		Assume that there are two IEEE-754 single precision floating point numbers stored in my_data.
				;		Calculate the sum of these two numbers and store it in R8
				;		Your program's results should be same as/similar to what happens in real C/Java programs.
				
				;		Suggestion: write functions that can extract the sign bit, mantissa and exponent
				
				;		numbers will not lead to overflow. Your program does not need to consider overflow..
my_data			DCD		0xC0350000, 0x40310000
				
				adr		r12,my_data
				mov		r11,r12
				ldr		r1,[r11]
				add		r11,r11,#4
				ldr		r2,[r11]
				
addfloat
				ldr		r9, =0x7f800000
				and		r3, r1, r9               ; get the first number's exponent from the string
				and		r4, r2, r9               ; get the second number's exponent from the string
				cmp		r3, r4
				
				movcc	r10, r1
				movcc	r1, r2
				movcc	r2, r10                  ; if r2 has the higher exponent swap r1 and r2 for easier calculation
				andcc	r4, r1, r9
				andcc	r5, r2, r9               ; update exponents if swapped to each registers
				
				mov		r3, r3, lsr #23 		; exponents to least significant position
				mov		r4, r4, lsr #23          ; exponents to least significant position
				
				sub		r10, r3, r4              ; calculate the shifted exponents
				ldr		r9, =0x007fffff
				and		r5, r1, r9               ; grab mantissa of first number
				and		r6, r2, r9               ; grab mantissa of second number
				ldr		r9, =0x00800000
				orr		r5, r5, r9               ; add 1 to first fractional part
				orr		r6, r6, r9               ; add 1 to second fractional part
				mov		r6, r6, lsr r10          ; shift r6 to the right as much as the exponent difference
				
				ldr		r9, =0x80000000
				ands		r0, r1, r9               ; check msb to check if its a negative number
				movne	r0, r5                   ; if negative copy the value in r5 to r0
				stmfdne	sp!, {lr}				; save the current position to come back after function
				blne		twos_complement          ; apply two's complement
				ldmfdne	sp!, {lr}				; load the position
				movne	r5, r0				; move the inveted value back to r5
				
				ands		r0, r2, r9               ; check msb to check if a negative number
				movne	r0, r6				; if negative copy the value into r0
				stmfdne	sp!, {lr}				; save the current position to come back after function
				blne		twos_complement          ; two's complement fractional second number if it's supposed to be negative
				ldmfdne	sp!, {lr}				; load the position
				movne	r6, r0				; move the inverted value back into r6
				
				add		r5, r5, r6               ; add two mantissa, save it into r5.
				
				ands		r0, r5, r9               ; check msb to see if the result is negative
				movne	r0, r5				; if negative, copy the value of r5 into r0
				stmfdne	sp!, {lr}				; save the current position to come back after function
				blne		twos_complement          ; two's complement result if negative
				ldmfdne	sp!, {lr}				; load the position
				movne	r5, r0				; copy the ro to r5
				
				ldrne	r0, =0x80000000          ; put a 1 as msb for result if negative
				moveq	r0, #0                   ; put a 0 as msb for result if positive
				
				mov		r10, #0
				ldr		r9, =0x80000000
				bl		final_step        		; merge the results together
				mov		r8,r0 				;copy the value of r0 to r8 as instructed
				b		exit
				
				
final_step
				cmp		r9, r5
				addhi	r10, r10, #1
				movhi	r9, r9, lsr #1
				bhi		final_step       		; count how many times you have to shift before hitting a 1 in the result
				
				cmp		r10, #8                  ; if it's shifted 8 times it's already in the right place
				subhi	r10, r10, #8            	;  count the numbers of shift needed on left direction
				movhi	r5, r5, lsl r10        	; shift as needed
				subhi	r4, r4, r10            	; subtract shift amount from exponent to unshift
				movcc	r9, #8
				subcc	r10, r9, r10           	; count the numbers of shift needed on right direction
				movcc	r5, r5, lsr r10        	; shift if needed
				addcc	r4, r4, r10            	; add shift amount to exponent to unshift the value
				
				mov		r4, r4, lsl #23         	; shift exponent into place
				orr		r0, r0, r4              	; if shifted, exponent into number
				ldr		r9, =0x007fffff
				and		r5, r5, r9             	; get rid of implied 1 in mantissa
				orr		r0, r0, r5             	; attach mantissa part
				
				mov		pc, lr
				
twos_complement								; invert the numbers
				mvn		r0, r0                  	; negate r0
				add		r0, r0, #1              	; add 1
				mOV		pc, lr                  	; Return to caller
exit
