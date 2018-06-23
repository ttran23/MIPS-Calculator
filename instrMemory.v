`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2016 12:42:46 PM
// Design Name: 
// Module Name: instrMemory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instrMemory(readAddr, Instruction);

    input [31:0] readAddr = 0;
    reg [31:0] memory [0:1023];
    output reg [31:0] Instruction;
    
    initial 
    begin
    //$readmemh("Instruction_memory.txt", memory);
//        memory[0] = 32'b00100000000100000000000000000001;// ->	main:	addi	$s0, $zero, 1
//        memory[1] = 32'b00100000000100010000000000000001;// ->          addi    $s1, $zero, 1
//        memory[2] = 32'b00000010000100011000000000100100;// ->          and     $s0, $s0, $s1
//        memory[3] = 32'b00000010000000001000000000100100;// ->          and     $s0, $s0, $zero
//        memory[4] = 32'b00000010001100001000000000100010;// ->          sub     $s0, $s1, $s0
//        memory[5] = 32'b00000010000000001000000000100111;// ->          nor     $s0, $s0, $zero
//        memory[6] = 32'b00000010000000001000000000100111;// ->          nor     $s0, $s0, $zero
//        memory[7] = 32'b00000000000000001000000000100101;// ->          or      $s0, $zero, $zero
//        memory[8] = 32'b00000010001000001000000000100101;// ->          or      $s0, $s1, $zero
//        memory[9] = 32'b00000000000100001000000010000000;// ->          sll     $s0, $s0, 2
//        memory[10] = 32'b00000010001100001000000000000100;// ->         sllv    $s0, $s0, $s1
//        memory[11] = 32'b00000010000000001000000000101010;// ->         slt     $s0, $s0, $zero
//        memory[12] = 32'b00000010000100011000000000101010;// ->         slt     $s0, $s0, $s1
//        memory[13] = 32'b00000000000100011000000001000011;// ->         sra     $s0, $s1, 1
//        memory[14] = 32'b00000000000100011000000000000111;// ->         srav    $s0, $s1, $zero
//        memory[15] = 32'b00000000000100011000000001000010;// ->         srl     $s0, $s1, 1
//        memory[16] = 32'b00000000000100011000000011000000;// ->         sll     $s0, $s1, 3
//        memory[17] = 32'b00000000000100001000000011000010;// ->         srl     $s0, $s0, 3
//        memory[18] = 32'b00000010001100001000000000000100;// ->         sllv    $s0, $s0, $s1
//        memory[19] = 32'b00000010001100001000000000000110;// ->         srlv    $s0, $s0, $s1
//        memory[20] = 32'b00000010000100011000000000100110;// ->         xor     $s0, $s0, $s1
//        memory[21] = 32'b00000010000100011000000000100110;// ->         xor     $s0, $s0, $s1
//        memory[22] = 32'b00100000000100100000000000000100;// ->         addi    $s2, $zero, 4
//        memory[23] = 32'b01110010000100101000000000000010;// ->         mul     $s0, $s0, $s2
//        memory[24] = 32'b00100010000100000000000000000100;// ->         addi    $s0, $s0, 4
//        memory[25] = 32'b00110010000100000000000000000000;// ->         andi    $s0, $s0, 0
//        memory[26] = 32'b00110110000100000000000000000001;// ->         ori     $s0, $s0, 1
//        memory[27] = 32'b00101010000100000000000000000000;// ->         slti    $s0, $s0, 0
//        memory[28] = 32'b00101010000100000000000000000001;// ->         slti    $s0, $s0, 1
//        memory[29] = 32'b00111010000100000000000000000001;// ->         xori    $s0, $s0, 1
//        memory[30] = 32'b00111010000100000000000000000001;// ->         xori    $s0, $s0, 1
//        memory[31] = 32'b00100000000100001111111111111110;// ->         addi    $s0, $zero, -2
//        memory[32] = 32'b00100000000100010000000000000010;// ->         addi    $s1, $zero, 2
//        memory[33] = 32'b00000010001100001001000000101011;// ->         sltu    $s2, $s1, $s0
//        memory[34] = 32'b00101110001100001111111111111110;// ->         sltiu   $s0, $s1, -2
//        memory[35] = 32'b00000010001000001000000000001010;// ->         movz    $s0, $s1, $zero
//        memory[36] = 32'b00000000000100011000000000001011;// ->         movn    $s0, $zero, $s1
//        memory[37] = 32'b00000010001100101000000000100000;// ->         add     $s0, $s1, $s2
//        memory[38] = 32'b00100000000100001111111111111110;// ->         addi    $s0, $zero, -2
//        memory[39] = 32'b00000010001100001000100000100001;// ->         addu    $s1, $s1, $s0
//        memory[40] = 32'b00100100000100011111111111111111;// ->         addiu   $s1, $zero, -1
//        memory[41] = 32'b00100000000100100000000000100000;// ->         addi    $s2, $zero, 32
//        memory[42] = 32'b00000010001100100000000000011000;// ->         mult    $s1, $s2
//        memory[43] = 32'b00000000000000001010000000010000;// ->         mfhi    $s4
//        memory[44] = 32'b00000000000000001010100000010010;// ->         mflo    $s5
//        memory[45] = 32'b00000010001100100000000000011001;// ->         multu   $s1, $s2
//        memory[46] = 32'b00000000000000001010000000010000;// ->         mfhi    $s4
//        memory[47] = 32'b00000000000000001010100000010010;// ->         mflo    $s5
//        memory[48] = 32'b01110010001100100000000000000000;// ->         madd    $s1, $s2
//        memory[49] = 32'b00000000000000001010000000010000;// ->         mfhi    $s4
//        memory[50] = 32'b00000000000000001010100000010010;// ->         mflo    $s5
//        memory[51] = 32'b00000010010000000000000000010001;// ->         mthi    $s2
//        memory[52] = 32'b00000010001000000000000000010011;// ->         mtlo    $s1
//        memory[53] = 32'b00000000000000001010000000010000;// ->         mfhi    $s4
//        memory[54] = 32'b00000000000000001010100000010010;// ->         mflo    $s5
//        memory[55] = 32'b00110010001100011111111111111111;// ->         andi    $s1, , $s1, 65535
//        memory[56] = 32'b01110010100100100000000000000100;// ->         msub    $s4, , $s2
//        memory[57] = 32'b00000000000000001010000000010000;// ->         mfhi    $s4
//        memory[58] = 32'b00000000000000001010100000010010;// ->         mflo    $s5
//        memory[59] = 32'b00100000000100100000000000000001;// ->         addi    $s2, $zero, 1
//        memory[60] = 32'b00000000001100101000111111000010;// ->         rotr    $s1, $s2, 31
//        memory[61] = 32'b00100000000101000000000000011111;// ->         addi    $s4, $zero, 31
//        memory[62] = 32'b00000010100100011000100001000110;// ->         rotrv   $s1, $s1, $s4
//        memory[63] = 32'b00110100000100010000111111110000;// ->         Should be 4080
//        memory[64] = 32'b01111100000100011010010000100000;// ->         seb     $s4, $s1
//        memory[65] = 32'b01111100000100011010011000100000;// ->         seh     $s4, $s1
        
//        memory[0] = 32'h34040000;	//	main:		ori	$a0, $zero, 0
//        memory[1] = 32'h08000004;	//			j	start
//        memory[2] = 32'h2004000a;	//			addi	$a0, $zero, 10
//        memory[3] = 32'h2004000a;	//			addi	$a0, $zero, 10
//        memory[4] = 32'h8c900004;	//	start:		lw	$s0, 4($a0)
//        memory[5] = 32'h8c900008;	//			lw	$s0, 8($a0)
//        memory[6] = 32'hac900000;	//			sw	$s0, 0($a0)
//        memory[7] = 32'hac90000c;	//			sw	$s0, 12($a0)
//        memory[8] = 32'h8c910000;	//			lw	$s1, 0($a0)
//        memory[9] = 32'h8c92000c;	//			lw	$s2, 12($a0)
//        memory[10] = 32'h12000003;	//			beq	$s0, $zero, branch1
//        memory[11] = 32'h02008820;	//			add	$s1, $s0, $zero
//        memory[12] = 32'h12110001;	//			beq	$s0, $s1, branch1
//        memory[13] = 32'h08000037;	//			j	error
//        memory[14] = 32'h2010ffff;	//	branch1:	addi	$s0, $zero, -1
//        memory[15] = 32'h0601fff4;	//			bgez	$s0, start
//        memory[16] = 32'h22100001;	//			addi	$s0, $s0, 1
//        memory[17] = 32'h06010001;	//			bgez	$s0, branch2
//        memory[18] = 32'h08000037;	//			j	error
//        memory[19] = 32'h2010ffff;	//	branch2:	addi	$s0, $zero, -1
//        memory[20] = 32'h1E000005;	//			bgtz	$s0, branch3
//        memory[21] = 32'h20100001;	//			addi	$s0, $zero, 1
//        memory[22] = 32'h20100001;	//			addi	$s0, $zero, 1
//        memory[23] = 32'h20100001;	//			addi	$s0, $zero, 1
//        memory[24] = 32'h1E000001;	//			bgtz	$s0, branch3
//        memory[25] = 32'h08000037;	//			j	error
//        memory[26] = 32'h06000003;	//	branch3:	bltz	$s0, branch4
//        memory[27] = 32'h2010ffff;	//			addi	$s0, $zero, -1
//        memory[28] = 32'h06000001;	//			bltz	$s0, branch4
//        memory[29] = 32'h08000037;	//			j	error
//        memory[30] = 32'h2011ffff;	//	branch4:	addi	$s1, $zero, -1
//        memory[31] = 32'h16110002;	//			bne	$s0, $s1, branch5
//        memory[32] = 32'h16000001;	//			bne	$s0, $zero, branch5
//        memory[33] = 32'h08000037;	//			j	error
//        memory[34] = 32'h20100080;	//	branch5:	addi	$s0, $zero, 128
//        memory[35] = 32'ha0900000;	//			sb	$s0, 0($a0)
//        memory[36] = 32'h80900000;	//			lb	$s0, 0($a0)
//        memory[37] = 32'h1a000001;	//			blez	$s0, branch6
//        memory[38] = 32'h08000037;	//			j	error
//        memory[39] = 32'h2010ffff;	//	branch6:	addi	$s0, $zero, -1
//        memory[40] = 32'ha4900000;	//			sh	$s0, 0($a0)
//        memory[41] = 32'h20100000;	//			addi	$s0, $zero, 0
//        memory[42] = 32'h84900000;	//			lh	$s0, 0($a0)
//        memory[43] = 32'h1a000001;	//			blez	$s0, branch7 //BREAKS HERE!!!!
//        memory[44] = 32'h08000037;	//			j	error
//        memory[45] = 32'h2010ffff;	//	branch7:	addi	$s0, $zero, -1
//        memory[46] = 32'h3c100001;	//			lui	$s0, 1
//        memory[47] = 32'h06010001;	//			bgez	$s0, branch8
//        memory[48] = 32'h08000037;	//			j	error
//        memory[49] = 32'h08000033;	//	branch8:	j	jump1
//        memory[50] = 32'h2210fffe;	//			addi	$s0, $s0, -2
//        memory[51] = 32'h0c000035;	//	jump1:		jal	jal1
//        memory[52] = 32'h08000004;	//			j	start
//        memory[53] = 32'h03e00008;	//	jal1:		jr	$ra
//        memory[54] = 32'h08000037;	//			j	error
//        memory[55] = 32'h00000008;	//	error:		jr	$zero
//        memory[56] = 32'h3402000a;	//			ori	$v0, $zero, 10
//        memory[57] = 32'h00000000;	//			nop
        
        memory[0] = 32'h23bdfffc;	//	main:			addi	$sp, $sp, -4
memory[1] = 32'hafbf0000;	//				sw	$ra, 0($sp)
memory[2] = 32'h34040060;	//				ori	$a0, $zero, 96
memory[3] = 32'h34050070;	//				ori	$a1, $zero, 112
memory[4] = 32'h34060470;	//				ori	$a2, $zero, 1136
memory[5] = 32'h0c00005b;	//				jal	vbsme
memory[6] = 32'h0c00004b;	//				jal	print_result
memory[7] = 32'h340404b0;	//				ori	$a0, $zero, 1200
memory[8] = 32'h340504c0;	//				ori	$a1, $zero, 1216
memory[9] = 32'h340608c0;	//				ori	$a2, $zero, 2240
memory[10] = 32'h0c00005b;	//				jal	vbsme
memory[11] = 32'h0c00004b;	//				jal	print_result
memory[12] = 32'h34040940;	//				ori	$a0, $zero, 2368
memory[13] = 32'h34050950;	//				ori	$a1, $zero, 2384
memory[14] = 32'h34060d50;	//				ori	$a2, $zero, 3408
memory[15] = 32'h0c00005b;	//				jal	vbsme
memory[16] = 32'h0c00004b;	//				jal	print_result
memory[17] = 32'h34040dd0;	//				ori	$a0, $zero, 3536
memory[18] = 32'h34050de0;	//				ori	$a1, $zero, 3552
memory[19] = 32'h340611e0;	//				ori	$a2, $zero, 4576
memory[20] = 32'h0c00005b;	//				jal	vbsme
memory[21] = 32'h0c00004b;	//				jal	print_result
memory[22] = 32'h34041220;	//				ori	$a0, $zero, 4640
memory[23] = 32'h34051230;	//				ori	$a1, $zero, 4656
memory[24] = 32'h34062230;	//				ori	$a2, $zero, 8752
memory[25] = 32'h0c00005b;	//				jal	vbsme
memory[26] = 32'h0c00004b;	//				jal	print_result
memory[27] = 32'h34042430;	//				ori	$a0, $zero, 9264
memory[28] = 32'h34052440;	//				ori	$a1, $zero, 9280
memory[29] = 32'h34063440;	//				ori	$a2, $zero, 13376
memory[30] = 32'h0c00005b;	//				jal	vbsme
memory[31] = 32'h0c00004b;	//				jal	print_result
memory[32] = 32'h34043480;	//				ori	$a0, $zero, 13440
memory[33] = 32'h34053490;	//				ori	$a1, $zero, 13456
memory[34] = 32'h34064490;	//				ori	$a2, $zero, 17552
memory[35] = 32'h0c00005b;	//				jal	vbsme
memory[36] = 32'h0c00004b;	//				jal	print_result
memory[37] = 32'h34044510;	//				ori	$a0, $zero, 17680
memory[38] = 32'h34054520;	//				ori	$a1, $zero, 17696
memory[39] = 32'h34064920;	//				ori	$a2, $zero, 18720
memory[40] = 32'h0c00005b;	//				jal	vbsme
memory[41] = 32'h0c00004b;	//				jal	print_result
memory[42] = 32'h340449a0;	//				ori	$a0, $zero, 18848
memory[43] = 32'h340549b0;	//				ori	$a1, $zero, 18864
memory[44] = 32'h34064db0;	//				ori	$a2, $zero, 19888
memory[45] = 32'h0c00005b;	//				jal	vbsme
memory[46] = 32'h0c00004b;	//				jal	print_result
memory[47] = 32'h34044df0;	//				ori	$a0, $zero, 19952
memory[48] = 32'h34054e00;	//				ori	$a1, $zero, 19968
memory[49] = 32'h34065200;	//				ori	$a2, $zero, 20992
memory[50] = 32'h0c00005b;	//				jal	vbsme
memory[51] = 32'h0c00004b;	//				jal	print_result
memory[52] = 32'h34045300;	//				ori	$a0, $zero, 21248
memory[53] = 32'h34055310;	//				ori	$a1, $zero, 21264
memory[54] = 32'h34066310;	//				ori	$a2, $zero, 25360
memory[55] = 32'h0c00005b;	//				jal	vbsme
memory[56] = 32'h0c00004b;	//				jal	print_result
memory[57] = 32'h34046710;	//				ori	$a0, $zero, 26384
memory[58] = 32'h34056720;	//				ori	$a1, $zero, 26400
memory[59] = 32'h34066b20;	//				ori	$a2, $zero, 27424
memory[60] = 32'h0c00005b;	//				jal	vbsme
memory[61] = 32'h0c00004b;	//				jal	print_result
memory[62] = 32'h34046b60;	//				ori	$a0, $zero, 27488
memory[63] = 32'h34056b70;	//				ori	$a1, $zero, 27504
memory[64] = 32'h34067b70;	//				ori	$a2, $zero, 31600
memory[65] = 32'h0c00005b;	//				jal	vbsme
memory[66] = 32'h0c00004b;	//				jal	print_result
memory[67] = 32'h34047bb0;	//				ori	$a0, $zero, 31664
memory[68] = 32'h34057bc0;	//				ori	$a1, $zero, 31680
memory[69] = 32'h34067c00;	//				ori	$a2, $zero, 31744
memory[70] = 32'h0c00005b;	//				jal	vbsme
memory[71] = 32'h0c00004b;	//				jal	print_result
memory[72] = 32'h8fbf0000;	//				lw	$ra, 0($sp)
memory[73] = 32'h23bd0004;	//				addi	$sp, $sp, 4
memory[74] = 32'h03e00008;	//				jr	$ra
memory[75] = 32'h00402020;	//	print_result:		add	$a0, $v0, $zero
memory[76] = 32'h34020001;	//				ori	$v0, $zero, 1
memory[77] = 32'h00000000;	//				nop
memory[78] = 32'h34047c40;	//				ori	$a0, $zero, 31808
memory[79] = 32'h34020004;	//				ori	$v0, $zero, 4
memory[80] = 32'h00000000;	//				nop
memory[81] = 32'h00602020;	//				add	$a0, $v1, $zero
memory[82] = 32'h34020001;	//				ori	$v0, $zero, 1
memory[83] = 32'h00000000;	//				nop
memory[84] = 32'h34047c40;	//				ori	$a0, $zero, 31808
memory[85] = 32'h34020004;	//				ori	$v0, $zero, 4
memory[86] = 32'h00000000;	//				nop
memory[87] = 32'h34047c40;	//				ori	$a0, $zero, 31808
memory[88] = 32'h34020004;	//				ori	$v0, $zero, 4
memory[89] = 32'h00000000;	//				nop
memory[90] = 32'h03e00008;	//				jr	$ra
memory[91] = 32'h34020000;	//	vbsme:			ori	$v0, $zero, 0
memory[92] = 32'h34030000;	//				ori	$v1, $zero, 0
memory[93] = 32'h8c900000;	//				lw	$s0, 0($a0)
memory[94] = 32'h8c910004;	//				lw	$s1, 4($a0)
memory[95] = 32'h8c880008;	//				lw	$t0, 8($a0)
memory[96] = 32'h8c89000c;	//				lw	$t1, 12($a0)
memory[97] = 32'h7109a802;	//				mul	$s5, $t0, $t1
memory[98] = 32'h02088022;	//				sub	$s0, $s0, $t0
memory[99] = 32'h02298822;	//				sub	$s1, $s1, $t1
memory[100] = 32'h00004020;	//				add	$t0, $zero, $zero
memory[101] = 32'h200b0002;	//				addi	$t3, $zero, 2
memory[102] = 32'h00005020;	//				add	$t2, $zero, $zero
memory[103] = 32'h00009820;	//				add	$s3, $zero, $zero
memory[104] = 32'h0000a020;	//				add	$s4, $zero, $zero
memory[105] = 32'h20172710;	//				addi	$s7, $zero, 10000
memory[106] = 32'h00007020;	//				add	$t6, $zero, $zero
memory[107] = 32'h00a06020;	//				add	$t4, $a1, $zero
memory[108] = 32'h00c06820;	//				add	$t5, $a2, $zero
memory[109] = 32'h00004820;	//				add	$t1, $zero, $zero
memory[110] = 32'h08000078;	//				j	Load
memory[111] = 32'h8c8d0004;	//	CalcuSAD:		lw	$t5, 4($a0)
memory[112] = 32'h71b36802;	//				mul	$t5, $t5, $s3
memory[113] = 32'h01b46820;	//				add	$t5, $t5, $s4
memory[114] = 32'h000d6880;	//				sll	$t5, $t5, 2
memory[115] = 32'h00ad6020;	//				add	$t4, $a1, $t5
memory[116] = 32'h00c06820;	//				add	$t5, $a2, $zero
memory[117] = 32'h0000b020;	//				add	$s6, $zero, $zero
memory[118] = 32'h00007020;	//				add	$t6, $zero, $zero
memory[119] = 32'h00004820;	//				add	$t1, $zero, $zero
memory[120] = 32'h01d5c82a;	//	Load:			slt	$t9, $t6, $s5
memory[121] = 32'h13200016;	//				beq	$t9, $zero, CheckSAD
memory[122] = 32'h8d8f0000;	//				lw	$t7, 0($t4)
memory[123] = 32'h8db80000;	//				lw	$t8, 0($t5)
memory[124] = 32'h030fc82a;	//				slt	$t9, $t8, $t7
memory[125] = 32'h13200002;	//				beq	$t9, $zero, Sub1
memory[126] = 32'h01f8c022;	//				sub	$t8, $t7, $t8
memory[127] = 32'h08000081;	//				j	Cont1
memory[128] = 32'h030fc022;	//	Sub1:			sub	$t8, $t8, $t7
memory[129] = 32'h02d8b020;	//	Cont1:			add	$s6, $s6, $t8
memory[130] = 32'h21ce0001;	//				addi	$t6, $t6, 1
memory[131] = 32'h21ad0004;	//				addi	$t5, $t5, 4
memory[132] = 32'h21290001;	//				addi	$t1, $t1, 1
memory[133] = 32'h8c8f000c;	//				lw	$t7, 12($a0)
memory[134] = 32'h012fc82a;	//				slt	$t9, $t1, $t7
memory[135] = 32'h13200002;	//				beq	$t9, $zero, NextLine
memory[136] = 32'h218c0004;	//				addi	$t4, $t4, 4
memory[137] = 32'h08000078;	//				j	Load
memory[138] = 32'h02207820;	//	NextLine:		add	$t7, $s1, $zero
memory[139] = 32'h21ef0001;	//				addi	$t7, $t7, 1
memory[140] = 32'h000f7880;	//				sll	$t7, $t7, 2
memory[141] = 32'h018f6020;	//				add	$t4, $t4, $t7
memory[142] = 32'h00004820;	//				add	$t1, $zero, $zero
memory[143] = 32'h08000078;	//				j	Load
memory[144] = 32'h02d7c82a;	//	CheckSAD:		slt	$t9, $s6, $s7
memory[145] = 32'h13200032;	//				beq	$t9, $zero, FirstSLELocation
memory[146] = 32'h02c0b820;	//	skip:			add	$s7, $s6, $zero
memory[147] = 32'h02601020;	//				add	$v0, $s3, $zero
memory[148] = 32'h02801820;	//				add	$v1, $s4, $zero
memory[149] = 32'h0274c820;	//	FrameMove:		add	$t9, $s3, $s4
memory[150] = 32'h20190001;	//	CheckDiag:		addi	$t9, $zero, 1
memory[151] = 32'h132b000b;	//				beq	$t9, $t3, MoveDiagDown
memory[152] = 32'h20190002;	//				addi	$t9, $zero, 2
memory[153] = 32'h132b0019;	//				beq	$t9, $t3, MoveDiagUp
memory[154] = 32'h0291c82a;	//	MoveRightDown:		slt	$t9, $s4, $s1
memory[155] = 32'h22940001;	//				addi	$s4, $s4, 1
memory[156] = 32'h1720ffd4;	//				bne	$t9, $zero, CalcuSAD
memory[157] = 32'h2294ffff;	//				addi	$s4, $s4, -1
memory[158] = 32'h0270c82a;	//				slt	$t9, $s3, $s0
memory[159] = 32'h22730001;	//				addi	$s3, $s3, 1
memory[160] = 32'h1720ffd0;	//				bne	$t9, $zero, CalcuSAD
memory[161] = 32'h2273ffff;	//				addi	$s3, $s3, -1
memory[162] = 32'h080000c3;	//				j	EXIT
memory[163] = 32'h2294ffff;	//	MoveDiagDown:		addi	$s4, $s4, -1
memory[164] = 32'h22730001;	//				addi	$s3, $s3, 1
memory[165] = 32'h0280c82a;	//				slt	$t9, $s4, $zero
memory[166] = 32'h17200013;	//				bne	$t9, $zero, FixIJ1
memory[167] = 32'h0270c82a;	//				slt	$t9, $s3, $s0
memory[168] = 32'h1320001d;	//				beq	$t9, $zero, SSLELoc
memory[169] = 32'h0800006f;	//				j	CalcuSAD
memory[170] = 32'h0270c82a;	//	MoveDownRight:		slt	$t9, $s3, $s0
memory[171] = 32'h22730001;	//				addi	$s3, $s3, 1
memory[172] = 32'h1720ffc4;	//				bne	$t9, $zero, CalcuSAD
memory[173] = 32'h2273ffff;	//				addi	$s3, $s3, -1
memory[174] = 32'h0291c82a;	//				slt	$t9, $s4, $s1
memory[175] = 32'h22940001;	//				addi	$s4, $s4, 1
memory[176] = 32'h1720ffc0;	//				bne	$t9, $zero, CalcuSAD
memory[177] = 32'h2294ffff;	//				addi	$s4, $s4, -1
memory[178] = 32'h080000c3;	//				j	EXIT
memory[179] = 32'h22940001;	//	MoveDiagUp:		addi	$s4, $s4, 1
memory[180] = 32'h2273ffff;	//				addi	$s3, $s3, -1
memory[181] = 32'h0260c82a;	//				slt	$t9, $s3, $zero
memory[182] = 32'h17200007;	//				bne	$t9, $zero, FixIJ2
memory[183] = 32'h0291c82a;	//				slt	$t9, $s4, $s1
memory[184] = 32'h1320000f;	//				beq	$t9, $zero, TSLELoc
memory[185] = 32'h0800006f;	//				j	CalcuSAD
memory[186] = 32'h22940001;	//	FixIJ1:			addi	$s4, $s4, 1
memory[187] = 32'h2273ffff;	//				addi	$s3, $s3, -1
memory[188] = 32'h200b0002;	//				addi	$t3, $zero, 2
memory[189] = 32'h080000aa;	//				j	MoveDownRight
memory[190] = 32'h00005020;	//	FixIJ2:			add	$t2, $zero, $zero
memory[191] = 32'h2294ffff;	//				addi	$s4, $s4, -1
memory[192] = 32'h22730001;	//				addi	$s3, $s3, 1
memory[193] = 32'h200b0001;	//				addi	$t3, $zero, 1
memory[194] = 32'h0800009a;	//				j	MoveRightDown
memory[195] = 32'h080000c3;	//	EXIT:			j	EXIT
memory[196] = 32'h12d7ffcf;	//	FirstSLELocation:	beq	$s6, $s7, skip
memory[197] = 32'h08000095;	//				j	FrameMove
memory[198] = 32'h1270ffaa;	//	SSLELoc:		beq	$s3, $s0, CalcuSAD
memory[199] = 32'h080000ba;	//				j	FixIJ1
memory[200] = 32'h1291ffa8;	//	TSLELoc:		beq	$s4, $s1, CalcuSAD
memory[201] = 32'h080000be;	//				j	FixIJ2

    end
    
    always @ (readAddr) begin   
        Instruction = memory [readAddr[10:2]];
    end

endmodule
