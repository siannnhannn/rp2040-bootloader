/* SPDX-License-Identifier: MPL-2.0 */
/*
 * stage2.ld -- second stage flash boot
 * Copyright (C) 2024--2025  Jacob Koziej <jacobkoziej@gmail.com>
 */

MEMORY {
	ROM   (RX)  : ORIGIN = 0x00000000, LENGTH = 16K
	FLASH (RX)  : ORIGIN = 0x10000000, LENGTH = 252
	SRAM  (RWX) : ORIGIN = 0x20000000, LENGTH = 256K
	SRAM4 (RWX) : ORIGIN = 0x20040000, LENGTH = 4K
	SRAM5 (RWX) : ORIGIN = 0x20041f00, LENGTH = 252
}

HIDDEN(word_align = 4);

ENTRY(_start)

SECTIONS {
	.text (READONLY) : ALIGN(word_align) {
		*(.text*)
	} > SRAM5 AT> FLASH

	.ARM.exidx (READONLY) : ALIGN(word_align) {
		*(.ARM.exidx*)
	} > SRAM5 AT> FLASH

	.rodata (READONLY) : ALIGN(word_align) {
		*(.rodata*)
	} > SRAM5 AT> FLASH

	.data : ALIGN(word_align) {
		*(.data*)
	} > SRAM5 AT> FLASH

	.bss (NOLOAD) : ALIGN(word_align) {
		*(.bss*)
	} > SRAM5

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
