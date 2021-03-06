`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2022 04:12:04 PM
// Design Name: 
// Module Name: firstConv
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

module firstConv
	#(
		parameter RAM_WIDTH_KER		= 16,
		parameter KER_MEM_LENGTH	= 27,
		parameter IMAGE_MEM_LENGTH	= 49152,
		parameter BIAS_MEM_LENGTH	= 32,
		parameter M1_PARAM			= 3,
		parameter N1_PARAM			= 3,
		parameter C1_PARAM			= 3,
		parameter M2_PARAM			= 128,
		parameter N2_PARAM			= 128,
		parameter ZERO_PAD_PARAM	= 1,
		parameter M3_PARAM			= 128,
		parameter N3_PARAM			= 128,
		/*
		parameter RAM_ADDR_BITS 	= 9,
		parameter DATA_FILE 		= "data_file.txt",
		parameter INIT_START_ADDR 	= 0,
		parameter INIT_END_ADDR		= 10*/
		parameter RAM_WIDTH_BIAS	= 16,
		parameter RAM_WIDTH_IMG		= 20,
		parameter CONV_ED			= 128*128
	)
	(
	input 									clk,
	input									reset,
	
	input				[RAM_WIDTH_KER-1:0] kernel0,
	input									kernel_vld0,
	output reg signed						kernel_rdy0,
	
	input				[RAM_WIDTH_KER-1:0] kernel1,
	input									 kernel_vld1,
	output reg signed						 kernel_rdy1,
	
	input				[RAM_WIDTH_KER-1:0] kernel2,
	input									kernel_vld2,
	output reg signed						 kernel_rdy2,	
	
	input				[RAM_WIDTH_KER-1:0] kernel3,
	input									kernel_vld3,
	output reg signed						kernel_rdy3,
	
	input				[RAM_WIDTH_KER-1:0] kernel4,
	input									kernel_vld4,
	output reg signed						kernel_rdy4,
	
	input				[RAM_WIDTH_KER-1:0] kernel5,
	input									kernel_vld5,
	output reg signed						kernel_rdy5,
	
	input				[RAM_WIDTH_KER-1:0] kernel6,
	input		 							kernel_vld6,
	output reg								 kernel_rdy6,
		
	input				[RAM_WIDTH_KER-1:0] kernel7,
	input		 							kernel_vld7,
	output reg								kernel_rdy7,
	
	input		[RAM_WIDTH_KER-1:0] kernel8,
	input		 kernel_vld8,
	output reg		 kernel_rdy8,
	
	input		[RAM_WIDTH_KER-1:0] kernel9,
	input		 kernel_vld9,
	output reg		kernel_rdy9,
	
	input		[RAM_WIDTH_KER-1:0] kernel10,
	input		 kernel_vld10,
	output reg		 kernel_rdy10,
	
	input		[RAM_WIDTH_KER-1:0] kernel11,
	input		 kernel_vld11,
	output reg		 kernel_rdy11,
	
	input		[RAM_WIDTH_KER-1:0] kernel12,
	input		 kernel_vld12,
	output reg		 kernel_rdy12,
	
	input		[RAM_WIDTH_KER-1:0] kernel13,
	input		kernel_vld13,
	output reg		kernel_rdy13,
	
	input		[RAM_WIDTH_KER-1:0] kernel14,
	input		 kernel_vld14,
	output reg		 kernel_rdy14,
	
	input		[RAM_WIDTH_KER-1:0] kernel15,
	input		 kernel_vld15,
	output reg		 kernel_rdy15,
	
	input		[RAM_WIDTH_KER-1:0] kernel16,
	input		 kernel_vld16,
	output reg		 kernel_rdy16,
	
	input		[RAM_WIDTH_KER-1:0] kernel17,
	input		 kernel_vld17,
	output reg		 kernel_rdy17,
	
	input		[RAM_WIDTH_KER-1:0] kernel18,
	input		 kernel_vld18,
	output reg		 kernel_rdy18,
	
	input		[RAM_WIDTH_KER-1:0] kernel19,
	input		 kernel_vld19,
	output reg		 kernel_rdy19,
	
	input		[RAM_WIDTH_KER-1:0] kernel20,
	input							kernel_vld20,
	output reg						kernel_rdy20,
		
	input		[RAM_WIDTH_KER-1:0] kernel21,
	input							kernel_vld21,
	output reg						kernel_rdy21,
	
	input		[RAM_WIDTH_KER-1:0] kernel22,
	input							kernel_vld22,
	output reg						kernel_rdy22,
	
	input		[RAM_WIDTH_KER-1:0] kernel23,
	input							kernel_vld23,
	output reg						kernel_rdy23,
	
	input		[RAM_WIDTH_KER-1:0] kernel24,
	input							kernel_vld24,
	output reg						kernel_rdy24,
	
	input		[RAM_WIDTH_KER-1:0] kernel25,
	input							kernel_vld25,
	output reg						kernel_rdy25,
	
	input		[RAM_WIDTH_KER-1:0] kernel26,
	input							kernel_vld26,
	output reg						kernel_rdy26,
	
	input		[RAM_WIDTH_KER-1:0] kernel27,
	input							kernel_vld27,
	output reg						kernel_rdy27,	
	
	input		[RAM_WIDTH_KER-1:0] kernel28,
	input							kernel_vld28,
	output reg						kernel_rdy28,
	
	input		[RAM_WIDTH_KER-1:0] kernel29,
	input							kernel_vld29,
	output reg						kernel_rdy29,
	
	input		[RAM_WIDTH_KER-1:0] kernel30,
	input							kernel_vld30,
	output reg						kernel_rdy30,
	
	input		[RAM_WIDTH_KER-1:0] kernel31,
	input							kernel_vld31,
	output reg						kernel_rdy31,	
		
	input		[RAM_WIDTH_IMG-1:0]	image,
	input							image_vld,
	output reg						image_rdy,
	
	input  		[RAM_WIDTH_BIAS-1:0]biases,
	input							biases_vld,
	output reg						biases_rdy,
	
	output reg	[RAM_WIDTH_KER-1:0] conv_2d_result,
	input		[RAM_WIDTH_KER-1:0] conv_2d_vld,
	output reg	[RAM_WIDTH_KER-1:0] conv_2d_rdy,
	
	output reg		[RAM_WIDTH_IMG-1:0] result0,
	output reg		[RAM_WIDTH_IMG-1:0] result1,
	output reg		[RAM_WIDTH_IMG-1:0] result2,
	output reg		[RAM_WIDTH_IMG-1:0] result3,
	output reg		[RAM_WIDTH_IMG-1:0] result4,
	output reg		[RAM_WIDTH_IMG-1:0] result5,
	output reg		[RAM_WIDTH_IMG-1:0] result6,
	output reg		[RAM_WIDTH_IMG-1:0] result7,
	output reg		[RAM_WIDTH_IMG-1:0] result8,
	output reg		[RAM_WIDTH_IMG-1:0] result9,
	output reg		[RAM_WIDTH_IMG-1:0] result10,
	output reg		[RAM_WIDTH_IMG-1:0] result11,
	output reg		[RAM_WIDTH_IMG-1:0] result12,
	output reg		[RAM_WIDTH_IMG-1:0] result13,
	output reg		[RAM_WIDTH_IMG-1:0] result14,
	output reg		[RAM_WIDTH_IMG-1:0] result15,
	output reg		[RAM_WIDTH_IMG-1:0] result16,
	output reg		[RAM_WIDTH_IMG-1:0] result17,
	output reg		[RAM_WIDTH_IMG-1:0] result18,
	output reg		[RAM_WIDTH_IMG-1:0] result19,
	output reg		[RAM_WIDTH_IMG-1:0] result20,
	output reg		[RAM_WIDTH_IMG-1:0] result21,
	output reg		[RAM_WIDTH_IMG-1:0] result22,
	output reg		[RAM_WIDTH_IMG-1:0] result23,
	output reg		[RAM_WIDTH_IMG-1:0] result24,
	output reg		[RAM_WIDTH_IMG-1:0] result25,
	output reg		[RAM_WIDTH_IMG-1:0] result26,
	output reg		[RAM_WIDTH_IMG-1:0] result27,
	output reg		[RAM_WIDTH_IMG-1:0] result28,
	output reg		[RAM_WIDTH_IMG-1:0] result29,
	output reg		[RAM_WIDTH_IMG-1:0] result30,
	output reg		[RAM_WIDTH_IMG-1:0] result31
    );
    
    reg	signed	[RAM_WIDTH_KER-1:0]kernel0_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel1_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel2_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel3_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel4_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel5_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel6_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel7_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel8_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel9_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel10_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel11_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel12_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel13_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel14_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel15_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel16_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel17_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel18_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel19_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel20_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel21_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel22_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel23_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel24_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel25_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel26_mem [KER_MEM_LENGTH:0];
    reg	signed	[RAM_WIDTH_KER-1:0]kernel27_mem [KER_MEM_LENGTH:0];
	reg	signed	[RAM_WIDTH_KER-1:0]kernel28_mem [KER_MEM_LENGTH:0];
	reg	signed	[RAM_WIDTH_KER-1:0]kernel29_mem [KER_MEM_LENGTH:0];
	reg	signed	[RAM_WIDTH_KER-1:0]kernel30_mem [KER_MEM_LENGTH:0];
	reg	signed	[RAM_WIDTH_KER-1:0]kernel31_mem [KER_MEM_LENGTH:0];
    reg								kernel_recieved[31:0];
    reg 		[5:0]				kernel_vals_cnt[31:0];
    
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in0 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in1 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in2 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in3 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in4 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in5 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in6 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in7 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in8 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in9 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in10 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in11 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in12 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in13 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in14 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in15 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in16 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in17 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in18 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in19 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in20 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in21 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in22 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in23 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in24 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in25 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in26 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in27 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in28 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in29 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in30 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in31 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
	reg			[6:0]				C1_var_def[31:0];
	reg			[8:0]				M1_var_def[31:0];
	reg			[8:0]				N1_var_def[31:0];
	reg 		[2:0]				L1_var_def[31:0];
	reg			[6:0]				C1_var_def0;
	reg			[8:0]				M1_var_def0;
	reg			[8:0]				N1_var_def0;
	reg 		[2:0]				L1_var_def0;
	reg								kernel_deflattened[31:0];
    
    //(* RAM_STYLE="BLOCK" *)
 	reg signed	[RAM_WIDTH_IMG-1:0]	image_mem [IMAGE_MEM_LENGTH:0];
 	reg 		[100:0]				image_vals_cnt;
    reg 							image_recieved;
    
    reg	signed	[RAM_WIDTH_BIAS-1:0]biases_mem [BIAS_MEM_LENGTH:0];
    reg 		[6:0]				biases_vals_cnt;				
    reg 							biases_recieved;
    
    reg signed	[RAM_WIDTH_IMG-1:0]	image_mem_arr_in [N2_PARAM-1:0][M2_PARAM-1:0][C1_PARAM-1:0];
    reg			[6:0]				C1_var;
    reg			[8:0]				M2_var;
    reg			[8:0]				N2_var;
    reg								image_deflattened;
    
    reg signed	[RAM_WIDTH_IMG-1:0]	image_mem_arr_in_zpad [(N2_PARAM-1)+2*ZERO_PAD_PARAM:0][(M2_PARAM-1)+2*ZERO_PAD_PARAM:0][C1_PARAM-1:0];
	reg			[6:0]				C1_var2;
	reg			[8:0]				M2_var2;
	reg			[8:0]				N2_var2;
    reg 							zero_pad_done;
    
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_0;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_1;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_2;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_3;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_4;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_5;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_6;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_7;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_8;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_9;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_10;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_11;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_12;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_13;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_14;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_15;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_16;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_17;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_18;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_19;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_20;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_21;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_22;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_23;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_24;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_25;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_26;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_27;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_28;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_29;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_30;
	wire signed [2*RAM_WIDTH_IMG-1:0]mult_temp_w_31;
	
	
	wire signed	[RAM_WIDTH_IMG-1:0] mult_temp_w_conc[31:0];
    wire signed	[RAM_WIDTH_IMG-1:0] res_temp_w_conc[31:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_0 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_1 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_2 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_3 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_4 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_5 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_6 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_7 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_8 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_9 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_10 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_11 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_12 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_13 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_14 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_15 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_16 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_17 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_18 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_19 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_20 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_21 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_22 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_23 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_24 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_25 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_26 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_27 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_28 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_29 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_30 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
	reg signed	[RAM_WIDTH_IMG-1:0]	result_mem_31 [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];

    reg signed	[2*RAM_WIDTH_IMG-1:0]result_temp[31:0];
    reg 		[8:0]				N1_var2[31:0];
    reg 		[8:0]    			M1_var2[31:0];
    reg			[6:0]				C1_var4[31:0];
	reg			[8:0]				M3_var[31:0];
	reg			[8:0]				N3_var[31:0];
    reg 							conv_done[31:0];
    
    reg			[8:0]				M3_var_def[31:0];
    reg			[8:0]				N3_var_def[31:0];
    reg 		[2:0]				L3_var_def[31:0];  
    reg								result_flattened[31:0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_0[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_1[(CONV_ED-1):0]; 
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_2[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_3[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_4[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_5[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_6[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_7[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_8[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_9[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_10[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_11[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_12[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_13[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_14[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_15[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_16[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_17[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_18[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_19[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_20[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_21[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_22[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_23[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_24[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_25[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_26[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_27[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_28[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_29[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_30[(CONV_ED-1):0];
    reg signed	[RAM_WIDTH_IMG-1:0]	result_fl_31[(CONV_ED-1):0]; 
    
    ////////////////////////
	// recieving image
	
	always@(posedge clk)
		if (reset == 1) 
		begin
			image_rdy <= 0;
			image_vals_cnt <= 10'd0;
			image_recieved <= 0;
		end
		else 
		begin
			if (image_recieved == 0)		 
				image_rdy <= 1; 
				if( (image_mem[image_vals_cnt] != image ) || (image_vld == 1) || (image_vals_cnt == IMAGE_MEM_LENGTH ) ) begin
				//counter clicks if new value came to kernel data port or it's the last value  
					image_vals_cnt = image_vals_cnt + 1'd1;
					image_mem[image_vals_cnt] <= image;
				end	
				if (image_vals_cnt == IMAGE_MEM_LENGTH) begin
					image_recieved <= 1'b1;
				end
					
			else if(image_recieved == 1)
				image_mem[image_vals_cnt]<=image_mem[image_vals_cnt];	
				//kernel_rdy0<=0; //why does this break all rdy-val protocol?????
		end/**/

    ////////////////////////
    // passing image to 3D array-register 
    
    always@(posedge clk)
    begin
    	if (reset == 1)
    	begin
    		N2_var <= 8'd0;
    		M2_var <= 8'd0;
    		C1_var <= 6'd0;
    		image_deflattened <= 1'd0;    		
    	end
    	else if (image_recieved == 1 && image_deflattened == 0)
    	begin
    		image_mem_arr_in[N2_var][M2_var][C1_var] <= 
    		image_mem[N2_var*M2_PARAM*C1_PARAM + M2_var*C1_PARAM + C1_var + 1]; //+1 because kludge in recieving protocol
    		//incerementing arrays counters
    		C1_var <= C1_var + 1;
    		if (C1_var >= C1_PARAM)
    		begin
    			C1_var <= 6'd0;
    			M2_var <= M2_var + 1;
				if (M2_var >= M2_PARAM)
				begin
					M2_var <= 8'd0;					
					N2_var <= N2_var + 1;
					if (N2_var >= N2_PARAM)
//						N2_var <= 8'd0;
						if (N2_var >= 32)
						begin
							image_deflattened <= 1'd1;
						end
				end
			end 
    	end
    end /**/
    
    ////////////////////////
    // zero_padding
    
    integer l, m, n;
     always@(posedge clk)
        begin
			if (reset == 1)
			begin
				N2_var2 <= 8'd0;
				M2_var2 <= 8'd0;
				C1_var2 <= 6'd0;
				zero_pad_done <= 1'd0;/*
				for (l=0; l < 130; l=l+1) 
				begin
					for (m=0; m < 130; m=m+1) 
					begin
						for( n=0; n < 3; n=n+1)
						begin
							image_mem_arr_in_zpad[l][m][n] <= 19'd0;//ONLY FOR SIM!!!
						end
					end	
				end  /**/  		
			end
		else if (image_deflattened == 1 && zero_pad_done == 0)
		begin
			image_mem_arr_in_zpad[N2_var2+ZERO_PAD_PARAM][M2_var2+ZERO_PAD_PARAM][C1_var2] <=
			image_mem_arr_in[N2_var2][M2_var2][C1_var2];
			C1_var2 <= C1_var2 + 1;
			if (C1_var2 >= C1_PARAM)
			begin
				C1_var2 <= 6'd0;
				M2_var2 <= M2_var2 + 1;
				if (M2_var2 >= M2_PARAM-1)
				begin
					M2_var2 <= 8'd0;					
					N2_var2 <= N2_var2 + 1;
					if (N2_var2 >= N2_PARAM-1)
						//N2_var2 <= 8'd0;
						if (N2_var2 >= 32)
						begin
							zero_pad_done <= 1'd1;
							
						end
				end
			end 
		end     
    end  /**/  
    
     ////////////////////////
	// recieving biases
	integer v;
	always@(posedge clk)
		if (reset == 1) begin
			biases_rdy <= 0;
			biases_vals_cnt <= 10'd0;
			biases_recieved <= 0;
			/*
			for (v =0; v < 30; v = v +1)begin
				biases_mem[v]<=15'd0;
			end/**/
		end
		else begin
			if (biases_recieved == 0)		 
				biases_rdy <= 1; 
				if( ((biases_mem[biases_vals_cnt] != biases) || (biases_vld == 1)) || (biases_vals_cnt == BIAS_MEM_LENGTH ) ) 
				begin
				//counter clicks if new value came to kernel data port or it's the last value  
					biases_vals_cnt <= biases_vals_cnt + 1'd1;
					biases_mem[biases_vals_cnt] <= biases;/*
					if (biases_vals_cnt >= 2)
					begin
						$display ("biases_mem[%0d] = %h | %b",
							 biases_vals_cnt-2, 
							biases_mem[biases_vals_cnt-2], biases_mem[biases_vals_cnt-2]);//$itor(output_biases_ram*imgSF));
					end/**/
				end	
				if (biases_vals_cnt == BIAS_MEM_LENGTH+2) 
				begin
					biases_recieved <= 1'b1;
				end
			else if(biases_recieved == 1)
				biases_mem[biases_vals_cnt] <= biases_mem[biases_vals_cnt];	
					
				//kernel_rdy0<=0; //why does this break all rdy-val protocol?????
		end
    
//---------------------------------------------------------------------------------------------------------
    ////////////////////////
    // recieving kernel[0]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy0 <= 0;
    		kernel0_mem[0] <= 20'd0;
    		kernel_vals_cnt[0] <= 5'd0;
    		kernel_recieved[0] <= 0;
    	end
    	else begin
    		if (kernel_recieved[0] == 0)		 
				kernel_rdy0 <= 1; 
				if(((kernel0_mem[kernel_vals_cnt[0]] != kernel0) || (kernel_vld0 == 1) )|| (kernel_vals_cnt[0] == KER_MEM_LENGTH)) begin
				//counter clicks if new value came to kernel data port or it's the last value  
					kernel_vals_cnt[0] <= kernel_vals_cnt[0] + 1'd1;
					kernel0_mem[kernel_vals_cnt[0]] <= kernel0;	/*
					if (kernel_vals_cnt[0]  >= 2 && kernel_vals_cnt[0] < 28)
					begin
						$display ("kernel0_mem[%0d] = %h | %b",
							 kernel_vals_cnt[0] -2, 
							kernel0_mem[kernel_vals_cnt[0]-2], kernel0_mem[kernel_vals_cnt[0]-2]);//$itor(output_biases_ram*imgSF));
					end/**/
				end				
				if (kernel_vals_cnt[0] == KER_MEM_LENGTH) begin
					kernel_recieved[0] <= 1'b1;
				end
					
			else if(kernel_recieved[0] == 1)
				kernel0_mem[kernel_vals_cnt[0]]<=kernel0_mem[kernel_vals_cnt[0]];	
				//kernel_rdy0<=0; //why does this break all rdy-val protocol?????
    	end
    	
    ////////////////////////
	// passing kernel[0] to 3D array-register 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N1_var_def0 <= 8'd0;
			M1_var_def0 <= 8'd0;
			C1_var_def0 <= 6'd0;
			L1_var_def0 <= 2'd0;
			kernel_deflattened[0] <= 1'd0;    		
		end
		else if (kernel_recieved[0] == 1 && kernel_deflattened[0] == 0)
		begin
			kernel_arr_in0[N1_var_def0][M1_var_def0][C1_var_def0][L1_var_def0] <=
			kernel0_mem[N1_var_def0*N1_PARAM*C1_PARAM + M1_var_def0*C1_PARAM 
			+ C1_var_def0 + L1_var_def0];
			//incerementing arrays counters
			//L1_var_def0 <= L1_var_def0 + 1;
			if (L1_var_def0 >= 0)
			begin
				L1_var_def0 <= 2'd0;
				C1_var_def0 <= C1_var_def0 + 1;
				if (C1_var_def0 >= C1_PARAM-1)
				begin
					C1_var_def0 <= 6'd0;
					M1_var_def0 <= M1_var_def0 + 1;
					if (M1_var_def0 >= M1_PARAM-1)
					begin
						M1_var_def0 <= 8'd0;					
						N1_var_def0 <= N1_var_def0 + 1;
						if (N1_var_def0 >= N1_PARAM-1)
						begin
							N1_var_def0 <= 8'd0;
							kernel_deflattened[0] <= 1'd1;
						end
					end
				end
			end 
		end
	end 
    
//---------------------------------------------------------------------------------------------------------
	////////////////////////
	// recieving kernel[1]
	always@(posedge clk)
		if (reset == 1) begin
			kernel_rdy1 <= 0;
			kernel1_mem[0] <= 20'd0;
			kernel_vals_cnt[1] <= 5'd0;
			kernel_recieved[1] <= 0;
		end
		else begin
			if (kernel_recieved[1] == 0)		 
				kernel_rdy1 <= 1; 
				if(((kernel1_mem[kernel_vals_cnt[1]] != kernel1) || (kernel_vld1 == 1) )|| (kernel_vals_cnt[1] == KER_MEM_LENGTH)) begin
				//counter clicks if new value came to kernel data port or it's the last value  
					kernel_vals_cnt[1] <= kernel_vals_cnt[1] + 1'd1;
					kernel1_mem[kernel_vals_cnt[1]] <= kernel1;	
				end				
				if (kernel_vals_cnt[1] == KER_MEM_LENGTH) begin
					kernel_recieved[1] <= 1'b1;
				end
					
			else if(kernel_recieved[1] == 1)
				kernel0_mem[kernel_vals_cnt[1]]<=kernel1_mem[kernel_vals_cnt[1]];
		end
		
	////////////////////////
	// passing kernel[1] to 3D array-register 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N1_var_def[1] <= 8'd0;
			M1_var_def[1] <= 8'd0;
			C1_var_def[1] <= 6'd0;
			L1_var_def[1] <= 2'd0;
			kernel_deflattened[1] <= 1'd0;    		
		end
		else if (kernel_recieved[1] == 1 && kernel_deflattened[1] == 0)
		begin
			kernel_arr_in1[N1_var_def[1]][M1_var_def[1]][C1_var_def[1]][L1_var_def[1]] <=
			kernel1_mem[N1_var_def[1]*N1_PARAM*C1_PARAM + M1_var_def[1]*C1_PARAM 
			+ C1_var_def[1] + L1_var_def[1]];
			//incerementing arrays counters
			if (L1_var_def[1] >= 0)
			begin
				L1_var_def[1] <= 2'd0;
				C1_var_def[1] <= C1_var_def[1] + 1;
				if (C1_var_def[1] >= C1_PARAM-1)
				begin
					C1_var_def[1] <= 6'd0;
					M1_var_def[1] <= M1_var_def[1] + 1;
					if (M1_var_def[1] >= M1_PARAM-1)
					begin
						M1_var_def[1] <= 8'd0;					
						N1_var_def[1] <= N1_var_def[1] + 1;
						if (N1_var_def[1] >= N1_PARAM-1)
						begin
							N1_var_def[1] <= 8'd0;
							kernel_deflattened[1] <= 1'd1;
						end
					end
				end
			end 
		end
	end 
//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[2]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy2 <= 0;
				kernel2_mem[0] <= 20'd0;
				kernel_vals_cnt[2] <= 5'd0;
				kernel_recieved[2] <= 0;
			end
			else begin
				if (kernel_recieved[2] == 0)		 
					kernel_rdy2 <= 1; 
					if(((kernel2_mem[kernel_vals_cnt[2]] != kernel2) || (kernel_vld2 == 1) )|| (kernel_vals_cnt[2] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[2] <= kernel_vals_cnt[2] + 1'd1;
						kernel2_mem[kernel_vals_cnt[2]] <= kernel1;	
					end				
					if (kernel_vals_cnt[2] == KER_MEM_LENGTH) begin
						kernel_recieved[2] <= 1'b1;
					end
						
				else if(kernel_recieved[2] == 1)
					kernel2_mem[kernel_vals_cnt[2]]<=kernel2_mem[kernel_vals_cnt[2]];
			end
			
		////////////////////////
		// passing kernel[2] to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[2] <= 8'd0;
				M1_var_def[2] <= 8'd0;
				C1_var_def[2] <= 6'd0;
				L1_var_def[2] <= 2'd0;
				kernel_deflattened[2] <= 1'd0;    		
			end
			else if (kernel_recieved[2] == 1 && kernel_deflattened[2] == 0)
			begin
				kernel_arr_in2[N1_var_def[2]][M1_var_def[2]][C1_var_def[2]][L1_var_def[2]] <=
				kernel2_mem[N1_var_def[2]*N1_PARAM*C1_PARAM + M1_var_def[2]*C1_PARAM 
				+ C1_var_def[2] + L1_var_def[2]];
				//incerementing arrays counters
				if (L1_var_def[2] >= 0)
				begin
					L1_var_def[2] <= 2'd0;
					C1_var_def[2] <= C1_var_def[2] + 1;
					if (C1_var_def[2] >= C1_PARAM-1)
					begin
						C1_var_def[2] <= 6'd0;
						M1_var_def[2] <= M1_var_def[2] + 1;
						if (M1_var_def[2] >= M1_PARAM-1)
						begin
							M1_var_def[2] <= 8'd0;					
							N1_var_def[2] <= N1_var_def[2] + 1;
							if (N1_var_def[2] >= N1_PARAM-1)
							begin
								N1_var_def[2] <= 8'd0;
								kernel_deflattened[2] <= 1'd1;
							end
						end
					end
				end 
			end
		end 
//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[3]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy3 <= 0;
				kernel3_mem[0] <= 20'd0;
				kernel_vals_cnt[3] <= 5'd0;
				kernel_recieved[3] <= 0;
			end
			else begin
				if (kernel_recieved[3] == 0)		 
					kernel_rdy3 <= 1; 
					if(((kernel3_mem[kernel_vals_cnt[3]] != kernel3) || (kernel_vld3 == 1) )|| (kernel_vals_cnt[3] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[3] <= kernel_vals_cnt[3] + 1'd1;
						kernel3_mem[kernel_vals_cnt[3]] <= kernel3;	
					end				
					if (kernel_vals_cnt[3] == KER_MEM_LENGTH) begin
						kernel_recieved[3] <= 1'b1;
					end
						
				else if(kernel_recieved[3] == 1)
					kernel3_mem[kernel_vals_cnt[3]]<=kernel3_mem[kernel_vals_cnt[3]];
			end
			
		////////////////////////
		// passing kernel[3] to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[3] <= 8'd0;
				M1_var_def[3] <= 8'd0;
				C1_var_def[3] <= 6'd0;
				L1_var_def[3] <= 2'd0;
				kernel_deflattened[3] <= 1'd0;    		
			end
			else if (kernel_recieved[3] == 1 && kernel_deflattened[3] == 0)
			begin
				kernel_arr_in3[N1_var_def[3]][M1_var_def[3]][C1_var_def[3]][L1_var_def[3]] <=
				kernel3_mem[N1_var_def[3]*N1_PARAM*C1_PARAM + M1_var_def[3]*C1_PARAM 
				+ C1_var_def[3] + L1_var_def[3]];
				//incerementing arrays counters
				if (L1_var_def[3] >= 0)
				begin
					L1_var_def[3] <= 2'd0;
					C1_var_def[3] <= C1_var_def[3] + 1;
					if (C1_var_def[3] >= C1_PARAM-1)
					begin
						C1_var_def[3] <= 6'd0;
						M1_var_def[3] <= M1_var_def[3] + 1;
						if (M1_var_def[3] >= M1_PARAM-1)
						begin
							M1_var_def[3] <= 8'd0;					
							N1_var_def[3] <= N1_var_def[3] + 1;
							if (N1_var_def[3] >= N1_PARAM-1)
							begin
								N1_var_def[3] <= 8'd0;
								kernel_deflattened[3] <= 1'd1;
							end
						end
					end
				end 
			end
		end

//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[4]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy4 <= 0;
				kernel_vals_cnt[4] <= 5'd0;
				kernel_recieved[4] <= 0;
			end
			else begin
				if (kernel_recieved[4] == 0)		 
					kernel_rdy4 <= 1; 
					if(((kernel4_mem[kernel_vals_cnt[4]] != kernel4) || (kernel_vld4 == 1) )|| (kernel_vals_cnt[4] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[4] <= kernel_vals_cnt[4] + 1'd1;
						kernel4_mem[kernel_vals_cnt[4]] <= kernel4;	
					end				
					if (kernel_vals_cnt[4] == KER_MEM_LENGTH) begin
						kernel_recieved[4] <= 1'b1;
					end
						
				else if(kernel_recieved[4] == 1)
					kernel3_mem[kernel_vals_cnt[4]]<=kernel4_mem[kernel_vals_cnt[4]];
			end
			
		////////////////////////
		// passing kernel[4] to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[4] <= 8'd0;
				M1_var_def[4] <= 8'd0;
				C1_var_def[4] <= 6'd0;
				L1_var_def[4] <= 2'd0;
				kernel_deflattened[4] <= 1'd0;    		
			end
			else if (kernel_recieved[4] == 1 && kernel_deflattened[4] == 0)
			begin
				kernel_arr_in4[N1_var_def[4]][M1_var_def[4]][C1_var_def[4]][L1_var_def[4]] <=
				kernel4_mem[N1_var_def[4]*N1_PARAM*C1_PARAM + M1_var_def[4]*C1_PARAM 
				+ C1_var_def[4] + L1_var_def[4]];
				//incerementing arrays counters
				if (L1_var_def[4] >= 0)
				begin
					L1_var_def[4] <= 2'd0;
					C1_var_def[4] <= C1_var_def[4] + 1;
					if (C1_var_def[4] >= C1_PARAM-1)
					begin
						C1_var_def[4] <= 6'd0;
						M1_var_def[4] <= M1_var_def[4] + 1;
						if (M1_var_def[4] >= M1_PARAM-1)
						begin
							M1_var_def[4] <= 8'd0;					
							N1_var_def[4] <= N1_var_def[4] + 1;
							if (N1_var_def[4] >= N1_PARAM-1)
							begin
								N1_var_def[4] <= 8'd0;
								kernel_deflattened[4] <= 1'd1;
							end
						end
					end
				end 
			end
		end
//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[5]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy5 <= 0;
				kernel5_mem[0] <= 20'd0;
				kernel_vals_cnt[5] <= 5'd0;
				kernel_recieved[5] <= 0;
			end
			else begin
				if (kernel_recieved[5] == 0)		 
					kernel_rdy5 <= 1; 
					if(((kernel5_mem[kernel_vals_cnt[5]] != kernel5) || (kernel_vld5 == 1) )|| (kernel_vals_cnt[5] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[5] <= kernel_vals_cnt[5] + 1'd1;
						kernel5_mem[kernel_vals_cnt[5]] <= kernel5;	
					end				
					if (kernel_vals_cnt[5] == KER_MEM_LENGTH) begin
						kernel_recieved[5] <= 1'b1;
					end
						
				else if(kernel_recieved[5] == 1)
					kernel5_mem[kernel_vals_cnt[5]]<=kernel5_mem[kernel_vals_cnt[5]];
			end
			
		////////////////////////
		// passing kernel[5] to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[5] <= 8'd0;
				M1_var_def[5] <= 8'd0;
				C1_var_def[5] <= 6'd0;
				L1_var_def[5] <= 2'd0;
				kernel_deflattened[5] <= 1'd0;    		
			end
			else if (kernel_recieved[5] == 1 && kernel_deflattened[5] == 0)
			begin
				kernel_arr_in5[N1_var_def[5]][M1_var_def[5]][C1_var_def[5]][L1_var_def[5]] <=
				kernel3_mem[N1_var_def[5]*N1_PARAM*C1_PARAM + M1_var_def[5]*C1_PARAM 
				+ C1_var_def[5] + L1_var_def[5]];
				//incerementing arrays counters
				if (L1_var_def[5] >= 0)
				begin
					L1_var_def[5] <= 2'd0;
					C1_var_def[5] <= C1_var_def[5] + 1;
					if (C1_var_def[5] >= C1_PARAM-1)
					begin
						C1_var_def[5] <= 6'd0;
						M1_var_def[5] <= M1_var_def[5] + 1;
						if (M1_var_def[5] >= M1_PARAM-1)
						begin
							M1_var_def[5] <= 8'd0;					
							N1_var_def[5] <= N1_var_def[5] + 1;
							if (N1_var_def[5] >= N1_PARAM-1)
							begin
								N1_var_def[5] <= 8'd0;
								kernel_deflattened[5] <= 1'd1;
							end
						end
					end
				end 
			end
		end
//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[6]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy6 <= 0;
				kernel_vals_cnt[6] <= 5'd0;
				kernel_recieved[6] <= 0;
			end
			else begin
				if (kernel_recieved[6] == 0)		 
					kernel_rdy6 <= 1; 
					if(((kernel6_mem[kernel_vals_cnt[6]] != kernel6) || (kernel_vld6 == 1) )|| (kernel_vals_cnt[6] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[6] <= kernel_vals_cnt[6] + 1'd1;
						kernel6_mem[kernel_vals_cnt[6]] <= kernel6;	
					end				
					if (kernel_vals_cnt[6] == KER_MEM_LENGTH) begin
						kernel_recieved[6] <= 1'b1;
					end
						
				else if(kernel_recieved[6] == 1)
					kernel6_mem[kernel_vals_cnt[6]]<=kernel6_mem[kernel_vals_cnt[6]];
			end
			
		////////////////////////
		// passing kernel[6] to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[6] <= 8'd0;
				M1_var_def[6] <= 8'd0;
				C1_var_def[6] <= 6'd0;
				L1_var_def[6] <= 2'd0;
				kernel_deflattened[6] <= 1'd0;    		
			end
			else if (kernel_recieved[6] == 1 && kernel_deflattened[6] == 0)
			begin
				kernel_arr_in6[N1_var_def[6]][M1_var_def[6]][C1_var_def[6]][L1_var_def[6]] <=
				kernel6_mem[N1_var_def[6]*N1_PARAM*C1_PARAM + M1_var_def[6]*C1_PARAM 
				+ C1_var_def[6] + L1_var_def[6]];
				//incerementing arrays counters
				if (L1_var_def[6] >= 0)
				begin
					L1_var_def[6] <= 2'd0;
					C1_var_def[6] <= C1_var_def[6] + 1;
					if (C1_var_def[6] >= C1_PARAM-1)
					begin
						C1_var_def[6] <= 6'd0;
						M1_var_def[6] <= M1_var_def[6] + 1;
						if (M1_var_def[6] >= M1_PARAM-1)
						begin
							M1_var_def[6] <= 8'd0;					
							N1_var_def[6] <= N1_var_def[6] + 1;
							if (N1_var_def[6] >= N1_PARAM-1)
							begin
								N1_var_def[6] <= 8'd0;
								kernel_deflattened[6] <= 1'd1;
							end
						end
					end
				end 
			end
		end 
//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[7]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy7 <= 0;
				kernel_vals_cnt[7] <= 5'd0;
				kernel_recieved[7] <= 0;
			end
			else begin
				if (kernel_recieved[7] == 0)		 
					kernel_rdy7 <= 1; 
					if(((kernel7_mem[kernel_vals_cnt[7]] != kernel7) || (kernel_vld7 == 1) )|| (kernel_vals_cnt[7] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[7] <= kernel_vals_cnt[7] + 1'd1;
						kernel7_mem[kernel_vals_cnt[7]] <= kernel7;	
					end				
					if (kernel_vals_cnt[7] == KER_MEM_LENGTH) begin
						kernel_recieved[7] <= 1'b1;
					end
						
				else if(kernel_recieved[7] == 1)
					kernel7_mem[kernel_vals_cnt[7]]<=kernel7_mem[kernel_vals_cnt[7]];
			end
			
		////////////////////////
		// passing kernel[7] to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[7] <= 8'd0;
				M1_var_def[7] <= 8'd0;
				C1_var_def[7] <= 6'd0;
				L1_var_def[7] <= 2'd0;
				kernel_deflattened[7] <= 1'd0;    		
			end
			else if (kernel_recieved[7] == 1 && kernel_deflattened[7] == 0)
			begin
				kernel_arr_in7[N1_var_def[7]][M1_var_def[7]][C1_var_def[7]][L1_var_def[7]] <=
				kernel7_mem[N1_var_def[7]*N1_PARAM*C1_PARAM + M1_var_def[7]*C1_PARAM 
				+ C1_var_def[7] + L1_var_def[7]];
				//incerementing arrays counters
				if (L1_var_def[7] >= 0)
				begin
					L1_var_def[7] <= 2'd0;
					C1_var_def[7] <= C1_var_def[7] + 1;
					if (C1_var_def[7] >= C1_PARAM-1)
					begin
						C1_var_def[7] <= 6'd0;
						M1_var_def[7] <= M1_var_def[7] + 1;
						if (M1_var_def[7] >= M1_PARAM-1)
						begin
							M1_var_def[7] <= 8'd0;					
							N1_var_def[7] <= N1_var_def[7] + 1;
							if (N1_var_def[7] >= N1_PARAM-1)
							begin
								N1_var_def[7] <= 8'd0;
								kernel_deflattened[7] <= 1'd1;
							end
						end
					end
				end 
			end
		end 

//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[8]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy8 <= 0;
				kernel_vals_cnt[8] <= 5'd0;
				kernel_recieved[8] <= 0;
			end
			else begin
				if (kernel_recieved[8] == 0)		 
					kernel_rdy8 <= 1; 
					if(((kernel8_mem[kernel_vals_cnt[8]] != kernel8) || (kernel_vld8 == 1) )|| (kernel_vals_cnt[8] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[8] <= kernel_vals_cnt[8] + 1'd1;
						kernel7_mem[kernel_vals_cnt[8]] <= kernel8;	
					end				
					if (kernel_vals_cnt[8] == KER_MEM_LENGTH) begin
						kernel_recieved[8] <= 1'b1;
					end
						
				else if(kernel_recieved[8] == 1)
					kernel8_mem[kernel_vals_cnt[8]]<=kernel8_mem[kernel_vals_cnt[8]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[8] <= 8'd0;
				M1_var_def[8] <= 8'd0;
				C1_var_def[8] <= 6'd0;
				L1_var_def[8] <= 2'd0;
				kernel_deflattened[8] <= 1'd0;    		
			end
			else if (kernel_recieved[8] == 1 && kernel_deflattened[8] == 0)
			begin
				kernel_arr_in8[N1_var_def[8]][M1_var_def[8]][C1_var_def[8]][L1_var_def[8]] <=
				kernel7_mem[N1_var_def[8]*N1_PARAM*C1_PARAM + M1_var_def[8]*C1_PARAM 
				+ C1_var_def[8] + L1_var_def[8]];
				//incerementing arrays counters
				if (L1_var_def[8] >= 0)
				begin
					L1_var_def[8] <= 2'd0;
					C1_var_def[8] <= C1_var_def[8] + 1;
					if (C1_var_def[8] >= C1_PARAM-1)
					begin
						C1_var_def[8] <= 6'd0;
						M1_var_def[8] <= M1_var_def[8] + 1;
						if (M1_var_def[8] >= M1_PARAM-1)
						begin
							M1_var_def[8] <= 8'd0;					
							N1_var_def[8] <= N1_var_def[8] + 1;
							if (N1_var_def[8] >= N1_PARAM-1)
							begin
								N1_var_def[8] <= 8'd0;
								kernel_deflattened[8] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[9]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy9 <= 0;
				kernel_vals_cnt[9] <= 5'd0;
				kernel_recieved[9] <= 0;
			end
			else begin
				if (kernel_recieved[9] == 0)		 
					kernel_rdy9 <= 1; 
					if(((kernel9_mem[kernel_vals_cnt[9]] != kernel9) || (kernel_vld9 == 1) )|| (kernel_vals_cnt[9] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[9] <= kernel_vals_cnt[9] + 1'd1;
						kernel9_mem[kernel_vals_cnt[9]] <= kernel9;	
					end				
					if (kernel_vals_cnt[9] == KER_MEM_LENGTH) begin
						kernel_recieved[9] <= 1'b1;
					end
						
				else if(kernel_recieved[9] == 1)
					kernel9_mem[kernel_vals_cnt[9]]<=kernel9_mem[kernel_vals_cnt[9]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[9] <= 8'd0;
				M1_var_def[9] <= 8'd0;
				C1_var_def[9] <= 6'd0;
				L1_var_def[9] <= 2'd0;
				kernel_deflattened[9] <= 1'd0;    		
			end
			else if (kernel_recieved[9] == 1 && kernel_deflattened[9] == 0)
			begin
				kernel_arr_in9[N1_var_def[9]][M1_var_def[9]][C1_var_def[9]][L1_var_def[9]] <=
				kernel9_mem[N1_var_def[9]*N1_PARAM*C1_PARAM + M1_var_def[9]*C1_PARAM 
				+ C1_var_def[9] + L1_var_def[9]];
				//incerementing arrays counters
				if (L1_var_def[9] >= 0)
				begin
					L1_var_def[9] <= 2'd0;
					C1_var_def[9] <= C1_var_def[9] + 1;
					if (C1_var_def[9] >= C1_PARAM-1)
					begin
						C1_var_def[9] <= 6'd0;
						M1_var_def[9] <= M1_var_def[9] + 1;
						if (M1_var_def[9] >= M1_PARAM-1)
						begin
							M1_var_def[9] <= 8'd0;					
							N1_var_def[9] <= N1_var_def[9] + 1;
							if (N1_var_def[9] >= N1_PARAM-1)
							begin
								N1_var_def[9] <= 8'd0;
								kernel_deflattened[9] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[10]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy10 <= 0;
				kernel_vals_cnt[10] <= 5'd0;
				kernel_recieved[10] <= 0;
			end
			else begin
				if (kernel_recieved[10] == 0)		 
					kernel_rdy10 <= 1; 
					if(((kernel10_mem[kernel_vals_cnt[10]] != kernel10) || (kernel_vld10 == 1) )|| (kernel_vals_cnt[10] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[10] <= kernel_vals_cnt[10] + 1'd1;
						kernel10_mem[kernel_vals_cnt[10]] <= kernel10;	
					end				
					if (kernel_vals_cnt[10] == KER_MEM_LENGTH) begin
						kernel_recieved[10] <= 1'b1;
					end
						
				else if(kernel_recieved[10] == 1)
					kernel10_mem[kernel_vals_cnt[10]]<=kernel10_mem[kernel_vals_cnt[10]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[10] <= 8'd0;
				M1_var_def[10] <= 8'd0;
				C1_var_def[10] <= 6'd0;
				L1_var_def[10] <= 2'd0;
				kernel_deflattened[10] <= 1'd0;    		
			end
			else if (kernel_recieved[10] == 1 && kernel_deflattened[10] == 0)
			begin
				kernel_arr_in10[N1_var_def[10]][M1_var_def[10]][C1_var_def[10]][L1_var_def[10]] <=
				kernel10_mem[N1_var_def[10]*N1_PARAM*C1_PARAM + M1_var_def[10]*C1_PARAM 
				+ C1_var_def[10] + L1_var_def[10]];
				//incerementing arrays counters
				if (L1_var_def[10] >= 0)
				begin
					L1_var_def[10] <= 2'd0;
					C1_var_def[10] <= C1_var_def[10] + 1;
					if (C1_var_def[10] >= C1_PARAM-1)
					begin
						C1_var_def[10] <= 6'd0;
						M1_var_def[10] <= M1_var_def[10] + 1;
						if (M1_var_def[10] >= M1_PARAM-1)
						begin
							M1_var_def[10] <= 8'd0;					
							N1_var_def[10] <= N1_var_def[10] + 1;
							if (N1_var_def[10] >= N1_PARAM-1)
							begin
								N1_var_def[10] <= 8'd0;
								kernel_deflattened[10] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[11]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy11 <= 0;
				kernel_vals_cnt[11] <= 5'd0;
				kernel_recieved[11] <= 0;
			end
			else begin
				if (kernel_recieved[11] == 0)		 
					kernel_rdy11 <= 1; 
					if(((kernel11_mem[kernel_vals_cnt[11]] != kernel11) || (kernel_vld11 == 1) )|| (kernel_vals_cnt[11] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[11] <= kernel_vals_cnt[11] + 1'd1;
						kernel11_mem[kernel_vals_cnt[11]] <= kernel11;	
					end				
					if (kernel_vals_cnt[11] == KER_MEM_LENGTH) begin
						kernel_recieved[11] <= 1'b1;
					end
						
				else if(kernel_recieved[11] == 1)
					kernel11_mem[kernel_vals_cnt[11]]<=kernel11_mem[kernel_vals_cnt[11]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[11] <= 8'd0;
				M1_var_def[11] <= 8'd0;
				C1_var_def[11] <= 6'd0;
				L1_var_def[11] <= 2'd0;
				kernel_deflattened[11] <= 1'd0;    		
			end
			else if (kernel_recieved[11] == 1 && kernel_deflattened[11] == 0)
			begin
				kernel_arr_in11[N1_var_def[11]][M1_var_def[11]][C1_var_def[11]][L1_var_def[11]] <=
				kernel11_mem[N1_var_def[11]*N1_PARAM*C1_PARAM + M1_var_def[11]*C1_PARAM 
				+ C1_var_def[11] + L1_var_def[11]];
				//incerementing arrays counters
				if (L1_var_def[11] >= 0)
				begin
					L1_var_def[11] <= 2'd0;
					C1_var_def[11] <= C1_var_def[11] + 1;
					if (C1_var_def[11] >= C1_PARAM-1)
					begin
						C1_var_def[11] <= 6'd0;
						M1_var_def[11] <= M1_var_def[11] + 1;
						if (M1_var_def[11] >= M1_PARAM-1)
						begin
							M1_var_def[11] <= 8'd0;					
							N1_var_def[11] <= N1_var_def[11] + 1;
							if (N1_var_def[11] >= N1_PARAM-1)
							begin
								N1_var_def[11] <= 8'd0;
								kernel_deflattened[11] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[12]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy12 <= 0;
				kernel_vals_cnt[12] <= 5'd0;
				kernel_recieved[12] <= 0;
			end
			else begin
				if (kernel_recieved[12] == 0)		 
					kernel_rdy12 <= 1; 
					if(((kernel12_mem[kernel_vals_cnt[12]] != kernel12) || (kernel_vld12 == 1) )|| (kernel_vals_cnt[12] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[12] <= kernel_vals_cnt[12] + 1'd1;
						kernel12_mem[kernel_vals_cnt[12]] <= kernel12;	
					end				
					if (kernel_vals_cnt[12] == KER_MEM_LENGTH) begin
						kernel_recieved[12] <= 1'b1;
					end
						
				else if(kernel_recieved[12] == 1)
					kernel12_mem[kernel_vals_cnt[12]]<=kernel12_mem[kernel_vals_cnt[12]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[12] <= 8'd0;
				M1_var_def[12] <= 8'd0;
				C1_var_def[12] <= 6'd0;
				L1_var_def[12] <= 2'd0;
				kernel_deflattened[12] <= 1'd0;    		
			end
			else if (kernel_recieved[12] == 1 && kernel_deflattened[12] == 0)
			begin
				kernel_arr_in12[N1_var_def[12]][M1_var_def[12]][C1_var_def[12]][L1_var_def[12]] <=
				kernel12_mem[N1_var_def[12]*N1_PARAM*C1_PARAM + M1_var_def[12]*C1_PARAM 
				+ C1_var_def[12] + L1_var_def[12]];
				//incerementing arrays counters
				if (L1_var_def[12] >= 0)
				begin
					L1_var_def[12] <= 2'd0;
					C1_var_def[12] <= C1_var_def[12] + 1;
					if (C1_var_def[12] >= C1_PARAM-1)
					begin
						C1_var_def[12] <= 6'd0;
						M1_var_def[12] <= M1_var_def[12] + 1;
						if (M1_var_def[12] >= M1_PARAM-1)
						begin
							M1_var_def[12] <= 8'd0;					
							N1_var_def[12] <= N1_var_def[12] + 1;
							if (N1_var_def[12] >= N1_PARAM-1)
							begin
								N1_var_def[12] <= 8'd0;
								kernel_deflattened[12] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[13]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy13 <= 0;
				kernel_vals_cnt[13] <= 5'd0;
				kernel_recieved[13] <= 0;
			end
			else begin
				if (kernel_recieved[13] == 0)		 
					kernel_rdy13 <= 1; 
					if(((kernel13_mem[kernel_vals_cnt[13]] != kernel13) || (kernel_vld13 == 1) )|| (kernel_vals_cnt[13] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[13] <= kernel_vals_cnt[13] + 1'd1;
						kernel13_mem[kernel_vals_cnt[13]] <= kernel13;	
					end				
					if (kernel_vals_cnt[13] == KER_MEM_LENGTH) begin
						kernel_recieved[13] <= 1'b1;
					end
						
				else if(kernel_recieved[13] == 1)
					kernel13_mem[kernel_vals_cnt[13]]<=kernel13_mem[kernel_vals_cnt[13]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[13] <= 8'd0;
				M1_var_def[13] <= 8'd0;
				C1_var_def[13] <= 6'd0;
				L1_var_def[13] <= 2'd0;
				kernel_deflattened[13] <= 1'd0;    		
			end
			else if (kernel_recieved[13] == 1 && kernel_deflattened[13] == 0)
			begin
				kernel_arr_in13[N1_var_def[13]][M1_var_def[13]][C1_var_def[13]][L1_var_def[13]] <=
				kernel13_mem[N1_var_def[13]*N1_PARAM*C1_PARAM + M1_var_def[13]*C1_PARAM 
				+ C1_var_def[13] + L1_var_def[13]];
				//incerementing arrays counters
				if (L1_var_def[13] >= 0)
				begin
					L1_var_def[13] <= 2'd0;
					C1_var_def[13] <= C1_var_def[13] + 1;
					if (C1_var_def[13] >= C1_PARAM-1)
					begin
						C1_var_def[13] <= 6'd0;
						M1_var_def[13] <= M1_var_def[13] + 1;
						if (M1_var_def[13] >= M1_PARAM-1)
						begin
							M1_var_def[13] <= 8'd0;					
							N1_var_def[13] <= N1_var_def[13] + 1;
							if (N1_var_def[13] >= N1_PARAM-1)
							begin
								N1_var_def[13] <= 8'd0;
								kernel_deflattened[13] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[14]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy14 <= 0;
				kernel_vals_cnt[14] <= 5'd0;
				kernel_recieved[14] <= 0;
			end
			else begin
				if (kernel_recieved[14] == 0)		 
					kernel_rdy14 <= 1; 
					if(((kernel14_mem[kernel_vals_cnt[14]] != kernel14) || (kernel_vld14 == 1) )|| (kernel_vals_cnt[14] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[14] <= kernel_vals_cnt[14] + 1'd1;
						kernel14_mem[kernel_vals_cnt[14]] <= kernel14;	
					end				
					if (kernel_vals_cnt[14] == KER_MEM_LENGTH) begin
						kernel_recieved[14] <= 1'b1;
					end
						
				else if(kernel_recieved[14] == 1)
					kernel14_mem[kernel_vals_cnt[14]]<=kernel14_mem[kernel_vals_cnt[14]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[14] <= 8'd0;
				M1_var_def[14] <= 8'd0;
				C1_var_def[14] <= 6'd0;
				L1_var_def[14] <= 2'd0;
				kernel_deflattened[14] <= 1'd0;    		
			end
			else if (kernel_recieved[14] == 1 && kernel_deflattened[14] == 0)
			begin
				kernel_arr_in14[N1_var_def[14]][M1_var_def[14]][C1_var_def[14]][L1_var_def[14]] <=
				kernel14_mem[N1_var_def[14]*N1_PARAM*C1_PARAM + M1_var_def[14]*C1_PARAM 
				+ C1_var_def[14] + L1_var_def[14]];
				//incerementing arrays counters
				if (L1_var_def[14] >= 0)
				begin
					L1_var_def[14] <= 2'd0;
					C1_var_def[14] <= C1_var_def[14] + 1;
					if (C1_var_def[14] >= C1_PARAM-1)
					begin
						C1_var_def[14] <= 6'd0;
						M1_var_def[14] <= M1_var_def[14] + 1;
						if (M1_var_def[14] >= M1_PARAM-1)
						begin
							M1_var_def[14] <= 8'd0;					
							N1_var_def[14] <= N1_var_def[14] + 1;
							if (N1_var_def[14] >= N1_PARAM-1)
							begin
								N1_var_def[14] <= 8'd0;
								kernel_deflattened[14] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[15]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy15 <= 0;
				kernel_vals_cnt[15] <= 5'd0;
				kernel_recieved[15] <= 0;
			end
			else begin
				if (kernel_recieved[15] == 0)		 
					kernel_rdy15 <= 1; 
					if(((kernel15_mem[kernel_vals_cnt[15]] != kernel15) || (kernel_vld15 == 1) )|| (kernel_vals_cnt[15] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[15] <= kernel_vals_cnt[15] + 1'd1;
						kernel15_mem[kernel_vals_cnt[15]] <= kernel15;	
					end				
					if (kernel_vals_cnt[15] == KER_MEM_LENGTH) begin
						kernel_recieved[15] <= 1'b1;
					end
						
				else if(kernel_recieved[15] == 1)
					kernel15_mem[kernel_vals_cnt[15]]<=kernel15_mem[kernel_vals_cnt[15]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[15] <= 8'd0;
				M1_var_def[15] <= 8'd0;
				C1_var_def[15] <= 6'd0;
				L1_var_def[15] <= 2'd0;
				kernel_deflattened[15] <= 1'd0;    		
			end
			else if (kernel_recieved[15] == 1 && kernel_deflattened[15] == 0)
			begin
				kernel_arr_in15[N1_var_def[15]][M1_var_def[15]][C1_var_def[15]][L1_var_def[15]] <=
				kernel15_mem[N1_var_def[15]*N1_PARAM*C1_PARAM + M1_var_def[15]*C1_PARAM 
				+ C1_var_def[15] + L1_var_def[15]];
				//incerementing arrays counters
				if (L1_var_def[15] >= 0)
				begin
					L1_var_def[15] <= 2'd0;
					C1_var_def[15] <= C1_var_def[15] + 1;
					if (C1_var_def[15] >= C1_PARAM-1)
					begin
						C1_var_def[15] <= 6'd0;
						M1_var_def[15] <= M1_var_def[15] + 1;
						if (M1_var_def[15] >= M1_PARAM-1)
						begin
							M1_var_def[15] <= 8'd0;					
							N1_var_def[15] <= N1_var_def[15] + 1;
							if (N1_var_def[15] >= N1_PARAM-1)
							begin
								N1_var_def[15] <= 8'd0;
								kernel_deflattened[15] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[16]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy16 <= 0;
				kernel_vals_cnt[16] <= 5'd0;
				kernel_recieved[16] <= 0;
			end
			else begin
				if (kernel_recieved[16] == 0)		 
					kernel_rdy16 <= 1; 
					if(((kernel16_mem[kernel_vals_cnt[16]] != kernel16) || (kernel_vld16 == 1) )|| (kernel_vals_cnt[16] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[16] <= kernel_vals_cnt[16] + 1'd1;
						kernel16_mem[kernel_vals_cnt[16]] <= kernel16;	
					end				
					if (kernel_vals_cnt[16] == KER_MEM_LENGTH) begin
						kernel_recieved[16] <= 1'b1;
					end
						
				else if(kernel_recieved[16] == 1)
					kernel16_mem[kernel_vals_cnt[16]]<=kernel16_mem[kernel_vals_cnt[16]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[16] <= 8'd0;
				M1_var_def[16] <= 8'd0;
				C1_var_def[16] <= 6'd0;
				L1_var_def[16] <= 2'd0;
				kernel_deflattened[16] <= 1'd0;    		
			end
			else if (kernel_recieved[16] == 1 && kernel_deflattened[16] == 0)
			begin
				kernel_arr_in16[N1_var_def[16]][M1_var_def[16]][C1_var_def[16]][L1_var_def[16]] <=
				kernel16_mem[N1_var_def[16]*N1_PARAM*C1_PARAM + M1_var_def[16]*C1_PARAM 
				+ C1_var_def[16] + L1_var_def[16]];
				//incerementing arrays counters
				if (L1_var_def[16] >= 0)
				begin
					L1_var_def[16] <= 2'd0;
					C1_var_def[16] <= C1_var_def[16] + 1;
					if (C1_var_def[16] >= C1_PARAM-1)
					begin
						C1_var_def[16] <= 6'd0;
						M1_var_def[16] <= M1_var_def[16] + 1;
						if (M1_var_def[16] >= M1_PARAM-1)
						begin
							M1_var_def[16] <= 8'd0;					
							N1_var_def[16] <= N1_var_def[16] + 1;
							if (N1_var_def[16] >= N1_PARAM-1)
							begin
								N1_var_def[16] <= 8'd0;
								kernel_deflattened[16] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[17]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy17 <= 0;
				kernel_vals_cnt[17] <= 5'd0;
				kernel_recieved[17] <= 0;
			end
			else begin
				if (kernel_recieved[17] == 0)		 
					kernel_rdy17 <= 1; 
					if(((kernel7_mem[kernel_vals_cnt[17]] != kernel17) || (kernel_vld17 == 1) )|| (kernel_vals_cnt[17] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[17] <= kernel_vals_cnt[17] + 1'd1;
						kernel17_mem[kernel_vals_cnt[17]] <= kernel17;	
					end				
					if (kernel_vals_cnt[17] == KER_MEM_LENGTH) begin
						kernel_recieved[17] <= 1'b1;
					end
						
				else if(kernel_recieved[17] == 1)
					kernel17_mem[kernel_vals_cnt[17]]<=kernel7_mem[kernel_vals_cnt[17]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[17] <= 8'd0;
				M1_var_def[17] <= 8'd0;
				C1_var_def[17] <= 6'd0;
				L1_var_def[17] <= 2'd0;
				kernel_deflattened[17] <= 1'd0;    		
			end
			else if (kernel_recieved[17] == 1 && kernel_deflattened[17] == 0)
			begin
				kernel_arr_in17[N1_var_def[17]][M1_var_def[17]][C1_var_def[17]][L1_var_def[17]] <=
				kernel17_mem[N1_var_def[17]*N1_PARAM*C1_PARAM + M1_var_def[17]*C1_PARAM 
				+ C1_var_def[17] + L1_var_def[17]];
				//incerementing arrays counters
				if (L1_var_def[17] >= 0)
				begin
					L1_var_def[17] <= 2'd0;
					C1_var_def[17] <= C1_var_def[17] + 1;
					if (C1_var_def[17] >= C1_PARAM-1)
					begin
						C1_var_def[17] <= 6'd0;
						M1_var_def[17] <= M1_var_def[17] + 1;
						if (M1_var_def[17] >= M1_PARAM-1)
						begin
							M1_var_def[17] <= 8'd0;					
							N1_var_def[17] <= N1_var_def[17] + 1;
							if (N1_var_def[17] >= N1_PARAM-1)
							begin
								N1_var_def[17] <= 8'd0;
								kernel_deflattened[17] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[18]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy18 <= 0;
				kernel_vals_cnt[18] <= 5'd0;
				kernel_recieved[18] <= 0;
			end
			else begin
				if (kernel_recieved[18] == 0)		 
					kernel_rdy18 <= 1; 
					if(((kernel18_mem[kernel_vals_cnt[18]] != kernel18) || (kernel_vld18 == 1) )|| (kernel_vals_cnt[18] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[18] <= kernel_vals_cnt[18] + 1'd1;
						kernel18_mem[kernel_vals_cnt[18]] <= kernel18;	
					end				
					if (kernel_vals_cnt[18] == KER_MEM_LENGTH) begin
						kernel_recieved[18] <= 1'b1;
					end
						
				else if(kernel_recieved[18] == 1)
					kernel18_mem[kernel_vals_cnt[18]]<=kernel18_mem[kernel_vals_cnt[18]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[18] <= 8'd0;
				M1_var_def[18] <= 8'd0;
				C1_var_def[18] <= 6'd0;
				L1_var_def[18] <= 2'd0;
				kernel_deflattened[18] <= 1'd0;    		
			end
			else if (kernel_recieved[18] == 1 && kernel_deflattened[18] == 0)
			begin
				kernel_arr_in18[N1_var_def[18]][M1_var_def[18]][C1_var_def[18]][L1_var_def[18]] <=
				kernel18_mem[N1_var_def[18]*N1_PARAM*C1_PARAM + M1_var_def[18]*C1_PARAM 
				+ C1_var_def[18] + L1_var_def[18]];
				//incerementing arrays counters
				if (L1_var_def[18] >= 0)
				begin
					L1_var_def[18] <= 2'd0;
					C1_var_def[18] <= C1_var_def[18] + 1;
					if (C1_var_def[18] >= C1_PARAM-1)
					begin
						C1_var_def[18] <= 6'd0;
						M1_var_def[18] <= M1_var_def[18] + 1;
						if (M1_var_def[18] >= M1_PARAM-1)
						begin
							M1_var_def[18] <= 8'd0;					
							N1_var_def[18] <= N1_var_def[18] + 1;
							if (N1_var_def[18] >= N1_PARAM-1)
							begin
								N1_var_def[18] <= 8'd0;
								kernel_deflattened[18] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[19]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy19 <= 0;
				kernel_vals_cnt[19] <= 5'd0;
				kernel_recieved[19] <= 0;
			end
			else begin
				if (kernel_recieved[19] == 0)		 
					kernel_rdy19 <= 1; 
					if(((kernel19_mem[kernel_vals_cnt[19]] != kernel19) || (kernel_vld19 == 1) )|| (kernel_vals_cnt[19] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[19] <= kernel_vals_cnt[19] + 1'd1;
						kernel19_mem[kernel_vals_cnt[19]] <= kernel19;	
					end				
					if (kernel_vals_cnt[19] == KER_MEM_LENGTH) begin
						kernel_recieved[19] <= 1'b1;
					end
						
				else if(kernel_recieved[19] == 1)
					kernel7_mem[kernel_vals_cnt[19]]<=kernel7_mem[kernel_vals_cnt[19]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[19] <= 8'd0;
				M1_var_def[19] <= 8'd0;
				C1_var_def[19] <= 6'd0;
				L1_var_def[19] <= 2'd0;
				kernel_deflattened[19] <= 1'd0;    		
			end
			else if (kernel_recieved[19] == 1 && kernel_deflattened[19] == 0)
			begin
				kernel_arr_in19[N1_var_def[19]][M1_var_def[19]][C1_var_def[19]][L1_var_def[19]] <=
				kernel19_mem[N1_var_def[19]*N1_PARAM*C1_PARAM + M1_var_def[19]*C1_PARAM 
				+ C1_var_def[19] + L1_var_def[19]];
				//incerementing arrays counters
				if (L1_var_def[19] >= 0)
				begin
					L1_var_def[19] <= 2'd0;
					C1_var_def[19] <= C1_var_def[19] + 1;
					if (C1_var_def[19] >= C1_PARAM-1)
					begin
						C1_var_def[19] <= 6'd0;
						M1_var_def[19] <= M1_var_def[19] + 1;
						if (M1_var_def[19] >= M1_PARAM-1)
						begin
							M1_var_def[19] <= 8'd0;					
							N1_var_def[19] <= N1_var_def[19] + 1;
							if (N1_var_def[19] >= N1_PARAM-1)
							begin
								N1_var_def[19] <= 8'd0;
								kernel_deflattened[19] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[20]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy20 <= 0;
				kernel_vals_cnt[20] <= 5'd0;
				kernel_recieved[20] <= 0;
			end
			else begin
				if (kernel_recieved[20] == 0)		 
					kernel_rdy20 <= 1; 
					if(((kernel20_mem[kernel_vals_cnt[20]] != kernel20) || (kernel_vld20 == 1) )|| (kernel_vals_cnt[20] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[20] <= kernel_vals_cnt[20] + 1'd1;
						kernel20_mem[kernel_vals_cnt[20]] <= kernel20;	
					end				
					if (kernel_vals_cnt[20] == KER_MEM_LENGTH) begin
						kernel_recieved[20] <= 1'b1;
					end
						
				else if(kernel_recieved[20] == 1)
					kernel20_mem[kernel_vals_cnt[20]]<=kernel7_mem[kernel_vals_cnt[20]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[20] <= 8'd0;
				M1_var_def[20] <= 8'd0;
				C1_var_def[20] <= 6'd0;
				L1_var_def[20] <= 2'd0;
				kernel_deflattened[20] <= 1'd0;    		
			end
			else if (kernel_recieved[20] == 1 && kernel_deflattened[20] == 0)
			begin
				kernel_arr_in20[N1_var_def[20]][M1_var_def[20]][C1_var_def[20]][L1_var_def[20]] <=
				kernel20_mem[N1_var_def[20]*N1_PARAM*C1_PARAM + M1_var_def[20]*C1_PARAM 
				+ C1_var_def[20] + L1_var_def[20]];
				//incerementing arrays counters
				if (L1_var_def[20] >= 0)
				begin
					L1_var_def[20] <= 2'd0;
					C1_var_def[20] <= C1_var_def[20] + 1;
					if (C1_var_def[20] >= C1_PARAM-1)
					begin
						C1_var_def[20] <= 6'd0;
						M1_var_def[20] <= M1_var_def[20] + 1;
						if (M1_var_def[20] >= M1_PARAM-1)
						begin
							M1_var_def[20] <= 8'd0;					
							N1_var_def[20] <= N1_var_def[20] + 1;
							if (N1_var_def[20] >= N1_PARAM-1)
							begin
								N1_var_def[20] <= 8'd0;
								kernel_deflattened[20] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[21]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy21 <= 0;
				kernel_vals_cnt[21] <= 5'd0;
				kernel_recieved[21] <= 0;
			end
			else begin
				if (kernel_recieved[21] == 0)		 
					kernel_rdy21 <= 1; 
					if(((kernel21_mem[kernel_vals_cnt[21]] != kernel21) || (kernel_vld21 == 1) )|| (kernel_vals_cnt[21] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[21] <= kernel_vals_cnt[21] + 1'd1;
						kernel21_mem[kernel_vals_cnt[21]] <= kernel21;	
					end				
					if (kernel_vals_cnt[21] == KER_MEM_LENGTH) begin
						kernel_recieved[21] <= 1'b1;
					end
						
				else if(kernel_recieved[21] == 1)
					kernel21_mem[kernel_vals_cnt[21]]<=kernel21_mem[kernel_vals_cnt[21]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[21] <= 8'd0;
				M1_var_def[21] <= 8'd0;
				C1_var_def[21] <= 6'd0;
				L1_var_def[21] <= 2'd0;
				kernel_deflattened[21] <= 1'd0;    		
			end
			else if (kernel_recieved[21] == 1 && kernel_deflattened[21] == 0)
			begin
				kernel_arr_in21[N1_var_def[21]][M1_var_def[21]][C1_var_def[21]][L1_var_def[21]] <=
				kernel21_mem[N1_var_def[21]*N1_PARAM*C1_PARAM + M1_var_def[21]*C1_PARAM 
				+ C1_var_def[21] + L1_var_def[21]];
				//incerementing arrays counters
				if (L1_var_def[21] >= 0)
				begin
					L1_var_def[21] <= 2'd0;
					C1_var_def[21] <= C1_var_def[21] + 1;
					if (C1_var_def[21] >= C1_PARAM-1)
					begin
						C1_var_def[21] <= 6'd0;
						M1_var_def[21] <= M1_var_def[21] + 1;
						if (M1_var_def[21] >= M1_PARAM-1)
						begin
							M1_var_def[21] <= 8'd0;					
							N1_var_def[21] <= N1_var_def[21] + 1;
							if (N1_var_def[21] >= N1_PARAM-1)
							begin
								N1_var_def[21] <= 8'd0;
								kernel_deflattened[21] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[22]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy22 <= 0;
				kernel_vals_cnt[22] <= 5'd0;
				kernel_recieved[22] <= 0;
			end
			else begin
				if (kernel_recieved[22] == 0)		 
					kernel_rdy22 <= 1; 
					if(((kernel22_mem[kernel_vals_cnt[22]] != kernel22) || (kernel_vld22 == 1) )|| (kernel_vals_cnt[22] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[22] <= kernel_vals_cnt[22] + 1'd1;
						kernel22_mem[kernel_vals_cnt[22]] <= kernel22;	
					end				
					if (kernel_vals_cnt[22] == KER_MEM_LENGTH) begin
						kernel_recieved[22] <= 1'b1;
					end
						
				else if(kernel_recieved[22] == 1)
					kernel22_mem[kernel_vals_cnt[22]]<=kernel7_mem[kernel_vals_cnt[22]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[22] <= 8'd0;
				M1_var_def[22] <= 8'd0;
				C1_var_def[22] <= 6'd0;
				L1_var_def[22] <= 2'd0;
				kernel_deflattened[22] <= 1'd0;    		
			end
			else if (kernel_recieved[22] == 1 && kernel_deflattened[22] == 0)
			begin
				kernel_arr_in22[N1_var_def[22]][M1_var_def[22]][C1_var_def[22]][L1_var_def[22]] <=
				kernel22_mem[N1_var_def[22]*N1_PARAM*C1_PARAM + M1_var_def[22]*C1_PARAM 
				+ C1_var_def[22] + L1_var_def[22]];
				//incerementing arrays counters
				if (L1_var_def[22] >= 0)
				begin
					L1_var_def[22] <= 2'd0;
					C1_var_def[22] <= C1_var_def[22] + 1;
					if (C1_var_def[22] >= C1_PARAM-1)
					begin
						C1_var_def[22] <= 6'd0;
						M1_var_def[22] <= M1_var_def[22] + 1;
						if (M1_var_def[22] >= M1_PARAM-1)
						begin
							M1_var_def[22] <= 8'd0;					
							N1_var_def[22] <= N1_var_def[22] + 1;
							if (N1_var_def[22] >= N1_PARAM-1)
							begin
								N1_var_def[22] <= 8'd0;
								kernel_deflattened[22] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[23]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy23 <= 0;
				kernel_vals_cnt[23] <= 5'd0;
				kernel_recieved[23] <= 0;
			end
			else begin
				if (kernel_recieved[23] == 0)		 
					kernel_rdy23 <= 1; 
					if(((kernel23_mem[kernel_vals_cnt[23]] != kernel23) || (kernel_vld23 == 1) )|| (kernel_vals_cnt[23] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[23] <= kernel_vals_cnt[23] + 1'd1;
						kernel23_mem[kernel_vals_cnt[23]] <= kernel23;	
					end				
					if (kernel_vals_cnt[23] == KER_MEM_LENGTH) begin
						kernel_recieved[23] <= 1'b1;
					end
						
				else if(kernel_recieved[23] == 1)
					kernel23_mem[kernel_vals_cnt[23]]<=kernel7_mem[kernel_vals_cnt[23]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[23] <= 8'd0;
				M1_var_def[23] <= 8'd0;
				C1_var_def[23] <= 6'd0;
				L1_var_def[23] <= 2'd0;
				kernel_deflattened[23] <= 1'd0;    		
			end
			else if (kernel_recieved[23] == 1 && kernel_deflattened[23] == 0)
			begin
				kernel_arr_in23[N1_var_def[23]][M1_var_def[23]][C1_var_def[23]][L1_var_def[23]] <=
				kernel23_mem[N1_var_def[23]*N1_PARAM*C1_PARAM + M1_var_def[23]*C1_PARAM 
				+ C1_var_def[23] + L1_var_def[23]];
				//incerementing arrays counters
				if (L1_var_def[23] >= 0)
				begin
					L1_var_def[23] <= 2'd0;
					C1_var_def[23] <= C1_var_def[23] + 1;
					if (C1_var_def[23] >= C1_PARAM-1)
					begin
						C1_var_def[23] <= 6'd0;
						M1_var_def[23] <= M1_var_def[23] + 1;
						if (M1_var_def[23] >= M1_PARAM-1)
						begin
							M1_var_def[23] <= 8'd0;					
							N1_var_def[23] <= N1_var_def[23] + 1;
							if (N1_var_def[23] >= N1_PARAM-1)
							begin
								N1_var_def[23] <= 8'd0;
								kernel_deflattened[23] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[24]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy24 <= 0;
				kernel_vals_cnt[24] <= 5'd0;
				kernel_recieved[24] <= 0;
			end
			else begin
				if (kernel_recieved[24] == 0)		 
					kernel_rdy24 <= 1; 
					if(((kernel24_mem[kernel_vals_cnt[24]] != kernel24) || (kernel_vld24 == 1) )|| (kernel_vals_cnt[24] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[24] <= kernel_vals_cnt[24] + 1'd1;
						kernel24_mem[kernel_vals_cnt[24]] <= kernel24;	
					end				
					if (kernel_vals_cnt[24] == KER_MEM_LENGTH) begin
						kernel_recieved[24] <= 1'b1;
					end
						
				else if(kernel_recieved[24] == 1)
					kernel24_mem[kernel_vals_cnt[24]]<=kernel24_mem[kernel_vals_cnt[24]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[24] <= 8'd0;
				M1_var_def[24] <= 8'd0;
				C1_var_def[24] <= 6'd0;
				L1_var_def[24] <= 2'd0;
				kernel_deflattened[24] <= 1'd0;    		
			end
			else if (kernel_recieved[24] == 1 && kernel_deflattened[24] == 0)
			begin
				kernel_arr_in24[N1_var_def[24]][M1_var_def[24]][C1_var_def[24]][L1_var_def[24]] <=
				kernel24_mem[N1_var_def[24]*N1_PARAM*C1_PARAM + M1_var_def[24]*C1_PARAM 
				+ C1_var_def[24] + L1_var_def[24]];
				//incerementing arrays counters
				if (L1_var_def[24] >= 0)
				begin
					L1_var_def[24] <= 2'd0;
					C1_var_def[24] <= C1_var_def[24] + 1;
					if (C1_var_def[24] >= C1_PARAM-1)
					begin
						C1_var_def[24] <= 6'd0;
						M1_var_def[24] <= M1_var_def[24] + 1;
						if (M1_var_def[24] >= M1_PARAM-1)
						begin
							M1_var_def[24] <= 8'd0;					
							N1_var_def[24] <= N1_var_def[24] + 1;
							if (N1_var_def[24] >= N1_PARAM-1)
							begin
								N1_var_def[24] <= 8'd0;
								kernel_deflattened[24] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[25]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy25 <= 0;
				kernel_vals_cnt[25] <= 5'd0;
				kernel_recieved[25] <= 0;
			end
			else begin
				if (kernel_recieved[25] == 0)		 
					kernel_rdy25 <= 1; 
					if(((kernel25_mem[kernel_vals_cnt[25]] != kernel25) || (kernel_vld25 == 1) )|| (kernel_vals_cnt[25] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[25] <= kernel_vals_cnt[25] + 1'd1;
						kernel25_mem[kernel_vals_cnt[25]] <= kernel25;	
					end				
					if (kernel_vals_cnt[25] == KER_MEM_LENGTH) begin
						kernel_recieved[25] <= 1'b1;
					end
						
				else if(kernel_recieved[25] == 1)
					kernel25_mem[kernel_vals_cnt[25]]<=kernel25_mem[kernel_vals_cnt[25]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[25] <= 8'd0;
				M1_var_def[25] <= 8'd0;
				C1_var_def[25] <= 6'd0;
				L1_var_def[25] <= 2'd0;
				kernel_deflattened[25] <= 1'd0;    		
			end
			else if (kernel_recieved[25] == 1 && kernel_deflattened[25] == 0)
			begin
				kernel_arr_in25[N1_var_def[25]][M1_var_def[25]][C1_var_def[25]][L1_var_def[25]] <=
				kernel25_mem[N1_var_def[25]*N1_PARAM*C1_PARAM + M1_var_def[25]*C1_PARAM 
				+ C1_var_def[25] + L1_var_def[25]];
				//incerementing arrays counters
				if (L1_var_def[25] >= 0)
				begin
					L1_var_def[25] <= 2'd0;
					C1_var_def[25] <= C1_var_def[25] + 1;
					if (C1_var_def[25] >= C1_PARAM-1)
					begin
						C1_var_def[25] <= 6'd0;
						M1_var_def[25] <= M1_var_def[25] + 1;
						if (M1_var_def[25] >= M1_PARAM-1)
						begin
							M1_var_def[25] <= 8'd0;					
							N1_var_def[25] <= N1_var_def[25] + 1;
							if (N1_var_def[25] >= N1_PARAM-1)
							begin
								N1_var_def[25] <= 8'd0;
								kernel_deflattened[25] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[26]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy26 <= 0;
				kernel_vals_cnt[26] <= 5'd0;
				kernel_recieved[26] <= 0;
			end
			else begin
				if (kernel_recieved[26] == 0)		 
					kernel_rdy26 <= 1; 
					if(((kernel26_mem[kernel_vals_cnt[26]] != kernel26) || (kernel_vld26 == 1) )|| (kernel_vals_cnt[26] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[26] <= kernel_vals_cnt[26] + 1'd1;
						kernel26_mem[kernel_vals_cnt[26]] <= kernel26;	
					end				
					if (kernel_vals_cnt[26] == KER_MEM_LENGTH) begin
						kernel_recieved[26] <= 1'b1;
					end
						
				else if(kernel_recieved[26] == 1)
					kernel7_mem[kernel_vals_cnt[26]]<=kernel7_mem[kernel_vals_cnt[26]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[26] <= 8'd0;
				M1_var_def[26] <= 8'd0;
				C1_var_def[26] <= 6'd0;
				L1_var_def[26] <= 2'd0;
				kernel_deflattened[26] <= 1'd0;    		
			end
			else if (kernel_recieved[26] == 1 && kernel_deflattened[26] == 0)
			begin
				kernel_arr_in26[N1_var_def[26]][M1_var_def[26]][C1_var_def[26]][L1_var_def[26]] <=
				kernel26_mem[N1_var_def[26]*N1_PARAM*C1_PARAM + M1_var_def[26]*C1_PARAM 
				+ C1_var_def[26] + L1_var_def[26]];
				//incerementing arrays counters
				if (L1_var_def[26] >= 0)
				begin
					L1_var_def[26] <= 2'd0;
					C1_var_def[26] <= C1_var_def[26] + 1;
					if (C1_var_def[26] >= C1_PARAM-1)
					begin
						C1_var_def[26] <= 6'd0;
						M1_var_def[26] <= M1_var_def[26] + 1;
						if (M1_var_def[26] >= M1_PARAM-1)
						begin
							M1_var_def[26] <= 8'd0;					
							N1_var_def[26] <= N1_var_def[26] + 1;
							if (N1_var_def[26] >= N1_PARAM-1)
							begin
								N1_var_def[26] <= 8'd0;
								kernel_deflattened[26] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[27]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy27 <= 0;
				kernel_vals_cnt[27] <= 5'd0;
				kernel_recieved[27] <= 0;
			end
			else begin
				if (kernel_recieved[27] == 0)		 
					kernel_rdy27 <= 1; 
					if(((kernel27_mem[kernel_vals_cnt[27]] != kernel27) || (kernel_vld27 == 1) )|| (kernel_vals_cnt[27] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[27] <= kernel_vals_cnt[27] + 1'd1;
						kernel27_mem[kernel_vals_cnt[27]] <= kernel27;	
					end				
					if (kernel_vals_cnt[27] == KER_MEM_LENGTH) begin
						kernel_recieved[27] <= 1'b1;
					end
						
				else if(kernel_recieved[27] == 1)
					kernel27_mem[kernel_vals_cnt[27]]<=kernel7_mem[kernel_vals_cnt[27]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[27] <= 8'd0;
				M1_var_def[27] <= 8'd0;
				C1_var_def[27] <= 6'd0;
				L1_var_def[27] <= 2'd0;
				kernel_deflattened[27] <= 1'd0;    		
			end
			else if (kernel_recieved[27] == 1 && kernel_deflattened[27] == 0)
			begin
				kernel_arr_in27[N1_var_def[27]][M1_var_def[27]][C1_var_def[27]][L1_var_def[27]] <=
				kernel27_mem[N1_var_def[27]*N1_PARAM*C1_PARAM + M1_var_def[27]*C1_PARAM 
				+ C1_var_def[27] + L1_var_def[27]];
				//incerementing arrays counters
				if (L1_var_def[27] >= 0)
				begin
					L1_var_def[27] <= 2'd0;
					C1_var_def[27] <= C1_var_def[27] + 1;
					if (C1_var_def[27] >= C1_PARAM-1)
					begin
						C1_var_def[27] <= 6'd0;
						M1_var_def[27] <= M1_var_def[27] + 1;
						if (M1_var_def[27] >= M1_PARAM-1)
						begin
							M1_var_def[27] <= 8'd0;					
							N1_var_def[27] <= N1_var_def[27] + 1;
							if (N1_var_def[27] >= N1_PARAM-1)
							begin
								N1_var_def[27] <= 8'd0;
								kernel_deflattened[27] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[28]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy28 <= 0;
				kernel_vals_cnt[28] <= 5'd0;
				kernel_recieved[28] <= 0;
			end
			else begin
				if (kernel_recieved[28] == 0)		 
					kernel_rdy28 <= 1; 
					if(((kernel28_mem[kernel_vals_cnt[28]] != kernel28) || (kernel_vld28 == 1) )|| (kernel_vals_cnt[28] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[28] <= kernel_vals_cnt[28] + 1'd1;
						kernel28_mem[kernel_vals_cnt[28]] <= kernel28;	
					end				
					if (kernel_vals_cnt[28] == KER_MEM_LENGTH) begin
						kernel_recieved[28] <= 1'b1;
					end
						
				else if(kernel_recieved[28] == 1)
					kernel28_mem[kernel_vals_cnt[28]]<=kernel7_mem[kernel_vals_cnt[28]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[28] <= 8'd0;
				M1_var_def[28] <= 8'd0;
				C1_var_def[28] <= 6'd0;
				L1_var_def[28] <= 2'd0;
				kernel_deflattened[28] <= 1'd0;    		
			end
			else if (kernel_recieved[28] == 1 && kernel_deflattened[28] == 0)
			begin
				kernel_arr_in28[N1_var_def[28]][M1_var_def[28]][C1_var_def[28]][L1_var_def[28]] <=
				kernel28_mem[N1_var_def[28]*N1_PARAM*C1_PARAM + M1_var_def[28]*C1_PARAM 
				+ C1_var_def[28] + L1_var_def[28]];
				//incerementing arrays counters
				if (L1_var_def[28] >= 0)
				begin
					L1_var_def[28] <= 2'd0;
					C1_var_def[28] <= C1_var_def[28] + 1;
					if (C1_var_def[28] >= C1_PARAM-1)
					begin
						C1_var_def[28] <= 6'd0;
						M1_var_def[28] <= M1_var_def[28] + 1;
						if (M1_var_def[28] >= M1_PARAM-1)
						begin
							M1_var_def[28] <= 8'd0;					
							N1_var_def[28] <= N1_var_def[28] + 1;
							if (N1_var_def[28] >= N1_PARAM-1)
							begin
								N1_var_def[28] <= 8'd0;
								kernel_deflattened[28] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[29]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy29 <= 0;
				kernel_vals_cnt[29] <= 5'd0;
				kernel_recieved[29] <= 0;
			end
			else begin
				if (kernel_recieved[29] == 0)		 
					kernel_rdy29 <= 1; 
					if(((kernel29_mem[kernel_vals_cnt[29]] != kernel29) || (kernel_vld29 == 1) )|| (kernel_vals_cnt[29] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[29] <= kernel_vals_cnt[29] + 1'd1;
						kernel29_mem[kernel_vals_cnt[29]] <= kernel29;	
					end				
					if (kernel_vals_cnt[29] == KER_MEM_LENGTH) begin
						kernel_recieved[29] <= 1'b1;
					end
						
				else if(kernel_recieved[29] == 1)
					kernel29_mem[kernel_vals_cnt[29]]<=kernel7_mem[kernel_vals_cnt[29]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[29] <= 8'd0;
				M1_var_def[29] <= 8'd0;
				C1_var_def[29] <= 6'd0;
				L1_var_def[29] <= 2'd0;
				kernel_deflattened[29] <= 1'd0;    		
			end
			else if (kernel_recieved[29] == 1 && kernel_deflattened[29] == 0)
			begin
				kernel_arr_in29[N1_var_def[29]][M1_var_def[29]][C1_var_def[29]][L1_var_def[29]] <=
				kernel29_mem[N1_var_def[29]*N1_PARAM*C1_PARAM + M1_var_def[29]*C1_PARAM 
				+ C1_var_def[29] + L1_var_def[29]];
				//incerementing arrays counters
				if (L1_var_def[29] >= 0)
				begin
					L1_var_def[29] <= 2'd0;
					C1_var_def[29] <= C1_var_def[29] + 1;
					if (C1_var_def[29] >= C1_PARAM-1)
					begin
						C1_var_def[29] <= 6'd0;
						M1_var_def[29] <= M1_var_def[29] + 1;
						if (M1_var_def[29] >= M1_PARAM-1)
						begin
							M1_var_def[29] <= 8'd0;					
							N1_var_def[29] <= N1_var_def[29] + 1;
							if (N1_var_def[29] >= N1_PARAM-1)
							begin
								N1_var_def[29] <= 8'd0;
								kernel_deflattened[29] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[30]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy30 <= 0;
				kernel_vals_cnt[30] <= 5'd0;
				kernel_recieved[30] <= 0;
			end
			else begin
				if (kernel_recieved[30] == 0)		 
					kernel_rdy30 <= 1; 
					if(((kernel30_mem[kernel_vals_cnt[30]] != kernel30) || (kernel_vld30 == 1) )|| (kernel_vals_cnt[30] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[30] <= kernel_vals_cnt[30] + 1'd1;
						kernel30_mem[kernel_vals_cnt[30]] <= kernel30;	
					end				
					if (kernel_vals_cnt[30] == KER_MEM_LENGTH) begin
						kernel_recieved[30] <= 1'b1;
					end
						
				else if(kernel_recieved[30] == 1)
					kernel30_mem[kernel_vals_cnt[30]]<=kernel30_mem[kernel_vals_cnt[30]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[30] <= 8'd0;
				M1_var_def[30] <= 8'd0;
				C1_var_def[30] <= 6'd0;
				L1_var_def[30] <= 2'd0;
				kernel_deflattened[30] <= 1'd0;    		
			end
			else if (kernel_recieved[30] == 1 && kernel_deflattened[30] == 0)
			begin
				kernel_arr_in30[N1_var_def[30]][M1_var_def[30]][C1_var_def[30]][L1_var_def[30]] <=
				kernel30_mem[N1_var_def[30]*N1_PARAM*C1_PARAM + M1_var_def[30]*C1_PARAM 
				+ C1_var_def[30] + L1_var_def[30]];
				//incerementing arrays counters
				if (L1_var_def[30] >= 0)
				begin
					L1_var_def[30] <= 2'd0;
					C1_var_def[30] <= C1_var_def[30] + 1;
					if (C1_var_def[30] >= C1_PARAM-1)
					begin
						C1_var_def[30] <= 6'd0;
						M1_var_def[30] <= M1_var_def[30] + 1;
						if (M1_var_def[30] >= M1_PARAM-1)
						begin
							M1_var_def[30] <= 8'd0;					
							N1_var_def[30] <= N1_var_def[30] + 1;
							if (N1_var_def[30] >= N1_PARAM-1)
							begin
								N1_var_def[30] <= 8'd0;
								kernel_deflattened[30] <= 1'd1;
							end
						end
					end
				end 
			end
		end 


//---------------------------------------------------------------------------------------------------------
		////////////////////////
		// recieving kernel[31]
		always@(posedge clk)
			if (reset == 1) begin
				kernel_rdy31 <= 0;
				kernel_vals_cnt[31] <= 5'd0;
				kernel_recieved[31] <= 0;
			end
			else begin
				if (kernel_recieved[31] == 0)		 
					kernel_rdy31 <= 1; 
					if(((kernel31_mem[kernel_vals_cnt[31]] != kernel31) || (kernel_vld31 == 1) )|| (kernel_vals_cnt[31] == KER_MEM_LENGTH)) begin
					//counter clicks if new value came to kernel data port or it's the last value  
						kernel_vals_cnt[31] <= kernel_vals_cnt[31] + 1'd1;
						kernel31_mem[kernel_vals_cnt[31]] <= kernel31;	
					end				
					if (kernel_vals_cnt[31] == KER_MEM_LENGTH) begin
						kernel_recieved[31] <= 1'b1;
					end
						
				else if(kernel_recieved[31] == 1)
					kernel31_mem[kernel_vals_cnt[31]]<=kernel31_mem[kernel_vals_cnt[31]];
			end
			
		////////////////////////
		// passing to 3D array-register 
		always@(posedge clk)
		begin
			if (reset == 1)
			begin
				N1_var_def[31] <= 8'd0;
				M1_var_def[31] <= 8'd0;
				C1_var_def[31] <= 6'd0;
				L1_var_def[31] <= 2'd0;
				kernel_deflattened[31] <= 1'd0;    		
			end
			else if (kernel_recieved[31] == 1 && kernel_deflattened[31] == 0)
			begin
				kernel_arr_in31[N1_var_def[31]][M1_var_def[31]][C1_var_def[31]][L1_var_def[31]] <=
				kernel31_mem[N1_var_def[31]*N1_PARAM*C1_PARAM + M1_var_def[31]*C1_PARAM 
				+ C1_var_def[31] + L1_var_def[31]];
				//incerementing arrays counters
				if (L1_var_def[31] >= 0)
				begin
					L1_var_def[31] <= 2'd0;
					C1_var_def[31] <= C1_var_def[31] + 1;
					if (C1_var_def[31] >= C1_PARAM-1)
					begin
						C1_var_def[31] <= 6'd0;
						M1_var_def[31] <= M1_var_def[31] + 1;
						if (M1_var_def[31] >= M1_PARAM-1)
						begin
							M1_var_def[31] <= 8'd0;					
							N1_var_def[31] <= N1_var_def[31] + 1;
							if (N1_var_def[31] >= N1_PARAM-1)
							begin
								N1_var_def[31] <= 8'd0;
								kernel_deflattened[31] <= 1'd1;
							end
						end
					end
				end 
			end
		end 



//_________________________________________________________________________________________________________________________________________________________________________________________
   ////////////////////////
   // convolution [0]
   localparam imgSF = 2.0**-14.00;  // Q6.14 scaling factor is 2^-14
   localparam tempSF = 2.0**-30.00; // Q12.28 scaling factor is 2^-30 for result_temp (?)
   assign mult_temp_w_0 = kernel_arr_in0[M1_var2[0]][N1_var2[0]][C1_var4[0]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[0] + M1_var2[0]][N3_var[0] + N1_var2[0]][C1_var4[0]];
   assign mult_temp_w_conc[0] = mult_temp_w_0[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[0] = mult_temp_w_conc[0] + result_mem_0[M3_var[0]][N3_var[0]][0];//wire with result
   integer j,i,k;//------------------------ONLY FOR SIM!!!
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[0] <= 8'd0;
       		M1_var2[0] <= 8'd0;
       		C1_var4[0] <= 6'd0;
       		N3_var[0] <= 8'd0;
			M3_var[0] <= 8'd0;
			conv_done[0] <= 1'd0;
			result_temp[0] <= 39'd0;
			//result_mem <= '{128{'{128{'{ 1{20'd0} }}}}};
			//------------------------ONLY FOR SIM!!!------------------
			/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_0[j][i][k] <= 19'd0;
					end
				end	
			end/**/
			//------------------------ONLY FOR SIM!!!------------------
       	end
       	else begin
       		if (kernel_recieved[0] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[0] == 0)
   			begin
   				
   				result_temp[0] <= result_mem_0[M3_var[0]][N3_var[0]][0] + 
   				kernel_arr_in0[M1_var2[0]][N1_var2[0]][C1_var4[0]][0] * 
   				image_mem_arr_in_zpad[M3_var[0] + M1_var2[0]][N3_var[0] + N1_var2[0]][C1_var4[0]];
   				
   				result_mem_0[M3_var[0]][N3_var[0]][0] <= res_temp_w_conc[0];
   				
   				$display ("result_mem[%0d][%0d][0] = %b",M3_var[0], N3_var[0],result_mem_0[M3_var[0]][N3_var[0]][0]);
   				$display ("kernel_arr_in0[%0d][%0d][%0d][0]*img_mem_arr[%0d+%0d][%0d+%0d][%0d]",
   						   M1_var2[0], N1_var2[0], C1_var4[0], M3_var[0], M1_var2[0], N3_var[0], N1_var2[0], C1_var4[0] );
   						   
   			    $display ("mult_temp_w = %b", mult_temp_w_0);
   			    $display ("mult_temp_w_conc =  %b", mult_temp_w_conc[0]);
   				$display ("res_temp_w_conc =   %b", res_temp_w_conc[0]);
   				//$display ("result_temp = %b", result_temp);
   				$display ("result_mem[%0d][%0d][0] = %b + %b * %b",
						   M3_var[0], N3_var[0], result_mem_0[M3_var[0]][N3_var[0]][0], 
						   kernel_arr_in0[M1_var2[0]][N1_var2[0]][C1_var4[0]][0],
						   image_mem_arr_in_zpad[M3_var[0] + M1_var2[0]][N3_var[0] + N1_var2[0]][C1_var4[0]]);/**/
			    $display (" ");
   				N1_var2[0] <= N1_var2[0] + 1;
   				if (N1_var2[0] >= N1_PARAM-1)
   				begin
   					N1_var2[0] <= 8'd0;
   					M1_var2[0] <= M1_var2[0] + 1;
   					if (M1_var2[0] >= M1_PARAM-1)
   					begin
   						M1_var2[0] <= 8'd0;
   							
   						C1_var4[0] <= C1_var4[0] + 1;
   						if (C1_var4[0] >= C1_PARAM-1)
   						begin
   							
							C1_var4[0] <= 6'd0;
   							N3_var[0] <= N3_var[0] + 1;
   							
							$display ("result_mem[%d][%d][0] = %b",
									   M3_var[0], N3_var[0],result_mem_0[M3_var[0]][N3_var[0]][0]); //$itor(imgSF*result_mem[M3_var][N3_var][0]));
							$display ("bias[%d] = %b",
												   C1_var4[0], biases_mem[(C1_var4[0]-2)]);
							$display ("------------------------------------------------");
							result_mem_0[M3_var[0]][N3_var[0]][0]<= res_temp_w_conc[0] + biases_mem[(C1_var4[0]-2)] ;
							$display ("result_mem_bias[%d][%d][0] = %b",
									   M3_var[0], N3_var[0],result_mem_0[M3_var[0]][N3_var[0]][0]);	
							$display ("---------------------------------------------------------------------------------------");   												
   							if (N3_var[0] >= N3_PARAM-1)
   							begin
   								N3_var[0] <= 8'd0;
   								M3_var[0] <= M3_var[0] + 1;
   								if (M3_var[0] >= M3_PARAM-1)
   								begin
   									conv_done[0] <= 1;
   									
   								end
   							end
   						end
   					end
   				end
   			end
   		end
    /**/
   //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [1]
   assign mult_temp_w_1 = kernel_arr_in1[M1_var2[1]][N1_var2[1]][C1_var4[1]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[1] + M1_var2[1]][N3_var[1] + N1_var2[1]][C1_var4[1]];
   assign mult_temp_w_conc[1] = mult_temp_w_1[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[1] = mult_temp_w_conc[1] + result_mem_1[M3_var[1]][N3_var[1]][0];//wire with result
   //integer j1,i1,k1;
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[1] <= 8'd0;
       		M1_var2[1] <= 8'd0;
       		C1_var4[1] <= 6'd0;
       		N3_var[1] <= 8'd0;
			M3_var[1] <= 8'd0;
			conv_done[1] <= 1'd0;
			result_temp[1] <= 39'd0;
			`ifdef FOR_LOOP_RESET/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_1[j][i][k] <= 19'd0;
					end
				end	
			end/**/
			`endif
       	end
       	else begin
       		if (kernel_recieved[1] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[1] == 0)
   			begin
   				result_temp[1] <= result_mem_1[M3_var[1]][N3_var[1]][0] + 
   				kernel_arr_in1[M1_var2[1]][N1_var2[1]][C1_var4[1]][0] * 
   				image_mem_arr_in_zpad[M3_var[1] + M1_var2[1]][N3_var[1] + N1_var2[1]][C1_var4[1]];
   				//-----------------------------------------------------------
   				result_mem_1[M3_var[1]][N3_var[1]][0] <= res_temp_w_conc[1];
   				N1_var2[1] <= N1_var2[1] + 1;
   				if (N1_var2[1] >= N1_PARAM-1)
   				begin
   					N1_var2[1] <= 8'd0;
   					M1_var2[1] <= M1_var2[1] + 1;
   					if (M1_var2[1] >= M1_PARAM-1)
   					begin
   						M1_var2[1] <= 8'd0;
   						C1_var4[1] <= C1_var4[1] + 1;
   						if (C1_var4[1] >= C1_PARAM-1)
   						begin
							C1_var4[1] <= 6'd0;
   							N3_var[1] <= N3_var[1] + 1;
							result_mem_1[M3_var[1]][N3_var[1]][0]<= res_temp_w_conc[1] + biases_mem[(C1_var4[1]-2)] ;												
   							if (N3_var[1] >= N3_PARAM-1)
   							begin
   								N3_var[1] <= 8'd0;
   								M3_var[1] <= M3_var[1] + 1;
   								if (M3_var[1] >= M3_PARAM-1)
   								begin
   									conv_done[1] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
    /**/

   //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [2]
   
   assign mult_temp_w_2 = kernel_arr_in2[M1_var2[2]][N1_var2[2]][C1_var4[2]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[2] + M1_var2[2]][N3_var[2] + N1_var2[2]][C1_var4[2]];
   assign mult_temp_w_conc[2] = mult_temp_w_3[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[2] = mult_temp_w_conc[2] + result_mem_2[M3_var[2]][N3_var[2]][0];//wire with result

   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[2] <= 8'd0;
       		M1_var2[2] <= 8'd0;
       		C1_var4[2] <= 6'd0;
       		N3_var[2] <= 8'd0;
			M3_var[2] <= 8'd0;
			conv_done[2] <= 1'd0;
			result_temp[2] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_2[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[2] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[2] == 0)
   			begin
   				result_temp[2] <= result_mem_2[M3_var[2]][N3_var[2]][0] + 
   				kernel_arr_in2[M1_var2[2]][N1_var2[2]][C1_var4[2]][0] * 
   				image_mem_arr_in_zpad[M3_var[2] + M1_var2[2]][N3_var[2] + N1_var2[2]][C1_var4[2]];
   				//-----------------------------------------------------------
   				result_mem_2[M3_var[2]][N3_var[2]][0] <= res_temp_w_conc[2];
   				N1_var2[2] <= N1_var2[2] + 1;
   				if (N1_var2[2] >= N1_PARAM-1)
   				begin
   					N1_var2[2] <= 8'd0;
   					M1_var2[2] <= M1_var2[2] + 1;
   					if (M1_var2[2] >= M1_PARAM-1)
   					begin
   						M1_var2[2] <= 8'd0;
   						C1_var4[2] <= C1_var4[2] + 1;
   						if (C1_var4[2] >= C1_PARAM-1)
   						begin
							C1_var4[2] <= 6'd0;
   							N3_var[2] <= N3_var[2] + 1;
							result_mem_2[M3_var[2]][N3_var[2]][0]<= res_temp_w_conc[2] + biases_mem[(C1_var4[2]-2)] ;												
   							if (N3_var[2] >= N3_PARAM-1)
   							begin
   								N3_var[2] <= 8'd0;
   								M3_var[2] <= M3_var[2] + 1;
   								if (M3_var[2] >= M3_PARAM-1)
   								begin
   									conv_done[2] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
   
   //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [3]
   
   assign mult_temp_w_3 = kernel_arr_in3[M1_var2[3]][N1_var2[3]][C1_var4[3]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[3] + M1_var2[3]][N3_var[3] + N1_var2[3]][C1_var4[3]];
   assign mult_temp_w_conc[3] = mult_temp_w_3[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[3] = mult_temp_w_conc[3] + result_mem_3[M3_var[3]][N3_var[3]][0];//wire with result

   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[3] <= 8'd0;
       		M1_var2[3] <= 8'd0;
       		C1_var4[3] <= 6'd0;
       		N3_var[3] <= 8'd0;
			M3_var[3] <= 8'd0;
			conv_done[3] <= 1'd0;
			result_temp[3] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_3[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[3] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[3] == 0)
   			begin
   				result_temp[3] <= result_mem_3[M3_var[3]][N3_var[3]][0] + 
   				kernel_arr_in3[M1_var2[3]][N1_var2[3]][C1_var4[3]][0] * 
   				image_mem_arr_in_zpad[M3_var[3] + M1_var2[3]][N3_var[3] + N1_var2[3]][C1_var4[3]];
   				//-----------------------------------------------------------
   				result_mem_3[M3_var[3]][N3_var[3]][0] <= res_temp_w_conc[3];
   				N1_var2[3] <= N1_var2[3] + 1;
   				if (N1_var2[3] >= N1_PARAM-1)
   				begin
   					N1_var2[3] <= 8'd0;
   					M1_var2[3] <= M1_var2[3] + 1;
   					if (M1_var2[3] >= M1_PARAM-1)
   					begin
   						M1_var2[3] <= 8'd0;
   						C1_var4[3] <= C1_var4[3] + 1;
   						if (C1_var4[3] >= C1_PARAM-1)
   						begin
							C1_var4[3] <= 6'd0;
   							N3_var[3] <= N3_var[3] + 1;
							result_mem_3[M3_var[3]][N3_var[3]][0]<= res_temp_w_conc[3] + biases_mem[(C1_var4[3]-2)] ;												
   							if (N3_var[3] >= N3_PARAM-1)
   							begin
   								N3_var[3] <= 8'd0;
   								M3_var[3] <= M3_var[3] + 1;
   								if (M3_var[3] >= M3_PARAM-1)
   								begin
   									conv_done[3] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
   
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [4]
   
   assign mult_temp_w_4 = kernel_arr_in4[M1_var2[4]][N1_var2[4]][C1_var4[4]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[4] + M1_var2[4]][N3_var[4] + N1_var2[4]][C1_var4[4]];
   assign mult_temp_w_conc[4] = mult_temp_w_4[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[4] = mult_temp_w_conc[4] + result_mem_4[M3_var[4]][N3_var[4]][0];//wire with result

   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[4] <= 8'd0;
       		M1_var2[4] <= 8'd0;
       		C1_var4[4] <= 6'd0;
       		N3_var[4] <= 8'd0;
			M3_var[4] <= 8'd0;
			conv_done[4] <= 1'd0;
			result_temp[4] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_4[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[4] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[4] == 0)
   			begin
   				result_temp[4] <= result_mem_4[M3_var[4]][N3_var[4]][0] + 
   				kernel_arr_in4[M1_var2[4]][N1_var2[4]][C1_var4[4]][0] * 
   				image_mem_arr_in_zpad[M3_var[4] + M1_var2[4]][N3_var[4] + N1_var2[4]][C1_var4[4]];
   				//-----------------------------------------------------------
   				result_mem_4[M3_var[4]][N3_var[4]][0] <= res_temp_w_conc[4];
   				N1_var2[4] <= N1_var2[4] + 1;
   				if (N1_var2[4] >= N1_PARAM-1)
   				begin
   					N1_var2[4] <= 8'd0;
   					M1_var2[4] <= M1_var2[4] + 1;
   					if (M1_var2[4] >= M1_PARAM-1)
   					begin
   						M1_var2[4] <= 8'd0;
   						C1_var4[4] <= C1_var4[4] + 1;
   						if (C1_var4[4] >= C1_PARAM-1)
   						begin
							C1_var4[4] <= 6'd0;
   							N3_var[4] <= N3_var[4] + 1;
							result_mem_4[M3_var[4]][N3_var[4]][0]<= res_temp_w_conc[4] + biases_mem[(C1_var4[4]-2)] ;												
   							if (N3_var[4] >= N3_PARAM-1)
   							begin
   								N3_var[4] <= 8'd0;
   								M3_var[4] <= M3_var[4] + 1;
   								if (M3_var[4] >= M3_PARAM-1)
   								begin
   									conv_done[4] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
   
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [5]
   
   assign mult_temp_w_5 = kernel_arr_in5[M1_var2[5]][N1_var2[5]][C1_var4[5]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[5] + M1_var2[5]][N3_var[5] + N1_var2[5]][C1_var4[5]];
   assign mult_temp_w_conc[5] = mult_temp_w_5[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[5] = mult_temp_w_conc[5] + result_mem_5[M3_var[5]][N3_var[5]][0];//wire with result
 
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[5] <= 8'd0;
       		M1_var2[5] <= 8'd0;
       		C1_var4[5] <= 6'd0;
       		N3_var[5] <= 8'd0;
			M3_var[5] <= 8'd0;
			conv_done[5] <= 1'd0;
			result_temp[5] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_5[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[5] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[5] == 0)
   			begin
   				result_temp[5] <= result_mem_5[M3_var[5]][N3_var[5]][0] + 
   				kernel_arr_in5[M1_var2[5]][N1_var2[5]][C1_var4[5]][0] * 
   				image_mem_arr_in_zpad[M3_var[5] + M1_var2[5]][N3_var[5] + N1_var2[5]][C1_var4[5]];
   				//-----------------------------------------------------------
   				result_mem_5[M3_var[5]][N3_var[5]][0] <= res_temp_w_conc[5];
   				N1_var2[5] <= N1_var2[5] + 1;
   				if (N1_var2[5] >= N1_PARAM-1)
   				begin
   					N1_var2[5] <= 8'd0;
   					M1_var2[5] <= M1_var2[5] + 1;
   					if (M1_var2[5] >= M1_PARAM-1)
   					begin
   						M1_var2[5] <= 8'd0;
   						C1_var4[5] <= C1_var4[5] + 1;
   						if (C1_var4[5] >= C1_PARAM-1)
   						begin
							C1_var4[5] <= 6'd0;
   							N3_var[5] <= N3_var[5] + 1;
							result_mem_5[M3_var[5]][N3_var[5]][0]<= res_temp_w_conc[5] + biases_mem[(C1_var4[5]-2)] ;												
   							if (N3_var[5] >= N3_PARAM-1)
   							begin
   								N3_var[5] <= 8'd0;
   								M3_var[5] <= M3_var[5] + 1;
   								if (M3_var[5] >= M3_PARAM-1)
   								begin
   									conv_done[5] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [6]
   
   assign mult_temp_w_6 = kernel_arr_in6[M1_var2[6]][N1_var2[6]][C1_var4[6]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[6] + M1_var2[6]][N3_var[6] + N1_var2[6]][C1_var4[6]];
   assign mult_temp_w_conc[6] = mult_temp_w_6[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[6] = mult_temp_w_conc[6] + result_mem_6[M3_var[6]][N3_var[6]][0];//wire with result

   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[6] <= 8'd0;
       		M1_var2[6] <= 8'd0;
       		C1_var4[6] <= 6'd0;
       		N3_var[6] <= 8'd0;
			M3_var[6] <= 8'd0;
			conv_done[6] <= 1'd0;
			result_temp[6] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_6[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[6] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[6] == 0)
   			begin
   				result_temp[6] <= result_mem_6[M3_var[6]][N3_var[6]][0] + 
   				kernel_arr_in6[M1_var2[6]][N1_var2[6]][C1_var4[6]][0] * 
   				image_mem_arr_in_zpad[M3_var[6] + M1_var2[6]][N3_var[6] + N1_var2[6]][C1_var4[6]];
   				//-----------------------------------------------------------
   				result_mem_6[M3_var[6]][N3_var[6]][0] <= res_temp_w_conc[6];
   				N1_var2[6] <= N1_var2[6] + 1;
   				if (N1_var2[6] >= N1_PARAM-1)
   				begin
   					N1_var2[6] <= 8'd0;
   					M1_var2[6] <= M1_var2[6] + 1;
   					if (M1_var2[6] >= M1_PARAM-1)
   					begin
   						M1_var2[6] <= 8'd0;
   						C1_var4[6] <= C1_var4[6] + 1;
   						if (C1_var4[6] >= C1_PARAM-1)
   						begin
							C1_var4[6] <= 6'd0;
   							N3_var[6] <= N3_var[6] + 1;
							result_mem_6[M3_var[6]][N3_var[6]][0]<= res_temp_w_conc[6] + biases_mem[(C1_var4[6]-2)] ;												
   							if (N3_var[6] >= N3_PARAM-1)
   							begin
   								N3_var[6] <= 8'd0;
   								M3_var[6] <= M3_var[6] + 1;
   								if (M3_var[6] >= M3_PARAM-1)
   								begin
   									conv_done[6] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [7]
   
   assign mult_temp_w_7 = kernel_arr_in7[M1_var2[7]][N1_var2[7]][C1_var4[7]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[7] + M1_var2[7]][N3_var[7] + N1_var2[7]][C1_var4[7]];
   assign mult_temp_w_conc[7] = mult_temp_w_7[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[7] = mult_temp_w_conc[7] + result_mem_7[M3_var[7]][N3_var[7]][0];//wire with result

   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[7] <= 8'd0;
       		M1_var2[7] <= 8'd0;
       		C1_var4[7] <= 6'd0;
       		N3_var[7] <= 8'd0;
			M3_var[7] <= 8'd0;
			conv_done[7] <= 1'd0;
			result_temp[7] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_7[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[7] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[7] == 0)
   			begin
   				result_temp[7] <= result_mem_7[M3_var[7]][N3_var[7]][0] + 
   				kernel_arr_in7[M1_var2[7]][N1_var2[7]][C1_var4[7]][0] * 
   				image_mem_arr_in_zpad[M3_var[7] + M1_var2[7]][N3_var[7] + N1_var2[7]][C1_var4[7]];
   				//-----------------------------------------------------------
   				result_mem_7[M3_var[7]][N3_var[7]][0] <= res_temp_w_conc[7];
   				N1_var2[7] <= N1_var2[7] + 1;
   				if (N1_var2[7] >= N1_PARAM-1)
   				begin
   					N1_var2[7] <= 8'd0;
   					M1_var2[7] <= M1_var2[7] + 1;
   					if (M1_var2[7] >= M1_PARAM-1)
   					begin
   						M1_var2[7] <= 8'd0;
   						C1_var4[7] <= C1_var4[7] + 1;
   						if (C1_var4[7] >= C1_PARAM-1)
   						begin
							C1_var4[7] <= 6'd0;
   							N3_var[7] <= N3_var[7] + 1;
							result_mem_7[M3_var[7]][N3_var[7]][0]<= res_temp_w_conc[7] + biases_mem[(C1_var4[7]-2)] ;												
   							if (N3_var[7] >= N3_PARAM-1)
   							begin
   								N3_var[7] <= 8'd0;
   								M3_var[7] <= M3_var[7] + 1;
   								if (M3_var[7] >= M3_PARAM-1)
   								begin
   									conv_done[7] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [8]
   
   assign mult_temp_w_8 = kernel_arr_in8[M1_var2[8]][N1_var2[8]][C1_var4[8]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[8] + M1_var2[8]][N3_var[8] + N1_var2[8]][C1_var4[8]];
   assign mult_temp_w_conc[8] = mult_temp_w_8[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[8] = mult_temp_w_conc[8] + result_mem_8[M3_var[8]][N3_var[8]][0];//wire with result

   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[8] <= 8'd0;
       		M1_var2[8] <= 8'd0;
       		C1_var4[8] <= 6'd0;
       		N3_var[8] <= 8'd0;
			M3_var[8] <= 8'd0;
			conv_done[8] <= 1'd0;
			result_temp[8] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_8[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[8] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[8] == 0)
   			begin
   				result_temp[8] <= result_mem_8[M3_var[8]][N3_var[8]][0] + 
   				kernel_arr_in8[M1_var2[8]][N1_var2[8]][C1_var4[8]][0] * 
   				image_mem_arr_in_zpad[M3_var[8] + M1_var2[8]][N3_var[8] + N1_var2[8]][C1_var4[8]];
   				//-----------------------------------------------------------
   				result_mem_8[M3_var[8]][N3_var[8]][0] <= res_temp_w_conc[8];
   				N1_var2[8] <= N1_var2[8] + 1;
   				if (N1_var2[8] >= N1_PARAM-1)
   				begin
   					N1_var2[8] <= 8'd0;
   					M1_var2[8] <= M1_var2[8] + 1;
   					if (M1_var2[8] >= M1_PARAM-1)
   					begin
   						M1_var2[8] <= 8'd0;
   						C1_var4[8] <= C1_var4[8] + 1;
   						if (C1_var4[8] >= C1_PARAM-1)
   						begin
							C1_var4[8] <= 6'd0;
   							N3_var[8] <= N3_var[8] + 1;
							result_mem_8[M3_var[8]][N3_var[8]][0]<= res_temp_w_conc[8] + biases_mem[(C1_var4[8]-2)] ;												
   							if (N3_var[8] >= N3_PARAM-1)
   							begin
   								N3_var[8] <= 8'd0;
   								M3_var[8] <= M3_var[8] + 1;
   								if (M3_var[8] >= M3_PARAM-1)
   								begin
   									conv_done[8] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [9]
   
   assign mult_temp_w_9 = kernel_arr_in9[M1_var2[9]][N1_var2[9]][C1_var4[9]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[9] + M1_var2[9]][N3_var[9] + N1_var2[9]][C1_var4[9]];
   assign mult_temp_w_conc[9] = mult_temp_w_9[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[9] = mult_temp_w_conc[9] + result_mem_9[M3_var[9]][N3_var[9]][0];//wire with result
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[9] <= 8'd0;
       		M1_var2[9] <= 8'd0;
       		C1_var4[9] <= 6'd0;
       		N3_var[9] <= 8'd0;
			M3_var[9] <= 8'd0;
			conv_done[9] <= 1'd0;
			result_temp[9] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_9[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[9] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[9] == 0)
   			begin
   				result_temp[9] <= result_mem_9[M3_var[9]][N3_var[9]][0] + 
   				kernel_arr_in9[M1_var2[9]][N1_var2[9]][C1_var4[9]][0] * 
   				image_mem_arr_in_zpad[M3_var[9] + M1_var2[9]][N3_var[9] + N1_var2[9]][C1_var4[9]];
   				//-----------------------------------------------------------
   				result_mem_9[M3_var[9]][N3_var[9]][0] <= res_temp_w_conc[9];
   				N1_var2[9] <= N1_var2[9] + 1;
   				if (N1_var2[9] >= N1_PARAM-1)
   				begin
   					N1_var2[9] <= 8'd0;
   					M1_var2[9] <= M1_var2[9] + 1;
   					if (M1_var2[9] >= M1_PARAM-1)
   					begin
   						M1_var2[9] <= 8'd0;
   						C1_var4[9] <= C1_var4[9] + 1;
   						if (C1_var4[9] >= C1_PARAM-1)
   						begin
							C1_var4[9] <= 6'd0;
   							N3_var[9] <= N3_var[9] + 1;
							result_mem_9[M3_var[9]][N3_var[9]][0]<= res_temp_w_conc[9] + biases_mem[(C1_var4[9]-2)] ;												
   							if (N3_var[9] >= N3_PARAM-1)
   							begin
   								N3_var[9] <= 8'd0;
   								M3_var[9] <= M3_var[9] + 1;
   								if (M3_var[9] >= M3_PARAM-1)
   								begin
   									conv_done[9] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [10]
   
   assign mult_temp_w_10 = kernel_arr_in10[M1_var2[10]][N1_var2[10]][C1_var4[10]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[10] + M1_var2[10]][N3_var[10] + N1_var2[10]][C1_var4[10]];
   assign mult_temp_w_conc[10] = mult_temp_w_10[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[10] = mult_temp_w_conc[10] + result_mem_4[M3_var[10]][N3_var[10]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[10] <= 8'd0;
       		M1_var2[10] <= 8'd0;
       		C1_var4[10] <= 6'd0;
       		N3_var[10] <= 8'd0;
			M3_var[10] <= 8'd0;
			conv_done[10] <= 1'd0;
			result_temp[10] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_10[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[10] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[10] == 0)
   			begin
   				result_temp[10] <= result_mem_10[M3_var[10]][N3_var[10]][0] + 
   				kernel_arr_in10[M1_var2[10]][N1_var2[10]][C1_var4[10]][0] * 
   				image_mem_arr_in_zpad[M3_var[10] + M1_var2[10]][N3_var[10] + N1_var2[10]][C1_var4[10]];
   				//-----------------------------------------------------------
   				result_mem_10[M3_var[10]][N3_var[10]][0] <= res_temp_w_conc[10];
   				N1_var2[10] <= N1_var2[10] + 1;
   				if (N1_var2[10] >= N1_PARAM-1)
   				begin
   					N1_var2[10] <= 8'd0;
   					M1_var2[10] <= M1_var2[10] + 1;
   					if (M1_var2[10] >= M1_PARAM-1)
   					begin
   						M1_var2[10] <= 8'd0;
   						C1_var4[10] <= C1_var4[10] + 1;
   						if (C1_var4[10] >= C1_PARAM-1)
   						begin
							C1_var4[10] <= 6'd0;
   							N3_var[10] <= N3_var[10] + 1;
							result_mem_10[M3_var[10]][N3_var[10]][0]<= res_temp_w_conc[10] + biases_mem[(C1_var4[10]-2)] ;												
   							if (N3_var[10] >= N3_PARAM-1)
   							begin
   								N3_var[10] <= 8'd0;
   								M3_var[10] <= M3_var[10] + 1;
   								if (M3_var[10] >= M3_PARAM-1)
   								begin
   									conv_done[10] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [11]
   
   assign mult_temp_w_11 = kernel_arr_in11[M1_var2[11]][N1_var2[11]][C1_var4[11]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[11] + M1_var2[11]][N3_var[11] + N1_var2[11]][C1_var4[11]];
   assign mult_temp_w_conc[11] = mult_temp_w_11[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[11] = mult_temp_w_conc[11] + result_mem_11[M3_var[11]][N3_var[11]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[11] <= 8'd0;
       		M1_var2[11] <= 8'd0;
       		C1_var4[11] <= 6'd0;
       		N3_var[11] <= 8'd0;
			M3_var[11] <= 8'd0;
			conv_done[11] <= 1'd0;
			result_temp[11] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_11[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[11] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[11] == 0)
   			begin
   				result_temp[11] <= result_mem_11[M3_var[11]][N3_var[11]][0] + 
   				kernel_arr_in11[M1_var2[11]][N1_var2[11]][C1_var4[11]][0] * 
   				image_mem_arr_in_zpad[M3_var[11] + M1_var2[11]][N3_var[11] + N1_var2[11]][C1_var4[11]];
   				//-----------------------------------------------------------
   				result_mem_11[M3_var[11]][N3_var[11]][0] <= res_temp_w_conc[11];
   				N1_var2[11] <= N1_var2[11] + 1;
   				if (N1_var2[11] >= N1_PARAM-1)
   				begin
   					N1_var2[11] <= 8'd0;
   					M1_var2[11] <= M1_var2[11] + 1;
   					if (M1_var2[11] >= M1_PARAM-1)
   					begin
   						M1_var2[11] <= 8'd0;
   						C1_var4[11] <= C1_var4[11] + 1;
   						if (C1_var4[11] >= C1_PARAM-1)
   						begin
							C1_var4[11] <= 6'd0;
   							N3_var[11] <= N3_var[11] + 1;
							result_mem_11[M3_var[11]][N3_var[11]][0]<= res_temp_w_conc[11] + biases_mem[(C1_var4[11]-2)] ;												
   							if (N3_var[11] >= N3_PARAM-1)
   							begin
   								N3_var[11] <= 8'd0;
   								M3_var[11] <= M3_var[11] + 1;
   								if (M3_var[11] >= M3_PARAM-1)
   								begin
   									conv_done[11] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [12]
   
   assign mult_temp_w_12 = kernel_arr_in12[M1_var2[12]][N1_var2[12]][C1_var4[12]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[12] + M1_var2[12]][N3_var[12] + N1_var2[12]][C1_var4[12]];
   assign mult_temp_w_conc[12] = mult_temp_w_12[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[12] = mult_temp_w_conc[12] + result_mem_12[M3_var[12]][N3_var[12]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[12] <= 8'd0;
       		M1_var2[12] <= 8'd0;
       		C1_var4[12] <= 6'd0;
       		N3_var[12] <= 8'd0;
			M3_var[12] <= 8'd0;
			conv_done[12] <= 1'd0;
			result_temp[12] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_12[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[12] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[12] == 0)
   			begin
   				result_temp[12] <= result_mem_12[M3_var[12]][N3_var[12]][0] + 
   				kernel_arr_in12[M1_var2[12]][N1_var2[12]][C1_var4[12]][0] * 
   				image_mem_arr_in_zpad[M3_var[12] + M1_var2[12]][N3_var[12] + N1_var2[12]][C1_var4[12]];
   				//-----------------------------------------------------------
   				result_mem_12[M3_var[12]][N3_var[12]][0] <= res_temp_w_conc[12];
   				N1_var2[12] <= N1_var2[12] + 1;
   				if (N1_var2[12] >= N1_PARAM-1)
   				begin
   					N1_var2[12] <= 8'd0;
   					M1_var2[12] <= M1_var2[12] + 1;
   					if (M1_var2[12] >= M1_PARAM-1)
   					begin
   						M1_var2[12] <= 8'd0;
   						C1_var4[12] <= C1_var4[12] + 1;
   						if (C1_var4[12] >= C1_PARAM-1)
   						begin
							C1_var4[12] <= 6'd0;
   							N3_var[12] <= N3_var[12] + 1;
							result_mem_12[M3_var[12]][N3_var[12]][0]<= res_temp_w_conc[12] + biases_mem[(C1_var4[12]-2)] ;												
   							if (N3_var[12] >= N3_PARAM-1)
   							begin
   								N3_var[12] <= 8'd0;
   								M3_var[12] <= M3_var[12] + 1;
   								if (M3_var[12] >= M3_PARAM-1)
   								begin
   									conv_done[12] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [13]
   
   assign mult_temp_w_13 = kernel_arr_in13[M1_var2[13]][N1_var2[13]][C1_var4[13]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[13] + M1_var2[13]][N3_var[13] + N1_var2[13]][C1_var4[13]];
   assign mult_temp_w_conc[13] = mult_temp_w_13[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[13] = mult_temp_w_conc[13] + result_mem_13[M3_var[13]][N3_var[13]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[13] <= 8'd0;
       		M1_var2[13] <= 8'd0;
       		C1_var4[13] <= 6'd0;
       		N3_var[13] <= 8'd0;
			M3_var[13] <= 8'd0;
			conv_done[13] <= 1'd0;
			result_temp[13] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_13[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[13] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[13] == 0)
   			begin
   				result_temp[13] <= result_mem_13[M3_var[13]][N3_var[13]][0] + 
   				kernel_arr_in13[M1_var2[13]][N1_var2[13]][C1_var4[13]][0] * 
   				image_mem_arr_in_zpad[M3_var[13] + M1_var2[13]][N3_var[13] + N1_var2[13]][C1_var4[13]];
   				//-----------------------------------------------------------
   				result_mem_13[M3_var[13]][N3_var[13]][0] <= res_temp_w_conc[13];
   				N1_var2[13] <= N1_var2[13] + 1;
   				if (N1_var2[13] >= N1_PARAM-1)
   				begin
   					N1_var2[13] <= 8'd0;
   					M1_var2[13] <= M1_var2[13] + 1;
   					if (M1_var2[13] >= M1_PARAM-1)
   					begin
   						M1_var2[13] <= 8'd0;
   						C1_var4[13] <= C1_var4[13] + 1;
   						if (C1_var4[13] >= C1_PARAM-1)
   						begin
							C1_var4[13] <= 6'd0;
   							N3_var[13] <= N3_var[13] + 1;
							result_mem_13[M3_var[13]][N3_var[13]][0]<= res_temp_w_conc[13] + biases_mem[(C1_var4[13]-2)] ;												
   							if (N3_var[13] >= N3_PARAM-1)
   							begin
   								N3_var[13] <= 8'd0;
   								M3_var[13] <= M3_var[13] + 1;
   								if (M3_var[13] >= M3_PARAM-1)
   								begin
   									conv_done[13] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [14]
   
   assign mult_temp_w_14 = kernel_arr_in14[M1_var2[14]][N1_var2[14]][C1_var4[14]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[14] + M1_var2[14]][N3_var[14] + N1_var2[14]][C1_var4[14]];
   assign mult_temp_w_conc[14] = mult_temp_w_14[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[14] = mult_temp_w_conc[14] + result_mem_14[M3_var[14]][N3_var[14]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[14] <= 8'd0;
       		M1_var2[14] <= 8'd0;
       		C1_var4[14] <= 6'd0;
       		N3_var[14] <= 8'd0;
			M3_var[14] <= 8'd0;
			conv_done[14] <= 1'd0;
			result_temp[14] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_14[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[14] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[14] == 0)
   			begin
   				result_temp[14] <= result_mem_14[M3_var[14]][N3_var[14]][0] + 
   				kernel_arr_in14[M1_var2[14]][N1_var2[14]][C1_var4[14]][0] * 
   				image_mem_arr_in_zpad[M3_var[14] + M1_var2[14]][N3_var[14] + N1_var2[14]][C1_var4[14]];
   				//-----------------------------------------------------------
   				result_mem_4[M3_var[14]][N3_var[14]][0] <= res_temp_w_conc[14];
   				N1_var2[14] <= N1_var2[14] + 1;
   				if (N1_var2[14] >= N1_PARAM-1)
   				begin
   					N1_var2[14] <= 8'd0;
   					M1_var2[14] <= M1_var2[14] + 1;
   					if (M1_var2[14] >= M1_PARAM-1)
   					begin
   						M1_var2[14] <= 8'd0;
   						C1_var4[14] <= C1_var4[14] + 1;
   						if (C1_var4[14] >= C1_PARAM-1)
   						begin
							C1_var4[14] <= 6'd0;
   							N3_var[14] <= N3_var[14] + 1;
							result_mem_14[M3_var[14]][N3_var[14]][0]<= res_temp_w_conc[14] + biases_mem[(C1_var4[14]-2)] ;												
   							if (N3_var[14] >= N3_PARAM-1)
   							begin
   								N3_var[14] <= 8'd0;
   								M3_var[14] <= M3_var[14] + 1;
   								if (M3_var[14] >= M3_PARAM-1)
   								begin
   									conv_done[14] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [15]
   
   assign mult_temp_w_15 = kernel_arr_in15[M1_var2[15]][N1_var2[15]][C1_var4[15]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[15] + M1_var2[15]][N3_var[15] + N1_var2[15]][C1_var4[15]];
   assign mult_temp_w_conc[15] = mult_temp_w_15[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[15] = mult_temp_w_conc[15] + result_mem_15[M3_var[15]][N3_var[15]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[15] <= 8'd0;
       		M1_var2[15] <= 8'd0;
       		C1_var4[15] <= 6'd0;
       		N3_var[15] <= 8'd0;
			M3_var[15] <= 8'd0;
			conv_done[15] <= 1'd0;
			result_temp[15] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_15[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[15] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[15] == 0)
   			begin
   				result_temp[15] <= result_mem_15[M3_var[15]][N3_var[15]][0] + 
   				kernel_arr_in15[M1_var2[15]][N1_var2[15]][C1_var4[15]][0] * 
   				image_mem_arr_in_zpad[M3_var[15] + M1_var2[15]][N3_var[15] + N1_var2[15]][C1_var4[15]];
   				//-----------------------------------------------------------
   				result_mem_15[M3_var[15]][N3_var[15]][0] <= res_temp_w_conc[15];
   				N1_var2[15] <= N1_var2[15] + 1;
   				if (N1_var2[15] >= N1_PARAM-1)
   				begin
   					N1_var2[15] <= 8'd0;
   					M1_var2[15] <= M1_var2[15] + 1;
   					if (M1_var2[15] >= M1_PARAM-1)
   					begin
   						M1_var2[15] <= 8'd0;
   						C1_var4[15] <= C1_var4[15] + 1;
   						if (C1_var4[15] >= C1_PARAM-1)
   						begin
							C1_var4[15] <= 6'd0;
   							N3_var[15] <= N3_var[15] + 1;
							result_mem_15[M3_var[15]][N3_var[15]][0]<= res_temp_w_conc[15] + biases_mem[(C1_var4[15]-2)] ;												
   							if (N3_var[15] >= N3_PARAM-1)
   							begin
   								N3_var[15] <= 8'd0;
   								M3_var[15] <= M3_var[15] + 1;
   								if (M3_var[15] >= M3_PARAM-1)
   								begin
   									conv_done[15] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [16]
   
   assign mult_temp_w_16 = kernel_arr_in16[M1_var2[16]][N1_var2[16]][C1_var4[16]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[16] + M1_var2[16]][N3_var[16] + N1_var2[16]][C1_var4[16]];
   assign mult_temp_w_conc[16] = mult_temp_w_16[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[16] = mult_temp_w_conc[16] + result_mem_16[M3_var[16]][N3_var[16]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[16] <= 8'd0;
       		M1_var2[16] <= 8'd0;
       		C1_var4[16] <= 6'd0;
       		N3_var[16] <= 8'd0;
			M3_var[16] <= 8'd0;
			conv_done[16] <= 1'd0;
			result_temp[16] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_16[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[16] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[16] == 0)
   			begin
   				result_temp[16] <= result_mem_16[M3_var[16]][N3_var[16]][0] + 
   				kernel_arr_in16[M1_var2[16]][N1_var2[16]][C1_var4[16]][0] * 
   				image_mem_arr_in_zpad[M3_var[16] + M1_var2[16]][N3_var[16] + N1_var2[16]][C1_var4[16]];
   				//-----------------------------------------------------------
   				result_mem_16[M3_var[16]][N3_var[16]][0] <= res_temp_w_conc[16];
   				N1_var2[16] <= N1_var2[16] + 1;
   				if (N1_var2[16] >= N1_PARAM-1)
   				begin
   					N1_var2[16] <= 8'd0;
   					M1_var2[16] <= M1_var2[16] + 1;
   					if (M1_var2[16] >= M1_PARAM-1)
   					begin
   						M1_var2[16] <= 8'd0;
   						C1_var4[16] <= C1_var4[16] + 1;
   						if (C1_var4[16] >= C1_PARAM-1)
   						begin
							C1_var4[16] <= 6'd0;
   							N3_var[16] <= N3_var[16] + 1;
							result_mem_16[M3_var[16]][N3_var[16]][0]<= res_temp_w_conc[16] + biases_mem[(C1_var4[16]-2)] ;												
   							if (N3_var[16] >= N3_PARAM-1)
   							begin
   								N3_var[16] <= 8'd0;
   								M3_var[16] <= M3_var[16] + 1;
   								if (M3_var[16] >= M3_PARAM-1)
   								begin
   									conv_done[16] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [17]
   
   assign mult_temp_w_17 = kernel_arr_in17[M1_var2[17]][N1_var2[17]][C1_var4[17]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[17] + M1_var2[17]][N3_var[17] + N1_var2[17]][C1_var4[17]];
   assign mult_temp_w_conc[17] = mult_temp_w_17[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[17] = mult_temp_w_conc[17] + result_mem_17[M3_var[17]][N3_var[17]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[17] <= 8'd0;
       		M1_var2[17] <= 8'd0;
       		C1_var4[17] <= 6'd0;
       		N3_var[17] <= 8'd0;
			M3_var[17] <= 8'd0;
			conv_done[17] <= 1'd0;
			result_temp[17] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_17[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[17] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[17] == 0)
   			begin
   				result_temp[17] <= result_mem_17[M3_var[17]][N3_var[17]][0] + 
   				kernel_arr_in17[M1_var2[17]][N1_var2[17]][C1_var4[17]][0] * 
   				image_mem_arr_in_zpad[M3_var[17] + M1_var2[17]][N3_var[17] + N1_var2[17]][C1_var4[17]];
   				//-----------------------------------------------------------
   				result_mem_17[M3_var[17]][N3_var[17]][0] <= res_temp_w_conc[17];
   				N1_var2[17] <= N1_var2[17] + 1;
   				if (N1_var2[17] >= N1_PARAM-1)
   				begin
   					N1_var2[17] <= 8'd0;
   					M1_var2[17] <= M1_var2[17] + 1;
   					if (M1_var2[17] >= M1_PARAM-1)
   					begin
   						M1_var2[17] <= 8'd0;
   						C1_var4[17] <= C1_var4[17] + 1;
   						if (C1_var4[17] >= C1_PARAM-1)
   						begin
							C1_var4[17] <= 6'd0;
   							N3_var[17] <= N3_var[17] + 1;
							result_mem_17[M3_var[17]][N3_var[17]][0]<= res_temp_w_conc[17] + biases_mem[(C1_var4[17]-2)] ;												
   							if (N3_var[17] >= N3_PARAM-1)
   							begin
   								N3_var[17] <= 8'd0;
   								M3_var[17] <= M3_var[17] + 1;
   								if (M3_var[17] >= M3_PARAM-1)
   								begin
   									conv_done[17] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [18]
   
   assign mult_temp_w_18 = kernel_arr_in18[M1_var2[18]][N1_var2[18]][C1_var4[18]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[18] + M1_var2[18]][N3_var[18] + N1_var2[18]][C1_var4[18]];
   assign mult_temp_w_conc[18] = mult_temp_w_18[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[18] = mult_temp_w_conc[18] + result_mem_18[M3_var[18]][N3_var[18]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[18] <= 8'd0;
       		M1_var2[18] <= 8'd0;
       		C1_var4[18] <= 6'd0;
       		N3_var[18] <= 8'd0;
			M3_var[18] <= 8'd0;
			conv_done[18] <= 1'd0;
			result_temp[18] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_18[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[18] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[18] == 0)
   			begin
   				result_temp[18] <= result_mem_18[M3_var[18]][N3_var[18]][0] + 
   				kernel_arr_in18[M1_var2[18]][N1_var2[18]][C1_var4[18]][0] * 
   				image_mem_arr_in_zpad[M3_var[18] + M1_var2[18]][N3_var[18] + N1_var2[18]][C1_var4[18]];
   				//-----------------------------------------------------------
   				result_mem_18[M3_var[18]][N3_var[18]][0] <= res_temp_w_conc[18];
   				N1_var2[18] <= N1_var2[18] + 1;
   				if (N1_var2[18] >= N1_PARAM-1)
   				begin
   					N1_var2[18] <= 8'd0;
   					M1_var2[18] <= M1_var2[18] + 1;
   					if (M1_var2[18] >= M1_PARAM-1)
   					begin
   						M1_var2[18] <= 8'd0;
   						C1_var4[18] <= C1_var4[18] + 1;
   						if (C1_var4[18] >= C1_PARAM-1)
   						begin
							C1_var4[18] <= 6'd0;
   							N3_var[18] <= N3_var[18] + 1;
							result_mem_18[M3_var[18]][N3_var[18]][0]<= res_temp_w_conc[18] + biases_mem[(C1_var4[18]-2)] ;												
   							if (N3_var[18] >= N3_PARAM-1)
   							begin
   								N3_var[18] <= 8'd0;
   								M3_var[18] <= M3_var[18] + 1;
   								if (M3_var[18] >= M3_PARAM-1)
   								begin
   									conv_done[18] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [19]
   
   assign mult_temp_w_19 = kernel_arr_in19[M1_var2[19]][N1_var2[19]][C1_var4[19]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[19] + M1_var2[19]][N3_var[19] + N1_var2[19]][C1_var4[19]];
   assign mult_temp_w_conc[19] = mult_temp_w_19[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[19] = mult_temp_w_conc[19] + result_mem_19[M3_var[19]][N3_var[19]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[19] <= 8'd0;
       		M1_var2[19] <= 8'd0;
       		C1_var4[19] <= 6'd0;
       		N3_var[19] <= 8'd0;
			M3_var[19] <= 8'd0;
			conv_done[19] <= 1'd0;
			result_temp[19] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_19[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[19] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[19] == 0)
   			begin
   				result_temp[19] <= result_mem_19[M3_var[19]][N3_var[19]][0] + 
   				kernel_arr_in19[M1_var2[19]][N1_var2[19]][C1_var4[19]][0] * 
   				image_mem_arr_in_zpad[M3_var[19] + M1_var2[19]][N3_var[19] + N1_var2[19]][C1_var4[19]];
   				//-----------------------------------------------------------
   				result_mem_19[M3_var[19]][N3_var[19]][0] <= res_temp_w_conc[19];
   				N1_var2[19] <= N1_var2[19] + 1;
   				if (N1_var2[19] >= N1_PARAM-1)
   				begin
   					N1_var2[19] <= 8'd0;
   					M1_var2[19] <= M1_var2[19] + 1;
   					if (M1_var2[19] >= M1_PARAM-1)
   					begin
   						M1_var2[19] <= 8'd0;
   						C1_var4[19] <= C1_var4[19] + 1;
   						if (C1_var4[19] >= C1_PARAM-1)
   						begin
							C1_var4[19] <= 6'd0;
   							N3_var[19] <= N3_var[19] + 1;
							result_mem_19[M3_var[19]][N3_var[19]][0]<= res_temp_w_conc[19] + biases_mem[(C1_var4[19]-2)] ;												
   							if (N3_var[19] >= N3_PARAM-1)
   							begin
   								N3_var[19] <= 8'd0;
   								M3_var[19] <= M3_var[19] + 1;
   								if (M3_var[19] >= M3_PARAM-1)
   								begin
   									conv_done[19] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [20]
   
   assign mult_temp_w_20 = kernel_arr_in20[M1_var2[20]][N1_var2[20]][C1_var4[20]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[20] + M1_var2[20]][N3_var[20] + N1_var2[20]][C1_var4[20]];
   assign mult_temp_w_conc[20] = mult_temp_w_20[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[20] = mult_temp_w_conc[20] + result_mem_20[M3_var[20]][N3_var[20]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[20] <= 8'd0;
       		M1_var2[20] <= 8'd0;
       		C1_var4[20] <= 6'd0;
       		N3_var[20] <= 8'd0;
			M3_var[20] <= 8'd0;
			conv_done[20] <= 1'd0;
			result_temp[20] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_20[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[20] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[20] == 0)
   			begin
   				result_temp[20] <= result_mem_20[M3_var[20]][N3_var[20]][0] + 
   				kernel_arr_in20[M1_var2[20]][N1_var2[20]][C1_var4[20]][0] * 
   				image_mem_arr_in_zpad[M3_var[20] + M1_var2[20]][N3_var[20] + N1_var2[20]][C1_var4[20]];
   				//-----------------------------------------------------------
   				result_mem_20[M3_var[20]][N3_var[20]][0] <= res_temp_w_conc[20];
   				N1_var2[20] <= N1_var2[20] + 1;
   				if (N1_var2[20] >= N1_PARAM-1)
   				begin
   					N1_var2[20] <= 8'd0;
   					M1_var2[20] <= M1_var2[20] + 1;
   					if (M1_var2[20] >= M1_PARAM-1)
   					begin
   						M1_var2[20] <= 8'd0;
   						C1_var4[20] <= C1_var4[20] + 1;
   						if (C1_var4[20] >= C1_PARAM-1)
   						begin
							C1_var4[20] <= 6'd0;
   							N3_var[20] <= N3_var[20] + 1;
							result_mem_20[M3_var[20]][N3_var[20]][0]<= res_temp_w_conc[20] + biases_mem[(C1_var4[20]-2)] ;												
   							if (N3_var[20] >= N3_PARAM-1)
   							begin
   								N3_var[20] <= 8'd0;
   								M3_var[20] <= M3_var[20] + 1;
   								if (M3_var[20] >= M3_PARAM-1)
   								begin
   									conv_done[20] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [21]
   
   assign mult_temp_w_21 = kernel_arr_in21[M1_var2[21]][N1_var2[21]][C1_var4[21]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[21] + M1_var2[21]][N3_var[21] + N1_var2[21]][C1_var4[21]];
   assign mult_temp_w_conc[21] = mult_temp_w_21[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[21] = mult_temp_w_conc[21] + result_mem_21[M3_var[21]][N3_var[21]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[21] <= 8'd0;
       		M1_var2[21] <= 8'd0;
       		C1_var4[21] <= 6'd0;
       		N3_var[21] <= 8'd0;
			M3_var[21] <= 8'd0;
			conv_done[21] <= 1'd0;
			result_temp[21] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_21[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[21] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[21] == 0)
   			begin
   				result_temp[21] <= result_mem_21[M3_var[21]][N3_var[21]][0] + 
   				kernel_arr_in21[M1_var2[21]][N1_var2[21]][C1_var4[21]][0] * 
   				image_mem_arr_in_zpad[M3_var[21] + M1_var2[21]][N3_var[21] + N1_var2[21]][C1_var4[21]];
   				//-----------------------------------------------------------
   				result_mem_21[M3_var[21]][N3_var[21]][0] <= res_temp_w_conc[21];
   				N1_var2[21] <= N1_var2[21] + 1;
   				if (N1_var2[21] >= N1_PARAM-1)
   				begin
   					N1_var2[21] <= 8'd0;
   					M1_var2[21] <= M1_var2[21] + 1;
   					if (M1_var2[21] >= M1_PARAM-1)
   					begin
   						M1_var2[21] <= 8'd0;
   						C1_var4[21] <= C1_var4[21] + 1;
   						if (C1_var4[21] >= C1_PARAM-1)
   						begin
							C1_var4[21] <= 6'd0;
   							N3_var[21] <= N3_var[21] + 1;
							result_mem_21[M3_var[21]][N3_var[21]][0]<= res_temp_w_conc[21] + biases_mem[(C1_var4[21]-2)] ;												
   							if (N3_var[21] >= N3_PARAM-1)
   							begin
   								N3_var[21] <= 8'd0;
   								M3_var[21] <= M3_var[21] + 1;
   								if (M3_var[21] >= M3_PARAM-1)
   								begin
   									conv_done[21] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [22]
   
   assign mult_temp_w_22 = kernel_arr_in22[M1_var2[22]][N1_var2[22]][C1_var4[22]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[22] + M1_var2[22]][N3_var[22] + N1_var2[22]][C1_var4[22]];
   assign mult_temp_w_conc[22] = mult_temp_w_22[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[22] = mult_temp_w_conc[22] + result_mem_22[M3_var[22]][N3_var[22]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[22] <= 8'd0;
       		M1_var2[22] <= 8'd0;
       		C1_var4[22] <= 6'd0;
       		N3_var[22] <= 8'd0;
			M3_var[22] <= 8'd0;
			conv_done[22] <= 1'd0;
			result_temp[22] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_22[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[22] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[22] == 0)
   			begin
   				result_temp[22] <= result_mem_22[M3_var[22]][N3_var[22]][0] + 
   				kernel_arr_in22[M1_var2[22]][N1_var2[22]][C1_var4[22]][0] * 
   				image_mem_arr_in_zpad[M3_var[22] + M1_var2[22]][N3_var[22] + N1_var2[22]][C1_var4[22]];
   				//-----------------------------------------------------------
   				result_mem_22[M3_var[22]][N3_var[22]][0] <= res_temp_w_conc[22];
   				N1_var2[22] <= N1_var2[22] + 1;
   				if (N1_var2[22] >= N1_PARAM-1)
   				begin
   					N1_var2[22] <= 8'd0;
   					M1_var2[22] <= M1_var2[22] + 1;
   					if (M1_var2[22] >= M1_PARAM-1)
   					begin
   						M1_var2[22] <= 8'd0;
   						C1_var4[22] <= C1_var4[22] + 1;
   						if (C1_var4[22] >= C1_PARAM-1)
   						begin
							C1_var4[22] <= 6'd0;
   							N3_var[22] <= N3_var[22] + 1;
							result_mem_22[M3_var[22]][N3_var[22]][0]<= res_temp_w_conc[22] + biases_mem[(C1_var4[22]-2)] ;												
   							if (N3_var[22] >= N3_PARAM-1)
   							begin
   								N3_var[22] <= 8'd0;
   								M3_var[22] <= M3_var[22] + 1;
   								if (M3_var[22] >= M3_PARAM-1)
   								begin
   									conv_done[22] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [23]
   
   assign mult_temp_w_23 = kernel_arr_in23[M1_var2[23]][N1_var2[23]][C1_var4[23]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[23] + M1_var2[23]][N3_var[23] + N1_var2[23]][C1_var4[23]];
   assign mult_temp_w_conc[23] = mult_temp_w_23[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[23] = mult_temp_w_conc[23] + result_mem_23[M3_var[23]][N3_var[23]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[23] <= 8'd0;
       		M1_var2[23] <= 8'd0;
       		C1_var4[23] <= 6'd0;
       		N3_var[23] <= 8'd0;
			M3_var[23] <= 8'd0;
			conv_done[23] <= 1'd0;
			result_temp[23] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_23[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[23] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[23] == 0)
   			begin
   				result_temp[23] <= result_mem_23[M3_var[23]][N3_var[23]][0] + 
   				kernel_arr_in23[M1_var2[23]][N1_var2[23]][C1_var4[23]][0] * 
   				image_mem_arr_in_zpad[M3_var[23] + M1_var2[23]][N3_var[23] + N1_var2[23]][C1_var4[23]];
   				//-----------------------------------------------------------
   				result_mem_23[M3_var[23]][N3_var[23]][0] <= res_temp_w_conc[23];
   				N1_var2[23] <= N1_var2[23] + 1;
   				if (N1_var2[23] >= N1_PARAM-1)
   				begin
   					N1_var2[23] <= 8'd0;
   					M1_var2[23] <= M1_var2[23] + 1;
   					if (M1_var2[23] >= M1_PARAM-1)
   					begin
   						M1_var2[23] <= 8'd0;
   						C1_var4[23] <= C1_var4[23] + 1;
   						if (C1_var4[23] >= C1_PARAM-1)
   						begin
							C1_var4[23] <= 6'd0;
   							N3_var[23] <= N3_var[23] + 1;
							result_mem_23[M3_var[23]][N3_var[23]][0]<= res_temp_w_conc[23] + biases_mem[(C1_var4[23]-2)] ;												
   							if (N3_var[23] >= N3_PARAM-1)
   							begin
   								N3_var[23] <= 8'd0;
   								M3_var[23] <= M3_var[23] + 1;
   								if (M3_var[23] >= M3_PARAM-1)
   								begin
   									conv_done[23] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [24]
   
   assign mult_temp_w_24 = kernel_arr_in24[M1_var2[24]][N1_var2[24]][C1_var4[24]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[24] + M1_var2[24]][N3_var[24] + N1_var2[24]][C1_var4[24]];
   assign mult_temp_w_conc[24] = mult_temp_w_24[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[24] = mult_temp_w_conc[24] + result_mem_24[M3_var[24]][N3_var[24]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[24] <= 8'd0;
       		M1_var2[24] <= 8'd0;
       		C1_var4[24] <= 6'd0;
       		N3_var[24] <= 8'd0;
			M3_var[24] <= 8'd0;
			conv_done[24] <= 1'd0;
			result_temp[24] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_24[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[24] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[24] == 0)
   			begin
   				result_temp[24] <= result_mem_24[M3_var[24]][N3_var[24]][0] + 
   				kernel_arr_in24[M1_var2[24]][N1_var2[24]][C1_var4[24]][0] * 
   				image_mem_arr_in_zpad[M3_var[24] + M1_var2[24]][N3_var[24] + N1_var2[24]][C1_var4[24]];
   				//-----------------------------------------------------------
   				result_mem_24[M3_var[24]][N3_var[24]][0] <= res_temp_w_conc[24];
   				N1_var2[24] <= N1_var2[24] + 1;
   				if (N1_var2[24] >= N1_PARAM-1)
   				begin
   					N1_var2[24] <= 8'd0;
   					M1_var2[24] <= M1_var2[24] + 1;
   					if (M1_var2[24] >= M1_PARAM-1)
   					begin
   						M1_var2[24] <= 8'd0;
   						C1_var4[24] <= C1_var4[24] + 1;
   						if (C1_var4[24] >= C1_PARAM-1)
   						begin
							C1_var4[24] <= 6'd0;
   							N3_var[24] <= N3_var[24] + 1;
							result_mem_24[M3_var[24]][N3_var[24]][0]<= res_temp_w_conc[24] + biases_mem[(C1_var4[24]-2)] ;												
   							if (N3_var[24] >= N3_PARAM-1)
   							begin
   								N3_var[24] <= 8'd0;
   								M3_var[24] <= M3_var[24] + 1;
   								if (M3_var[24] >= M3_PARAM-1)
   								begin
   									conv_done[24] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [25]
   
   assign mult_temp_w_25 = kernel_arr_in25[M1_var2[25]][N1_var2[25]][C1_var4[25]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[25] + M1_var2[25]][N3_var[25] + N1_var2[25]][C1_var4[25]];
   assign mult_temp_w_conc[25] = mult_temp_w_25[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[25] = mult_temp_w_conc[25] + result_mem_25[M3_var[25]][N3_var[25]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[25] <= 8'd0;
       		M1_var2[25] <= 8'd0;
       		C1_var4[25] <= 6'd0;
       		N3_var[25] <= 8'd0;
			M3_var[25] <= 8'd0;
			conv_done[25] <= 1'd0;
			result_temp[25] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_25[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[25] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[25] == 0)
   			begin
   				result_temp[25] <= result_mem_25[M3_var[25]][N3_var[25]][0] + 
   				kernel_arr_in25[M1_var2[25]][N1_var2[25]][C1_var4[25]][0] * 
   				image_mem_arr_in_zpad[M3_var[25] + M1_var2[25]][N3_var[25] + N1_var2[25]][C1_var4[25]];
   				//-----------------------------------------------------------
   				result_mem_25[M3_var[25]][N3_var[25]][0] <= res_temp_w_conc[25];
   				N1_var2[25] <= N1_var2[25] + 1;
   				if (N1_var2[25] >= N1_PARAM-1)
   				begin
   					N1_var2[25] <= 8'd0;
   					M1_var2[25] <= M1_var2[25] + 1;
   					if (M1_var2[25] >= M1_PARAM-1)
   					begin
   						M1_var2[25] <= 8'd0;
   						C1_var4[25] <= C1_var4[25] + 1;
   						if (C1_var4[25] >= C1_PARAM-1)
   						begin
							C1_var4[25] <= 6'd0;
   							N3_var[25] <= N3_var[25] + 1;
							result_mem_25[M3_var[25]][N3_var[25]][0]<= res_temp_w_conc[25] + biases_mem[(C1_var4[25]-2)] ;												
   							if (N3_var[25] >= N3_PARAM-1)
   							begin
   								N3_var[25] <= 8'd0;
   								M3_var[25] <= M3_var[25] + 1;
   								if (M3_var[25] >= M3_PARAM-1)
   								begin
   									conv_done[25] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [26]
   
   assign mult_temp_w_26 = kernel_arr_in26[M1_var2[26]][N1_var2[26]][C1_var4[26]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[26] + M1_var2[26]][N3_var[26] + N1_var2[26]][C1_var4[26]];
   assign mult_temp_w_conc[26] = mult_temp_w_26[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[26] = mult_temp_w_conc[26] + result_mem_26[M3_var[26]][N3_var[26]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[26] <= 8'd0;
       		M1_var2[26] <= 8'd0;
       		C1_var4[26] <= 6'd0;
       		N3_var[26] <= 8'd0;
			M3_var[26] <= 8'd0;
			conv_done[26] <= 1'd0;
			result_temp[26] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_26[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[26] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[26] == 0)
   			begin
   				result_temp[26] <= result_mem_26[M3_var[26]][N3_var[26]][0] + 
   				kernel_arr_in26[M1_var2[26]][N1_var2[26]][C1_var4[26]][0] * 
   				image_mem_arr_in_zpad[M3_var[26] + M1_var2[26]][N3_var[26] + N1_var2[26]][C1_var4[26]];
   				//-----------------------------------------------------------
   				result_mem_26[M3_var[26]][N3_var[26]][0] <= res_temp_w_conc[26];
   				N1_var2[26] <= N1_var2[26] + 1;
   				if (N1_var2[26] >= N1_PARAM-1)
   				begin
   					N1_var2[26] <= 8'd0;
   					M1_var2[26] <= M1_var2[26] + 1;
   					if (M1_var2[26] >= M1_PARAM-1)
   					begin
   						M1_var2[26] <= 8'd0;
   						C1_var4[26] <= C1_var4[26] + 1;
   						if (C1_var4[26] >= C1_PARAM-1)
   						begin
							C1_var4[26] <= 6'd0;
   							N3_var[26] <= N3_var[26] + 1;
							result_mem_26[M3_var[26]][N3_var[26]][0]<= res_temp_w_conc[26] + biases_mem[(C1_var4[26]-2)] ;												
   							if (N3_var[26] >= N3_PARAM-1)
   							begin
   								N3_var[26] <= 8'd0;
   								M3_var[26] <= M3_var[26] + 1;
   								if (M3_var[26] >= M3_PARAM-1)
   								begin
   									conv_done[26] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [27]
   
   assign mult_temp_w_27 = kernel_arr_in27[M1_var2[27]][N1_var2[27]][C1_var4[27]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[27] + M1_var2[27]][N3_var[27] + N1_var2[27]][C1_var4[27]];
   assign mult_temp_w_conc[27] = mult_temp_w_27[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[27] = mult_temp_w_conc[27] + result_mem_27[M3_var[27]][N3_var[27]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[27] <= 8'd0;
       		M1_var2[27] <= 8'd0;
       		C1_var4[27] <= 6'd0;
       		N3_var[27] <= 8'd0;
			M3_var[27] <= 8'd0;
			conv_done[27] <= 1'd0;
			result_temp[27] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_27[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[27] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[27] == 0)
   			begin
   				result_temp[27] <= result_mem_27[M3_var[27]][N3_var[27]][0] + 
   				kernel_arr_in27[M1_var2[27]][N1_var2[27]][C1_var4[27]][0] * 
   				image_mem_arr_in_zpad[M3_var[27] + M1_var2[27]][N3_var[27] + N1_var2[27]][C1_var4[27]];
   				//-----------------------------------------------------------
   				result_mem_27[M3_var[27]][N3_var[27]][0] <= res_temp_w_conc[27];
   				N1_var2[27] <= N1_var2[27] + 1;
   				if (N1_var2[27] >= N1_PARAM-1)
   				begin
   					N1_var2[27] <= 8'd0;
   					M1_var2[27] <= M1_var2[27] + 1;
   					if (M1_var2[27] >= M1_PARAM-1)
   					begin
   						M1_var2[27] <= 8'd0;
   						C1_var4[27] <= C1_var4[27] + 1;
   						if (C1_var4[27] >= C1_PARAM-1)
   						begin
							C1_var4[27] <= 6'd0;
   							N3_var[27] <= N3_var[27] + 1;
							result_mem_27[M3_var[27]][N3_var[27]][0]<= res_temp_w_conc[27] + biases_mem[(C1_var4[27]-2)] ;												
   							if (N3_var[27] >= N3_PARAM-1)
   							begin
   								N3_var[27] <= 8'd0;
   								M3_var[27] <= M3_var[27] + 1;
   								if (M3_var[27] >= M3_PARAM-1)
   								begin
   									conv_done[27] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [28]
   
   assign mult_temp_w_28 = kernel_arr_in28[M1_var2[28]][N1_var2[28]][C1_var4[28]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[28] + M1_var2[28]][N3_var[28] + N1_var2[28]][C1_var4[28]];
   assign mult_temp_w_conc[28] = mult_temp_w_28[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[28] = mult_temp_w_conc[28] + result_mem_28[M3_var[28]][N3_var[28]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[28] <= 8'd0;
       		M1_var2[28] <= 8'd0;
       		C1_var4[28] <= 6'd0;
       		N3_var[28] <= 8'd0;
			M3_var[28] <= 8'd0;
			conv_done[28] <= 1'd0;
			result_temp[28] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_28[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[28] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[28] == 0)
   			begin
   				result_temp[28] <= result_mem_28[M3_var[28]][N3_var[28]][0] + 
   				kernel_arr_in28[M1_var2[28]][N1_var2[28]][C1_var4[28]][0] * 
   				image_mem_arr_in_zpad[M3_var[28] + M1_var2[28]][N3_var[28] + N1_var2[28]][C1_var4[28]];
   				//-----------------------------------------------------------
   				result_mem_28[M3_var[28]][N3_var[28]][0] <= res_temp_w_conc[28];
   				N1_var2[28] <= N1_var2[28] + 1;
   				if (N1_var2[28] >= N1_PARAM-1)
   				begin
   					N1_var2[28] <= 8'd0;
   					M1_var2[28] <= M1_var2[28] + 1;
   					if (M1_var2[28] >= M1_PARAM-1)
   					begin
   						M1_var2[28] <= 8'd0;
   						C1_var4[28] <= C1_var4[28] + 1;
   						if (C1_var4[28] >= C1_PARAM-1)
   						begin
							C1_var4[28] <= 6'd0;
   							N3_var[28] <= N3_var[28] + 1;
							result_mem_28[M3_var[28]][N3_var[28]][0]<= res_temp_w_conc[28] + biases_mem[(C1_var4[28]-2)] ;												
   							if (N3_var[28] >= N3_PARAM-1)
   							begin
   								N3_var[28] <= 8'd0;
   								M3_var[28] <= M3_var[28] + 1;
   								if (M3_var[28] >= M3_PARAM-1)
   								begin
   									conv_done[28] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [29]
   
   assign mult_temp_w_29 = kernel_arr_in29[M1_var2[29]][N1_var2[29]][C1_var4[29]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[29] + M1_var2[29]][N3_var[29] + N1_var2[29]][C1_var4[29]];
   assign mult_temp_w_conc[29] = mult_temp_w_29[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[29] = mult_temp_w_conc[29] + result_mem_29[M3_var[29]][N3_var[29]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[29] <= 8'd0;
       		M1_var2[29] <= 8'd0;
       		C1_var4[29] <= 6'd0;
       		N3_var[29] <= 8'd0;
			M3_var[29] <= 8'd0;
			conv_done[29] <= 1'd0;
			result_temp[29] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_29[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[29] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[29] == 0)
   			begin
   				result_temp[29] <= result_mem_29[M3_var[29]][N3_var[29]][0] + 
   				kernel_arr_in29[M1_var2[29]][N1_var2[29]][C1_var4[29]][0] * 
   				image_mem_arr_in_zpad[M3_var[29] + M1_var2[29]][N3_var[29] + N1_var2[29]][C1_var4[29]];
   				//-----------------------------------------------------------
   				result_mem_29[M3_var[29]][N3_var[29]][0] <= res_temp_w_conc[29];
   				N1_var2[29] <= N1_var2[29] + 1;
   				if (N1_var2[29] >= N1_PARAM-1)
   				begin
   					N1_var2[29] <= 8'd0;
   					M1_var2[29] <= M1_var2[29] + 1;
   					if (M1_var2[29] >= M1_PARAM-1)
   					begin
   						M1_var2[29] <= 8'd0;
   						C1_var4[29] <= C1_var4[29] + 1;
   						if (C1_var4[29] >= C1_PARAM-1)
   						begin
							C1_var4[29] <= 6'd0;
   							N3_var[29] <= N3_var[29] + 1;
							result_mem_29[M3_var[29]][N3_var[29]][0]<= res_temp_w_conc[29] + biases_mem[(C1_var4[29]-2)] ;												
   							if (N3_var[29] >= N3_PARAM-1)
   							begin
   								N3_var[29] <= 8'd0;
   								M3_var[29] <= M3_var[29] + 1;
   								if (M3_var[29] >= M3_PARAM-1)
   								begin
   									conv_done[29] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [30]
   
   assign mult_temp_w_30 = kernel_arr_in30[M1_var2[30]][N1_var2[30]][C1_var4[30]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[30] + M1_var2[30]][N3_var[30] + N1_var2[30]][C1_var4[30]];
   assign mult_temp_w_conc[30] = mult_temp_w_30[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[30] = mult_temp_w_conc[30] + result_mem_30[M3_var[30]][N3_var[30]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[30] <= 8'd0;
       		M1_var2[30] <= 8'd0;
       		C1_var4[30] <= 6'd0;
       		N3_var[30] <= 8'd0;
			M3_var[30] <= 8'd0;
			conv_done[30] <= 1'd0;
			result_temp[30] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_30[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[30] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[30] == 0)
   			begin
   				result_temp[30] <= result_mem_30[M3_var[30]][N3_var[30]][0] + 
   				kernel_arr_in30[M1_var2[30]][N1_var2[30]][C1_var4[30]][0] * 
   				image_mem_arr_in_zpad[M3_var[30] + M1_var2[30]][N3_var[30] + N1_var2[30]][C1_var4[30]];
   				//-----------------------------------------------------------
   				result_mem_30[M3_var[30]][N3_var[30]][0] <= res_temp_w_conc[30];
   				N1_var2[30] <= N1_var2[30] + 1;
   				if (N1_var2[30] >= N1_PARAM-1)
   				begin
   					N1_var2[30] <= 8'd0;
   					M1_var2[30] <= M1_var2[30] + 1;
   					if (M1_var2[30] >= M1_PARAM-1)
   					begin
   						M1_var2[30] <= 8'd0;
   						C1_var4[30] <= C1_var4[30] + 1;
   						if (C1_var4[30] >= C1_PARAM-1)
   						begin
							C1_var4[30] <= 6'd0;
   							N3_var[30] <= N3_var[30] + 1;
							result_mem_30[M3_var[30]][N3_var[30]][0]<= res_temp_w_conc[30] + biases_mem[(C1_var4[30]-2)] ;												
   							if (N3_var[30] >= N3_PARAM-1)
   							begin
   								N3_var[30] <= 8'd0;
   								M3_var[30] <= M3_var[30] + 1;
   								if (M3_var[30] >= M3_PARAM-1)
   								begin
   									conv_done[30] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
     
  //---------------------------------------------------------------------------------------------------------------------------
   ////////////////////////
   // convolution [31]
   
   assign mult_temp_w_31 = kernel_arr_in31[M1_var2[31]][N1_var2[31]][C1_var4[31]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[31] + M1_var2[31]][N3_var[31] + N1_var2[31]][C1_var4[31]];
   assign mult_temp_w_conc[31] = mult_temp_w_31[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[31] = mult_temp_w_conc[31] + result_mem_31[M3_var[31]][N3_var[31]][0];//wire with result
   
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2[31] <= 8'd0;
       		M1_var2[31] <= 8'd0;
       		C1_var4[31] <= 6'd0;
       		N3_var[31] <= 8'd0;
			M3_var[31] <= 8'd0;
			conv_done[31] <= 1'd0;
			result_temp[31] <= 39'd0;/*
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem_31[j][i][k] <= 19'd0;
					end
				end	
			end/**/
       	end
       	else begin
       		if (kernel_recieved[31] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done[31] == 0)
   			begin
   				result_temp[31] <= result_mem_31[M3_var[31]][N3_var[31]][0] + 
   				kernel_arr_in31[M1_var2[31]][N1_var2[31]][C1_var4[31]][0] * 
   				image_mem_arr_in_zpad[M3_var[31] + M1_var2[31]][N3_var[31] + N1_var2[31]][C1_var4[31]];
   				//-----------------------------------------------------------
   				result_mem_31[M3_var[31]][N3_var[31]][0] <= res_temp_w_conc[31];
   				N1_var2[31] <= N1_var2[31] + 1;
   				if (N1_var2[31] >= N1_PARAM-1)
   				begin
   					N1_var2[31] <= 8'd0;
   					M1_var2[31] <= M1_var2[31] + 1;
   					if (M1_var2[31] >= M1_PARAM-1)
   					begin
   						M1_var2[31] <= 8'd0;
   						C1_var4[31] <= C1_var4[31] + 1;
   						if (C1_var4[31] >= C1_PARAM-1)
   						begin
							C1_var4[31] <= 6'd0;
   							N3_var[31] <= N3_var[31] + 1;
							result_mem_31[M3_var[31]][N3_var[31]][0]<= res_temp_w_conc[31] + biases_mem[(C1_var4[31]-2)] ;												
   							if (N3_var[31] >= N3_PARAM-1)
   							begin
   								N3_var[31] <= 8'd0;
   								M3_var[31] <= M3_var[31] + 1;
   								if (M3_var[31] >= M3_PARAM-1)
   								begin
   									conv_done[31] <= 1;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
    
//_____________________________________________________________________________________________________________________________________________________________________
	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[0] <= 8'd0;
			M3_var_def[0] <= 8'd0;
			result_flattened[0] <= 1'd0;    		
		end
		else if (conv_done[0] == 1)
		begin
			result_fl_0[M3_var_def[0]*N3_PARAM + N3_var_def[0]] <=
			result_mem_0[N3_var_def[0]][M3_var_def[0]][0];
			//--------
			result0 <= result_fl_0[M3_var_def[0]*N3_PARAM + N3_var_def[0]];
			//incerementing arrays counters
			N3_var_def[0] <= N3_var_def[0] + 1;
			if (N3_var_def[0] >= N3_PARAM-1)
			begin
				N3_var_def[0] <= 8'd0;
				M3_var_def[0] <= M3_var_def[0] + 1;
				if (M3_var_def[0] >= M3_PARAM-1)
				begin
					M3_var_def[0] <= 8'd0;					
					result_flattened[0] <= 1'd1;
					
				end
			end
		end
	end

	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[1] <= 8'd0;
			M3_var_def[1] <= 8'd0;
			result_flattened[1] <= 1'd0;    		
		end
		else if (conv_done[1] == 1)
		begin
			result_fl_1[M3_var_def[1]*N3_PARAM + N3_var_def[1]] <=
			result_mem_1[N3_var_def[1]][M3_var_def[1]][0];
			//--------
			result1 <= result_fl_1[M3_var_def[1]*N3_PARAM + N3_var_def[1]];
			//incerementing arrays counters
			N3_var_def[1] <= N3_var_def[1] + 1;
			if (N3_var_def[1] >= N3_PARAM-1)
			begin
				N3_var_def[1] <= 8'd0;
				M3_var_def[1] <= M3_var_def[1] + 1;
				if (M3_var_def[1] >= M3_PARAM-1)
				begin
					M3_var_def[1] <= 8'd0;					
					result_flattened[1] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[2] <= 8'd0;
			M3_var_def[2] <= 8'd0;
			result_flattened[2] <= 1'd0;    		
		end
		else if (conv_done[2] == 1)
		begin
			result_fl_2[M3_var_def[2]*N3_PARAM + N3_var_def[2]] <=
			result_mem_2[N3_var_def[2]][M3_var_def[2]][0];
			//--------
			result2 <= result_fl_2[M3_var_def[2]*N3_PARAM + N3_var_def[2]];
			//incerementing arrays counters
			N3_var_def[2] <= N3_var_def[2] + 1;
			if (N3_var_def[2] >= N3_PARAM-1)
			begin
				N3_var_def[2] <= 8'd0;
				M3_var_def[2] <= M3_var_def[2] + 1;
				if (M3_var_def[2] >= M3_PARAM-1)
				begin
					M3_var_def[2] <= 8'd0;					
					result_flattened[2] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[3] <= 8'd0;
			M3_var_def[3] <= 8'd0;
			result_flattened[3] <= 1'd0;    		
		end
		else if (conv_done[3] == 1)
		begin
			result_fl_3[M3_var_def[3]*N3_PARAM + N3_var_def[3]] <=
			result_mem_3[N3_var_def[3]][M3_var_def[3]][0];
			//--------
			result3 <= result_fl_3[M3_var_def[3]*N3_PARAM + N3_var_def[3]];
			//incerementing arrays counters
			N3_var_def[3] <= N3_var_def[3] + 1;
			if (N3_var_def[3] >= N3_PARAM-1)
			begin
				N3_var_def[3] <= 8'd0;
				M3_var_def[3] <= M3_var_def[3] + 1;
				if (M3_var_def[3] >= M3_PARAM-1)
				begin
					M3_var_def[3] <= 8'd0;					
					result_flattened[3] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[4] <= 8'd0;
			M3_var_def[4] <= 8'd0;
			result_flattened[4] <= 1'd0;    		
		end
		else if (conv_done[4] == 1)
		begin
			result_fl_4[M3_var_def[4]*N3_PARAM + N3_var_def[4]] <=
			result_mem_4[N3_var_def[4]][M3_var_def[4]][0];
			//--------
			result4 <= result_fl_4[M3_var_def[4]*N3_PARAM + N3_var_def[4]];
			//incerementing arrays counters
			N3_var_def[4] <= N3_var_def[4] + 1;
			if (N3_var_def[4] >= N3_PARAM-1)
			begin
				N3_var_def[4] <= 8'd0;
				M3_var_def[4] <= M3_var_def[4] + 1;
				if (M3_var_def[4] >= M3_PARAM-1)
				begin
					M3_var_def[4] <= 8'd0;					
					result_flattened[4] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[5] <= 8'd0;
			M3_var_def[5] <= 8'd0;
			result_flattened[5] <= 1'd0;    		
		end
		else if (conv_done[5] == 1)
		begin
			result_fl_5[M3_var_def[5]*N3_PARAM + N3_var_def[5]] <=
			result_mem_5[N3_var_def[5]][M3_var_def[5]][0];
			//--------
			result5 <= result_fl_5[M3_var_def[5]*N3_PARAM + N3_var_def[5]];
			//incerementing arrays counters
			N3_var_def[5] <= N3_var_def[5] + 1;
			if (N3_var_def[5] >= N3_PARAM-1)
			begin
				N3_var_def[5] <= 8'd0;
				M3_var_def[5] <= M3_var_def[5] + 1;
				if (M3_var_def[5] >= M3_PARAM-1)
				begin
					M3_var_def[5] <= 8'd0;					
					result_flattened[5] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[6] <= 8'd0;
			M3_var_def[6] <= 8'd0;
			result_flattened[6] <= 1'd0;    		
		end
		else if (conv_done[6] == 1)
		begin
			result_fl_6[M3_var_def[6]*N3_PARAM + N3_var_def[6]] <=
			result_mem_6[N3_var_def[6]][M3_var_def[6]][0];
			//--------
			result6 <= result_fl_6[M3_var_def[6]*N3_PARAM + N3_var_def[6]];
			//incerementing arrays counters
			N3_var_def[6] <= N3_var_def[6] + 1;
			if (N3_var_def[6] >= N3_PARAM-1)
			begin
				N3_var_def[6] <= 6'd0;
				M3_var_def[6] <= M3_var_def[6] + 1;
				if (M3_var_def[6] >= M3_PARAM-1)
				begin
					M3_var_def[6] <= 8'd0;					
					result_flattened[6] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[7] <= 8'd0;
			M3_var_def[7] <= 8'd0;
			result_flattened[7] <= 1'd0;    		
		end
		else if (conv_done[7] == 1)
		begin
			result_fl_7[M3_var_def[7]*N3_PARAM + N3_var_def[7]] <=
			result_mem_7[N3_var_def[7]][M3_var_def[7]][0];
			//--------
			result7 <= result_fl_7[M3_var_def[7]*N3_PARAM + N3_var_def[7]];
			//incerementing arrays counters
			N3_var_def[7] <= N3_var_def[7] + 1;
			if (N3_var_def[7] >= N3_PARAM-1)
			begin
				N3_var_def[7] <= 8'd0;
				M3_var_def[7] <= M3_var_def[7] + 1;
				if (M3_var_def[7] >= M3_PARAM-1)
				begin
					M3_var_def[7] <= 8'd0;					
					result_flattened[7] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[8] <= 8'd0;
			M3_var_def[8] <= 8'd0;
			result_flattened[8] <= 1'd0;    		
		end
		else if (conv_done[8] == 1)
		begin
			result_fl_8[M3_var_def[8]*N3_PARAM + N3_var_def[8]] <=
			result_mem_8[N3_var_def[8]][M3_var_def[8]][0];
			//--------
			result8 <= result_fl_8[M3_var_def[8]*N3_PARAM + N3_var_def[8]];
			//incerementing arrays counters
			N3_var_def[8] <= N3_var_def[8] + 1;
			if (N3_var_def[8] >= N3_PARAM-1)
			begin
				N3_var_def[8] <= 8'd0;
				M3_var_def[8] <= M3_var_def[8] + 1;
				if (M3_var_def[8] >= M3_PARAM-1)
				begin
					M3_var_def[8] <= 8'd0;					
					result_flattened[8] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[9] <= 8'd0;
			M3_var_def[9] <= 8'd0;
			result_flattened[9] <= 1'd0;    		
		end
		else if (conv_done[9] == 1)
		begin
			result_fl_9[M3_var_def[9]*N3_PARAM + N3_var_def[9]] <=
			result_mem_9[N3_var_def[9]][M3_var_def[9]][0];
			//--------
			result9 <= result_fl_9[M3_var_def[9]*N3_PARAM + N3_var_def[9]];
			//incerementing arrays counters
			N3_var_def[9] <= N3_var_def[9] + 1;
			if (N3_var_def[9] >= N3_PARAM-1)
			begin
				N3_var_def[9] <= 8'd0;
				M3_var_def[9] <= M3_var_def[9] + 1;
				if (M3_var_def[9] >= M3_PARAM-1)
				begin
					M3_var_def[9] <= 8'd0;					
					result_flattened[9] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[10] <= 8'd0;
			M3_var_def[10] <= 8'd0;
			result_flattened[10] <= 1'd0;    		
		end
		else if (conv_done[10] == 1)
		begin
			result_fl_10[M3_var_def[10]*N3_PARAM + N3_var_def[10]] <=
			result_mem_10[N3_var_def[10]][M3_var_def[10]][0];
			//--------
			result10 <= result_fl_10[M3_var_def[10]*N3_PARAM + N3_var_def[10]];
			//incerementing arrays counters
			N3_var_def[10] <= N3_var_def[10] + 1;
			if (N3_var_def[10] >= N3_PARAM-1)
			begin
				N3_var_def[10] <= 8'd0;
				M3_var_def[10] <= M3_var_def[10] + 1;
				if (M3_var_def[10] >= M3_PARAM-1)
				begin
					M3_var_def[10] <= 8'd0;					
					result_flattened[10] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[11] <= 8'd0;
			M3_var_def[11] <= 8'd0;
			result_flattened[11] <= 1'd0;    		
		end
		else if (conv_done[11] == 1)
		begin
			result_fl_11[M3_var_def[11]*N3_PARAM + N3_var_def[11]] <=
			result_mem_11[N3_var_def[11]][M3_var_def[11]][0];
			//--------
			result11 <= result_fl_11[M3_var_def[11]*N3_PARAM + N3_var_def[11]];
			//incerementing arrays counters
			N3_var_def[11] <= N3_var_def[11] + 1;
			if (N3_var_def[11] >= N3_PARAM-1)
			begin
				N3_var_def[11] <= 8'd0;
				M3_var_def[11] <= M3_var_def[11] + 1;
				if (M3_var_def[11] >= M3_PARAM-1)
				begin
					M3_var_def[11] <= 8'd0;					
					result_flattened[11] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[12] <= 8'd0;
			M3_var_def[12] <= 8'd0;
			result_flattened[12] <= 1'd0;    		
		end
		else if (conv_done[12] == 1)
		begin
			result_fl_12[M3_var_def[12]*N3_PARAM + N3_var_def[12]] <=
			result_mem_12[N3_var_def[12]][M3_var_def[12]][0];
			//--------
			result12 <= result_fl_12[M3_var_def[12]*N3_PARAM + N3_var_def[12]];
			//incerementing arrays counters
			N3_var_def[12] <= N3_var_def[12] + 1;
			if (N3_var_def[12] >= N3_PARAM-1)
			begin
				N3_var_def[12] <= 8'd0;
				M3_var_def[12] <= M3_var_def[12] + 1;
				if (M3_var_def[12] >= M3_PARAM-1)
				begin
					M3_var_def[12] <= 8'd0;					
					result_flattened[12] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[13] <= 8'd0;
			M3_var_def[13] <= 8'd0;
			result_flattened[13] <= 1'd0;    		
		end
		else if (conv_done[13] == 1)
		begin
			result_fl_13[M3_var_def[13]*N3_PARAM + N3_var_def[13]] <=
			result_mem_13[N3_var_def[13]][M3_var_def[13]][0];
			//--------
			result13 <= result_fl_13[M3_var_def[13]*N3_PARAM + N3_var_def[13]];
			//incerementing arrays counters
			N3_var_def[13] <= N3_var_def[13] + 1;
			if (N3_var_def[13] >= N3_PARAM-1)
			begin
				N3_var_def[13] <= 8'd0;
				M3_var_def[13] <= M3_var_def[13] + 1;
				if (M3_var_def[13] >= M3_PARAM-1)
				begin
					M3_var_def[13] <= 8'd0;					
					result_flattened[13] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[14] <= 8'd0;
			M3_var_def[14] <= 8'd0;
			result_flattened[14] <= 1'd0;    		
		end
		else if (conv_done[14] == 1)
		begin
			result_fl_14[M3_var_def[14]*N3_PARAM + N3_var_def[14]] <=
			result_mem_14[N3_var_def[14]][M3_var_def[14]][0];
			//--------
			result14 <= result_fl_14[M3_var_def[14]*N3_PARAM + N3_var_def[14]];
			//incerementing arrays counters
			N3_var_def[14] <= N3_var_def[14] + 1;
			if (N3_var_def[14] >= N3_PARAM-1)
			begin
				N3_var_def[14] <= 8'd0;
				M3_var_def[14] <= M3_var_def[14] + 1;
				if (M3_var_def[14] >= M3_PARAM-1)
				begin
					M3_var_def[14] <= 8'd0;					
					result_flattened[14] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[15] <= 8'd0;
			M3_var_def[15] <= 8'd0;
			result_flattened[15] <= 1'd0;    		
		end
		else if (conv_done[15] == 1)
		begin
			result_fl_15[M3_var_def[15]*N3_PARAM + N3_var_def[15]] <=
			result_mem_15[N3_var_def[15]][M3_var_def[15]][0];
			//--------
			result15 <= result_fl_15[M3_var_def[15]*N3_PARAM + N3_var_def[15]];
			//incerementing arrays counters
			N3_var_def[15] <= N3_var_def[15] + 1;
			if (N3_var_def[15] >= N3_PARAM-1)
			begin
				N3_var_def[15] <= 8'd0;
				M3_var_def[15] <= M3_var_def[15] + 1;
				if (M3_var_def[15] >= M3_PARAM-1)
				begin
					M3_var_def[15] <= 8'd0;					
					result_flattened[15] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[16] <= 8'd0;
			M3_var_def[16] <= 8'd0;
			result_flattened[16] <= 1'd0;    		
		end
		else if (conv_done[16] == 1)
		begin
			result_fl_16[M3_var_def[16]*N3_PARAM + N3_var_def[16]] <=
			result_mem_16[N3_var_def[16]][M3_var_def[16]][0];
			//--------
			result16 <= result_fl_16[M3_var_def[16]*N3_PARAM + N3_var_def[16]];
			//incerementing arrays counters
			N3_var_def[16] <= N3_var_def[16] + 1;
			if (N3_var_def[16] >= N3_PARAM-1)
			begin
				N3_var_def[16] <= 8'd0;
				M3_var_def[16] <= M3_var_def[16] + 1;
				if (M3_var_def[16] >= M3_PARAM-1)
				begin
					M3_var_def[16] <= 8'd0;					
					result_flattened[16] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[17] <= 8'd0;
			M3_var_def[17] <= 8'd0;
			result_flattened[17] <= 1'd0;    		
		end
		else if (conv_done[17] == 1)
		begin
			result_fl_17[M3_var_def[17]*N3_PARAM + N3_var_def[17]] <=
			result_mem_17[N3_var_def[17]][M3_var_def[17]][0];
			//--------
			result17 <= result_fl_17[M3_var_def[17]*N3_PARAM + N3_var_def[17]];
			//incerementing arrays counters
			N3_var_def[17] <= N3_var_def[17] + 1;
			if (N3_var_def[17] >= N3_PARAM-1)
			begin
				N3_var_def[17] <= 8'd0;
				M3_var_def[17] <= M3_var_def[17] + 1;
				if (M3_var_def[17] >= M3_PARAM-1)
				begin
					M3_var_def[17] <= 8'd0;					
					result_flattened[17] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[18] <= 8'd0;
			M3_var_def[18] <= 8'd0;
			result_flattened[18] <= 1'd0;    		
		end
		else if (conv_done[18] == 1)
		begin
			result_fl_18[M3_var_def[18]*N3_PARAM + N3_var_def[18]] <=
			result_mem_18[N3_var_def[18]][M3_var_def[18]][0];
			//--------
			result18 <= result_fl_18[M3_var_def[18]*N3_PARAM + N3_var_def[18]];
			//incerementing arrays counters
			N3_var_def[18] <= N3_var_def[18] + 1;
			if (N3_var_def[18] >= N3_PARAM-1)
			begin
				N3_var_def[18] <= 8'd0;
				M3_var_def[18] <= M3_var_def[18] + 1;
				if (M3_var_def[18] >= M3_PARAM-1)
				begin
					M3_var_def[18] <= 8'd0;					
					result_flattened[18] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[19] <= 8'd0;
			M3_var_def[19] <= 8'd0;
			result_flattened[19] <= 1'd0;    		
		end
		else if (conv_done[19] == 1)
		begin
			result_fl_19[M3_var_def[19]*N3_PARAM + N3_var_def[19]] <=
			result_mem_19[N3_var_def[19]][M3_var_def[19]][0];
			//--------
			result19 <= result_fl_19[M3_var_def[19]*N3_PARAM + N3_var_def[19]];
			//incerementing arrays counters
			N3_var_def[19] <= N3_var_def[19] + 1;
			if (N3_var_def[19] >= N3_PARAM-1)
			begin
				N3_var_def[19] <= 8'd0;
				M3_var_def[19] <= M3_var_def[19] + 1;
				if (M3_var_def[19] >= M3_PARAM-1)
				begin
					M3_var_def[19] <= 8'd0;					
					result_flattened[19] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[20] <= 8'd0;
			M3_var_def[20] <= 8'd0;
			result_flattened[20] <= 1'd0;    		
		end
		else if (conv_done[20] == 1)
		begin
			result_fl_20[M3_var_def[20]*N3_PARAM + N3_var_def[20]] <=
			result_mem_20[N3_var_def[20]][M3_var_def[20]][0];
			//--------
			result20 <= result_fl_20[M3_var_def[20]*N3_PARAM + N3_var_def[20]];
			//incerementing arrays counters
			N3_var_def[20] <= N3_var_def[20] + 1;
			if (N3_var_def[20] >= N3_PARAM-1)
			begin
				N3_var_def[20] <= 8'd0;
				M3_var_def[20] <= M3_var_def[20] + 1;
				if (M3_var_def[20] >= M3_PARAM-1)
				begin
					M3_var_def[20] <= 8'd0;					
					result_flattened[20] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[21] <= 8'd0;
			M3_var_def[21] <= 8'd0;
			result_flattened[21] <= 1'd0;    		
		end
		else if (conv_done[21] == 1)
		begin
			result_fl_21[M3_var_def[21]*N3_PARAM + N3_var_def[21]] <=
			result_mem_21[N3_var_def[21]][M3_var_def[21]][0];
			//--------
			result21 <= result_fl_21[M3_var_def[21]*N3_PARAM + N3_var_def[21]];
			//incerementing arrays counters
			N3_var_def[21] <= N3_var_def[21] + 1;
			if (N3_var_def[21] >= N3_PARAM-1)
			begin
				N3_var_def[21] <= 8'd0;
				M3_var_def[21] <= M3_var_def[21] + 1;
				if (M3_var_def[21] >= M3_PARAM-1)
				begin
					M3_var_def[21] <= 8'd0;					
					result_flattened[21] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[22] <= 8'd0;
			M3_var_def[22] <= 8'd0;
			result_flattened[22] <= 1'd0;    		
		end
		else if (conv_done[22] == 1)
		begin
			result_fl_22[M3_var_def[22]*N3_PARAM + N3_var_def[22]] <=
			result_mem_22[N3_var_def[22]][M3_var_def[22]][0];
			//--------
			result22 <= result_fl_22[M3_var_def[22]*N3_PARAM + N3_var_def[22]];
			//incerementing arrays counters
			N3_var_def[22] <= N3_var_def[22] + 1;
			if (N3_var_def[22] >= N3_PARAM-1)
			begin
				N3_var_def[22] <= 8'd0;
				M3_var_def[22] <= M3_var_def[22] + 1;
				if (M3_var_def[22] >= M3_PARAM-1)
				begin
					M3_var_def[22] <= 8'd0;					
					result_flattened[22] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[23] <= 8'd0;
			M3_var_def[23] <= 8'd0;
			result_flattened[23] <= 1'd0;    		
		end
		else if (conv_done[23] == 1)
		begin
			result_fl_23[M3_var_def[23]*N3_PARAM + N3_var_def[23]] <=
			result_mem_23[N3_var_def[23]][M3_var_def[23]][0];
			//--------
			result23 <= result_fl_23[M3_var_def[23]*N3_PARAM + N3_var_def[23]];
			//incerementing arrays counters
			N3_var_def[23] <= N3_var_def[23] + 1;
			if (N3_var_def[23] >= N3_PARAM-1)
			begin
				N3_var_def[23] <= 8'd0;
				M3_var_def[23] <= M3_var_def[23] + 1;
				if (M3_var_def[23] >= M3_PARAM-1)
				begin
					M3_var_def[23] <= 8'd0;					
					result_flattened[23] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[24] <= 8'd0;
			M3_var_def[24] <= 8'd0;
			result_flattened[24] <= 1'd0;    		
		end
		else if (conv_done[24] == 1)
		begin
			result_fl_24[M3_var_def[24]*N3_PARAM + N3_var_def[24]] <=
			result_mem_24[N3_var_def[24]][M3_var_def[24]][0];
			//--------
			result24 <= result_fl_24[M3_var_def[24]*N3_PARAM + N3_var_def[24]];
			//incerementing arrays counters
			N3_var_def[24] <= N3_var_def[24] + 1;
			if (N3_var_def[24] >= N3_PARAM-1)
			begin
				N3_var_def[24] <= 8'd0;
				M3_var_def[24] <= M3_var_def[24] + 1;
				if (M3_var_def[24] >= M3_PARAM-1)
				begin
					M3_var_def[24] <= 8'd0;					
					result_flattened[24] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[25] <= 8'd0;
			M3_var_def[25] <= 8'd0;
			result_flattened[25] <= 1'd0;    		
		end
		else if (conv_done[25] == 1)
		begin
			result_fl_25[M3_var_def[25]*N3_PARAM + N3_var_def[25]] <=
			result_mem_25[N3_var_def[25]][M3_var_def[25]][0];
			//--------
			result25 <= result_fl_25[M3_var_def[25]*N3_PARAM + N3_var_def[25]];
			//incerementing arrays counters
			N3_var_def[25] <= N3_var_def[25] + 1;
			if (N3_var_def[25] >= N3_PARAM-1)
			begin
				N3_var_def[25] <= 8'd0;
				M3_var_def[25] <= M3_var_def[25] + 1;
				if (M3_var_def[25] >= M3_PARAM-1)
				begin
					M3_var_def[25] <= 8'd0;					
					result_flattened[25] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[26] <= 8'd0;
			M3_var_def[26] <= 8'd0;
			result_flattened[26] <= 1'd0;    		
		end
		else if (conv_done[26] == 1)
		begin
			result_fl_26[M3_var_def[26]*N3_PARAM + N3_var_def[26]] <=
			result_mem_26[N3_var_def[26]][M3_var_def[26]][0];
			//--------
			result26 <= result_fl_26[M3_var_def[26]*N3_PARAM + N3_var_def[26]];
			//incerementing arrays counters
			N3_var_def[26] <= N3_var_def[26] + 1;
			if (N3_var_def[26] >= N3_PARAM-1)
			begin
				N3_var_def[26] <= 8'd0;
				M3_var_def[26] <= M3_var_def[26] + 1;
				if (M3_var_def[26] >= M3_PARAM-1)
				begin
					M3_var_def[26] <= 8'd0;					
					result_flattened[26] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[27] <= 8'd0;
			M3_var_def[27] <= 8'd0;
			result_flattened[27] <= 1'd0;    		
		end
		else if (conv_done[27] == 1)
		begin
			result_fl_27[M3_var_def[27]*N3_PARAM + N3_var_def[27]] <=
			result_mem_27[N3_var_def[27]][M3_var_def[27]][0];
			//--------
			result27 <= result_fl_27[M3_var_def[27]*N3_PARAM + N3_var_def[27]];
			//incerementing arrays counters
			N3_var_def[27] <= N3_var_def[27] + 1;
			if (N3_var_def[27] >= N3_PARAM-1)
			begin
				N3_var_def[27] <= 8'd0;
				M3_var_def[27] <= M3_var_def[27] + 1;
				if (M3_var_def[27] >= M3_PARAM-1)
				begin
					M3_var_def[27] <= 8'd0;					
					result_flattened[27] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[28] <= 8'd0;
			M3_var_def[28] <= 8'd0;
			result_flattened[28] <= 1'd0;    		
		end
		else if (conv_done[28] == 1)
		begin
			result_fl_28[M3_var_def[28]*N3_PARAM + N3_var_def[28]] <=
			result_mem_28[N3_var_def[28]][M3_var_def[28]][0];
			//--------
			result28 <= result_fl_28[M3_var_def[28]*N3_PARAM + N3_var_def[28]];
			//incerementing arrays counters
			N3_var_def[28] <= N3_var_def[28] + 1;
			if (N3_var_def[28] >= N3_PARAM-1)
			begin
				N3_var_def[28] <= 8'd0;
				M3_var_def[28] <= M3_var_def[28] + 1;
				if (M3_var_def[28] >= M3_PARAM-1)
				begin
					M3_var_def[28] <= 8'd0;					
					result_flattened[28] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[29] <= 8'd0;
			M3_var_def[29] <= 8'd0;
			result_flattened[29] <= 1'd0;    		
		end
		else if (conv_done[29] == 1)
		begin
			result_fl_29[M3_var_def[29]*N3_PARAM + N3_var_def[29]] <=
			result_mem_29[N3_var_def[29]][M3_var_def[29]][0];
			//--------
			result29 <= result_fl_29[M3_var_def[29]*N3_PARAM + N3_var_def[29]];
			//incerementing arrays counters
			N3_var_def[29] <= N3_var_def[29] + 1;
			if (N3_var_def[29] >= N3_PARAM-1)
			begin
				N3_var_def[29] <= 8'd0;
				M3_var_def[29] <= M3_var_def[29] + 1;
				if (M3_var_def[29] >= M3_PARAM-1)
				begin
					M3_var_def[29] <= 8'd0;					
					result_flattened[29] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[30] <= 8'd0;
			M3_var_def[30] <= 8'd0;
			result_flattened[30] <= 1'd0;    		
		end
		else if (conv_done[30] == 1)
		begin
			result_fl_30[M3_var_def[30]*N3_PARAM + N3_var_def[30]] <=
			result_mem_30[N3_var_def[30]][M3_var_def[30]][0];
			//--------
			result30 <= result_fl_30[M3_var_def[30]*N3_PARAM + N3_var_def[30]];
			//incerementing arrays counters
			N3_var_def[30] <= N3_var_def[30] + 1;
			if (N3_var_def[30] >= N3_PARAM-1)
			begin
				N3_var_def[30] <= 8'd0;
				M3_var_def[30] <= M3_var_def[30] + 1;
				if (M3_var_def[30] >= M3_PARAM-1)
				begin
					M3_var_def[30] <= 8'd0;					
					result_flattened[30] <= 1'd1;
					
				end
			end
		end
	end


	//---------------------------------------------------------------------------------------------------
	////////////////////////
	// result flattening 
	always@(posedge clk)
	begin
		if (reset == 1)
		begin
			N3_var_def[31] <= 8'd0;
			M3_var_def[31] <= 8'd0;
			result_flattened[31] <= 1'd0;    		
		end
		else if (conv_done[31] == 1)
		begin
			result_fl_31[M3_var_def[31]*N3_PARAM + N3_var_def[31]] <=
			result_mem_31[N3_var_def[31]][M3_var_def[31]][0];
			//--------
			result31 <= result_fl_31[M3_var_def[31]*N3_PARAM + N3_var_def[31]];
			//incerementing arrays counters
			N3_var_def[31] <= N3_var_def[31] + 1;
			if (N3_var_def[31] >= N3_PARAM-1)
			begin
				N3_var_def[31] <= 8'd0;
				M3_var_def[31] <= M3_var_def[31] + 1;
				if (M3_var_def[31] >= M3_PARAM-1)
				begin
					M3_var_def[31] <= 8'd0;					
					result_flattened[31] <= 1'd1;
					
				end
			end
		end
	end
endmodule
