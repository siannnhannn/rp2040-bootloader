/*
 * crt0.S -- c runtime
 */

#define VTOR 0xE000ED08

	.syntax unified

	.arch armv6s-m
	.cpu  cortex-m0plus

	.text

	.section .text._start, "ax", %progbits

	.type   _start, %function
	.global _start
_start:
//disable interrupts
	cpsid i

//initialize vector table
	ldr r0, =VTOR
	ldr r1, =_vectors
	str r1, [r0]
	dsb
	isb

//set msp
	ldr r1, [r1]
	msr msp, r1

//copy table
	ldr r0, =__copy_start__
	ldr r1, =__copy_end__

.Lcopy_loop:
	ldmia r0!, {r2-r4}

.Lcopy:
	ldmia r3!, {r6}
	stmia r2!, {r6}
	cmp r2, r4
	blt .Lcopy
	cmp r0, r1
	blt .Lcopy_loop

//zero table
	ldr r0, =__zero_start__
	ldr r1, =__zero_end__
	movs r2, #0

.Lzero_loop:
	ldmia r0!, {r3, r4}

.Lzero:
	stmia r3!, {r2}
	cmp r3, r4
	blt .Lzero
	cmp r0, r1
	blt .Lzero_loop

//enable interrupts
	cpsie i

//main
	ldr r0, =main
	blx r0

.Lexit:
	bkpt
	b .Lexit
