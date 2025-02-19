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
		*(.data*)
		. = ALIGN(word_align);
	} > SRAM AT> FLASH

	.bss (NOLOAD) : ALIGN(word_align) {
		*(.bss*)
		. = ALIGN(word_align);
	} > SRAM

	.stack0 (NOLOAD) : ALIGN(word_align) {
		__stack0_limit__ = .;
		. += LENGTH(SRAM4);
		. = ALIGN(word_align);
		__stack0_init__ = .;

	} > SRAM4

	.stack1 (NOLOAD) : ALIGN(word_align) {
		__stack1_limit__ = .;	
		. += LENGTH(SRAM5);
		. = ALIGN(word_align);
		__stack1_init__ = .;
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
		LONG(ADDR(.stack0) + SIZEOF(.stack0))
		LONG(ADDR(.stack1))
		LONG(ADDR(.stack1) + SIZEOF(.stack1))
		__zero_end__ = .;
	} > FLASH

	.ARM.attributes 0 : { *(.ARM.attributes) }
	.comment        0 : { *(.comment)        }
	.debug_abbrev   0 : { *(.debug_abbrev)   }
	.debug_aranges  0 : { *(.debug_aranges)  }
	.debug_frame    0 : { *(.debug_frame)    }
	.debug_info     0 : { *(.debug_info)     }
	.debug_line     0 : { *(.debug_line)     }
	.debug_line_str 0 : { *(.debug_line_str) }
	.debug_loclists 0 : { *(.debug_loclists) }
	.debug_rnglists 0 : { *(.debug_rnglists) }
	.debug_str      0 : { *(.debug_str)      }
	.shstrtab       0 : { *(.shstrtab)       }
	.strtab         0 : { *(.strtab)         }
	.symtab         0 : { *(.symtab)         }

	.unmapped 0 : { *(*) }
}

ASSERT(SIZEOF(.unmapped) == 0, "SIZEOF(.unmapped) != 0")
ASSERT(SIZEOF(.stage2) == stage2_size, "SIZEOF(.stage2) != stage2_size")
ASSERT(LOADADDR(.stage2) == stage2_lma, "LOADADDR(.stage2) != stage2_lma")
ASSERT(ALIGNOF(.rodata._vectors) == vector_align, "ALIGNOF(.rodata._vectors) == vector_align")
ASSERT(LOADADDR(.rodata._vectors) == vectors_lma, "LOADADDR(.rodata._vectors) == vectors_lma")
