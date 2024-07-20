// Code generated by command: go run avo.go -out ../../asm_amd64.s -stubs ../../stubs_amd64.go -pkg vectorcmp --dispatcher-amd64 ../../dispatch_amd64.go --dispatcher-other ../../dispatch_other.go. DO NOT EDIT.

//go:build !purego

#include "textflag.h"

DATA constants<>+0(SB)/4, $0x55555555
DATA constants<>+4(SB)/4, $0x11111111
DATA constants<>+8(SB)/4, $0x01010101
GLOBL constants<>(SB), RODATA|NOPTR, $12

// func asmBulkEquals8(dstMask []byte, b uint8, rows []uint8)
// Requires: AVX, AVX2
TEXT ·asmBulkEquals8(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTB b+24(FP), Y0

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPEQB Y1, Y0, Y1
	VPCMPEQB Y2, Y0, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Write the registers to dstMask
	MOVL BX, (AX)
	MOVL SI, 4(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000008, AX

	// Decrement loop counter
	SUBQ $0x00000040, DX
	JNZ  loop
	RET

// func asmBulkGreaterThan8(dstMask []byte, b uint8, rows []uint8)
// Requires: AVX, AVX2
TEXT ·asmBulkGreaterThan8(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTB b+24(FP), Y0

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTB Y1, Y0, Y1
	VPCMPGTB Y2, Y0, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Write the registers to dstMask
	MOVL BX, (AX)
	MOVL SI, 4(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000008, AX

	// Decrement loop counter
	SUBQ $0x00000040, DX
	JNZ  loop
	RET

// func asmBulkLessThan8(dstMask []byte, b uint8, rows []uint8)
// Requires: AVX, AVX2
TEXT ·asmBulkLessThan8(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTB b+24(FP), Y0

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTB Y0, Y1, Y1
	VPCMPGTB Y0, Y2, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Write the registers to dstMask
	MOVL BX, (AX)
	MOVL SI, 4(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000008, AX

	// Decrement loop counter
	SUBQ $0x00000040, DX
	JNZ  loop
	RET

// func asmBulkGreaterEquals8(dstMask []byte, b uint8, rows []uint8)
// Requires: AVX, AVX2
TEXT ·asmBulkGreaterEquals8(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTB b+24(FP), Y0

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTB Y0, Y1, Y1
	VPCMPGTB Y0, Y2, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// To get GreaterEquals semantics, we flipped the arguments of VPCMPGT and now invert the result
	NOTL BX
	NOTL SI

	// Write the registers to dstMask
	MOVL BX, (AX)
	MOVL SI, 4(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000008, AX

	// Decrement loop counter
	SUBQ $0x00000040, DX
	JNZ  loop
	RET

// func asmBulkLesserEquals8(dstMask []byte, b uint8, rows []uint8)
// Requires: AVX, AVX2
TEXT ·asmBulkLesserEquals8(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTB b+24(FP), Y0

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTB Y1, Y0, Y1
	VPCMPGTB Y2, Y0, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// To get LesserEquals semantics, we flipped the arguments of VPCMPGT and now invert the result
	NOTL BX
	NOTL SI

	// Write the registers to dstMask
	MOVL BX, (AX)
	MOVL SI, 4(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000008, AX

	// Decrement loop counter
	SUBQ $0x00000040, DX
	JNZ  loop
	RET

// func asmBulkEquals16(dstMask []byte, b uint16, rows []uint16)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkEquals16(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTW b+24(FP), Y0

	// Load the mask 01010101... which we will use with PEXT to drop half the bits
	MOVL constants<>+0(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPEQW Y1, Y0, Y1
	VPCMPEQW Y2, Y0, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// Write the registers to dstMask
	MOVW BX, (AX)
	MOVW SI, 2(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000004, AX

	// Decrement loop counter
	SUBQ $0x00000020, DX
	JNZ  loop
	RET

// func asmBulkGreaterThan16(dstMask []byte, b uint16, rows []uint16)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkGreaterThan16(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTW b+24(FP), Y0

	// Load the mask 01010101... which we will use with PEXT to drop half the bits
	MOVL constants<>+0(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTW Y1, Y0, Y1
	VPCMPGTW Y2, Y0, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// Write the registers to dstMask
	MOVW BX, (AX)
	MOVW SI, 2(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000004, AX

	// Decrement loop counter
	SUBQ $0x00000020, DX
	JNZ  loop
	RET

// func asmBulkLessThan16(dstMask []byte, b uint16, rows []uint16)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkLessThan16(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTW b+24(FP), Y0

	// Load the mask 01010101... which we will use with PEXT to drop half the bits
	MOVL constants<>+0(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTW Y0, Y1, Y1
	VPCMPGTW Y0, Y2, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// Write the registers to dstMask
	MOVW BX, (AX)
	MOVW SI, 2(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000004, AX

	// Decrement loop counter
	SUBQ $0x00000020, DX
	JNZ  loop
	RET

// func asmBulkGreaterEquals16(dstMask []byte, b uint16, rows []uint16)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkGreaterEquals16(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTW b+24(FP), Y0

	// Load the mask 01010101... which we will use with PEXT to drop half the bits
	MOVL constants<>+0(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTW Y0, Y1, Y1
	VPCMPGTW Y0, Y2, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// To get GreaterEquals semantics, we flipped the arguments of VPCMPGT and now invert the result
	NOTW BX
	NOTW SI

	// Write the registers to dstMask
	MOVW BX, (AX)
	MOVW SI, 2(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000004, AX

	// Decrement loop counter
	SUBQ $0x00000020, DX
	JNZ  loop
	RET

// func asmBulkLesserEquals16(dstMask []byte, b uint16, rows []uint16)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkLesserEquals16(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTW b+24(FP), Y0

	// Load the mask 01010101... which we will use with PEXT to drop half the bits
	MOVL constants<>+0(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTW Y1, Y0, Y1
	VPCMPGTW Y2, Y0, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// To get LesserEquals semantics, we flipped the arguments of VPCMPGT and now invert the result
	NOTW BX
	NOTW SI

	// Write the registers to dstMask
	MOVW BX, (AX)
	MOVW SI, 2(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000004, AX

	// Decrement loop counter
	SUBQ $0x00000020, DX
	JNZ  loop
	RET

// func asmBulkEquals32(dstMask []byte, b uint32, rows []uint32)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkEquals32(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTD b+24(FP), Y0

	// Load the mask 00010001... which we will use with PEXT to drop 75% of the bits
	MOVL constants<>+4(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPEQD Y1, Y0, Y1
	VPCMPEQD Y2, Y0, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second-fourth bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// Write the registers to dstMask
	MOVB BL, (AX)
	MOVB SI, 1(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000002, AX

	// Decrement loop counter
	SUBQ $0x00000010, DX
	JNZ  loop
	RET

// func asmBulkGreaterThan32(dstMask []byte, b uint32, rows []uint32)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkGreaterThan32(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTD b+24(FP), Y0

	// Load the mask 00010001... which we will use with PEXT to drop 75% of the bits
	MOVL constants<>+4(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTD Y1, Y0, Y1
	VPCMPGTD Y2, Y0, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second-fourth bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// Write the registers to dstMask
	MOVB BL, (AX)
	MOVB SI, 1(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000002, AX

	// Decrement loop counter
	SUBQ $0x00000010, DX
	JNZ  loop
	RET

// func asmBulkLessThan32(dstMask []byte, b uint32, rows []uint32)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkLessThan32(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTD b+24(FP), Y0

	// Load the mask 00010001... which we will use with PEXT to drop 75% of the bits
	MOVL constants<>+4(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTD Y0, Y1, Y1
	VPCMPGTD Y0, Y2, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second-fourth bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// Write the registers to dstMask
	MOVB BL, (AX)
	MOVB SI, 1(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000002, AX

	// Decrement loop counter
	SUBQ $0x00000010, DX
	JNZ  loop
	RET

// func asmBulkGreaterEquals32(dstMask []byte, b uint32, rows []uint32)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkGreaterEquals32(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTD b+24(FP), Y0

	// Load the mask 00010001... which we will use with PEXT to drop 75% of the bits
	MOVL constants<>+4(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTD Y0, Y1, Y1
	VPCMPGTD Y0, Y2, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second-fourth bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// To get GreaterEquals semantics, we flipped the arguments of VPCMPGT and now invert the result
	NOTB BL
	NOTB SI

	// Write the registers to dstMask
	MOVB BL, (AX)
	MOVB SI, 1(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000002, AX

	// Decrement loop counter
	SUBQ $0x00000010, DX
	JNZ  loop
	RET

// func asmBulkLesserEquals32(dstMask []byte, b uint32, rows []uint32)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkLesserEquals32(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTD b+24(FP), Y0

	// Load the mask 00010001... which we will use with PEXT to drop 75% of the bits
	MOVL constants<>+4(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTD Y1, Y0, Y1
	VPCMPGTD Y2, Y0, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second-fourth bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// To get LesserEquals semantics, we flipped the arguments of VPCMPGT and now invert the result
	NOTB BL
	NOTB SI

	// Write the registers to dstMask
	MOVB BL, (AX)
	MOVB SI, 1(AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000002, AX

	// Decrement loop counter
	SUBQ $0x00000010, DX
	JNZ  loop
	RET

// func asmBulkEquals64(dstMask []byte, b uint64, rows []uint64)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkEquals64(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTQ b+24(FP), Y0

	// Load the mask 00000001... which we will use with PEXT to drop 7/8th of the bits
	MOVL constants<>+8(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPEQQ Y1, Y0, Y1
	VPCMPEQQ Y2, Y0, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second-seventh bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// Write the registers to dstMask
	// Each register contains 4 bytes, so we first combine pairs before writing them back
	SHLB $0x04, SI
	ORB  SI, BL
	MOVB BL, (AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000001, AX

	// Decrement loop counter
	SUBQ $0x00000008, DX
	JNZ  loop
	RET

// func asmBulkGreaterThan64(dstMask []byte, b uint64, rows []uint64)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkGreaterThan64(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTQ b+24(FP), Y0

	// Load the mask 00000001... which we will use with PEXT to drop 7/8th of the bits
	MOVL constants<>+8(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTQ Y1, Y0, Y1
	VPCMPGTQ Y2, Y0, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second-seventh bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// Write the registers to dstMask
	// Each register contains 4 bytes, so we first combine pairs before writing them back
	SHLB $0x04, SI
	ORB  SI, BL
	MOVB BL, (AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000001, AX

	// Decrement loop counter
	SUBQ $0x00000008, DX
	JNZ  loop
	RET

// func asmBulkLessThan64(dstMask []byte, b uint64, rows []uint64)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkLessThan64(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTQ b+24(FP), Y0

	// Load the mask 00000001... which we will use with PEXT to drop 7/8th of the bits
	MOVL constants<>+8(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTQ Y0, Y1, Y1
	VPCMPGTQ Y0, Y2, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second-seventh bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// Write the registers to dstMask
	// Each register contains 4 bytes, so we first combine pairs before writing them back
	SHLB $0x04, SI
	ORB  SI, BL
	MOVB BL, (AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000001, AX

	// Decrement loop counter
	SUBQ $0x00000008, DX
	JNZ  loop
	RET

// func asmBulkGreaterEquals64(dstMask []byte, b uint64, rows []uint64)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkGreaterEquals64(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTQ b+24(FP), Y0

	// Load the mask 00000001... which we will use with PEXT to drop 7/8th of the bits
	MOVL constants<>+8(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTQ Y0, Y1, Y1
	VPCMPGTQ Y0, Y2, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second-seventh bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// To get GreaterEquals semantics, we flipped the arguments of VPCMPGT and now invert the result
	// Write the registers to dstMask
	// Each register contains 4 bytes, so we first combine pairs before writing them back
	SHLB $0x04, SI
	ORB  SI, BL
	NOTB BL
	MOVB BL, (AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000001, AX

	// Decrement loop counter
	SUBQ $0x00000008, DX
	JNZ  loop
	RET

// func asmBulkLesserEquals64(dstMask []byte, b uint64, rows []uint64)
// Requires: AVX, AVX2, BMI2
TEXT ·asmBulkLesserEquals64(SB), NOSPLIT, $0-56
	MOVQ dstMask_base+0(FP), AX
	MOVQ rows_base+32(FP), CX
	MOVQ rows_len+40(FP), DX

	// Read param b into YMM register. If b is 0x07, YMM becomes {0x07, 0x07, 0x07...}
	VPBROADCASTQ b+24(FP), Y0

	// Load the mask 00000001... which we will use with PEXT to drop 7/8th of the bits
	MOVL constants<>+8(SB), DI

loop:
	// Load 2 256-bit chunks into YMM registers
	VMOVDQU (CX), Y1
	VMOVDQU 32(CX), Y2

	// Compare all bytes in each YMM register to b. Each byte in the YMMs becomes 0x00 (mismatch) or 0xff (match)
	VPCMPGTQ Y1, Y0, Y1
	VPCMPGTQ Y2, Y0, Y2

	// Take one bit of each byte and pack it into an R32
	VPMOVMSKB Y1, BX
	VPMOVMSKB Y2, SI

	// Drop every second-seventh bit from these registers
	PEXTL DI, BX, BX
	PEXTL DI, SI, SI

	// To get LesserEquals semantics, we flipped the arguments of VPCMPGT and now invert the result
	// Write the registers to dstMask
	// Each register contains 4 bytes, so we first combine pairs before writing them back
	SHLB $0x04, SI
	ORB  SI, BL
	NOTB BL
	MOVB BL, (AX)

	// Update our offsets into rows and dstMask
	ADDQ $0x00000040, CX
	ADDQ $0x00000001, AX

	// Decrement loop counter
	SUBQ $0x00000008, DX
	JNZ  loop
	RET
