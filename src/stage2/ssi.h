// SPDX-License-Identifier: MPL-2.0
/*
 * ssi.h -- rp2040 SSI
 * Copyright (C) 2024  Jacob Koziej <jacobkoziej@gmail.com>
 */

#ifndef STAGE2_SSI
#define STAGE2_SSI

// 4.10.13
#define SSI_BASE 0x18000000

#define SSI_CTRLR0_OFFSET        0x00
#define SSI_CTRLR1_OFFSET        0x04
#define SSI_SSIENR_OFFSET        0x08
#define SSI_BAUDR_OFFSET         0x14
#define SSI_SR_OFFSET            0x28
#define SSI_DR0_OFFSET           0x60
#define SSI_RX_SAMPLE_DLY_OFFSET 0xf0
#define SSI_SPI_CTRLR0_OFFSET    0xf4

#define SSI_CTRLR0_SPI_FRF_SHIFT 21
#define SSI_CTRLR0_DFS_32_SHIFT  16
#define SSI_CTRLR0_TMOD_SHIFT    8

#define SSI_CTRLR0_SPI_FRF_STANDARD 0
#define SSI_CTRLR0_SPI_FRF_DUAL_SPI 1
#define SSI_CTRLR0_SPI_FRF_QUAD_SPI 2

#define SSI_CTRLR0_TMOD_TX_RX   0
#define SSI_CTRLR0_TMOD_TX_ONLY 1
#define SSI_CTRLR0_TMOD_RX_ONLY 2
#define SSI_CTRLR0_TMOD_EEPROM  3

#define SSI_SR_TFE_SHIFT  2
#define SSI_SR_BUSY_SHIFT 0

#define SSI_SPI_CTRLR0_XIP_CMD_SHIFT     24
#define SSI_SPI_CTRLR0_WAIT_CYCLES_SHIFT 11
#define SSI_SPI_CTRLR0_INST_L_SHIFT      8
#define SSI_SPI_CTRLR0_ADDR_L_SHIFT      2
#define SSI_SPI_CTRLR0_TRANS_TYPE_SHIFT  0

#define SSI_SPI_CTRLR0_INST_L_NO_INSTRUCTION     0
#define SSI_SPI_CTRLR0_INST_L_8_BIT_INSTRUCTION  2

#define SSI_SPI_CTRLR0_TRANS_TYPE_FRF_ADDRESS 1
#define SSI_SPI_CTRLR0_TRANS_TYPE_FRF         2

#endif // STAGE2_SSI
