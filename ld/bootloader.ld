/*
 * bootloader.ld -- bootloader link
 */


MEMORY {
	ROM   (RX)  : ORIGIN = 0x00000000, LENGTH = 16K
	FLASH (RX)  : ORIGIN = 0x10000000, LENGTH = 2048K
	SRAM  (RWX) : ORIGIN = 0x20000000, LENGTH = 256K
	SRAM4 (RWX) : ORIGIN = 0x20040000, LENGTH = 4K
	SRAM5 (RWX) : ORIGIN = 0x20041000, LENGTH = 4K
}

HIDDEN(stage2_size = 256);
HIDDEN(stage2_lma  = ORIGIN(FLASH));
HIDDEN(vectors_lma = stage2_lma + stage2_size);

HIDDEN(vector_align = 256);
HIDDEN(word_align   = 4);

ENTRY(_start)

SECTIONS {
	.stage2 (READONLY) : {
		KEEP(*(.stage2))
	} > FLASH

	.rodata._vectors (READONLY) : ALIGN(vector_align) {
		KEEP(*(.rodata._vectors))
	} > FLASH

	.text (READONLY) : ALIGN(word_align) {
		*(.text*)
	} > FLASH

	.rodata (READONLY) : ALIGN(word_align) {
		*(.rodata*)
	} > FLASH

	.data : ALIGN(word_align) {
		__data_start__ = .;
		*(.data*)
		. = ALIGN(word_align);
		__data_end__ = .;
	} > SRAM AT> FLASH

	__data_load__ = LOADADDR(.data);

	.bss (NOLOAD) : ALIGN(word_align) {
		__bss_start__ = .;
		*(.bss*)
		. = ALIGN(word_align);
		__bss_end__ = .;
	} > SRAM

	.stack0 (NOLOAD) : ALIGN(word_align) {
		__stack4_start__ = .;
		. += LENGTH(SRAM4);
		. = ALIGN(word_align);
		__stack4_end__ = .;

	} > SRAM4

	.stack1 (NOLOAD) : ALIGN(word_align) {
		__stack5_start__ = .;	
		. += LENGTH(SRAM5);
		. = ALIGN(word_align);
		__stack5_end__ = .;
	} > SRAM5

	.copy : ALIGN(word_align) {
		__copy_start__ = .;
		LONG(ADDR(.data))
		LONG(LOADADDR(.data))
		LONG(ADDR(.data) + SIZEOF(.data))
		__copy_end__ = .;
	} > FLASH

	.zero : ALIGN(word_align) {
		__zero_start__ = .;
		LONG(ADDR(.bss))
		LONG(ADDR(.bss) + SIZEOF(.bss))
		LONG(ADDR(.stack0))
		LONG(ADDR(.stack1) + SIZEOF(.stack1))
		__zero_end__ = .;
	} > FLASH
}

__msp0_init__  = ORIGIN(SRAM4) + LENGTH(SRAM4);
__msp0_limit__ = ORIGIN(SRAM4);
__msp1_init__  = ORIGIN(SRAM5) + LENGTH(SRAM5);
__msp1_limit__ = ORIGIN(SRAM5);

/* TODO: make sure this assertion passes */
/* ASSERT(SIZEOF(.unmapped) == 0, "SIZEOF(.unmapped) != 0") */

ASSERT(SIZEOF(.stage2) == stage2_size, "SIZEOF(.stage2) != stage2_size")
ASSERT(LOADADDR(.stage2) == stage2_lma, "LOADADDR(.stage2) != stage2_lma")
ASSERT(ALIGNOF(.rodata._vectors) == vector_align, "ALIGNOF(.rodata._vectors) == vector_align")
ASSERT(LOADADDR(.rodata._vectors) == vectors_lma, "LOADADDR(.rodata._vectors) == vectors_lma")
