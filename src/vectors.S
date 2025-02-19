// SPDX-License-Identifier: MPL-2.0
/*
 * vectors.S -- vector table
 * Copyright (C) 2024--2025  Jacob Koziej <jacobkoziej@gmail.com>
 */

	.arch armv6s-m
	.cpu  cortex-m0plus

	.section .rodata, "a", %progbits

	.section .rodata._vectors, "a", %progbits

	.type   _vectors, %object
	.global _vectors
_vectors:
	.word __stack0_init__
	.word _start
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default
	.word handler_default

	.text

	.section .text.handler_default, "ax", %progbits

	.type handler_default, %function
handler_default:
	mrs r0, ipsr
1:
	bkpt
	b 1b

	bx lr
