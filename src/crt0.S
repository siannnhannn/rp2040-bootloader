/*
 * crt0.S -- c runtime
 */

	.syntax unified

	.arch armv6s-m
	.cpu  cortex-m0plus

	.text

	.section .text._start, "ax", %progbits

	.type   _start, %function
	.global _start
_start:
	b _start
