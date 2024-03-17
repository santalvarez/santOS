#include <armv7a.h>

	.text
	.globl	disable
	.globl	restore
	.globl	enable
	.globl	pause
	.globl	halt

/*------------------------------------------------------------------------
 * disable  -  Disable interrupts and return the previous state
 *------------------------------------------------------------------------
 */
disable:
	mrs	r0, cpsr	/* Copy the CPSR into r0		*/
	cpsid	i		/* Disable interrupts			*/
	mov	pc, lr		/* Return the CPSR			*/

/*------------------------------------------------------------------------
 * restore  -  Restore interrupts to value given by mask argument
 *------------------------------------------------------------------------
 */
restore:
	push	{r1, r2}	/* Save r1, r2 on stack			*/
	mrs	r1, cpsr	/* Copy CPSR into r1			*/
	ldr	r2, =0x01F00220
	and	r1, r1, r2	/* Extract flags and other important	*/
	bic	r0, r0, r2	/*    bits from the mask		*/
	orr	r1, r1, r0
	msr	cpsr_cfsx, r1	/* Restore the CPSR			*/
	pop	{r1, r2}	/* Restore r1, r2			*/
	mov	pc, lr		/* Return to caller			*/

/*------------------------------------------------------------------------
 * enable  -  Enable interrupts
 *------------------------------------------------------------------------
 */
enable:
	cpsie	i		/* Enable interrupts			*/
	mov	pc, lr		/* Return				*/

/*------------------------------------------------------------------------
 * pause or halt  -  Place the processor in a hard loop
 *------------------------------------------------------------------------
 */
halt:
pause:
	cpsid	i		/* Disable interrupts		*/

dloop:	b	dloop		/* Dead loop			*/

