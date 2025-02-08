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

//data
	ldr r0, =__data_start__
	ldr r1, =__data_end__
	ldr r2, =__data_load__

.Lcopy:
	ldr r3, [r2]
	str r3, [r0]
	adds r0, r0, #4
	adds r2, r2, #4
	cmp r0, r1
	blt .Lcopy

//zero bss
	movs r0, #0
	ldr r1, =__bss_start__
	ldr r2, =__bss_end__

.Lzero:
	str r0, [r1]
	adds r1, r1, #4
	cmp r1, r2
	blt .Lzero

//enable interrupts
	cpsie i

//going to main
	ldr r0, =main
	blx r0

.Lexit:
	bkpt
	b .Lexit
