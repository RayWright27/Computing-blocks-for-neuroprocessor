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
		parameter ZERO_PADDED		= 130*130*3,
		parameter M3_PARAM			= 128,
		parameter N3_PARAM			= 128,
		parameter RAM_WIDTH_BIAS	= 16,
		parameter RAM_WIDTH_IMG		= 16,
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
	/**/	
	input		[RAM_WIDTH_IMG-1:0]	image,
	input							image_vld,
	output reg						image_rdy,
	
	input  		[RAM_WIDTH_BIAS-1:0]biases,
	input							biases_vld,
	output reg						biases_rdy,
	

	output   [RAM_WIDTH_IMG-1:0] image_out,
	output   [RAM_WIDTH_BIAS-1:0] biases_out,
	output reg  [RAM_WIDTH_IMG-1:0] kernel_all, 
	output reg 	[RAM_WIDTH_IMG-1:0] result_all,
	output reg						result_rdy_all,
	output reg 						result_vld_all							
    );

    //outputs for results
     reg signed 	[RAM_WIDTH_IMG-1:0] result0;
	 reg signed		[RAM_WIDTH_IMG-1:0] result1;
	 reg signed		[RAM_WIDTH_IMG-1:0] result2;
	 reg signed		[RAM_WIDTH_IMG-1:0] result3;
	 reg signed		[RAM_WIDTH_IMG-1:0] result4;
	 reg signed		[RAM_WIDTH_IMG-1:0] result5;
	 reg signed		[RAM_WIDTH_IMG-1:0] result6;
	 reg signed		[RAM_WIDTH_IMG-1:0] result7;
	 reg signed		[RAM_WIDTH_IMG-1:0] result8;
	 reg signed		[RAM_WIDTH_IMG-1:0] result9;
	 reg signed		[RAM_WIDTH_IMG-1:0] result10;
	 reg signed		[RAM_WIDTH_IMG-1:0] result11;
	 reg signed		[RAM_WIDTH_IMG-1:0] result12;
	 reg signed		[RAM_WIDTH_IMG-1:0] result13;
	 reg signed		[RAM_WIDTH_IMG-1:0] result14;
	 reg signed		[RAM_WIDTH_IMG-1:0] result15;
	 reg signed		[RAM_WIDTH_IMG-1:0] result16;
	 reg signed		[RAM_WIDTH_IMG-1:0] result17;
	 reg signed		[RAM_WIDTH_IMG-1:0] result18;
	 reg signed		[RAM_WIDTH_IMG-1:0] result19;
	 reg signed		[RAM_WIDTH_IMG-1:0] result20;
	 reg signed		[RAM_WIDTH_IMG-1:0] result21;
	 reg signed		[RAM_WIDTH_IMG-1:0] result22;
	 reg signed		[RAM_WIDTH_IMG-1:0] result23;
	 reg signed		[RAM_WIDTH_IMG-1:0] result24;
	 reg signed		[RAM_WIDTH_IMG-1:0] result25;
	 reg signed		[RAM_WIDTH_IMG-1:0] result26;
	 reg signed		[RAM_WIDTH_IMG-1:0] result27;
	 reg signed		[RAM_WIDTH_IMG-1:0] result28;
	 reg signed		[RAM_WIDTH_IMG-1:0] result29;
	 reg signed		[RAM_WIDTH_IMG-1:0] result30;
	 reg signed		[RAM_WIDTH_IMG-1:0] result31;
        
	reg 		        		   we_kernel0_mem ;
	reg 		        		   en_w_kernel0_mem ;
	reg 		        		   en_r_kernel0_mem ;
	reg 	   [6-1:0]	           addr_w_kernel0_mem;
	reg 	   [6-1:0]	           addr_r_kernel0_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel0_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel0_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel0_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel0_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel0_mem_w;
	always@(posedge clk) begin
		outp_kernel0_mem <= outp_kernel0_mem_w;
		dat_read_kernel0_mem <= dat_read_kernel0_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel0_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel0_mem),
			.en_w(en_w_kernel0_mem),
			.en_r(en_r_kernel0_mem),
			.addr_w(addr_w_kernel0_mem),
			.addr_r(addr_r_kernel0_mem),
			.di(inp_kernel0_mem),
			.dout(outp_kernel0_mem_w),
			.dat_read(dat_read_kernel0_mem_w)
	);

              
	reg 		        		   we_kernel1_mem ;
	reg 		        		   en_w_kernel1_mem ;
	reg 		        		   en_r_kernel1_mem ;
	reg 	   [6-1:0]	           addr_w_kernel1_mem;
	reg 	   [16-1:0]	           addr_r_kernel1_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel1_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel1_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel1_mem;

	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel1_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel1_mem_w;
	always@(posedge clk) begin
		outp_kernel1_mem <= outp_kernel1_mem_w;
		dat_read_kernel1_mem <= dat_read_kernel1_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel1_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel1_mem),
			.en_w(en_w_kernel1_mem),
			.en_r(en_r_kernel1_mem),
			.addr_w(addr_w_kernel1_mem),
			.addr_r(addr_r_kernel1_mem),
			.di(inp_kernel1_mem),
			.dout(outp_kernel1_mem_w),
			.dat_read(dat_read_kernel1_mem_w)
	);
              
	reg 		        		   we_kernel2_mem ;
	reg 		        		   en_w_kernel2_mem ;
	reg 		        		   en_r_kernel2_mem ;
	reg 	   [6-1:0]	           addr_w_kernel2_mem;
	reg 	   [16-1:0]	           addr_r_kernel2_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel2_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel2_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel2_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel2_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel2_mem_w;
	always@(posedge clk) begin
		outp_kernel2_mem <= outp_kernel2_mem_w;
		dat_read_kernel2_mem <= dat_read_kernel2_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel2_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel2_mem),
			.en_w(en_w_kernel2_mem),
			.en_r(en_r_kernel2_mem),
			.addr_w(addr_w_kernel2_mem),
			.addr_r(addr_r_kernel2_mem),
			.di(inp_kernel2_mem),
			.dout(outp_kernel2_mem_w),
			.dat_read(dat_read_kernel2_mem_w)
	);
 
	reg 		        		   we_kernel3_mem ;
	reg 		        		   en_w_kernel3_mem ;
	reg 		        		   en_r_kernel3_mem ;
	reg 	   [6-1:0]	           addr_w_kernel3_mem;
	reg 	   [16-1:0]	           addr_r_kernel3_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel3_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel3_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel3_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel3_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel3_mem_w;
	always@(posedge clk) begin
		outp_kernel3_mem <= outp_kernel3_mem_w;
		dat_read_kernel3_mem <= dat_read_kernel3_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel3_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel3_mem),
			.en_w(en_w_kernel3_mem),
			.en_r(en_r_kernel3_mem),
			.addr_w(addr_w_kernel3_mem),
			.addr_r(addr_r_kernel3_mem),
			.di(inp_kernel3_mem),
			.dout(outp_kernel3_mem_w),
			.dat_read(dat_read_kernel3_mem_w)
	);
              
	reg 		        		   we_kernel4_mem ;
	reg 		        		   en_w_kernel4_mem ;
	reg 		        		   en_r_kernel4_mem ;
	reg 	   [6-1:0]	           addr_w_kernel4_mem;
	reg 	   [16-1:0]	           addr_r_kernel4_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel4_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel4_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel4_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel4_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel4_mem_w;
	always@(posedge clk) begin
		outp_kernel4_mem <= outp_kernel4_mem_w;
		dat_read_kernel4_mem <= dat_read_kernel4_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel4_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel4_mem),
			.en_w(en_w_kernel4_mem),
			.en_r(en_r_kernel4_mem),
			.addr_w(addr_w_kernel4_mem),
			.addr_r(addr_r_kernel4_mem),
			.di(inp_kernel4_mem),
			.dout(outp_kernel4_mem_w),
			.dat_read(dat_read_kernel4_mem_w)
	);
              
	reg 		        		   we_kernel5_mem ;
	reg 		        		   en_w_kernel5_mem ;
	reg 		        		   en_r_kernel5_mem ;
	reg 	   [6-1:0]	           addr_w_kernel5_mem;
	reg 	   [16-1:0]	           addr_r_kernel5_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel5_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel5_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel5_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel5_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel5_mem_w;
	always@(posedge clk) begin
		outp_kernel5_mem <= outp_kernel5_mem_w;
		dat_read_kernel5_mem <= dat_read_kernel5_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel5_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel5_mem),
			.en_w(en_w_kernel5_mem),
			.en_r(en_r_kernel5_mem),
			.addr_w(addr_w_kernel5_mem),
			.addr_r(addr_r_kernel5_mem),
			.di(inp_kernel5_mem),
			.dout(outp_kernel5_mem_w),
			.dat_read(dat_read_kernel5_mem_w)
	);
              
	reg 		        		   we_kernel6_mem ;
	reg 		        		   en_w_kernel6_mem ;
	reg 		        		   en_r_kernel6_mem ;
	reg 	   [6-1:0]	           addr_w_kernel6_mem;
	reg 	   [16-1:0]	           addr_r_kernel6_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel6_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel6_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel6_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel6_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel6_mem_w;
	always@(posedge clk) begin
		outp_kernel6_mem <= outp_kernel6_mem_w;
		dat_read_kernel6_mem <= dat_read_kernel6_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel6_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel6_mem),
			.en_w(en_w_kernel6_mem),
			.en_r(en_r_kernel6_mem),
			.addr_w(addr_w_kernel6_mem),
			.addr_r(addr_r_kernel6_mem),
			.di(inp_kernel6_mem),
			.dout(outp_kernel6_mem_w),
			.dat_read(dat_read_kernel6_mem_w)
	);
              
	reg 		        		   we_kernel7_mem ;
	reg 		        		   en_w_kernel7_mem ;
	reg 		        		   en_r_kernel7_mem ;
	reg 	   [6-1:0]	           addr_w_kernel7_mem;
	reg 	   [16-1:0]	           addr_r_kernel7_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel7_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel7_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel7_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel7_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel7_mem_w;
	always@(posedge clk) begin
		outp_kernel7_mem <= outp_kernel7_mem_w;
		dat_read_kernel7_mem <= dat_read_kernel7_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel7_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel7_mem),
			.en_w(en_w_kernel7_mem),
			.en_r(en_r_kernel7_mem),
			.addr_w(addr_w_kernel7_mem),
			.addr_r(addr_r_kernel7_mem),
			.di(inp_kernel7_mem),
			.dout(outp_kernel7_mem_w),
			.dat_read(dat_read_kernel7_mem_w)
	);
              
	reg 		        		   we_kernel8_mem ;
	reg 		        		   en_w_kernel8_mem ;
	reg 		        		   en_r_kernel8_mem ;
	reg 	   [6-1:0]	           addr_w_kernel8_mem;
	reg 	   [16-1:0]	           addr_r_kernel8_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel8_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel8_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel8_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel8_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel8_mem_w;
	always@(posedge clk) begin
		outp_kernel8_mem <= outp_kernel8_mem_w;
		dat_read_kernel8_mem <= dat_read_kernel8_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel8_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel8_mem),
			.en_w(en_w_kernel8_mem),
			.en_r(en_r_kernel8_mem),
			.addr_w(addr_w_kernel8_mem),
			.addr_r(addr_r_kernel8_mem),
			.di(inp_kernel8_mem),
			.dout(outp_kernel8_mem_w),
			.dat_read(dat_read_kernel8_mem_w)
	);
              
	reg 		        		   we_kernel9_mem ;
	reg 		        		   en_w_kernel9_mem ;
	reg 		        		   en_r_kernel9_mem ;
	reg 	   [6-1:0]	           addr_w_kernel9_mem;
	reg 	   [16-1:0]	           addr_r_kernel9_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel9_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel9_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel9_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel9_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel9_mem_w;
	always@(posedge clk) begin
		outp_kernel9_mem <= outp_kernel9_mem_w;
		dat_read_kernel9_mem <= dat_read_kernel9_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel9_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel9_mem),
			.en_w(en_w_kernel9_mem),
			.en_r(en_r_kernel9_mem),
			.addr_w(addr_w_kernel9_mem),
			.addr_r(addr_r_kernel9_mem),
			.di(inp_kernel9_mem),
			.dout(outp_kernel9_mem_w),
			.dat_read(dat_read_kernel9_mem_w)
	);
              
	reg 		        		   we_kernel10_mem ;
	reg 		        		   en_w_kernel10_mem ;
	reg 		        		   en_r_kernel10_mem ;
	reg 	   [6-1:0]	           addr_w_kernel10_mem;
	reg 	   [16-1:0]	           addr_r_kernel10_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel10_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel10_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel10_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel10_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel10_mem_w;
	always@(posedge clk) begin
		outp_kernel10_mem <= outp_kernel10_mem_w;
		dat_read_kernel10_mem <= dat_read_kernel10_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel10_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel10_mem),
			.en_w(en_w_kernel10_mem),
			.en_r(en_r_kernel10_mem),
			.addr_w(addr_w_kernel10_mem),
			.addr_r(addr_r_kernel10_mem),
			.di(inp_kernel10_mem),
			.dout(outp_kernel10_mem_w),
			.dat_read(dat_read_kernel10_mem_w)
	);
              
	reg 		        		   we_kernel11_mem ;
	reg 		        		   en_w_kernel11_mem ;
	reg 		        		   en_r_kernel11_mem ;
	reg 	   [6-1:0]	           addr_w_kernel11_mem;
	reg 	   [16-1:0]	           addr_r_kernel11_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel11_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel11_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel11_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel11_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel11_mem_w;
	always@(posedge clk) begin
		outp_kernel11_mem <= outp_kernel11_mem_w;
		dat_read_kernel11_mem <= dat_read_kernel11_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel11_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel11_mem),
			.en_w(en_w_kernel11_mem),
			.en_r(en_r_kernel11_mem),
			.addr_w(addr_w_kernel11_mem),
			.addr_r(addr_r_kernel11_mem),
			.di(inp_kernel11_mem),
			.dout(outp_kernel11_mem_w),
			.dat_read(dat_read_kernel11_mem_w)
	);
              
	reg 		        		   we_kernel12_mem ;
	reg 		        		   en_w_kernel12_mem ;
	reg 		        		   en_r_kernel12_mem ;
	reg 	   [6-1:0]	           addr_w_kernel12_mem;
	reg 	   [16-1:0]	           addr_r_kernel12_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel12_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel12_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel12_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel12_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel12_mem_w;
	always@(posedge clk) begin
		outp_kernel12_mem <= outp_kernel12_mem_w;
		dat_read_kernel12_mem <= dat_read_kernel12_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel12_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel12_mem),
			.en_w(en_w_kernel12_mem),
			.en_r(en_r_kernel12_mem),
			.addr_w(addr_w_kernel12_mem),
			.addr_r(addr_r_kernel12_mem),
			.di(inp_kernel12_mem),
			.dout(outp_kernel12_mem_w),
			.dat_read(dat_read_kernel12_mem_w)
	);
              
	reg 		        		   we_kernel13_mem ;
	reg 		        		   en_w_kernel13_mem ;
	reg 		        		   en_r_kernel13_mem ;
	reg 	   [6-1:0]	           addr_w_kernel13_mem;
	reg 	   [16-1:0]	           addr_r_kernel13_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel13_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel13_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel13_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel13_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel13_mem_w;
	always@(posedge clk) begin
		outp_kernel13_mem <= outp_kernel13_mem_w;
		dat_read_kernel13_mem <= dat_read_kernel13_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel13_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel13_mem),
			.en_w(en_w_kernel13_mem),
			.en_r(en_r_kernel13_mem),
			.addr_w(addr_w_kernel13_mem),
			.addr_r(addr_r_kernel13_mem),
			.di(inp_kernel13_mem),
			.dout(outp_kernel13_mem_w),
			.dat_read(dat_read_kernel13_mem_w)
	);
              
	reg 		        		   we_kernel14_mem ;
	reg 		        		   en_w_kernel14_mem ;
	reg 		        		   en_r_kernel14_mem ;
	reg 	   [6-1:0]	           addr_w_kernel14_mem;
	reg 	   [16-1:0]	           addr_r_kernel14_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel14_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel14_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel14_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel14_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel14_mem_w;
	always@(posedge clk) begin
		outp_kernel14_mem <= outp_kernel14_mem_w;
		dat_read_kernel14_mem <= dat_read_kernel14_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel14_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel14_mem),
			.en_w(en_w_kernel14_mem),
			.en_r(en_r_kernel14_mem),
			.addr_w(addr_w_kernel14_mem),
			.addr_r(addr_r_kernel14_mem),
			.di(inp_kernel14_mem),
			.dout(outp_kernel14_mem_w),
			.dat_read(dat_read_kernel14_mem_w)
	);
              
	reg 		        		   we_kernel15_mem ;
	reg 		        		   en_w_kernel15_mem ;
	reg 		        		   en_r_kernel15_mem ;
	reg 	   [6-1:0]	           addr_w_kernel15_mem;
	reg 	   [16-1:0]	           addr_r_kernel15_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel15_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel15_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel15_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel15_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel15_mem_w;
	always@(posedge clk) begin
		outp_kernel15_mem <= outp_kernel15_mem_w;
		dat_read_kernel15_mem <= dat_read_kernel15_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel15_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel15_mem),
			.en_w(en_w_kernel15_mem),
			.en_r(en_r_kernel15_mem),
			.addr_w(addr_w_kernel15_mem),
			.addr_r(addr_r_kernel15_mem),
			.di(inp_kernel15_mem),
			.dout(outp_kernel15_mem_w),
			.dat_read(dat_read_kernel15_mem_w)
	);
              
	reg 		        		   we_kernel16_mem ;
	reg 		        		   en_w_kernel16_mem ;
	reg 		        		   en_r_kernel16_mem ;
	reg 	   [6-1:0]	           addr_w_kernel16_mem;
	reg 	   [16-1:0]	           addr_r_kernel16_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel16_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel16_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel16_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel16_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel16_mem_w;
	always@(posedge clk) begin
		outp_kernel16_mem <= outp_kernel16_mem_w;
		dat_read_kernel16_mem <= dat_read_kernel16_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel16_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel16_mem),
			.en_w(en_w_kernel16_mem),
			.en_r(en_r_kernel16_mem),
			.addr_w(addr_w_kernel16_mem),
			.addr_r(addr_r_kernel16_mem),
			.di(inp_kernel16_mem),
			.dout(outp_kernel16_mem_w),
			.dat_read(dat_read_kernel16_mem_w)
	);
              
	reg 		        		   we_kernel17_mem ;
	reg 		        		   en_w_kernel17_mem ;
	reg 		        		   en_r_kernel17_mem ;
	reg 	   [6-1:0]	           addr_w_kernel17_mem;
	reg 	   [16-1:0]	           addr_r_kernel17_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel17_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel17_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel17_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel17_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel17_mem_w;
	always@(posedge clk) begin
		outp_kernel17_mem <= outp_kernel17_mem_w;
		dat_read_kernel17_mem <= dat_read_kernel17_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel17_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel17_mem),
			.en_w(en_w_kernel17_mem),
			.en_r(en_r_kernel17_mem),
			.addr_w(addr_w_kernel17_mem),
			.addr_r(addr_r_kernel17_mem),
			.di(inp_kernel17_mem),
			.dout(outp_kernel17_mem_w),
			.dat_read(dat_read_kernel17_mem_w)
	);
              
	reg 		        		   we_kernel18_mem ;
	reg 		        		   en_w_kernel18_mem ;
	reg 		        		   en_r_kernel18_mem ;
	reg 	   [6-1:0]	           addr_w_kernel18_mem;
	reg 	   [16-1:0]	           addr_r_kernel18_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel18_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel18_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel18_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel18_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel18_mem_w;
	always@(posedge clk) begin
		outp_kernel18_mem <= outp_kernel18_mem_w;
		dat_read_kernel18_mem <= dat_read_kernel18_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel18_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel18_mem),
			.en_w(en_w_kernel18_mem),
			.en_r(en_r_kernel18_mem),
			.addr_w(addr_w_kernel18_mem),
			.addr_r(addr_r_kernel18_mem),
			.di(inp_kernel18_mem),
			.dout(outp_kernel18_mem_w),
			.dat_read(dat_read_kernel18_mem_w)
	);
              
	reg 		        		   we_kernel19_mem ;
	reg 		        		   en_w_kernel19_mem ;
	reg 		        		   en_r_kernel19_mem ;
	reg 	   [6-1:0]	           addr_w_kernel19_mem;
	reg 	   [16-1:0]	           addr_r_kernel19_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel19_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel19_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel19_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel19_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel19_mem_w;
	always@(posedge clk) begin
		outp_kernel19_mem <= outp_kernel19_mem_w;
		dat_read_kernel19_mem <= dat_read_kernel19_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel19_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel19_mem),
			.en_w(en_w_kernel19_mem),
			.en_r(en_r_kernel19_mem),
			.addr_w(addr_w_kernel19_mem),
			.addr_r(addr_r_kernel19_mem),
			.di(inp_kernel19_mem),
			.dout(outp_kernel19_mem_w),
			.dat_read(dat_read_kernel19_mem_w)
	);
              
	reg 		        		   we_kernel20_mem ;
	reg 		        		   en_w_kernel20_mem ;
	reg 		        		   en_r_kernel20_mem ;
	reg 	   [6-1:0]	           addr_w_kernel20_mem;
	reg 	   [16-1:0]	           addr_r_kernel20_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel20_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel20_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel20_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel20_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel20_mem_w;
	always@(posedge clk) begin
		outp_kernel20_mem <= outp_kernel20_mem_w;
		dat_read_kernel20_mem <= dat_read_kernel20_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel20_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel20_mem),
			.en_w(en_w_kernel20_mem),
			.en_r(en_r_kernel20_mem),
			.addr_w(addr_w_kernel20_mem),
			.addr_r(addr_r_kernel20_mem),
			.di(inp_kernel20_mem),
			.dout(outp_kernel20_mem_w),
			.dat_read(dat_read_kernel20_mem_w)
	);
              
	reg 		        		   we_kernel21_mem ;
	reg 		        		   en_w_kernel21_mem ;
	reg 		        		   en_r_kernel21_mem ;
	reg 	   [6-1:0]	           addr_w_kernel21_mem;
	reg 	   [16-1:0]	           addr_r_kernel21_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel21_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel21_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel21_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel21_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel21_mem_w;
	always@(posedge clk) begin
		outp_kernel21_mem <= outp_kernel21_mem_w;
		dat_read_kernel21_mem <= dat_read_kernel21_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel21_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel21_mem),
			.en_w(en_w_kernel21_mem),
			.en_r(en_r_kernel21_mem),
			.addr_w(addr_w_kernel21_mem),
			.addr_r(addr_r_kernel21_mem),
			.di(inp_kernel21_mem),
			.dout(outp_kernel21_mem_w),
			.dat_read(dat_read_kernel21_mem_w)
	);
              
	reg 		        		   we_kernel22_mem ;
	reg 		        		   en_w_kernel22_mem ;
	reg 		        		   en_r_kernel22_mem ;
	reg 	   [6-1:0]	           addr_w_kernel22_mem;
	reg 	   [16-1:0]	           addr_r_kernel22_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel22_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel22_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel22_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel22_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel22_mem_w;
	always@(posedge clk) begin
		outp_kernel22_mem <= outp_kernel22_mem_w;
		dat_read_kernel22_mem <= dat_read_kernel22_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel22_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel22_mem),
			.en_w(en_w_kernel22_mem),
			.en_r(en_r_kernel22_mem),
			.addr_w(addr_w_kernel22_mem),
			.addr_r(addr_r_kernel22_mem),
			.di(inp_kernel22_mem),
			.dout(outp_kernel22_mem_w),
			.dat_read(dat_read_kernel22_mem_w)
	);
              
	reg 		        		   we_kernel23_mem ;
	reg 		        		   en_w_kernel23_mem ;
	reg 		        		   en_r_kernel23_mem ;
	reg 	   [6-1:0]	           addr_w_kernel23_mem;
	reg 	   [16-1:0]	           addr_r_kernel23_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel23_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel23_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel23_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel23_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel23_mem_w;
	always@(posedge clk) begin
		outp_kernel23_mem <= outp_kernel23_mem_w;
		dat_read_kernel23_mem <= dat_read_kernel23_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel23_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel23_mem),
			.en_w(en_w_kernel23_mem),
			.en_r(en_r_kernel23_mem),
			.addr_w(addr_w_kernel23_mem),
			.addr_r(addr_r_kernel23_mem),
			.di(inp_kernel23_mem),
			.dout(outp_kernel23_mem_w),
			.dat_read(dat_read_kernel23_mem_w)
	);
              
	reg 		        		   we_kernel24_mem ;
	reg 		        		   en_w_kernel24_mem ;
	reg 		        		   en_r_kernel24_mem ;
	reg 	   [6-1:0]	           addr_w_kernel24_mem;
	reg 	   [16-1:0]	           addr_r_kernel24_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel24_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel24_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel24_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel24_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel24_mem_w;
	always@(posedge clk) begin
		outp_kernel24_mem <= outp_kernel24_mem_w;
		dat_read_kernel24_mem <= dat_read_kernel24_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel24_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel24_mem),
			.en_w(en_w_kernel24_mem),
			.en_r(en_r_kernel24_mem),
			.addr_w(addr_w_kernel24_mem),
			.addr_r(addr_r_kernel24_mem),
			.di(inp_kernel24_mem),
			.dout(outp_kernel24_mem_w),
			.dat_read(dat_read_kernel24_mem_w)
	);
              
	reg 		        		   we_kernel25_mem ;
	reg 		        		   en_w_kernel25_mem ;
	reg 		        		   en_r_kernel25_mem ;
	reg 	   [6-1:0]	           addr_w_kernel25_mem;
	reg 	   [16-1:0]	           addr_r_kernel25_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel25_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel25_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel25_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel25_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel25_mem_w;
	always@(posedge clk) begin
		outp_kernel25_mem <= outp_kernel25_mem_w;
		dat_read_kernel25_mem <= dat_read_kernel25_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel25_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel25_mem),
			.en_w(en_w_kernel25_mem),
			.en_r(en_r_kernel25_mem),
			.addr_w(addr_w_kernel25_mem),
			.addr_r(addr_r_kernel25_mem),
			.di(inp_kernel25_mem),
			.dout(outp_kernel25_mem_w),
			.dat_read(dat_read_kernel25_mem_w)
	);
              
	reg 		        		   we_kernel26_mem ;
	reg 		        		   en_w_kernel26_mem ;
	reg 		        		   en_r_kernel26_mem ;
	reg 	   [6-1:0]	           addr_w_kernel26_mem;
	reg 	   [16-1:0]	           addr_r_kernel26_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel26_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel26_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel26_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel26_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel26_mem_w;
	always@(posedge clk) begin
		outp_kernel26_mem <= outp_kernel26_mem_w;
		dat_read_kernel26_mem <= dat_read_kernel26_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel26_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel26_mem),
			.en_w(en_w_kernel26_mem),
			.en_r(en_r_kernel26_mem),
			.addr_w(addr_w_kernel26_mem),
			.addr_r(addr_r_kernel26_mem),
			.di(inp_kernel26_mem),
			.dout(outp_kernel26_mem_w),
			.dat_read(dat_read_kernel26_mem_w)
	);
              
	reg 		        		   we_kernel27_mem ;
	reg 		        		   en_w_kernel27_mem ;
	reg 		        		   en_r_kernel27_mem ;
	reg 	   [6-1:0]	           addr_w_kernel27_mem;
	reg 	   [16-1:0]	           addr_r_kernel27_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel27_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel27_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel27_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel27_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel27_mem_w;
	always@(posedge clk) begin
		outp_kernel27_mem <= outp_kernel27_mem_w;
		dat_read_kernel27_mem <= dat_read_kernel27_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel27_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel27_mem),
			.en_w(en_w_kernel27_mem),
			.en_r(en_r_kernel27_mem),
			.addr_w(addr_w_kernel27_mem),
			.addr_r(addr_r_kernel27_mem),
			.di(inp_kernel27_mem),
			.dout(outp_kernel27_mem_w),
			.dat_read(dat_read_kernel27_mem_w)
	);
              
	reg 		        		   we_kernel28_mem ;
	reg 		        		   en_w_kernel28_mem ;
	reg 		        		   en_r_kernel28_mem ;
	reg 	   [6-1:0]	           addr_w_kernel28_mem;
	reg 	   [16-1:0]	           addr_r_kernel28_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel28_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel28_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel28_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel28_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel28_mem_w;
	always@(posedge clk) begin
		outp_kernel28_mem <= outp_kernel28_mem_w;
		dat_read_kernel28_mem <= dat_read_kernel28_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel28_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel28_mem),
			.en_w(en_w_kernel28_mem),
			.en_r(en_r_kernel28_mem),
			.addr_w(addr_w_kernel28_mem),
			.addr_r(addr_r_kernel28_mem),
			.di(inp_kernel28_mem),
			.dout(outp_kernel28_mem_w),
			.dat_read(dat_read_kernel28_mem_w)
	);
              
	reg 		        		   we_kernel29_mem ;
	reg 		        		   en_w_kernel29_mem ;
	reg 		        		   en_r_kernel29_mem ;
	reg 	   [6-1:0]	           addr_w_kernel29_mem;
	reg 	   [16-1:0]	           addr_r_kernel29_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel29_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel29_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel29_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel29_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel29_mem_w;
	always@(posedge clk) begin
		outp_kernel29_mem <= outp_kernel29_mem_w;
		dat_read_kernel29_mem <= dat_read_kernel29_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel29_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel29_mem),
			.en_w(en_w_kernel29_mem),
			.en_r(en_r_kernel29_mem),
			.addr_w(addr_w_kernel29_mem),
			.addr_r(addr_r_kernel29_mem),
			.di(inp_kernel29_mem),
			.dout(outp_kernel29_mem_w),
			.dat_read(dat_read_kernel29_mem_w)
	);
              
	reg 		        		   we_kernel30_mem ;
	reg 		        		   en_w_kernel30_mem ;
	reg 		        		   en_r_kernel30_mem ;
	reg 	   [6-1:0]	           addr_w_kernel30_mem;
	reg 	   [16-1:0]	           addr_r_kernel30_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel30_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel30_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel30_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel30_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel30_mem_w;
	always@(posedge clk) begin
		outp_kernel30_mem <= outp_kernel30_mem_w;
		dat_read_kernel30_mem <= dat_read_kernel30_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel30_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel30_mem),
			.en_w(en_w_kernel30_mem),
			.en_r(en_r_kernel30_mem),
			.addr_w(addr_w_kernel30_mem),
			.addr_r(addr_r_kernel30_mem),
			.di(inp_kernel30_mem),
			.dout(outp_kernel30_mem_w),
			.dat_read(dat_read_kernel30_mem_w)
	);
              
	reg 		        		   we_kernel31_mem ;
	reg 		        		   en_w_kernel31_mem ;
	reg 		        		   en_r_kernel31_mem ;
	reg 	   [6-1:0]	           addr_w_kernel31_mem;
	reg 	   [16-1:0]	           addr_r_kernel31_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_kernel31_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_kernel31_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_kernel31_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_kernel31_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_kernel31_mem_w;
	always@(posedge clk) begin
		outp_kernel31_mem <= outp_kernel31_mem_w;
		dat_read_kernel31_mem <= dat_read_kernel31_mem_w; 
	end
	oneDRAM #(.A_WIDTH(5),
			  .ADDR_WIDTH(6), 
			  .D_WIDTH(RAM_WIDTH_KER)
	)kernel31_mem(.clk(clk),
			.reset(reset),
			.we(we_kernel31_mem),
			.en_w(en_w_kernel31_mem),
			.en_r(en_r_kernel31_mem),
			.addr_w(addr_w_kernel31_mem),
			.addr_r(addr_r_kernel31_mem),
			.di(inp_kernel31_mem),
			.dout(outp_kernel31_mem_w),
			.dat_read(dat_read_kernel31_mem_w)
	);
   /**/
    reg								kernel_recieved[31:0];
    reg 		[5:0]				kernel_vals_cnt[31:0];
   //--------------------------------------------------------------------------------------------------------------------------------------------------
   
 	reg 		[100:0]				image_vals_cnt;
    reg 							image_recieved;
    
    reg 		        		   we_img_mem ;
	reg 		        		   en_w_img_mem ;
	reg 		        		   en_r_img_mem ;
	reg 	   [16-1:0]		       addr_w_img_mem;
	reg 	   [16-1:0]		       addr_r_img_mem;
	reg signed [RAM_WIDTH_IMG-1:0] inp_img_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_img_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_img_mem;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_img_mem_w;
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_img_mem_w; 
	always@(posedge clk) begin
		outp_img_mem <= outp_img_mem_w;
		dat_read_img_mem <= dat_read_img_mem_w;
	end
	
	oneDRAM #(.A_WIDTH(16),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)img_mem(.clk(clk),
			  .reset(reset),
			  .we(we_img_mem),
			  .en_w(en_w_img_mem),
			  .en_r(en_r_img_mem),
			  .addr_w(addr_w_img_mem),
			  .addr_r(addr_r_img_mem),
			  .di(inp_img_mem),
			  .dout(outp_img_mem_w),
			  .dat_read(dat_read_img_mem_w)
	);
   

    //--------------------------------------------------------------------------------------------------------------------------------------------------
    reg 							biases_recieved;
    
    reg 		        		   we_biases_mem ;
	reg 		        		   en_w_biases_mem ;
	reg 		        		   en_r_biases_mem ;
	reg 	   [6-1:0]	           addr_w_biases_mem;
	reg 	   [6-1:0]	           addr_r_biases_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_biases_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_biases_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_biases_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_biases_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_biases_mem_w;
	always@(posedge clk) begin
		outp_biases_mem <= outp_biases_mem_w;
		dat_read_biases_mem <= dat_read_biases_mem_w; 
	end
	oneDRAM #(.A_WIDTH(6),
			  .ADDR_WIDTH(7), 
			  .D_WIDTH(RAM_WIDTH_BIAS)
	)biases_mem(.clk(clk),
			.reset(reset),
			.we(we_biases_mem),
			.en_w(en_w_biases_mem),
			.en_r(en_r_biases_mem),
			.addr_w(addr_w_biases_mem),
			.addr_r(addr_r_biases_mem),
			.di(inp_biases_mem),
			.dout(outp_biases_mem_w),
			.dat_read(dat_read_biases_mem_w)
	);

    reg			[6:0]				C1_var;
    reg			[8:0]				M2_var;
    reg			[8:0]				N2_var;
    reg								image_deflattened;
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
	wire signed [RAM_WIDTH_IMG-1:0] mult_temp_w_conc[31:0];
    wire signed	[RAM_WIDTH_IMG-1:0] res_temp_w_conc[31:0];
        
    reg 		        		   we_result0_mem ;
	reg 		        		   en_w_result0_mem ;
	reg 		        		   en_r_result0_mem ;
	reg 	   [16-1:0]	           addr_w_result0_mem;
	reg 	   [16-1:0]	           addr_r_result0_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result0_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result0_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result0_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result0_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result0_mem_w;
	always@(posedge clk) begin
		outp_result0_mem <= outp_result0_mem_w;
		dat_read_result0_mem <= dat_read_result0_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result0_mem(.clk(clk),
			.reset(reset),
			.we(we_result0_mem),
			.en_w(en_w_result0_mem),
			.en_r(en_r_result0_mem),
			.addr_w(addr_w_result0_mem),
			.addr_r(addr_r_result0_mem),
			.di(inp_result0_mem),
			.dout(outp_result0_mem_w),
			.dat_read(dat_read_result0_mem_w)
	);
     
    reg 		        		   we_result1_mem ;
	reg 		        		   en_w_result1_mem ;
	reg 		        		   en_r_result1_mem ;
	reg 	   [15-1:0]	           addr_w_result1_mem;
	reg 	   [16-1:0]	           addr_r_result1_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result1_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result1_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result1_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result1_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result1_mem_w;
	always@(posedge clk) begin
		outp_result1_mem <= outp_result1_mem_w;
		dat_read_result1_mem <= dat_read_result1_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result1_mem(.clk(clk),
			.reset(reset),
			.we(we_result1_mem),
			.en_w(en_w_result1_mem),
			.en_r(en_r_result1_mem),
			.addr_w(addr_w_result1_mem),
			.addr_r(addr_r_result1_mem),
			.di(inp_result1_mem),
			.dout(outp_result1_mem_w),
			.dat_read(dat_read_result1_mem_w)
	);
        
    reg 		        		   we_result2_mem ;
	reg 		        		   en_w_result2_mem ;
	reg 		        		   en_r_result2_mem ;
	reg 	   [15-1:0]	           addr_w_result2_mem;
	reg 	   [16-1:0]	           addr_r_result2_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result2_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result2_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result2_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result2_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result2_mem_w;
	always@(posedge clk) begin
		outp_result2_mem <= outp_result2_mem_w;
		dat_read_result2_mem <= dat_read_result2_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result2_mem(.clk(clk),
			.reset(reset),
			.we(we_result2_mem),
			.en_w(en_w_result2_mem),
			.en_r(en_r_result2_mem),
			.addr_w(addr_w_result2_mem),
			.addr_r(addr_r_result2_mem),
			.di(inp_result2_mem),
			.dout(outp_result2_mem_w),
			.dat_read(dat_read_result2_mem_w)
	);
        
    reg 		        		   we_result3_mem ;
	reg 		        		   en_w_result3_mem ;
	reg 		        		   en_r_result3_mem ;
	reg 	   [15-1:0]	           addr_w_result3_mem;
	reg 	   [16-1:0]	           addr_r_result3_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result3_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result3_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result3_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result3_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result3_mem_w;
	always@(posedge clk) begin
		outp_result3_mem <= outp_result3_mem_w;
		dat_read_result3_mem <= dat_read_result3_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result3_mem(.clk(clk),
			.reset(reset),
			.we(we_result3_mem),
			.en_w(en_w_result3_mem),
			.en_r(en_r_result3_mem),
			.addr_w(addr_w_result3_mem),
			.addr_r(addr_r_result3_mem),
			.di(inp_result3_mem),
			.dout(outp_result3_mem_w),
			.dat_read(dat_read_result3_mem_w)
	);
        
    reg 		        		   we_result4_mem ;
	reg 		        		   en_w_result4_mem ;
	reg 		        		   en_r_result4_mem ;
	reg 	   [15-1:0]	           addr_w_result4_mem;
	reg 	   [16-1:0]	           addr_r_result4_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result4_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result4_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result4_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result4_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result4_mem_w;
	always@(posedge clk) begin
		outp_result4_mem <= outp_result4_mem_w;
		dat_read_result4_mem <= dat_read_result4_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result4_mem(.clk(clk),
			.reset(reset),
			.we(we_result4_mem),
			.en_w(en_w_result4_mem),
			.en_r(en_r_result4_mem),
			.addr_w(addr_w_result4_mem),
			.addr_r(addr_r_result4_mem),
			.di(inp_result4_mem),
			.dout(outp_result4_mem_w),
			.dat_read(dat_read_result4_mem_w)
	);
        
    reg 		        		   we_result5_mem ;
	reg 		        		   en_w_result5_mem ;
	reg 		        		   en_r_result5_mem ;
	reg 	   [15-1:0]	           addr_w_result5_mem;
	reg 	   [16-1:0]	           addr_r_result5_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result5_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result5_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result5_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result5_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result5_mem_w;
	always@(posedge clk) begin
		outp_result5_mem <= outp_result5_mem_w;
		dat_read_result5_mem <= dat_read_result5_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result5_mem(.clk(clk),
			.reset(reset),
			.we(we_result5_mem),
			.en_w(en_w_result5_mem),
			.en_r(en_r_result5_mem),
			.addr_w(addr_w_result5_mem),
			.addr_r(addr_r_result5_mem),
			.di(inp_result5_mem),
			.dout(outp_result5_mem_w),
			.dat_read(dat_read_result5_mem_w)
	);
        
    reg 		        		   we_result6_mem ;
	reg 		        		   en_w_result6_mem ;
	reg 		        		   en_r_result6_mem ;
	reg 	   [15-1:0]	           addr_w_result6_mem;
	reg 	   [16-1:0]	           addr_r_result6_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result6_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result6_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result6_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result6_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result6_mem_w;
	always@(posedge clk) begin
		outp_result6_mem <= outp_result6_mem_w;
		dat_read_result6_mem <= dat_read_result6_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result6_mem(.clk(clk),
			.reset(reset),
			.we(we_result6_mem),
			.en_w(en_w_result6_mem),
			.en_r(en_r_result6_mem),
			.addr_w(addr_w_result6_mem),
			.addr_r(addr_r_result6_mem),
			.di(inp_result6_mem),
			.dout(outp_result6_mem_w),
			.dat_read(dat_read_result6_mem_w)
	);
        
    reg 		        		   we_result7_mem ;
	reg 		        		   en_w_result7_mem ;
	reg 		        		   en_r_result7_mem ;
	reg 	   [15-1:0]	           addr_w_result7_mem;
	reg 	   [16-1:0]	           addr_r_result7_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result7_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result7_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result7_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result7_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result7_mem_w;
	always@(posedge clk) begin
		outp_result7_mem <= outp_result7_mem_w;
		dat_read_result7_mem <= dat_read_result7_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result7_mem(.clk(clk),
			.reset(reset),
			.we(we_result7_mem),
			.en_w(en_w_result7_mem),
			.en_r(en_r_result7_mem),
			.addr_w(addr_w_result7_mem),
			.addr_r(addr_r_result7_mem),
			.di(inp_result7_mem),
			.dout(outp_result7_mem_w),
			.dat_read(dat_read_result7_mem_w)
	);
        
    reg 		        		   we_result8_mem ;
	reg 		        		   en_w_result8_mem ;
	reg 		        		   en_r_result8_mem ;
	reg 	   [15-1:0]	           addr_w_result8_mem;
	reg 	   [16-1:0]	           addr_r_result8_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result8_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result8_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result8_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result8_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result8_mem_w;
	always@(posedge clk) begin
		outp_result8_mem <= outp_result8_mem_w;
		dat_read_result8_mem <= dat_read_result8_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result8_mem(.clk(clk),
			.reset(reset),
			.we(we_result8_mem),
			.en_w(en_w_result8_mem),
			.en_r(en_r_result8_mem),
			.addr_w(addr_w_result8_mem),
			.addr_r(addr_r_result8_mem),
			.di(inp_result8_mem),
			.dout(outp_result8_mem_w),
			.dat_read(dat_read_result8_mem_w)
	);
        
    reg 		        		   we_result9_mem ;
	reg 		        		   en_w_result9_mem ;
	reg 		        		   en_r_result9_mem ;
	reg 	   [15-1:0]	           addr_w_result9_mem;
	reg 	   [16-1:0]	           addr_r_result9_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result9_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result9_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result9_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result9_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result9_mem_w;
	always@(posedge clk) begin
		outp_result9_mem <= outp_result9_mem_w;
		dat_read_result9_mem <= dat_read_result9_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result9_mem(.clk(clk),
			.reset(reset),
			.we(we_result9_mem),
			.en_w(en_w_result9_mem),
			.en_r(en_r_result9_mem),
			.addr_w(addr_w_result9_mem),
			.addr_r(addr_r_result9_mem),
			.di(inp_result9_mem),
			.dout(outp_result9_mem_w),
			.dat_read(dat_read_result9_mem_w)
	);
        
    reg 		        		   we_result10_mem ;
	reg 		        		   en_w_result10_mem ;
	reg 		        		   en_r_result10_mem ;
	reg 	   [15-1:0]	           addr_w_result10_mem;
	reg 	   [16-1:0]	           addr_r_result10_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result10_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result10_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result10_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result10_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result10_mem_w;
	always@(posedge clk) begin
		outp_result10_mem <= outp_result10_mem_w;
		dat_read_result10_mem <= dat_read_result10_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result10_mem(.clk(clk),
			.reset(reset),
			.we(we_result10_mem),
			.en_w(en_w_result10_mem),
			.en_r(en_r_result10_mem),
			.addr_w(addr_w_result10_mem),
			.addr_r(addr_r_result10_mem),
			.di(inp_result10_mem),
			.dout(outp_result10_mem_w),
			.dat_read(dat_read_result10_mem_w)
	);
        
    reg 		        		   we_result11_mem ;
	reg 		        		   en_w_result11_mem ;
	reg 		        		   en_r_result11_mem ;
	reg 	   [15-1:0]	           addr_w_result11_mem;
	reg 	   [16-1:0]	           addr_r_result11_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result11_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result11_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result11_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result11_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result11_mem_w;
	always@(posedge clk) begin
		outp_result11_mem <= outp_result11_mem_w;
		dat_read_result11_mem <= dat_read_result11_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result11_mem(.clk(clk),
			.reset(reset),
			.we(we_result11_mem),
			.en_w(en_w_result11_mem),
			.en_r(en_r_result11_mem),
			.addr_w(addr_w_result11_mem),
			.addr_r(addr_r_result11_mem),
			.di(inp_result11_mem),
			.dout(outp_result11_mem_w),
			.dat_read(dat_read_result11_mem_w)
	);
        
    reg 		        		   we_result12_mem ;
	reg 		        		   en_w_result12_mem ;
	reg 		        		   en_r_result12_mem ;
	reg 	   [15-1:0]	           addr_w_result12_mem;
	reg 	   [16-1:0]	           addr_r_result12_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result12_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result12_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result12_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result12_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result12_mem_w;
	always@(posedge clk) begin
		outp_result12_mem <= outp_result12_mem_w;
		dat_read_result12_mem <= dat_read_result12_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result12_mem(.clk(clk),
			.reset(reset),
			.we(we_result12_mem),
			.en_w(en_w_result12_mem),
			.en_r(en_r_result12_mem),
			.addr_w(addr_w_result12_mem),
			.addr_r(addr_r_result12_mem),
			.di(inp_result12_mem),
			.dout(outp_result12_mem_w),
			.dat_read(dat_read_result12_mem_w)
	);
        
    reg 		        		   we_result13_mem ;
	reg 		        		   en_w_result13_mem ;
	reg 		        		   en_r_result13_mem ;
	reg 	   [15-1:0]	           addr_w_result13_mem;
	reg 	   [16-1:0]	           addr_r_result13_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result13_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result13_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result13_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result13_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result13_mem_w;
	always@(posedge clk) begin
		outp_result13_mem <= outp_result13_mem_w;
		dat_read_result13_mem <= dat_read_result13_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result13_mem(.clk(clk),
			.reset(reset),
			.we(we_result13_mem),
			.en_w(en_w_result13_mem),
			.en_r(en_r_result13_mem),
			.addr_w(addr_w_result13_mem),
			.addr_r(addr_r_result13_mem),
			.di(inp_result13_mem),
			.dout(outp_result13_mem_w),
			.dat_read(dat_read_result13_mem_w)
	);
        
    reg 		        		   we_result14_mem ;
	reg 		        		   en_w_result14_mem ;
	reg 		        		   en_r_result14_mem ;
	reg 	   [15-1:0]	           addr_w_result14_mem;
	reg 	   [16-1:0]	           addr_r_result14_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result14_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result14_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result14_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result14_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result14_mem_w;
	always@(posedge clk) begin
		outp_result14_mem <= outp_result14_mem_w;
		dat_read_result14_mem <= dat_read_result14_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result14_mem(.clk(clk),
			.reset(reset),
			.we(we_result14_mem),
			.en_w(en_w_result14_mem),
			.en_r(en_r_result14_mem),
			.addr_w(addr_w_result14_mem),
			.addr_r(addr_r_result14_mem),
			.di(inp_result14_mem),
			.dout(outp_result14_mem_w),
			.dat_read(dat_read_result14_mem_w)
	);
        
    reg 		        		   we_result15_mem ;
	reg 		        		   en_w_result15_mem ;
	reg 		        		   en_r_result15_mem ;
	reg 	   [15-1:0]	           addr_w_result15_mem;
	reg 	   [16-1:0]	           addr_r_result15_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result15_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result15_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result15_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result15_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result15_mem_w;
	always@(posedge clk) begin
		outp_result15_mem <= outp_result15_mem_w;
		dat_read_result15_mem <= dat_read_result15_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result15_mem(.clk(clk),
			.reset(reset),
			.we(we_result15_mem),
			.en_w(en_w_result15_mem),
			.en_r(en_r_result15_mem),
			.addr_w(addr_w_result15_mem),
			.addr_r(addr_r_result15_mem),
			.di(inp_result15_mem),
			.dout(outp_result15_mem_w),
			.dat_read(dat_read_result15_mem_w)
	);
        
    reg 		        		   we_result16_mem ;
	reg 		        		   en_w_result16_mem ;
	reg 		        		   en_r_result16_mem ;
	reg 	   [15-1:0]	           addr_w_result16_mem;
	reg 	   [16-1:0]	           addr_r_result16_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result16_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result16_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result16_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result16_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result16_mem_w;
	always@(posedge clk) begin
		outp_result16_mem <= outp_result16_mem_w;
		dat_read_result16_mem <= dat_read_result16_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result16_mem(.clk(clk),
			.reset(reset),
			.we(we_result16_mem),
			.en_w(en_w_result16_mem),
			.en_r(en_r_result16_mem),
			.addr_w(addr_w_result16_mem),
			.addr_r(addr_r_result16_mem),
			.di(inp_result16_mem),
			.dout(outp_result16_mem_w),
			.dat_read(dat_read_result16_mem_w)
	);
        
    reg 		        		   we_result17_mem ;
	reg 		        		   en_w_result17_mem ;
	reg 		        		   en_r_result17_mem ;
	reg 	   [15-1:0]	           addr_w_result17_mem;
	reg 	   [16-1:0]	           addr_r_result17_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result17_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result17_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result17_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result17_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result17_mem_w;
	always@(posedge clk) begin
		outp_result17_mem <= outp_result17_mem_w;
		dat_read_result17_mem <= dat_read_result17_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result17_mem(.clk(clk),
			.reset(reset),
			.we(we_result17_mem),
			.en_w(en_w_result17_mem),
			.en_r(en_r_result17_mem),
			.addr_w(addr_w_result17_mem),
			.addr_r(addr_r_result17_mem),
			.di(inp_result17_mem),
			.dout(outp_result17_mem_w),
			.dat_read(dat_read_result17_mem_w)
	);
        
    reg 		        		   we_result18_mem ;
	reg 		        		   en_w_result18_mem ;
	reg 		        		   en_r_result18_mem ;
	reg 	   [15-1:0]	           addr_w_result18_mem;
	reg 	   [16-1:0]	           addr_r_result18_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result18_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result18_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result18_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result18_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result18_mem_w;
	always@(posedge clk) begin
		outp_result18_mem <= outp_result18_mem_w;
		dat_read_result18_mem <= dat_read_result18_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result18_mem(.clk(clk),
			.reset(reset),
			.we(we_result18_mem),
			.en_w(en_w_result18_mem),
			.en_r(en_r_result18_mem),
			.addr_w(addr_w_result18_mem),
			.addr_r(addr_r_result18_mem),
			.di(inp_result18_mem),
			.dout(outp_result18_mem_w),
			.dat_read(dat_read_result18_mem_w)
	);
        
    reg 		        		   we_result19_mem ;
	reg 		        		   en_w_result19_mem ;
	reg 		        		   en_r_result19_mem ;
	reg 	   [15-1:0]	           addr_w_result19_mem;
	reg 	   [16-1:0]	           addr_r_result19_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result19_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result19_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result19_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result19_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result19_mem_w;
	always@(posedge clk) begin
		outp_result19_mem <= outp_result19_mem_w;
		dat_read_result19_mem <= dat_read_result19_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result19_mem(.clk(clk),
			.reset(reset),
			.we(we_result19_mem),
			.en_w(en_w_result19_mem),
			.en_r(en_r_result19_mem),
			.addr_w(addr_w_result19_mem),
			.addr_r(addr_r_result19_mem),
			.di(inp_result19_mem),
			.dout(outp_result19_mem_w),
			.dat_read(dat_read_result19_mem_w)
	);
        
    reg 		        		   we_result20_mem ;
	reg 		        		   en_w_result20_mem ;
	reg 		        		   en_r_result20_mem ;
	reg 	   [15-1:0]	           addr_w_result20_mem;
	reg 	   [16-1:0]	           addr_r_result20_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result20_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result20_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result20_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result20_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result20_mem_w;
	always@(posedge clk) begin
		outp_result20_mem <= outp_result20_mem_w;
		dat_read_result20_mem <= dat_read_result20_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result20_mem(.clk(clk),
			.reset(reset),
			.we(we_result20_mem),
			.en_w(en_w_result20_mem),
			.en_r(en_r_result20_mem),
			.addr_w(addr_w_result20_mem),
			.addr_r(addr_r_result20_mem),
			.di(inp_result20_mem),
			.dout(outp_result20_mem_w),
			.dat_read(dat_read_result20_mem_w)
	);
        
    reg 		        		   we_result21_mem ;
	reg 		        		   en_w_result21_mem ;
	reg 		        		   en_r_result21_mem ;
	reg 	   [15-1:0]	           addr_w_result21_mem;
	reg 	   [16-1:0]	           addr_r_result21_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result21_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result21_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result21_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result21_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result21_mem_w;
	always@(posedge clk) begin
		outp_result21_mem <= outp_result21_mem_w;
		dat_read_result21_mem <= dat_read_result21_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result21_mem(.clk(clk),
			.reset(reset),
			.we(we_result21_mem),
			.en_w(en_w_result21_mem),
			.en_r(en_r_result21_mem),
			.addr_w(addr_w_result21_mem),
			.addr_r(addr_r_result21_mem),
			.di(inp_result21_mem),
			.dout(outp_result21_mem_w),
			.dat_read(dat_read_result21_mem_w)
	);
        
    reg 		        		   we_result22_mem ;
	reg 		        		   en_w_result22_mem ;
	reg 		        		   en_r_result22_mem ;
	reg 	   [15-1:0]	           addr_w_result22_mem;
	reg 	   [16-1:0]	           addr_r_result22_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result22_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result22_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result22_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result22_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result22_mem_w;
	always@(posedge clk) begin
		outp_result22_mem <= outp_result22_mem_w;
		dat_read_result22_mem <= dat_read_result22_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result22_mem(.clk(clk),
			.reset(reset),
			.we(we_result22_mem),
			.en_w(en_w_result22_mem),
			.en_r(en_r_result22_mem),
			.addr_w(addr_w_result22_mem),
			.addr_r(addr_r_result22_mem),
			.di(inp_result22_mem),
			.dout(outp_result22_mem_w),
			.dat_read(dat_read_result22_mem_w)
	);
        
    reg 		        		   we_result23_mem ;
	reg 		        		   en_w_result23_mem ;
	reg 		        		   en_r_result23_mem ;
	reg 	   [15-1:0]	           addr_w_result23_mem;
	reg 	   [16-1:0]	           addr_r_result23_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result23_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result23_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result23_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result23_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result23_mem_w;
	always@(posedge clk) begin
		outp_result23_mem <= outp_result23_mem_w;
		dat_read_result23_mem <= dat_read_result23_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result23_mem(.clk(clk),
			.reset(reset),
			.we(we_result23_mem),
			.en_w(en_w_result23_mem),
			.en_r(en_r_result23_mem),
			.addr_w(addr_w_result23_mem),
			.addr_r(addr_r_result23_mem),
			.di(inp_result23_mem),
			.dout(outp_result23_mem_w),
			.dat_read(dat_read_result23_mem_w)
	);
        
    reg 		        		   we_result24_mem ;
	reg 		        		   en_w_result24_mem ;
	reg 		        		   en_r_result24_mem ;
	reg 	   [15-1:0]	           addr_w_result24_mem;
	reg 	   [16-1:0]	           addr_r_result24_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result24_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result24_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result24_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result24_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result24_mem_w;
	always@(posedge clk) begin
		outp_result24_mem <= outp_result24_mem_w;
		dat_read_result24_mem <= dat_read_result24_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result24_mem(.clk(clk),
			.reset(reset),
			.we(we_result24_mem),
			.en_w(en_w_result24_mem),
			.en_r(en_r_result24_mem),
			.addr_w(addr_w_result24_mem),
			.addr_r(addr_r_result24_mem),
			.di(inp_result24_mem),
			.dout(outp_result24_mem_w),
			.dat_read(dat_read_result24_mem_w)
	);
        
    reg 		        		   we_result25_mem ;
	reg 		        		   en_w_result25_mem ;
	reg 		        		   en_r_result25_mem ;
	reg 	   [15-1:0]	           addr_w_result25_mem;
	reg 	   [16-1:0]	           addr_r_result25_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result25_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result25_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result25_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result25_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result25_mem_w;
	always@(posedge clk) begin
		outp_result25_mem <= outp_result25_mem_w;
		dat_read_result25_mem <= dat_read_result25_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result25_mem(.clk(clk),
			.reset(reset),
			.we(we_result25_mem),
			.en_w(en_w_result25_mem),
			.en_r(en_r_result25_mem),
			.addr_w(addr_w_result25_mem),
			.addr_r(addr_r_result25_mem),
			.di(inp_result25_mem),
			.dout(outp_result25_mem_w),
			.dat_read(dat_read_result25_mem_w)
	);
        
    reg 		        		   we_result26_mem ;
	reg 		        		   en_w_result26_mem ;
	reg 		        		   en_r_result26_mem ;
	reg 	   [15-1:0]	           addr_w_result26_mem;
	reg 	   [16-1:0]	           addr_r_result26_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result26_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result26_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result26_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result26_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result26_mem_w;
	always@(posedge clk) begin
		outp_result26_mem <= outp_result26_mem_w;
		dat_read_result26_mem <= dat_read_result26_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result26_mem(.clk(clk),
			.reset(reset),
			.we(we_result26_mem),
			.en_w(en_w_result26_mem),
			.en_r(en_r_result26_mem),
			.addr_w(addr_w_result26_mem),
			.addr_r(addr_r_result26_mem),
			.di(inp_result26_mem),
			.dout(outp_result26_mem_w),
			.dat_read(dat_read_result26_mem_w)
	);
        
    reg 		        		   we_result27_mem ;
	reg 		        		   en_w_result27_mem ;
	reg 		        		   en_r_result27_mem ;
	reg 	   [15-1:0]	           addr_w_result27_mem;
	reg 	   [16-1:0]	           addr_r_result27_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result27_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result27_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result27_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result27_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result27_mem_w;
	always@(posedge clk) begin
		outp_result27_mem <= outp_result27_mem_w;
		dat_read_result27_mem <= dat_read_result27_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result27_mem(.clk(clk),
			.reset(reset),
			.we(we_result27_mem),
			.en_w(en_w_result27_mem),
			.en_r(en_r_result27_mem),
			.addr_w(addr_w_result27_mem),
			.addr_r(addr_r_result27_mem),
			.di(inp_result27_mem),
			.dout(outp_result27_mem_w),
			.dat_read(dat_read_result27_mem_w)
	);
        
    reg 		        		   we_result28_mem ;
	reg 		        		   en_w_result28_mem ;
	reg 		        		   en_r_result28_mem ;
	reg 	   [15-1:0]	           addr_w_result28_mem;
	reg 	   [16-1:0]	           addr_r_result28_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result28_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result28_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result28_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result28_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result28_mem_w;
	always@(posedge clk) begin
		outp_result28_mem <= outp_result28_mem_w;
		dat_read_result28_mem <= dat_read_result28_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result28_mem(.clk(clk),
			.reset(reset),
			.we(we_result28_mem),
			.en_w(en_w_result28_mem),
			.en_r(en_r_result28_mem),
			.addr_w(addr_w_result28_mem),
			.addr_r(addr_r_result28_mem),
			.di(inp_result28_mem),
			.dout(outp_result28_mem_w),
			.dat_read(dat_read_result28_mem_w)
	);
        
    reg 		        		   we_result29_mem ;
	reg 		        		   en_w_result29_mem ;
	reg 		        		   en_r_result29_mem ;
	reg 	   [15-1:0]	           addr_w_result29_mem;
	reg 	   [16-1:0]	           addr_r_result29_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result29_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result29_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result29_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result29_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result29_mem_w;
	always@(posedge clk) begin
		outp_result29_mem <= outp_result29_mem_w;
		dat_read_result29_mem <= dat_read_result29_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result29_mem(.clk(clk),
			.reset(reset),
			.we(we_result29_mem),
			.en_w(en_w_result29_mem),
			.en_r(en_r_result29_mem),
			.addr_w(addr_w_result29_mem),
			.addr_r(addr_r_result29_mem),
			.di(inp_result29_mem),
			.dout(outp_result29_mem_w),
			.dat_read(dat_read_result29_mem_w)
	);
        
    reg 		        		   we_result30_mem ;
	reg 		        		   en_w_result30_mem ;
	reg 		        		   en_r_result30_mem ;
	reg 	   [15-1:0]	           addr_w_result30_mem;
	reg 	   [16-1:0]	           addr_r_result30_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result30_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result30_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result30_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result30_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result30_mem_w;
	always@(posedge clk) begin
		outp_result30_mem <= outp_result30_mem_w;
		dat_read_result30_mem <= dat_read_result30_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result30_mem(.clk(clk),
			.reset(reset),
			.we(we_result30_mem),
			.en_w(en_w_result30_mem),
			.en_r(en_r_result30_mem),
			.addr_w(addr_w_result30_mem),
			.addr_r(addr_r_result30_mem),
			.di(inp_result30_mem),
			.dout(outp_result30_mem_w),
			.dat_read(dat_read_result30_mem_w)
	);
        
    reg 		        		   we_result31_mem ;
	reg 		        		   en_w_result31_mem ;
	reg 		        		   en_r_result31_mem ;
	reg 	   [15-1:0]	           addr_w_result31_mem;
	reg 	   [16-1:0]	           addr_r_result31_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result31_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result31_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result31_mem;
	
	wire signed [RAM_WIDTH_IMG-1:0] dat_read_result31_mem_w;   
	wire signed [RAM_WIDTH_IMG-1:0] outp_result31_mem_w;
	always@(posedge clk) begin
		outp_result31_mem <= outp_result31_mem_w;
		dat_read_result31_mem <= dat_read_result31_mem_w; 
	end
	oneDRAM #(.A_WIDTH(14),
			  .ADDR_WIDTH(15), 
			  .D_WIDTH(RAM_WIDTH_IMG)
	)result31_mem(.clk(clk),
			.reset(reset),
			.we(we_result31_mem),
			.en_w(en_w_result31_mem),
			.en_r(en_r_result31_mem),
			.addr_w(addr_w_result31_mem),
			.addr_r(addr_r_result31_mem),
			.di(inp_result31_mem),
			.dout(outp_result31_mem_w),
			.dat_read(dat_read_result31_mem_w)
	);
/**/
	reg								resultset2zero[31:0];
   
   
    reg signed	[2*RAM_WIDTH_IMG-1:0]result_temp[31:0];
    reg 		[8:0]				N1_var2[31:0];
    reg 		[8:0]    			M1_var2[31:0];
    reg			[6:0]				C1_var4[31:0];
	reg			[8:0]				M3_var[31:0];
	reg			[8:0]				N3_var[31:0];
    reg 							conv_done[31:0];
//--------------------------------------------------------------------------------------------------------	
    ////////////////////////
	// recieving image
	assign image_out = outp_img_mem; 
	always@(posedge clk)
		if (reset == 1) 
		begin
			image_rdy <= 1'd0;
			addr_w_img_mem <= 15'd0;
			image_recieved <= 0;
			we_img_mem <= 1'd0;
			inp_img_mem <= 16'd0;
			en_w_img_mem <=1'd0;
		end
		else 
		begin
			if (image_recieved == 0 && reset == 0)
				we_img_mem <= 1'd1;
			    en_w_img_mem <=1'd1;		 
				image_rdy <= 1; 
				if(image_vld == 1) 
				begin
					addr_w_img_mem <= addr_w_img_mem + 16'd1;
					inp_img_mem  <= image;
					
				end	
				if (addr_w_img_mem >= 130*130*3)//IMAGE_MEM_LENGTH) 
				begin
					we_img_mem <= 1'd0;
					en_w_img_mem <= 1'd0;
					image_rdy <= 1'd0;
					addr_w_img_mem <= 16'd0;
					image_recieved <= 1'b1;
					
				end
		end
	
//----------------------------------------------------------------------------------------------------------------------------------------

     ////////////////////////
	// recieving biases
	assign biases_out = outp_biases_mem;
	always@(posedge clk)
	if (reset == 1) 
	begin
		biases_rdy <= 1'd0;
		biases_recieved <= 1'd0;
		addr_w_biases_mem <= 6'd0;
		we_biases_mem <= 1'd0;
		en_w_biases_mem <= 1'd0;
		inp_biases_mem <=16'd0 ;
	end
	else begin
		if (biases_recieved == 0 && reset == 0)	
		    we_biases_mem <= 1'd1;
			en_w_biases_mem <= 1'd1;	 
			biases_rdy <= 1'd1; 
			if(biases_vld == 1) 
			begin
				addr_w_biases_mem <= addr_w_biases_mem + 1'd1;
				inp_biases_mem <= biases;
			end	
			if (addr_w_biases_mem >= BIAS_MEM_LENGTH) //removed a "+2" kludge, might cause error!!!! 
			begin
				biases_recieved <= 1'b1;
				we_biases_mem <= 1'd0;
				en_w_biases_mem <= 1'd0;
				biases_rdy <= 1'd0; 
			end
	end

    
//---------------------------------------------------------------------------------------------------------
    ////////////////////////
    // recieving kernel[0]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy0 <= 1'b0;
    		addr_w_kernel0_mem <= 6'b0;
    		kernel_recieved[0] <= 1'b0;
    		we_kernel0_mem <= 1'b0;
			en_w_kernel0_mem <= 1'b0;
			inp_kernel0_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[0] == 0 && reset == 0)		
    			we_kernel0_mem <= 1'b1;
    		    en_w_kernel0_mem <= 1'b1; 
				kernel_rdy0 <= 1'b1; 
				if(kernel_vld0 == 1) 
				begin
					addr_w_kernel0_mem <= addr_w_kernel0_mem + 6'b1;
					inp_kernel0_mem <= kernel0;	
					
				end				
				if (addr_w_kernel0_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[0] <= 1'b1;
					we_kernel0_mem <= 1'b0;
					en_w_kernel0_mem <= 1'b0;
					kernel_rdy0 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[1]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy1 <= 1'b0;
    		addr_w_kernel1_mem <= 6'b0;
    		kernel_recieved[1] <= 1'b0;
    		we_kernel1_mem <= 1'b0;
			en_w_kernel1_mem <= 1'b0;
			inp_kernel1_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[1] == 0 && reset == 0)		
    			we_kernel1_mem <= 1'b1;
    		    en_w_kernel1_mem <= 1'b1; 
				kernel_rdy1 <= 1'b1; 
				if(kernel_vld1 == 1) 
				begin
					addr_w_kernel1_mem <= addr_w_kernel1_mem + 6'b1;
					inp_kernel1_mem <= kernel1;	
					
				end				
				if (addr_w_kernel1_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[1] <= 1'b1;
					we_kernel1_mem <= 1'b0;
					en_w_kernel1_mem <= 1'b0;
					kernel_rdy1 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[2]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy2 <= 1'b0;
    		addr_w_kernel2_mem <= 6'b0;
    		kernel_recieved[2] <= 1'b0;
    		we_kernel2_mem <= 1'b0;
			en_w_kernel2_mem <= 1'b0;
			inp_kernel2_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[2] == 0 && reset == 0)		
    			we_kernel2_mem <= 1'b1;
    		    en_w_kernel2_mem <= 1'b1; 
				kernel_rdy2 <= 1'b1; 
				if(kernel_vld2 == 1) 
				begin
					addr_w_kernel2_mem <= addr_w_kernel2_mem + 6'b1;
					inp_kernel2_mem <= kernel2;	
				end				
				if (addr_w_kernel2_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[2] <= 1'b1;
					we_kernel2_mem <= 1'b0;
					en_w_kernel2_mem <= 1'b0;
					kernel_rdy2 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[3]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy3 <= 1'b0;
    		addr_w_kernel3_mem <= 6'b0;
    		kernel_recieved[3] <= 1'b0;
    		we_kernel3_mem <= 1'b0;
			en_w_kernel3_mem <= 1'b0;
			inp_kernel3_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[3] == 0 && reset == 0)		
    			we_kernel3_mem <= 1'b1;
    		    en_w_kernel3_mem <= 1'b1; 
				kernel_rdy3 <= 1'b1; 
				if(kernel_vld3 == 1) 
				begin
					addr_w_kernel3_mem <= addr_w_kernel3_mem + 6'b1;
					inp_kernel3_mem <= kernel3;	
					
				end				
				if (addr_w_kernel3_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[3] <= 1'b1;
					we_kernel3_mem <= 1'b0;
					en_w_kernel3_mem <= 1'b0;
					kernel_rdy3 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[4]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy4 <= 1'b0;
    		addr_w_kernel4_mem <= 6'b0;
    		kernel_recieved[4] <= 1'b0;
    		we_kernel4_mem <= 1'b0;
			en_w_kernel4_mem <= 1'b0;
			inp_kernel4_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[4] == 0 && reset == 0)		
    			we_kernel4_mem <= 1'b1;
    		    en_w_kernel4_mem <= 1'b1; 
				kernel_rdy4 <= 1'b1; 
				if(kernel_vld4 == 1) 
				begin
					addr_w_kernel4_mem <= addr_w_kernel4_mem + 6'b1;
					inp_kernel4_mem <= kernel4;	
					
				end				
				if (addr_w_kernel4_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[4] <= 1'b1;
					we_kernel4_mem <= 1'b0;
					en_w_kernel4_mem <= 1'b0;
					kernel_rdy4 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[5]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy5 <= 1'b0;
    		addr_w_kernel5_mem <= 6'b0;
    		kernel_recieved[5] <= 1'b0;
    		we_kernel5_mem <= 1'b0;
			en_w_kernel5_mem <= 1'b0;
			inp_kernel5_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[5] == 0 && reset == 0)		
    			we_kernel5_mem <= 1'b1;
    		    en_w_kernel5_mem <= 1'b1; 
				kernel_rdy5 <= 1'b1; 
				if(kernel_vld5 == 1) 
				begin
					addr_w_kernel5_mem <= addr_w_kernel5_mem + 6'b1;
					inp_kernel5_mem <= kernel5;	
					
				end				
				if (addr_w_kernel5_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[5] <= 1'b1;
					we_kernel5_mem <= 1'b0;
					en_w_kernel5_mem <= 1'b0;
					kernel_rdy5 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[6]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy6 <= 1'b0;
    		addr_w_kernel6_mem <= 6'b0;
    		kernel_recieved[6] <= 1'b0;
    		we_kernel6_mem <= 1'b0;
			en_w_kernel6_mem <= 1'b0;
			inp_kernel6_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[6] == 0 && reset == 0)		
    			we_kernel6_mem <= 1'b1;
    		    en_w_kernel6_mem <= 1'b1; 
				kernel_rdy6 <= 1'b1; 
				if(kernel_vld6 == 1) 
				begin
					addr_w_kernel6_mem <= addr_w_kernel6_mem + 6'b1;
					inp_kernel6_mem <= kernel6;	
					
				end				
				if (addr_w_kernel6_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[6] <= 1'b1;
					we_kernel6_mem <= 1'b0;
					en_w_kernel6_mem <= 1'b0;
					kernel_rdy6 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[7]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy7 <= 1'b0;
    		addr_w_kernel7_mem <= 6'b0;
    		kernel_recieved[7] <= 1'b0;
    		we_kernel7_mem <= 1'b0;
			en_w_kernel7_mem <= 1'b0;
			inp_kernel7_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[7] == 0 && reset == 0)		
    			we_kernel7_mem <= 1'b1;
    		    en_w_kernel7_mem <= 1'b1; 
				kernel_rdy7 <= 1'b1; 
				if(kernel_vld7 == 1) 
				begin
					addr_w_kernel7_mem <= addr_w_kernel7_mem + 6'b1;
					inp_kernel7_mem <= kernel7;	
					
				end				
				if (addr_w_kernel7_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[7] <= 1'b1;
					we_kernel7_mem <= 1'b0;
					en_w_kernel7_mem <= 1'b0;
					kernel_rdy7 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[8]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy8 <= 1'b0;
    		addr_w_kernel8_mem <= 6'b0;
    		kernel_recieved[8] <= 1'b0;
    		we_kernel8_mem <= 1'b0;
			en_w_kernel8_mem <= 1'b0;
			inp_kernel8_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[8] == 0 && reset == 0)		
    			we_kernel8_mem <= 1'b1;
    		    en_w_kernel8_mem <= 1'b1; 
				kernel_rdy8 <= 1'b1; 
				if(kernel_vld8 == 1) 
				begin
					addr_w_kernel8_mem <= addr_w_kernel8_mem + 6'b1;
					inp_kernel8_mem <= kernel8;	
					
				end				
				if (addr_w_kernel8_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[8] <= 1'b1;
					we_kernel8_mem <= 1'b0;
					en_w_kernel8_mem <= 1'b0;
					kernel_rdy8 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[9]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy9 <= 1'b0;
    		addr_w_kernel9_mem <= 6'b0;
    		kernel_recieved[9] <= 1'b0;
    		we_kernel9_mem <= 1'b0;
			en_w_kernel9_mem <= 1'b0;
			inp_kernel9_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[9] == 0 && reset == 0)		
    			we_kernel9_mem <= 1'b1;
    		    en_w_kernel9_mem <= 1'b1; 
				kernel_rdy9 <= 1'b1; 
				if(kernel_vld9 == 1) 
				begin
					addr_w_kernel9_mem <= addr_w_kernel9_mem + 6'b1;
					inp_kernel9_mem <= kernel9;	
					
				end				
				if (addr_w_kernel9_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[9] <= 1'b1;
					we_kernel9_mem <= 1'b0;
					en_w_kernel9_mem <= 1'b0;
					kernel_rdy9 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[10]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy10 <= 1'b0;
    		addr_w_kernel10_mem <= 6'b0;
    		kernel_recieved[10] <= 1'b0;
    		we_kernel10_mem <= 1'b0;
			en_w_kernel10_mem <= 1'b0;
			inp_kernel10_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[10] == 0 && reset == 0)		
    			we_kernel10_mem <= 1'b1;
    		    en_w_kernel10_mem <= 1'b1; 
				kernel_rdy10 <= 1'b1; 
				if(kernel_vld10 == 1) 
				begin
					addr_w_kernel10_mem <= addr_w_kernel10_mem + 6'b1;
					inp_kernel10_mem <= kernel10;
					
				end				
				if (addr_w_kernel10_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[10] <= 1'b1;
					we_kernel10_mem <= 1'b0;
					en_w_kernel10_mem <= 1'b0;
					kernel_rdy10 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[11]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy11 <= 1'b0;
    		addr_w_kernel11_mem <= 6'b0;
    		kernel_recieved[11] <= 1'b0;
    		we_kernel11_mem <= 1'b0;
			en_w_kernel11_mem <= 1'b0;
			inp_kernel11_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[11] == 0 && reset == 0)		
    			we_kernel11_mem <= 1'b1;
    		    en_w_kernel11_mem <= 1'b1; 
				kernel_rdy11 <= 1'b1; 
				if(kernel_vld11 == 1) 
				begin
					addr_w_kernel11_mem <= addr_w_kernel11_mem + 6'b1;
					inp_kernel11_mem <= kernel11;	
					
				end				
				if (addr_w_kernel11_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[11] <= 1'b1;
					we_kernel11_mem <= 1'b0;
					en_w_kernel11_mem <= 1'b0;
					kernel_rdy11 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[12]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy12 <= 1'b0;
    		addr_w_kernel12_mem <= 6'b0;
    		kernel_recieved[12] <= 1'b0;
    		we_kernel12_mem <= 1'b0;
			en_w_kernel12_mem <= 1'b0;
			inp_kernel12_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[12] == 0 && reset == 0)		
    			we_kernel12_mem <= 1'b1;
    		    en_w_kernel12_mem <= 1'b1; 
				kernel_rdy12 <= 1'b1; 
				if(kernel_vld12 == 1) 
				begin
					addr_w_kernel12_mem <= addr_w_kernel12_mem + 6'b1;
					inp_kernel12_mem <= kernel12;	
					
				end				
				if (addr_w_kernel12_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[12] <= 1'b1;
					we_kernel12_mem <= 1'b0;
					en_w_kernel12_mem <= 1'b0;
					kernel_rdy12 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[13]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy13 <= 1'b0;
    		addr_w_kernel13_mem <= 6'b0;
    		kernel_recieved[13] <= 1'b0;
    		we_kernel13_mem <= 1'b0;
			en_w_kernel13_mem <= 1'b0;
			inp_kernel13_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[13] == 0 && reset == 0)		
    			we_kernel13_mem <= 1'b1;
    		    en_w_kernel13_mem <= 1'b1; 
				kernel_rdy13 <= 1'b1; 
				if(kernel_vld13 == 1) 
				begin
					addr_w_kernel13_mem <= addr_w_kernel13_mem + 6'b1;
					inp_kernel13_mem <= kernel13;
					
				end				
				if (addr_w_kernel13_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[13] <= 1'b1;
					we_kernel13_mem <= 1'b0;
					en_w_kernel13_mem <= 1'b0;
					kernel_rdy13 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[14]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy14 <= 1'b0;
    		addr_w_kernel14_mem <= 6'b0;
    		kernel_recieved[14] <= 1'b0;
    		we_kernel14_mem <= 1'b0;
			en_w_kernel14_mem <= 1'b0;
			inp_kernel14_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[14] == 0 && reset == 0)		
    			we_kernel14_mem <= 1'b1;
    		    en_w_kernel14_mem <= 1'b1; 
				kernel_rdy14 <= 1'b1; 
				if(kernel_vld14 == 1) 
				begin
					addr_w_kernel14_mem <= addr_w_kernel14_mem + 6'b1;
					inp_kernel14_mem <= kernel14;	
					
				end				
				if (addr_w_kernel14_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[14] <= 1'b1;
					we_kernel14_mem <= 1'b0;
					en_w_kernel14_mem <= 1'b0;
					kernel_rdy14 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[15]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy15 <= 1'b0;
    		addr_w_kernel15_mem <= 6'b0;
    		kernel_recieved[15] <= 1'b0;
    		we_kernel15_mem <= 1'b0;
			en_w_kernel15_mem <= 1'b0;
			inp_kernel15_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[15] == 0 && reset == 0)		
    			we_kernel15_mem <= 1'b1;
    		    en_w_kernel15_mem <= 1'b1; 
				kernel_rdy15 <= 1'b1; 
				if(kernel_vld15 == 1) 
				begin
					addr_w_kernel15_mem <= addr_w_kernel15_mem + 6'b1;
					inp_kernel15_mem <= kernel15;	
					
				end				
				if (addr_w_kernel15_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[15] <= 1'b1;
					we_kernel15_mem <= 1'b0;
					en_w_kernel15_mem <= 1'b0;
					kernel_rdy15 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[16]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy16 <= 1'b0;
    		addr_w_kernel16_mem <= 6'b0;
    		kernel_recieved[16] <= 1'b0;
    		we_kernel16_mem <= 1'b0;
			en_w_kernel16_mem <= 1'b0;
			inp_kernel16_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[16] == 0 && reset == 0)		
    			we_kernel16_mem <= 1'b1;
    		    en_w_kernel16_mem <= 1'b1; 
				kernel_rdy16 <= 1'b1; 
				if(kernel_vld16 == 1) 
				begin
					addr_w_kernel16_mem <= addr_w_kernel16_mem + 6'b1;
					inp_kernel16_mem <= kernel16;	
					
				end				
				if (addr_w_kernel16_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[16] <= 1'b1;
					we_kernel16_mem <= 1'b0;
					en_w_kernel16_mem <= 1'b0;
					kernel_rdy16 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[17]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy17 <= 1'b0;
    		addr_w_kernel17_mem <= 6'b0;
    		kernel_recieved[17] <= 1'b0;
    		we_kernel17_mem <= 1'b0;
			en_w_kernel17_mem <= 1'b0;
			inp_kernel17_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[17] == 0 && reset == 0)		
    			we_kernel17_mem <= 1'b1;
    		    en_w_kernel17_mem <= 1'b1; 
				kernel_rdy17 <= 1'b1; 
				if(kernel_vld17 == 1) 
				begin
					addr_w_kernel17_mem <= addr_w_kernel17_mem + 6'b1;
					inp_kernel17_mem <= kernel17;
					
				end				
				if (addr_w_kernel17_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[17] <= 1'b1;
					we_kernel17_mem <= 1'b0;
					en_w_kernel17_mem <= 1'b0;
					kernel_rdy17 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[18]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy18 <= 1'b0;
    		addr_w_kernel18_mem <= 6'b0;
    		kernel_recieved[18] <= 1'b0;
    		we_kernel18_mem <= 1'b0;
			en_w_kernel18_mem <= 1'b0;
			inp_kernel18_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[18] == 0 && reset == 0)		
    			we_kernel18_mem <= 1'b1;
    		    en_w_kernel18_mem <= 1'b1; 
				kernel_rdy18 <= 1'b1; 
				if(kernel_vld18 == 1) 
				begin
					addr_w_kernel18_mem <= addr_w_kernel18_mem + 6'b1;
					inp_kernel18_mem <= kernel18;	
					
				end				
				if (addr_w_kernel18_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[18] <= 1'b1;
					we_kernel18_mem <= 1'b0;
					en_w_kernel18_mem <= 1'b0;
					kernel_rdy18 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[19]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy19 <= 1'b0;
    		addr_w_kernel19_mem <= 6'b0;
    		kernel_recieved[19] <= 1'b0;
    		we_kernel19_mem <= 1'b0;
			en_w_kernel19_mem <= 1'b0;
			inp_kernel19_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[19] == 0 && reset == 0)		
    			we_kernel19_mem <= 1'b1;
    		    en_w_kernel19_mem <= 1'b1; 
				kernel_rdy19 <= 1'b1; 
				if(kernel_vld19 == 1) 
				begin
					addr_w_kernel19_mem <= addr_w_kernel19_mem + 6'b1;
					inp_kernel19_mem <= kernel19;
					
				end				
				if (addr_w_kernel19_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[19] <= 1'b1;
					we_kernel19_mem <= 1'b0;
					en_w_kernel19_mem <= 1'b0;
					kernel_rdy19 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[20]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy20 <= 1'b0;
    		addr_w_kernel20_mem <= 6'b0;
    		kernel_recieved[20] <= 1'b0;
    		we_kernel20_mem <= 1'b0;
			en_w_kernel20_mem <= 1'b0;
			inp_kernel20_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[20] == 0 && reset == 0)		
    			we_kernel20_mem <= 1'b1;
    		    en_w_kernel20_mem <= 1'b1; 
				kernel_rdy20 <= 1'b1; 
				if(kernel_vld20 == 1) 
				begin
					addr_w_kernel20_mem <= addr_w_kernel20_mem + 6'b1;
					inp_kernel20_mem <= kernel20;	
					
				end				
				if (addr_w_kernel20_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[20] <= 1'b1;
					we_kernel20_mem <= 1'b0;
					en_w_kernel20_mem <= 1'b0;
					kernel_rdy20 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[21]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy21 <= 1'b0;
    		addr_w_kernel21_mem <= 6'b0;
    		kernel_recieved[21] <= 1'b0;
    		we_kernel21_mem <= 1'b0;
			en_w_kernel21_mem <= 1'b0;
			inp_kernel21_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[21] == 0 && reset == 0)		
    			we_kernel21_mem <= 1'b1;
    		    en_w_kernel21_mem <= 1'b1; 
				kernel_rdy21 <= 1'b1; 
				if(kernel_vld21 == 1) 
				begin
					addr_w_kernel21_mem <= addr_w_kernel21_mem + 6'b1;
					inp_kernel21_mem <= kernel21;	
					
				end				
				if (addr_w_kernel21_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[21] <= 1'b1;
					we_kernel21_mem <= 1'b0;
					en_w_kernel21_mem <= 1'b0;
					kernel_rdy21 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[22]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy22 <= 1'b0;
    		addr_w_kernel22_mem <= 6'b0;
    		kernel_recieved[22] <= 1'b0;
    		we_kernel22_mem <= 1'b0;
			en_w_kernel22_mem <= 1'b0;
			inp_kernel22_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[22] == 0 && reset == 0)		
    			we_kernel22_mem <= 1'b1;
    		    en_w_kernel22_mem <= 1'b1; 
				kernel_rdy22 <= 1'b1; 
				if(kernel_vld22 == 1) 
				begin
					addr_w_kernel22_mem <= addr_w_kernel22_mem + 6'b1;
					inp_kernel22_mem <= kernel22;	
					
				end				
				if (addr_w_kernel22_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[22] <= 1'b1;
					we_kernel22_mem <= 1'b0;
					en_w_kernel22_mem <= 1'b0;
					kernel_rdy22 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[23]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy23 <= 1'b0;
    		addr_w_kernel23_mem <= 6'b0;
    		kernel_recieved[23] <= 1'b0;
    		we_kernel23_mem <= 1'b0;
			en_w_kernel23_mem <= 1'b0;
			inp_kernel23_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[23] == 0 && reset == 0)		
    			we_kernel23_mem <= 1'b1;
    		    en_w_kernel23_mem <= 1'b1; 
				kernel_rdy23 <= 1'b1; 
				if(kernel_vld23 == 1) 
				begin
					addr_w_kernel23_mem <= addr_w_kernel23_mem + 6'b1;
					inp_kernel23_mem <= kernel23;	
					
				end				
				if (addr_w_kernel23_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[23] <= 1'b1;
					we_kernel23_mem <= 1'b0;
					en_w_kernel23_mem <= 1'b0;
					kernel_rdy23 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[24]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy24 <= 1'b0;
    		addr_w_kernel24_mem <= 6'b0;
    		kernel_recieved[24] <= 1'b0;
    		we_kernel24_mem <= 1'b0;
			en_w_kernel24_mem <= 1'b0;
			inp_kernel24_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[24] == 0 && reset == 0)		
    			we_kernel24_mem <= 1'b1;
    		    en_w_kernel24_mem <= 1'b1; 
				kernel_rdy24 <= 1'b1; 
				if(kernel_vld24 == 1) 
				begin
					addr_w_kernel24_mem <= addr_w_kernel24_mem + 6'b1;
					inp_kernel24_mem <= kernel24;	
					
				end				
				if (addr_w_kernel24_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[24] <= 1'b1;
					we_kernel24_mem <= 1'b0;
					en_w_kernel24_mem <= 1'b0;
					kernel_rdy24 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[25]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy25 <= 1'b0;
    		addr_w_kernel25_mem <= 6'b0;
    		kernel_recieved[25] <= 1'b0;
    		we_kernel25_mem <= 1'b0;
			en_w_kernel25_mem <= 1'b0;
			inp_kernel25_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[25] == 0 && reset == 0)		
    			we_kernel25_mem <= 1'b1;
    		    en_w_kernel25_mem <= 1'b1; 
				kernel_rdy25 <= 1'b1; 
				if(kernel_vld25 == 1) 
				begin
					addr_w_kernel25_mem <= addr_w_kernel25_mem + 6'b1;
					inp_kernel25_mem <= kernel25;
					
				end				
				if (addr_w_kernel25_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[25] <= 1'b1;
					we_kernel25_mem <= 1'b0;
					en_w_kernel25_mem <= 1'b0;
					kernel_rdy25 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[26]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy26 <= 1'b0;
    		addr_w_kernel26_mem <= 6'b0;
    		kernel_recieved[26] <= 1'b0;
    		we_kernel26_mem <= 1'b0;
			en_w_kernel26_mem <= 1'b0;
			inp_kernel26_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[26] == 0 && reset == 0)		
    			we_kernel26_mem <= 1'b1;
    		    en_w_kernel26_mem <= 1'b1; 
				kernel_rdy26 <= 1'b1; 
				if(kernel_vld26 == 1) 
				begin
					addr_w_kernel26_mem <= addr_w_kernel26_mem + 6'b1;
					inp_kernel26_mem <= kernel26;
						
				end				
				if (addr_w_kernel26_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[26] <= 1'b1;
					we_kernel26_mem <= 1'b0;
					en_w_kernel26_mem <= 1'b0;
					kernel_rdy26 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[27]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy27 <= 1'b0;
    		addr_w_kernel27_mem <= 6'b0;
    		kernel_recieved[27] <= 1'b0;
    		we_kernel27_mem <= 1'b0;
			en_w_kernel27_mem <= 1'b0;
			inp_kernel27_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[27] == 0 && reset == 0)		
    			we_kernel27_mem <= 1'b1;
    		    en_w_kernel27_mem <= 1'b1; 
				kernel_rdy27 <= 1'b1; 
				if(kernel_vld27 == 1) 
				begin
					addr_w_kernel27_mem <= addr_w_kernel27_mem + 6'b1;
					inp_kernel27_mem <= kernel27;	
					
				end				
				if (addr_w_kernel27_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[27] <= 1'b1;
					we_kernel27_mem <= 1'b0;
					en_w_kernel27_mem <= 1'b0;
					kernel_rdy27 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[28]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy28 <= 1'b0;
    		addr_w_kernel28_mem <= 6'b0;
    		kernel_recieved[28] <= 1'b0;
    		we_kernel28_mem <= 1'b0;
			en_w_kernel28_mem <= 1'b0;
			inp_kernel28_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[28] == 0 && reset == 0)		
    			we_kernel28_mem <= 1'b1;
    		    en_w_kernel28_mem <= 1'b1; 
				kernel_rdy28 <= 1'b1; 
				if(kernel_vld28 == 1) 
				begin
					addr_w_kernel28_mem <= addr_w_kernel28_mem + 6'b1;
					inp_kernel28_mem <= kernel28;
						
				end				
				if (addr_w_kernel28_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[28] <= 1'b1;
					we_kernel28_mem <= 1'b0;
					en_w_kernel28_mem <= 1'b0;
					kernel_rdy28 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[29]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy29 <= 1'b0;
    		addr_w_kernel29_mem <= 6'b0;
    		kernel_recieved[29] <= 1'b0;
    		we_kernel29_mem <= 1'b0;
			en_w_kernel29_mem <= 1'b0;
			inp_kernel29_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[29] == 0 && reset == 0)		
    			we_kernel29_mem <= 1'b1;
    		    en_w_kernel29_mem <= 1'b1; 
				kernel_rdy29 <= 1'b1; 
				if(kernel_vld29 == 1) 
				begin
					addr_w_kernel29_mem <= addr_w_kernel29_mem + 6'b1;
					inp_kernel29_mem <= kernel29;
					
				end				
				if (addr_w_kernel29_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[29] <= 1'b1;
					we_kernel29_mem <= 1'b0;
					en_w_kernel29_mem <= 1'b0;
					kernel_rdy29 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[30]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy30 <= 1'b0;
    		addr_w_kernel30_mem <= 6'b0;
    		kernel_recieved[30] <= 1'b0;
    		we_kernel30_mem <= 1'b0;
			en_w_kernel30_mem <= 1'b0;
			inp_kernel30_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[30] == 0 && reset == 0)		
    			we_kernel30_mem <= 1'b1;
    		    en_w_kernel30_mem <= 1'b1; 
				kernel_rdy30 <= 1'b1; 
				if(kernel_vld30 == 1) 
				begin
					addr_w_kernel30_mem <= addr_w_kernel30_mem + 6'b1;
					inp_kernel30_mem <= kernel30;	
					
				end				
				if (addr_w_kernel30_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[30] <= 1'b1;
					we_kernel30_mem <= 1'b0;
					en_w_kernel30_mem <= 1'b0;
					kernel_rdy30 <= 1'b0; 
				end
    	end

    ////////////////////////
    // recieving kernel[31]
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy31 <= 1'b0;
    		addr_w_kernel31_mem <= 6'b0;
    		kernel_recieved[31] <= 1'b0;
    		we_kernel31_mem <= 1'b0;
			en_w_kernel31_mem <= 1'b0;
			inp_kernel31_mem <=16'b0 ;
    	end
    	else begin
    		if (kernel_recieved[31] == 0 && reset == 0)		
    			we_kernel31_mem <= 1'b1;
    		    en_w_kernel31_mem <= 1'b1; 
				kernel_rdy31 <= 1'b1; 
				if(kernel_vld31 == 1) 
				begin
					addr_w_kernel31_mem <= addr_w_kernel31_mem + 6'b1;
					inp_kernel31_mem <= kernel31;	
					
				end				
				if (addr_w_kernel31_mem >= KER_MEM_LENGTH) begin
					kernel_recieved[31] <= 1'b1;
					we_kernel31_mem <= 1'b0;
					en_w_kernel31_mem <= 1'b0;
					kernel_rdy31 <= 1'b0; 
				end
    	end


/**/

//_________________________________________________________________________________________________________________________________________________________________________________________
   ////////////////////////
   // convolution [0]
   reg [RAM_WIDTH_IMG-1:0] res_temp_conc [31:0];
   //delay for result_mem
   reg [7:0] delay_cnt[31:0];
   reg       delay_done[31:0];
    //delay for vars
   reg [7:0] delay2_cnt[31:0];
   reg       delay2_done[31:0];
   localparam imgSF = 2.0**-14.00;  // Q6.14 scaling factor is 2^-14
   localparam tempSF = 2.0**-30.00; // Q12.28 scaling factor is 2^-30 for result_temp 
   /* how it was:
   assign mult_temp_w_0 = kernel_arr_in0[M1_var2[0]][N1_var2[0]][C1_var4[0]][0] *       //wire for multiplication
   						image_mem_arr_in_zpad[M3_var[0] + M1_var2[0]][N3_var[0] + N1_var2[0]][C1_var4[0]];
   assign mult_temp_w_conc[0] = mult_temp_w_0[33:14];                             //wire for concatenation after multiplication
   assign res_temp_w_conc[0] = mult_temp_w_conc[0] + result_mem_0[M3_var[0]][N3_var[0]][0];//wire with result
   /**/
   
   assign mult_temp_w_0 = dat_read_kernel0_mem * dat_read_img_mem;
   assign mult_temp_w_conc[0] = mult_temp_w_0[24:5]; 
   assign res_temp_w_conc[0] = mult_temp_w_conc[0] + dat_read_result0_mem;//instead of outp_result0_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[0] <= 10'd1;
       		delay_done[0] <= 1'd0;
       		delay2_cnt[0] <= 10'd1;
			delay2_done[0] <= 1'd0;
       		N1_var2[0] <= 8'd0;
       		M1_var2[0] <= 9'd0;
       		C1_var4[0] <= 6'd0;
       		N3_var[0] <= 9'd0;
			M3_var[0] <= 9'd0;
			en_r_img_mem <= 1'd0;
			addr_r_img_mem <= 16'd0;
			en_r_biases_mem <= 1'd0;
			addr_r_biases_mem <= 16'd0;
			en_r_kernel0_mem <= 1'd0;
			addr_r_kernel0_mem <= 16'd0;
			en_w_result0_mem <= 1'd0;
			we_result0_mem <= 1'd0;
			addr_w_result0_mem <= 16'd0;
			inp_result0_mem <= 16'd0;
			conv_done[0] <= 1'd0;
			result_temp[0] <= 16'd0;// aux reg for $display
			resultset2zero[0] <= 1'd0;
			outp_result0_mem <= 16'd0;
			addr_r_result0_mem <= 1'd0;
			//dat_read_result0_mem <= 16'd0;
			res_temp_conc[0] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[0] == 0)
       	begin
       		en_r_result0_mem <= 1'd1;
			en_w_result0_mem <= 1'd1;
			we_result0_mem <= 1'd1;
			addr_w_result0_mem <= addr_w_result0_mem + 1'd1;
			inp_result0_mem <= 16'd0;
			if ( addr_w_result0_mem >= CONV_ED)
			begin
				addr_w_result0_mem <= 15'd0;
				resultset2zero[0] <= 1'd1;
				we_result0_mem <= 1'd0; //MAT CAUSE ERROR BC SHIFT OR DELAY FOR THE NEXT PROCESS ?
			end	
       	end
       	else if (kernel_recieved[0] == 1 && 
       			biases_recieved == 1 &&	conv_done[0] == 0 &&
       			resultset2zero[0] == 1)
		begin
			//we_img0_mem <= 1'd0;
			en_r_img_mem <= 1'd1;
			en_r_biases_mem <= 1'd1;
			en_r_kernel0_mem <= 1'd1;
			en_w_result0_mem <= 1'd1;
			we_result0_mem <= 1'd1;
			//artificial delays
			delay_cnt[0] <= delay_cnt[0] + 1;
			delay2_cnt[0] <= delay2_cnt[0] + 1;
			if(delay_cnt[0] >= 10'd6) begin
				delay_done[0] <= 1'd1;
				delay_cnt[0] <= 7'd0;
			end
			if(delay2_cnt[0] >= 10'd6) begin
				delay2_done[0] <= 1'd1;
			end
			if(delay_done[0] == 1'd0) 
			begin
				inp_result0_mem <= 16'd0;
			end
			res_temp_conc[0] <= res_temp_w_conc[0];
			if(delay_done[0] == 1'd1) 
			begin
				inp_result0_mem <= res_temp_conc[0];
			end
			// kernel addr: [M1_var2[0]][N1_var2[0]][C1_var4[0]][0]
			//              [N1_var_def[0]*N1_PARAM*C1_PARAM + M1_var_def[0]*C1_PARAM + C1_var_def[0] + L1_var_def[0]]
			addr_r_kernel0_mem <= (M1_var2[0])*M1_PARAM*C1_PARAM + (N1_var2[0])*C1_PARAM + (C1_var4[0]) + 1;
			// image addr :  [N2_var*M2_PARAM*C1_PARAM + M2_var*C1_PARAM + C1_var + 1] 
			//  			[M3_var[0] + M1_var2[0]][N3_var[0] + N1_var2[0]][C1_var4[0]]
			// 						[[WARNING]]:
			// HERE I USE M3 AND N3 INSTEAD OF M2 AND N2 (AS IT SHOULD BE, ACCORDING TO RESHAPING CODE) ONLY
			// BECAUSE IN THIS CONVOLUTION INPUT AND OUTPUT IMAGE DIMENSIONS ARE THE SAME!!!
			//
			// 1. COMPARE VARs of this and orig multidim
			// 2. MAKE "-n" to vars in result address calculation to compensate
			addr_r_img_mem <= (M3_var[0] + M1_var2[0])*N3_PARAM*C1_PARAM 
			///-------------------------[ATTENTION!!!]----------------------------------------------
			+ (N3_var[0] + N1_var2[0])*C1_PARAM + C1_var4[0] + 10; // !!! be aware of this "+10" !!!	
			//--------------------------------------------------------------------------------------

			addr_w_result0_mem <= M3_var[0]*N3_PARAM + N3_var[0];
			addr_r_result0_mem <= M3_var[0]*N3_PARAM + N3_var[0];
		
			$display ("outp_result0_mem[%0d][%0d][0] = %h",M3_var[0], N3_var[0], outp_result0_mem);
			$display ("kernel_arr_in0[%0d][%0d][%0d][0]*img_mem_arr[%0d+%0d][%0d+%0d][%0d]",
					   M1_var2[0], N1_var2[0], C1_var4[0], M3_var[0], M1_var2[0], N3_var[0], N1_var2[0], C1_var4[0] );
					   
			$display ("mult_temp_w = %h", mult_temp_w_0);
			$display ("mult_temp_w_conc =  %h", mult_temp_w_conc[0]);
			$display ("res_temp_w_conc =   %h", res_temp_w_conc[0]);
			//$display ("result_temp = %b", result_temp);
			$display ("outp_result0_mem[%0d][%0d][0] = %h + %h * %h",
					   M3_var[0], N3_var[0], outp_result0_mem, 
					  dat_read_kernel0_mem,
					   dat_read_img_mem);
			$display (" ");
			if(delay2_done[0] == 1'd1) begin
				N1_var2[0] <= N1_var2[0] + 1;
			end
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
						addr_r_biases_mem <= C1_var4[0] - 2; // there was "-2" kludge!
						C1_var4[0] <= 6'd0;
						N3_var[0] <= N3_var[0] + 1;
						
						$display ("outp_result0_mem[%d][%d][0] = %h",
								   M3_var[0], N3_var[0],outp_result0_mem); //$itor(imgSF*result_mem[M3_var][N3_var][0]));
						$display ("bias[%d] = %h",
											   C1_var4[0]-2, dat_read_biases_mem);
						$display ("------------------------------------------------");
						//result_mem_0[M3_var[0]][N3_var[0]][0]<= res_temp_w_conc[0] + biases_mem[(C1_var4[0]-2)] ;
						//inp_result0_mem <= result_temp[0]; // result temp is AUX signal
						inp_result0_mem <= res_temp_w_conc[0] + dat_read_biases_mem;
						result0 <= dat_read_result0_mem;
						/*
						$display ("result_mem_bias[%d][%d][0] = %b",
								   M3_var[0], N3_var[0],result_mem_0[M3_var[0]][N3_var[0]][0]);	
						$display ("---------------------------------------------------------------------------------------");/**/												
						if (N3_var[0] >= N3_PARAM-1)
						begin
							N3_var[0] <= 8'd0;
							M3_var[0] <= M3_var[0] + 1;
							if (M3_var[0] >= M3_PARAM-1)
							begin
								M3_var[0] <= 8'd0;
								conv_done[0] <= 1'd0;
								en_r_img_mem <= 1'd0;
								en_r_biases_mem <= 1'd0;
								en_r_kernel0_mem <= 1'd0;
								en_w_result0_mem <= 1'd0;
								we_result0_mem <= 1'd0;
							end
						end
					end
				end
			//end
			end
   		end
		
   ////////////////////////
   // For the rest of the convolution threads we don't change control signals for image/biases memories
   // to avoid multidriven nets
   ////////////////////////
   // convolution [1]
   assign mult_temp_w_1 = dat_read_kernel1_mem * dat_read_img_mem;
   assign mult_temp_w_conc[1] = mult_temp_w_1[24:5]; 
   assign res_temp_w_conc[1] = mult_temp_w_conc[1] + dat_read_result1_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[1] <= 10'd1;
       		delay_done[1] <= 1'd0;
       		delay2_cnt[1] <= 10'd1;
			delay2_done[1] <= 1'd0;
       		N1_var2[1] <= 8'd0;
       		M1_var2[1] <= 9'd0;
       		C1_var4[1] <= 6'd0;
       		N3_var[1] <= 9'd0;
			M3_var[1] <= 9'd0;
			//en_r_img1_mem <= 1'd0;
			//addr_r_img1_mem <= 16'd0;
			//en_r_biases_mem <= 1'd0;
			//addr_r_biases_mem <= 16'd0;
			en_r_kernel1_mem <= 1'd0;
			addr_r_kernel1_mem <= 16'd0;
			en_w_result1_mem <= 1'd0;
			we_result1_mem <= 1'd0;
			addr_w_result1_mem <= 16'd0;
			inp_result1_mem <= 16'd0;
			conv_done[1] <= 1'd0;
			result_temp[1] <= 16'd0;// aux reg for $display
			resultset2zero[1] <= 1'd0;
			outp_result1_mem <= 16'd0;
			addr_r_result1_mem <= 1'd0;
			res_temp_conc[1] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[1] == 0)
       	begin
       		en_r_result1_mem <= 1'd1;
			en_w_result1_mem <= 1'd1;
			we_result1_mem <= 1'd1;
			addr_w_result1_mem <= addr_w_result1_mem + 1'd1;
			inp_result1_mem <= 16'd0;
			if ( addr_w_result1_mem >= CONV_ED)
			begin
				addr_w_result1_mem <= 15'd0;
				resultset2zero[1] <= 1'd1;
				we_result1_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[1] == 1 && 
       			biases_recieved == 1 &&	conv_done[1] == 0 &&
       			resultset2zero[1] == 1)
		begin
			//we_img_mem <= 1'd0;
			//en_r_img_mem <= 1'd1;
			//en_r_biases_mem <= 1'd1;
			en_r_kernel1_mem <= 1'd1;
			en_w_result1_mem <= 1'd1;
			we_result1_mem <= 1'd1;
			//artificial delays
			delay_cnt[1] <= delay_cnt[1] + 1;
			delay2_cnt[1] <= delay2_cnt[1] + 1;
			if(delay_cnt[1] >= 10'd6) begin
				delay_done[1] <= 1'd1;
				delay_cnt[1] <= 7'd0;
			end
			if(delay2_cnt[1] >= 10'd6) begin
				delay2_done[1] <= 1'd1;
			end
			if(delay_done[1] == 1'd0) 
			begin
				inp_result1_mem <= 16'd0;
			end
			res_temp_conc[1] <= res_temp_w_conc[1];
			if(delay_done[1] == 1'd1) 
			begin
				inp_result1_mem <= res_temp_conc[1];
			end
			addr_r_kernel1_mem <= (M1_var2[1])*M1_PARAM*C1_PARAM + (N1_var2[1])*C1_PARAM + (C1_var4[1]) + 1;
			//addr_r_img_mem <= (M3_var[0] + M1_var2[0])*N3_PARAM*C1_PARAM 
			//+ (N3_var[0] + N1_var2[0])*C1_PARAM + C1_var4[0] + 10;
			addr_w_result1_mem <= M3_var[1]*N3_PARAM + N3_var[1];
			addr_r_result1_mem <= M3_var[1]*N3_PARAM + N3_var[1];
			if(delay2_done[1] == 1'd1) begin
				N1_var2[1] <= N1_var2[1] + 1;
			end
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
						//addr_r_biases_mem <= C1_var4[0] - 2; 
						C1_var4[1] <= 6'd0;
						N3_var[1] <= N3_var[1] + 1;
						inp_result1_mem <= res_temp_w_conc[1] + dat_read_biases_mem;				
						result1 <= dat_read_result1_mem;							
						if (N3_var[1] >= N3_PARAM-1)
						begin
							N3_var[1] <= 8'd0;
							M3_var[1] <= M3_var[1] + 1;
							if (M3_var[1] >= M3_PARAM-1)
							begin
								conv_done[1] <= 1'd0;
								//en_r_img_mem <= 1'd0;
								//en_r_biases_mem <= 1'd0;
								en_r_kernel1_mem <= 1'd0;
								en_w_result1_mem <= 1'd0;
								we_result1_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end


   ////////////////////////
   // convolution [2]
   assign mult_temp_w_2 = dat_read_kernel2_mem * dat_read_img_mem;
   assign mult_temp_w_conc[2] = mult_temp_w_2[24:5]; 
   assign res_temp_w_conc[2] = mult_temp_w_conc[2] + dat_read_result2_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[2] <= 10'd1;
       		delay_done[2] <= 1'd0;
       		delay2_cnt[2] <= 10'd1;
			delay2_done[2] <= 1'd0;
       		N1_var2[2] <= 8'd0;
       		M1_var2[2] <= 9'd0;
       		C1_var4[2] <= 6'd0;
       		N3_var[2] <= 9'd0;
			M3_var[2] <= 9'd0;
			en_r_kernel2_mem <= 1'd0;
			addr_r_kernel2_mem <= 16'd0;
			en_w_result2_mem <= 1'd0;
			we_result2_mem <= 1'd0;
			addr_w_result2_mem <= 16'd0;
			inp_result2_mem <= 16'd0;
			conv_done[2] <= 1'd0;
			result_temp[2] <= 16'd0;// aux reg for $display
			resultset2zero[2] <= 1'd0;
			outp_result2_mem <= 16'd0;
			addr_r_result2_mem <= 1'd0;
			res_temp_conc[2] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[2] == 0)
       	begin
       		en_r_result2_mem <= 1'd1;
			en_w_result2_mem <= 1'd1;
			we_result2_mem <= 1'd1;
			addr_w_result2_mem <= addr_w_result2_mem + 1'd1;
			inp_result2_mem <= 16'd0;
			if ( addr_w_result2_mem >= CONV_ED)
			begin
				addr_w_result2_mem <= 15'd0;
				resultset2zero[2] <= 1'd1;
				we_result2_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[2] == 1 && 
       			biases_recieved == 1 &&	conv_done[2] == 0 &&
       			resultset2zero[2] == 1)
		begin
			en_r_kernel2_mem <= 1'd1;
			en_w_result2_mem <= 1'd1;
			we_result2_mem <= 1'd1;
			//artificial delays
			delay_cnt[2] <= delay_cnt[2] + 1;
			delay2_cnt[2] <= delay2_cnt[2] + 1;
			if(delay_cnt[2] >= 10'd6) begin
				delay_done[2] <= 1'd1;
				delay_cnt[2] <= 7'd0;
			end
			if(delay2_cnt[2] >= 10'd6) begin
				delay2_done[2] <= 1'd1;
			end
			if(delay_done[2] == 1'd0) 
			begin
				inp_result2_mem <= 16'd0;
			end
			res_temp_conc[2] <= res_temp_w_conc[2];
			if(delay_done[2] == 1'd1) 
			begin
				inp_result2_mem <= res_temp_conc[2];
			end
			addr_r_kernel2_mem <= (M1_var2[2])*M1_PARAM*C1_PARAM + (N1_var2[2])*C1_PARAM + (C1_var4[2]) + 1;
			addr_w_result2_mem <= M3_var[2]*N3_PARAM + N3_var[2];
			addr_r_result2_mem <= M3_var[2]*N3_PARAM + N3_var[2];
			if(delay2_done[2] == 1'd1) begin
				N1_var2[2] <= N1_var2[2] + 1;
			end
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
						inp_result2_mem <= res_temp_w_conc[2] + dat_read_biases_mem;	
						result2 <= dat_read_result2_mem;										
						if (N3_var[2] >= N3_PARAM-1)
						begin
							N3_var[2] <= 8'd0;
							M3_var[2] <= M3_var[2] + 1;
							if (M3_var[2] >= M3_PARAM-1)
							begin
								conv_done[2] <= 1'd0;
								en_r_kernel2_mem <= 1'd0;
								en_w_result2_mem <= 1'd0;
								we_result2_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [3]
   assign mult_temp_w_3 = dat_read_kernel3_mem * dat_read_img_mem;
   assign mult_temp_w_conc[3] = mult_temp_w_3[24:5]; 
   assign res_temp_w_conc[3] = mult_temp_w_conc[3] + dat_read_result3_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[3] <= 10'd1;
       		delay_done[3] <= 1'd0;
       		delay2_cnt[3] <= 10'd1;
			delay2_done[3] <= 1'd0;
       		N1_var2[3] <= 8'd0;
       		M1_var2[3] <= 9'd0;
       		C1_var4[3] <= 6'd0;
       		N3_var[3] <= 9'd0;
			M3_var[3] <= 9'd0;
			en_r_kernel3_mem <= 1'd0;
			addr_r_kernel3_mem <= 16'd0;
			en_w_result3_mem <= 1'd0;
			we_result3_mem <= 1'd0;
			addr_w_result3_mem <= 16'd0;
			inp_result3_mem <= 16'd0;
			conv_done[3] <= 1'd0;
			result_temp[3] <= 16'd0;// aux reg for $display
			resultset2zero[3] <= 1'd0;
			outp_result3_mem <= 16'd0;
			addr_r_result3_mem <= 1'd0;
			res_temp_conc[3] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[3] == 0)
       	begin
       		en_r_result3_mem <= 1'd1;
			en_w_result3_mem <= 1'd1;
			we_result3_mem <= 1'd1;
			addr_w_result3_mem <= addr_w_result3_mem + 1'd1;
			inp_result3_mem <= 16'd0;
			if ( addr_w_result3_mem >= CONV_ED)
			begin
				addr_w_result3_mem <= 15'd0;
				resultset2zero[3] <= 1'd1;
				we_result3_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[3] == 1 && 
       			biases_recieved == 1 &&	conv_done[3] == 0 &&
       			resultset2zero[3] == 1)
		begin
			en_r_kernel3_mem <= 1'd1;
			en_w_result3_mem <= 1'd1;
			we_result3_mem <= 1'd1;
			//artificial delays
			delay_cnt[3] <= delay_cnt[3] + 1;
			delay2_cnt[3] <= delay2_cnt[3] + 1;
			if(delay_cnt[3] >= 10'd6) begin
				delay_done[3] <= 1'd1;
				delay_cnt[3] <= 7'd0;
			end
			if(delay2_cnt[3] >= 10'd6) begin
				delay2_done[3] <= 1'd1;
			end
			if(delay_done[3] == 1'd0) 
			begin
				inp_result3_mem <= 16'd0;
			end
			res_temp_conc[3] <= res_temp_w_conc[3];
			if(delay_done[3] == 1'd1) 
			begin
				inp_result3_mem <= res_temp_conc[3];
			end
			addr_r_kernel3_mem <= (M1_var2[3])*M1_PARAM*C1_PARAM + (N1_var2[3])*C1_PARAM + (C1_var4[3]) + 1;
			addr_w_result3_mem <= M3_var[3]*N3_PARAM + N3_var[3];
			addr_r_result3_mem <= M3_var[3]*N3_PARAM + N3_var[3];
			if(delay2_done[3] == 1'd1) begin
				N1_var2[3] <= N1_var2[3] + 1;
			end
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
						inp_result3_mem <= res_temp_w_conc[3] + dat_read_biases_mem;	
						result3 <= dat_read_result3_mem;										
						if (N3_var[3] >= N3_PARAM-1)
						begin
							N3_var[3] <= 8'd0;
							M3_var[3] <= M3_var[3] + 1;
							if (M3_var[3] >= M3_PARAM-1)
							begin
								conv_done[3] <= 1'd0;
								en_r_kernel3_mem <= 1'd0;
								en_w_result3_mem <= 1'd0;
								we_result3_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [4]
   assign mult_temp_w_4 = dat_read_kernel4_mem * dat_read_img_mem;
   assign mult_temp_w_conc[4] = mult_temp_w_4[24:5]; 
   assign res_temp_w_conc[4] = mult_temp_w_conc[4] + dat_read_result4_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[4] <= 10'd1;
       		delay_done[4] <= 1'd0;
       		delay2_cnt[4] <= 10'd1;
			delay2_done[4] <= 1'd0;
       		N1_var2[4] <= 8'd0;
       		M1_var2[4] <= 9'd0;
       		C1_var4[4] <= 6'd0;
       		N3_var[4] <= 9'd0;
			M3_var[4] <= 9'd0;
			en_r_kernel4_mem <= 1'd0;
			addr_r_kernel4_mem <= 16'd0;
			en_w_result4_mem <= 1'd0;
			we_result4_mem <= 1'd0;
			addr_w_result4_mem <= 16'd0;
			inp_result4_mem <= 16'd0;
			conv_done[4] <= 1'd0;
			result_temp[4] <= 16'd0;// aux reg for $display
			resultset2zero[4] <= 1'd0;
			outp_result4_mem <= 16'd0;
			addr_r_result4_mem <= 1'd0;
			res_temp_conc[4] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[4] == 0)
       	begin
       		en_r_result4_mem <= 1'd1;
			en_w_result4_mem <= 1'd1;
			we_result4_mem <= 1'd1;
			addr_w_result4_mem <= addr_w_result4_mem + 1'd1;
			inp_result4_mem <= 16'd0;
			if ( addr_w_result4_mem >= CONV_ED)
			begin
				addr_w_result4_mem <= 15'd0;
				resultset2zero[4] <= 1'd1;
				we_result4_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[4] == 1 && 
       			biases_recieved == 1 &&	conv_done[4] == 0 &&
       			resultset2zero[4] == 1)
		begin
			en_r_kernel4_mem <= 1'd1;
			en_w_result4_mem <= 1'd1;
			we_result4_mem <= 1'd1;
			//artificial delays
			delay_cnt[4] <= delay_cnt[4] + 1;
			delay2_cnt[4] <= delay2_cnt[4] + 1;
			if(delay_cnt[4] >= 10'd6) begin
				delay_done[4] <= 1'd1;
				delay_cnt[4] <= 7'd0;
			end
			if(delay2_cnt[4] >= 10'd6) begin
				delay2_done[4] <= 1'd1;
			end
			if(delay_done[4] == 1'd0) 
			begin
				inp_result4_mem <= 16'd0;
			end
			res_temp_conc[4] <= res_temp_w_conc[4];
			if(delay_done[4] == 1'd1) 
			begin
				inp_result4_mem <= res_temp_conc[4];
			end
			addr_r_kernel4_mem <= (M1_var2[4])*M1_PARAM*C1_PARAM + (N1_var2[4])*C1_PARAM + (C1_var4[4]) + 1;
			addr_w_result4_mem <= M3_var[4]*N3_PARAM + N3_var[4];
			addr_r_result4_mem <= M3_var[4]*N3_PARAM + N3_var[4];
			if(delay2_done[4] == 1'd1) begin
				N1_var2[4] <= N1_var2[4] + 1;
			end
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
						inp_result4_mem <= res_temp_w_conc[4] + dat_read_biases_mem;	
						result4 <= dat_read_result4_mem;										
						if (N3_var[4] >= N3_PARAM-1)
						begin
							N3_var[4] <= 8'd0;
							M3_var[4] <= M3_var[4] + 1;
							if (M3_var[4] >= M3_PARAM-1)
							begin
								conv_done[4] <= 1'd0;
								en_r_kernel4_mem <= 1'd0;
								en_w_result4_mem <= 1'd0;
								we_result4_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [5]
   assign mult_temp_w_5 = dat_read_kernel5_mem * dat_read_img_mem;
   assign mult_temp_w_conc[5] = mult_temp_w_5[24:5]; 
   assign res_temp_w_conc[5] = mult_temp_w_conc[5] + dat_read_result5_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[5] <= 10'd1;
       		delay_done[5] <= 1'd0;
       		delay2_cnt[5] <= 10'd1;
			delay2_done[5] <= 1'd0;
       		N1_var2[5] <= 8'd0;
       		M1_var2[5] <= 9'd0;
       		C1_var4[5] <= 6'd0;
       		N3_var[5] <= 9'd0;
			M3_var[5] <= 9'd0;
			en_r_kernel5_mem <= 1'd0;
			addr_r_kernel5_mem <= 16'd0;
			en_w_result5_mem <= 1'd0;
			we_result5_mem <= 1'd0;
			addr_w_result5_mem <= 16'd0;
			inp_result5_mem <= 16'd0;
			conv_done[5] <= 1'd0;
			result_temp[5] <= 16'd0;// aux reg for $display
			resultset2zero[5] <= 1'd0;
			outp_result5_mem <= 16'd0;
			addr_r_result5_mem <= 1'd0;
			res_temp_conc[5] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[5] == 0)
       	begin
       		en_r_result5_mem <= 1'd1;
			en_w_result5_mem <= 1'd1;
			we_result5_mem <= 1'd1;
			addr_w_result5_mem <= addr_w_result5_mem + 1'd1;
			inp_result5_mem <= 16'd0;
			if ( addr_w_result5_mem >= CONV_ED)
			begin
				addr_w_result5_mem <= 15'd0;
				resultset2zero[5] <= 1'd1;
				we_result5_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[5] == 1 && 
       			biases_recieved == 1 &&	conv_done[5] == 0 &&
       			resultset2zero[5] == 1)
		begin
			en_r_kernel5_mem <= 1'd1;
			en_w_result5_mem <= 1'd1;
			we_result5_mem <= 1'd1;
			//artificial delays
			delay_cnt[5] <= delay_cnt[5] + 1;
			delay2_cnt[5] <= delay2_cnt[5] + 1;
			if(delay_cnt[5] >= 10'd6) begin
				delay_done[5] <= 1'd1;
				delay_cnt[5] <= 7'd0;
			end
			if(delay2_cnt[5] >= 10'd6) begin
				delay2_done[5] <= 1'd1;
			end
			if(delay_done[5] == 1'd0) 
			begin
				inp_result5_mem <= 16'd0;
			end
			res_temp_conc[5] <= res_temp_w_conc[5];
			if(delay_done[5] == 1'd1) 
			begin
				inp_result5_mem <= res_temp_conc[5];
			end
			addr_r_kernel5_mem <= (M1_var2[5])*M1_PARAM*C1_PARAM + (N1_var2[5])*C1_PARAM + (C1_var4[5]) + 1;
			addr_w_result5_mem <= M3_var[5]*N3_PARAM + N3_var[5];
			addr_r_result5_mem <= M3_var[5]*N3_PARAM + N3_var[5];
			if(delay2_done[5] == 1'd1) begin
				N1_var2[5] <= N1_var2[5] + 1;
			end
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
						inp_result5_mem <= res_temp_w_conc[5] + dat_read_biases_mem;	
						result5 <= dat_read_result5_mem;										
						if (N3_var[5] >= N3_PARAM-1)
						begin
							N3_var[5] <= 8'd0;
							M3_var[5] <= M3_var[5] + 1;
							if (M3_var[5] >= M3_PARAM-1)
							begin
								conv_done[5] <= 1'd0;
								en_r_kernel5_mem <= 1'd0;
								en_w_result5_mem <= 1'd0;
								we_result5_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [6]
   assign mult_temp_w_6 = dat_read_kernel6_mem * dat_read_img_mem;
   assign mult_temp_w_conc[6] = mult_temp_w_6[24:5]; 
   assign res_temp_w_conc[6] = mult_temp_w_conc[6] + dat_read_result6_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[6] <= 10'd1;
       		delay_done[6] <= 1'd0;
       		delay2_cnt[6] <= 10'd1;
			delay2_done[6] <= 1'd0;
       		N1_var2[6] <= 8'd0;
       		M1_var2[6] <= 9'd0;
       		C1_var4[6] <= 6'd0;
       		N3_var[6] <= 9'd0;
			M3_var[6] <= 9'd0;
			en_r_kernel6_mem <= 1'd0;
			addr_r_kernel6_mem <= 16'd0;
			en_w_result6_mem <= 1'd0;
			we_result6_mem <= 1'd0;
			addr_w_result6_mem <= 16'd0;
			inp_result6_mem <= 16'd0;
			conv_done[6] <= 1'd0;
			result_temp[6] <= 16'd0;// aux reg for $display
			resultset2zero[6] <= 1'd0;
			outp_result6_mem <= 16'd0;
			addr_r_result6_mem <= 1'd0;
			res_temp_conc[6] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[6] == 0)
       	begin
       		en_r_result6_mem <= 1'd1;
			en_w_result6_mem <= 1'd1;
			we_result6_mem <= 1'd1;
			addr_w_result6_mem <= addr_w_result6_mem + 1'd1;
			inp_result6_mem <= 16'd0;
			if ( addr_w_result6_mem >= CONV_ED)
			begin
				addr_w_result6_mem <= 15'd0;
				resultset2zero[6] <= 1'd1;
				we_result6_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[6] == 1 && 
       			biases_recieved == 1 &&	conv_done[6] == 0 &&
       			resultset2zero[6] == 1)
		begin
			en_r_kernel6_mem <= 1'd1;
			en_w_result6_mem <= 1'd1;
			we_result6_mem <= 1'd1;
			//artificial delays
			delay_cnt[6] <= delay_cnt[6] + 1;
			delay2_cnt[6] <= delay2_cnt[6] + 1;
			if(delay_cnt[6] >= 10'd6) begin
				delay_done[6] <= 1'd1;
				delay_cnt[6] <= 7'd0;
			end
			if(delay2_cnt[6] >= 10'd6) begin
				delay2_done[6] <= 1'd1;
			end
			if(delay_done[6] == 1'd0) 
			begin
				inp_result6_mem <= 16'd0;
			end
			res_temp_conc[6] <= res_temp_w_conc[6];
			if(delay_done[6] == 1'd1) 
			begin
				inp_result6_mem <= res_temp_conc[6];
			end
			addr_r_kernel6_mem <= (M1_var2[6])*M1_PARAM*C1_PARAM + (N1_var2[6])*C1_PARAM + (C1_var4[6]) + 1;
			addr_w_result6_mem <= M3_var[6]*N3_PARAM + N3_var[6];
			addr_r_result6_mem <= M3_var[6]*N3_PARAM + N3_var[6];
			if(delay2_done[6] == 1'd1) begin
				N1_var2[6] <= N1_var2[6] + 1;
			end
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
						inp_result6_mem <= res_temp_w_conc[6] + dat_read_biases_mem;	
						result6 <= dat_read_result6_mem;										
						if (N3_var[6] >= N3_PARAM-1)
						begin
							N3_var[6] <= 8'd0;
							M3_var[6] <= M3_var[6] + 1;
							if (M3_var[6] >= M3_PARAM-1)
							begin
								conv_done[6] <= 1'd0;
								en_r_kernel6_mem <= 1'd0;
								en_w_result6_mem <= 1'd0;
								we_result6_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [7]
   assign mult_temp_w_7 = dat_read_kernel7_mem * dat_read_img_mem;
   assign mult_temp_w_conc[7] = mult_temp_w_7[24:5]; 
   assign res_temp_w_conc[7] = mult_temp_w_conc[7] + dat_read_result7_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[7] <= 10'd1;
       		delay_done[7] <= 1'd0;
       		delay2_cnt[7] <= 10'd1;
			delay2_done[7] <= 1'd0;
       		N1_var2[7] <= 8'd0;
       		M1_var2[7] <= 9'd0;
       		C1_var4[7] <= 6'd0;
       		N3_var[7] <= 9'd0;
			M3_var[7] <= 9'd0;
			en_r_kernel7_mem <= 1'd0;
			addr_r_kernel7_mem <= 16'd0;
			en_w_result7_mem <= 1'd0;
			we_result7_mem <= 1'd0;
			addr_w_result7_mem <= 16'd0;
			inp_result7_mem <= 16'd0;
			conv_done[7] <= 1'd0;
			result_temp[7] <= 16'd0;// aux reg for $display
			resultset2zero[7] <= 1'd0;
			outp_result7_mem <= 16'd0;
			addr_r_result7_mem <= 1'd0;
			res_temp_conc[7] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[7] == 0)
       	begin
       		en_r_result7_mem <= 1'd1;
			en_w_result7_mem <= 1'd1;
			we_result7_mem <= 1'd1;
			addr_w_result7_mem <= addr_w_result7_mem + 1'd1;
			inp_result7_mem <= 16'd0;
			if ( addr_w_result7_mem >= CONV_ED)
			begin
				addr_w_result7_mem <= 15'd0;
				resultset2zero[7] <= 1'd1;
				we_result7_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[7] == 1 && 
       			biases_recieved == 1 &&	conv_done[7] == 0 &&
       			resultset2zero[7] == 1)
		begin
			en_r_kernel7_mem <= 1'd1;
			en_w_result7_mem <= 1'd1;
			we_result7_mem <= 1'd1;
			//artificial delays
			delay_cnt[7] <= delay_cnt[7] + 1;
			delay2_cnt[7] <= delay2_cnt[7] + 1;
			if(delay_cnt[7] >= 10'd6) begin
				delay_done[7] <= 1'd1;
				delay_cnt[7] <= 7'd0;
			end
			if(delay2_cnt[7] >= 10'd6) begin
				delay2_done[7] <= 1'd1;
			end
			if(delay_done[7] == 1'd0) 
			begin
				inp_result7_mem <= 16'd0;
			end
			res_temp_conc[7] <= res_temp_w_conc[7];
			if(delay_done[7] == 1'd1) 
			begin
				inp_result7_mem <= res_temp_conc[7];
			end
			addr_r_kernel7_mem <= (M1_var2[7])*M1_PARAM*C1_PARAM + (N1_var2[7])*C1_PARAM + (C1_var4[7]) + 1;
			addr_w_result7_mem <= M3_var[7]*N3_PARAM + N3_var[7];
			addr_r_result7_mem <= M3_var[7]*N3_PARAM + N3_var[7];
			if(delay2_done[7] == 1'd1) begin
				N1_var2[7] <= N1_var2[7] + 1;
			end
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
						inp_result7_mem <= res_temp_w_conc[7] + dat_read_biases_mem;	
						result7 <= dat_read_result7_mem;										
						if (N3_var[7] >= N3_PARAM-1)
						begin
							N3_var[7] <= 8'd0;
							M3_var[7] <= M3_var[7] + 1;
							if (M3_var[7] >= M3_PARAM-1)
							begin
								conv_done[7] <= 1'd0;
								en_r_kernel7_mem <= 1'd0;
								en_w_result7_mem <= 1'd0;
								we_result7_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [8]
   assign mult_temp_w_8 = dat_read_kernel8_mem * dat_read_img_mem;
   assign mult_temp_w_conc[8] = mult_temp_w_8[24:5]; 
   assign res_temp_w_conc[8] = mult_temp_w_conc[8] + dat_read_result8_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[8] <= 10'd1;
       		delay_done[8] <= 1'd0;
       		delay2_cnt[8] <= 10'd1;
			delay2_done[8] <= 1'd0;
       		N1_var2[8] <= 8'd0;
       		M1_var2[8] <= 9'd0;
       		C1_var4[8] <= 6'd0;
       		N3_var[8] <= 9'd0;
			M3_var[8] <= 9'd0;
			en_r_kernel8_mem <= 1'd0;
			addr_r_kernel8_mem <= 16'd0;
			en_w_result8_mem <= 1'd0;
			we_result8_mem <= 1'd0;
			addr_w_result8_mem <= 16'd0;
			inp_result8_mem <= 16'd0;
			conv_done[8] <= 1'd0;
			result_temp[8] <= 16'd0;// aux reg for $display
			resultset2zero[8] <= 1'd0;
			outp_result8_mem <= 16'd0;
			addr_r_result8_mem <= 1'd0;
			res_temp_conc[8] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[8] == 0)
       	begin
       		en_r_result8_mem <= 1'd1;
			en_w_result8_mem <= 1'd1;
			we_result8_mem <= 1'd1;
			addr_w_result8_mem <= addr_w_result8_mem + 1'd1;
			inp_result8_mem <= 16'd0;
			if ( addr_w_result8_mem >= CONV_ED)
			begin
				addr_w_result8_mem <= 15'd0;
				resultset2zero[8] <= 1'd1;
				we_result8_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[8] == 1 && 
       			biases_recieved == 1 &&	conv_done[8] == 0 &&
       			resultset2zero[8] == 1)
		begin
			en_r_kernel8_mem <= 1'd1;
			en_w_result8_mem <= 1'd1;
			we_result8_mem <= 1'd1;
			//artificial delays
			delay_cnt[8] <= delay_cnt[8] + 1;
			delay2_cnt[8] <= delay2_cnt[8] + 1;
			if(delay_cnt[8] >= 10'd6) begin
				delay_done[8] <= 1'd1;
				delay_cnt[8] <= 7'd0;
			end
			if(delay2_cnt[8] >= 10'd6) begin
				delay2_done[8] <= 1'd1;
			end
			if(delay_done[8] == 1'd0) 
			begin
				inp_result8_mem <= 16'd0;
			end
			res_temp_conc[8] <= res_temp_w_conc[8];
			if(delay_done[8] == 1'd1) 
			begin
				inp_result8_mem <= res_temp_conc[8];
			end
			addr_r_kernel8_mem <= (M1_var2[8])*M1_PARAM*C1_PARAM + (N1_var2[8])*C1_PARAM + (C1_var4[8]) + 1;
			addr_w_result8_mem <= M3_var[8]*N3_PARAM + N3_var[8];
			addr_r_result8_mem <= M3_var[8]*N3_PARAM + N3_var[8];
			if(delay2_done[8] == 1'd1) begin
				N1_var2[8] <= N1_var2[8] + 1;
			end
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
						inp_result8_mem <= res_temp_w_conc[8] + dat_read_biases_mem;	
						result8 <= dat_read_result8_mem;										
						if (N3_var[8] >= N3_PARAM-1)
						begin
							N3_var[8] <= 8'd0;
							M3_var[8] <= M3_var[8] + 1;
							if (M3_var[8] >= M3_PARAM-1)
							begin
								conv_done[8] <= 1'd0;
								en_r_kernel8_mem <= 1'd0;
								en_w_result8_mem <= 1'd0;
								we_result8_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [9]
   assign mult_temp_w_9 = dat_read_kernel9_mem * dat_read_img_mem;
   assign mult_temp_w_conc[9] = mult_temp_w_9[24:5]; 
   assign res_temp_w_conc[9] = mult_temp_w_conc[9] + dat_read_result9_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[9] <= 10'd1;
       		delay_done[9] <= 1'd0;
       		delay2_cnt[9] <= 10'd1;
			delay2_done[9] <= 1'd0;
       		N1_var2[9] <= 8'd0;
       		M1_var2[9] <= 9'd0;
       		C1_var4[9] <= 6'd0;
       		N3_var[9] <= 9'd0;
			M3_var[9] <= 9'd0;
			en_r_kernel9_mem <= 1'd0;
			addr_r_kernel9_mem <= 16'd0;
			en_w_result9_mem <= 1'd0;
			we_result9_mem <= 1'd0;
			addr_w_result9_mem <= 16'd0;
			inp_result9_mem <= 16'd0;
			conv_done[9] <= 1'd0;
			result_temp[9] <= 16'd0;// aux reg for $display
			resultset2zero[9] <= 1'd0;
			outp_result9_mem <= 16'd0;
			addr_r_result9_mem <= 1'd0;
			res_temp_conc[9] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[9] == 0)
       	begin
       		en_r_result9_mem <= 1'd1;
			en_w_result9_mem <= 1'd1;
			we_result9_mem <= 1'd1;
			addr_w_result9_mem <= addr_w_result9_mem + 1'd1;
			inp_result9_mem <= 16'd0;
			if ( addr_w_result9_mem >= CONV_ED)
			begin
				addr_w_result9_mem <= 15'd0;
				resultset2zero[9] <= 1'd1;
				we_result9_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[9] == 1 && 
       			biases_recieved == 1 &&	conv_done[9] == 0 &&
       			resultset2zero[9] == 1)
		begin
			en_r_kernel9_mem <= 1'd1;
			en_w_result9_mem <= 1'd1;
			we_result9_mem <= 1'd1;
			//artificial delays
			delay_cnt[9] <= delay_cnt[9] + 1;
			delay2_cnt[9] <= delay2_cnt[9] + 1;
			if(delay_cnt[9] >= 10'd6) begin
				delay_done[9] <= 1'd1;
				delay_cnt[9] <= 7'd0;
			end
			if(delay2_cnt[9] >= 10'd6) begin
				delay2_done[9] <= 1'd1;
			end
			if(delay_done[9] == 1'd0) 
			begin
				inp_result9_mem <= 16'd0;
			end
			res_temp_conc[9] <= res_temp_w_conc[9];
			if(delay_done[9] == 1'd1) 
			begin
				inp_result9_mem <= res_temp_conc[9];
			end
			addr_r_kernel9_mem <= (M1_var2[9])*M1_PARAM*C1_PARAM + (N1_var2[9])*C1_PARAM + (C1_var4[9]) + 1;
			addr_w_result9_mem <= M3_var[9]*N3_PARAM + N3_var[9];
			addr_r_result9_mem <= M3_var[9]*N3_PARAM + N3_var[9];
			if(delay2_done[9] == 1'd1) begin
				N1_var2[9] <= N1_var2[9] + 1;
			end
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
						inp_result9_mem <= res_temp_w_conc[9] + dat_read_biases_mem;	
						result9 <= dat_read_result9_mem;										
						if (N3_var[9] >= N3_PARAM-1)
						begin
							N3_var[9] <= 8'd0;
							M3_var[9] <= M3_var[9] + 1;
							if (M3_var[9] >= M3_PARAM-1)
							begin
								conv_done[9] <= 1'd0;
								en_r_kernel9_mem <= 1'd0;
								en_w_result9_mem <= 1'd0;
								we_result9_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [10]
   assign mult_temp_w_10 = dat_read_kernel10_mem * dat_read_img_mem;
   assign mult_temp_w_conc[10] = mult_temp_w_10[24:5]; 
   assign res_temp_w_conc[10] = mult_temp_w_conc[10] + dat_read_result10_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[10] <= 10'd1;
       		delay_done[10] <= 1'd0;
       		delay2_cnt[10] <= 10'd1;
			delay2_done[10] <= 1'd0;
       		N1_var2[10] <= 8'd0;
       		M1_var2[10] <= 9'd0;
       		C1_var4[10] <= 6'd0;
       		N3_var[10] <= 9'd0;
			M3_var[10] <= 9'd0;
			en_r_kernel10_mem <= 1'd0;
			addr_r_kernel10_mem <= 16'd0;
			en_w_result10_mem <= 1'd0;
			we_result10_mem <= 1'd0;
			addr_w_result10_mem <= 16'd0;
			inp_result10_mem <= 16'd0;
			conv_done[10] <= 1'd0;
			result_temp[10] <= 16'd0;// aux reg for $display
			resultset2zero[10] <= 1'd0;
			outp_result10_mem <= 16'd0;
			addr_r_result10_mem <= 1'd0;
			res_temp_conc[10] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[10] == 0)
       	begin
       		en_r_result10_mem <= 1'd1;
			en_w_result10_mem <= 1'd1;
			we_result10_mem <= 1'd1;
			addr_w_result10_mem <= addr_w_result10_mem + 1'd1;
			inp_result10_mem <= 16'd0;
			if ( addr_w_result10_mem >= CONV_ED)
			begin
				addr_w_result10_mem <= 15'd0;
				resultset2zero[10] <= 1'd1;
				we_result10_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[10] == 1 && 
       			biases_recieved == 1 &&	conv_done[10] == 0 &&
       			resultset2zero[10] == 1)
		begin
			en_r_kernel10_mem <= 1'd1;
			en_w_result10_mem <= 1'd1;
			we_result10_mem <= 1'd1;
			//artificial delays
			delay_cnt[10] <= delay_cnt[10] + 1;
			delay2_cnt[10] <= delay2_cnt[10] + 1;
			if(delay_cnt[10] >= 10'd6) begin
				delay_done[10] <= 1'd1;
				delay_cnt[10] <= 7'd0;
			end
			if(delay2_cnt[10] >= 10'd6) begin
				delay2_done[10] <= 1'd1;
			end
			if(delay_done[10] == 1'd0) 
			begin
				inp_result10_mem <= 16'd0;
			end
			res_temp_conc[10] <= res_temp_w_conc[10];
			if(delay_done[10] == 1'd1) 
			begin
				inp_result10_mem <= res_temp_conc[10];
			end
			addr_r_kernel10_mem <= (M1_var2[10])*M1_PARAM*C1_PARAM + (N1_var2[10])*C1_PARAM + (C1_var4[10]) + 1;
			addr_w_result10_mem <= M3_var[10]*N3_PARAM + N3_var[10];
			addr_r_result10_mem <= M3_var[10]*N3_PARAM + N3_var[10];
			if(delay2_done[10] == 1'd1) begin
				N1_var2[10] <= N1_var2[10] + 1;
			end
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
						inp_result10_mem <= res_temp_w_conc[10] + dat_read_biases_mem;	
						result10 <= dat_read_result10_mem;										
						if (N3_var[10] >= N3_PARAM-1)
						begin
							N3_var[10] <= 8'd0;
							M3_var[10] <= M3_var[10] + 1;
							if (M3_var[10] >= M3_PARAM-1)
							begin
								conv_done[10] <= 1'd0;
								en_r_kernel10_mem <= 1'd0;
								en_w_result10_mem <= 1'd0;
								we_result10_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [11]
   assign mult_temp_w_11 = dat_read_kernel11_mem * dat_read_img_mem;
   assign mult_temp_w_conc[11] = mult_temp_w_11[24:5]; 
   assign res_temp_w_conc[11] = mult_temp_w_conc[11] + dat_read_result11_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[11] <= 10'd1;
       		delay_done[11] <= 1'd0;
       		delay2_cnt[11] <= 10'd1;
			delay2_done[11] <= 1'd0;
       		N1_var2[11] <= 8'd0;
       		M1_var2[11] <= 9'd0;
       		C1_var4[11] <= 6'd0;
       		N3_var[11] <= 9'd0;
			M3_var[11] <= 9'd0;
			en_r_kernel11_mem <= 1'd0;
			addr_r_kernel11_mem <= 16'd0;
			en_w_result11_mem <= 1'd0;
			we_result11_mem <= 1'd0;
			addr_w_result11_mem <= 16'd0;
			inp_result11_mem <= 16'd0;
			conv_done[11] <= 1'd0;
			result_temp[11] <= 16'd0;// aux reg for $display
			resultset2zero[11] <= 1'd0;
			outp_result11_mem <= 16'd0;
			addr_r_result11_mem <= 1'd0;
			res_temp_conc[11] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[11] == 0)
       	begin
       		en_r_result11_mem <= 1'd1;
			en_w_result11_mem <= 1'd1;
			we_result11_mem <= 1'd1;
			addr_w_result11_mem <= addr_w_result11_mem + 1'd1;
			inp_result11_mem <= 16'd0;
			if ( addr_w_result11_mem >= CONV_ED)
			begin
				addr_w_result11_mem <= 15'd0;
				resultset2zero[11] <= 1'd1;
				we_result11_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[11] == 1 && 
       			biases_recieved == 1 &&	conv_done[11] == 0 &&
       			resultset2zero[11] == 1)
		begin
			en_r_kernel11_mem <= 1'd1;
			en_w_result11_mem <= 1'd1;
			we_result11_mem <= 1'd1;
			//artificial delays
			delay_cnt[11] <= delay_cnt[11] + 1;
			delay2_cnt[11] <= delay2_cnt[11] + 1;
			if(delay_cnt[11] >= 10'd6) begin
				delay_done[11] <= 1'd1;
				delay_cnt[11] <= 7'd0;
			end
			if(delay2_cnt[11] >= 10'd6) begin
				delay2_done[11] <= 1'd1;
			end
			if(delay_done[11] == 1'd0) 
			begin
				inp_result11_mem <= 16'd0;
			end
			res_temp_conc[11] <= res_temp_w_conc[11];
			if(delay_done[11] == 1'd1) 
			begin
				inp_result11_mem <= res_temp_conc[11];
			end
			addr_r_kernel11_mem <= (M1_var2[11])*M1_PARAM*C1_PARAM + (N1_var2[11])*C1_PARAM + (C1_var4[11]) + 1;
			addr_w_result11_mem <= M3_var[11]*N3_PARAM + N3_var[11];
			addr_r_result11_mem <= M3_var[11]*N3_PARAM + N3_var[11];
			if(delay2_done[11] == 1'd1) begin
				N1_var2[11] <= N1_var2[11] + 1;
			end
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
						inp_result11_mem <= res_temp_w_conc[11] + dat_read_biases_mem;	
						result11 <= dat_read_result11_mem;										
						if (N3_var[11] >= N3_PARAM-1)
						begin
							N3_var[11] <= 8'd0;
							M3_var[11] <= M3_var[11] + 1;
							if (M3_var[11] >= M3_PARAM-1)
							begin
								conv_done[11] <= 1'd0;
								en_r_kernel11_mem <= 1'd0;
								en_w_result11_mem <= 1'd0;
								we_result11_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [12]
   assign mult_temp_w_12 = dat_read_kernel12_mem * dat_read_img_mem;
   assign mult_temp_w_conc[12] = mult_temp_w_12[24:5]; 
   assign res_temp_w_conc[12] = mult_temp_w_conc[12] + dat_read_result12_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[12] <= 10'd1;
       		delay_done[12] <= 1'd0;
       		delay2_cnt[12] <= 10'd1;
			delay2_done[12] <= 1'd0;
       		N1_var2[12] <= 8'd0;
       		M1_var2[12] <= 9'd0;
       		C1_var4[12] <= 6'd0;
       		N3_var[12] <= 9'd0;
			M3_var[12] <= 9'd0;
			en_r_kernel12_mem <= 1'd0;
			addr_r_kernel12_mem <= 16'd0;
			en_w_result12_mem <= 1'd0;
			we_result12_mem <= 1'd0;
			addr_w_result12_mem <= 16'd0;
			inp_result12_mem <= 16'd0;
			conv_done[12] <= 1'd0;
			result_temp[12] <= 16'd0;// aux reg for $display
			resultset2zero[12] <= 1'd0;
			outp_result12_mem <= 16'd0;
			addr_r_result12_mem <= 1'd0;
			res_temp_conc[12] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[12] == 0)
       	begin
       		en_r_result12_mem <= 1'd1;
			en_w_result12_mem <= 1'd1;
			we_result12_mem <= 1'd1;
			addr_w_result12_mem <= addr_w_result12_mem + 1'd1;
			inp_result12_mem <= 16'd0;
			if ( addr_w_result12_mem >= CONV_ED)
			begin
				addr_w_result12_mem <= 15'd0;
				resultset2zero[12] <= 1'd1;
				we_result12_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[12] == 1 && 
       			biases_recieved == 1 &&	conv_done[12] == 0 &&
       			resultset2zero[12] == 1)
		begin
			en_r_kernel12_mem <= 1'd1;
			en_w_result12_mem <= 1'd1;
			we_result12_mem <= 1'd1;
			//artificial delays
			delay_cnt[12] <= delay_cnt[12] + 1;
			delay2_cnt[12] <= delay2_cnt[12] + 1;
			if(delay_cnt[12] >= 10'd6) begin
				delay_done[12] <= 1'd1;
				delay_cnt[12] <= 7'd0;
			end
			if(delay2_cnt[12] >= 10'd6) begin
				delay2_done[12] <= 1'd1;
			end
			if(delay_done[12] == 1'd0) 
			begin
				inp_result12_mem <= 16'd0;
			end
			res_temp_conc[12] <= res_temp_w_conc[12];
			if(delay_done[12] == 1'd1) 
			begin
				inp_result12_mem <= res_temp_conc[12];
			end
			addr_r_kernel12_mem <= (M1_var2[12])*M1_PARAM*C1_PARAM + (N1_var2[12])*C1_PARAM + (C1_var4[12]) + 1;
			addr_w_result12_mem <= M3_var[12]*N3_PARAM + N3_var[12];
			addr_r_result12_mem <= M3_var[12]*N3_PARAM + N3_var[12];
			if(delay2_done[12] == 1'd1) begin
				N1_var2[12] <= N1_var2[12] + 1;
			end
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
						inp_result12_mem <= res_temp_w_conc[12] + dat_read_biases_mem;	
						result12 <= dat_read_result12_mem;										
						if (N3_var[12] >= N3_PARAM-1)
						begin
							N3_var[12] <= 8'd0;
							M3_var[12] <= M3_var[12] + 1;
							if (M3_var[12] >= M3_PARAM-1)
							begin
								conv_done[12] <= 1'd0;
								en_r_kernel12_mem <= 1'd0;
								en_w_result12_mem <= 1'd0;
								we_result12_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [13]
   assign mult_temp_w_13 = dat_read_kernel13_mem * dat_read_img_mem;
   assign mult_temp_w_conc[13] = mult_temp_w_13[24:5]; 
   assign res_temp_w_conc[13] = mult_temp_w_conc[13] + dat_read_result13_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[13] <= 10'd1;
       		delay_done[13] <= 1'd0;
       		delay2_cnt[13] <= 10'd1;
			delay2_done[13] <= 1'd0;
       		N1_var2[13] <= 8'd0;
       		M1_var2[13] <= 9'd0;
       		C1_var4[13] <= 6'd0;
       		N3_var[13] <= 9'd0;
			M3_var[13] <= 9'd0;
			en_r_kernel13_mem <= 1'd0;
			addr_r_kernel13_mem <= 16'd0;
			en_w_result13_mem <= 1'd0;
			we_result13_mem <= 1'd0;
			addr_w_result13_mem <= 16'd0;
			inp_result13_mem <= 16'd0;
			conv_done[13] <= 1'd0;
			result_temp[13] <= 16'd0;// aux reg for $display
			resultset2zero[13] <= 1'd0;
			outp_result13_mem <= 16'd0;
			addr_r_result13_mem <= 1'd0;
			res_temp_conc[13] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[13] == 0)
       	begin
       		en_r_result13_mem <= 1'd1;
			en_w_result13_mem <= 1'd1;
			we_result13_mem <= 1'd1;
			addr_w_result13_mem <= addr_w_result13_mem + 1'd1;
			inp_result13_mem <= 16'd0;
			if ( addr_w_result13_mem >= CONV_ED)
			begin
				addr_w_result13_mem <= 15'd0;
				resultset2zero[13] <= 1'd1;
				we_result13_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[13] == 1 && 
       			biases_recieved == 1 &&	conv_done[13] == 0 &&
       			resultset2zero[13] == 1)
		begin
			en_r_kernel13_mem <= 1'd1;
			en_w_result13_mem <= 1'd1;
			we_result13_mem <= 1'd1;
			//artificial delays
			delay_cnt[13] <= delay_cnt[13] + 1;
			delay2_cnt[13] <= delay2_cnt[13] + 1;
			if(delay_cnt[13] >= 10'd6) begin
				delay_done[13] <= 1'd1;
				delay_cnt[13] <= 7'd0;
			end
			if(delay2_cnt[13] >= 10'd6) begin
				delay2_done[13] <= 1'd1;
			end
			if(delay_done[13] == 1'd0) 
			begin
				inp_result13_mem <= 16'd0;
			end
			res_temp_conc[13] <= res_temp_w_conc[13];
			if(delay_done[13] == 1'd1) 
			begin
				inp_result13_mem <= res_temp_conc[13];
			end
			addr_r_kernel13_mem <= (M1_var2[13])*M1_PARAM*C1_PARAM + (N1_var2[13])*C1_PARAM + (C1_var4[13]) + 1;
			addr_w_result13_mem <= M3_var[13]*N3_PARAM + N3_var[13];
			addr_r_result13_mem <= M3_var[13]*N3_PARAM + N3_var[13];
			if(delay2_done[13] == 1'd1) begin
				N1_var2[13] <= N1_var2[13] + 1;
			end
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
						inp_result13_mem <= res_temp_w_conc[13] + dat_read_biases_mem;	
						result13 <= dat_read_result13_mem;										
						if (N3_var[13] >= N3_PARAM-1)
						begin
							N3_var[13] <= 8'd0;
							M3_var[13] <= M3_var[13] + 1;
							if (M3_var[13] >= M3_PARAM-1)
							begin
								conv_done[13] <= 1'd0;
								en_r_kernel13_mem <= 1'd0;
								en_w_result13_mem <= 1'd0;
								we_result13_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [14]
   assign mult_temp_w_14 = dat_read_kernel14_mem * dat_read_img_mem;
   assign mult_temp_w_conc[14] = mult_temp_w_14[24:5]; 
   assign res_temp_w_conc[14] = mult_temp_w_conc[14] + dat_read_result14_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[14] <= 10'd1;
       		delay_done[14] <= 1'd0;
       		delay2_cnt[14] <= 10'd1;
			delay2_done[14] <= 1'd0;
       		N1_var2[14] <= 8'd0;
       		M1_var2[14] <= 9'd0;
       		C1_var4[14] <= 6'd0;
       		N3_var[14] <= 9'd0;
			M3_var[14] <= 9'd0;
			en_r_kernel14_mem <= 1'd0;
			addr_r_kernel14_mem <= 16'd0;
			en_w_result14_mem <= 1'd0;
			we_result14_mem <= 1'd0;
			addr_w_result14_mem <= 16'd0;
			inp_result14_mem <= 16'd0;
			conv_done[14] <= 1'd0;
			result_temp[14] <= 16'd0;// aux reg for $display
			resultset2zero[14] <= 1'd0;
			outp_result14_mem <= 16'd0;
			addr_r_result14_mem <= 1'd0;
			res_temp_conc[14] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[14] == 0)
       	begin
       		en_r_result14_mem <= 1'd1;
			en_w_result14_mem <= 1'd1;
			we_result14_mem <= 1'd1;
			addr_w_result14_mem <= addr_w_result14_mem + 1'd1;
			inp_result14_mem <= 16'd0;
			if ( addr_w_result14_mem >= CONV_ED)
			begin
				addr_w_result14_mem <= 15'd0;
				resultset2zero[14] <= 1'd1;
				we_result14_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[14] == 1 && 
       			biases_recieved == 1 &&	conv_done[14] == 0 &&
       			resultset2zero[14] == 1)
		begin
			en_r_kernel14_mem <= 1'd1;
			en_w_result14_mem <= 1'd1;
			we_result14_mem <= 1'd1;
			//artificial delays
			delay_cnt[14] <= delay_cnt[14] + 1;
			delay2_cnt[14] <= delay2_cnt[14] + 1;
			if(delay_cnt[14] >= 10'd6) begin
				delay_done[14] <= 1'd1;
				delay_cnt[14] <= 7'd0;
			end
			if(delay2_cnt[14] >= 10'd6) begin
				delay2_done[14] <= 1'd1;
			end
			if(delay_done[14] == 1'd0) 
			begin
				inp_result14_mem <= 16'd0;
			end
			res_temp_conc[14] <= res_temp_w_conc[14];
			if(delay_done[14] == 1'd1) 
			begin
				inp_result14_mem <= res_temp_conc[14];
			end
			addr_r_kernel14_mem <= (M1_var2[14])*M1_PARAM*C1_PARAM + (N1_var2[14])*C1_PARAM + (C1_var4[14]) + 1;
			addr_w_result14_mem <= M3_var[14]*N3_PARAM + N3_var[14];
			addr_r_result14_mem <= M3_var[14]*N3_PARAM + N3_var[14];
			if(delay2_done[14] == 1'd1) begin
				N1_var2[14] <= N1_var2[14] + 1;
			end
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
						inp_result14_mem <= res_temp_w_conc[14] + dat_read_biases_mem;	
						result14 <= dat_read_result14_mem;										
						if (N3_var[14] >= N3_PARAM-1)
						begin
							N3_var[14] <= 8'd0;
							M3_var[14] <= M3_var[14] + 1;
							if (M3_var[14] >= M3_PARAM-1)
							begin
								conv_done[14] <= 1'd0;
								en_r_kernel14_mem <= 1'd0;
								en_w_result14_mem <= 1'd0;
								we_result14_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [15]
   assign mult_temp_w_15 = dat_read_kernel15_mem * dat_read_img_mem;
   assign mult_temp_w_conc[15] = mult_temp_w_15[24:5]; 
   assign res_temp_w_conc[15] = mult_temp_w_conc[15] + dat_read_result15_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[15] <= 10'd1;
       		delay_done[15] <= 1'd0;
       		delay2_cnt[15] <= 10'd1;
			delay2_done[15] <= 1'd0;
       		N1_var2[15] <= 8'd0;
       		M1_var2[15] <= 9'd0;
       		C1_var4[15] <= 6'd0;
       		N3_var[15] <= 9'd0;
			M3_var[15] <= 9'd0;
			en_r_kernel15_mem <= 1'd0;
			addr_r_kernel15_mem <= 16'd0;
			en_w_result15_mem <= 1'd0;
			we_result15_mem <= 1'd0;
			addr_w_result15_mem <= 16'd0;
			inp_result15_mem <= 16'd0;
			conv_done[15] <= 1'd0;
			result_temp[15] <= 16'd0;// aux reg for $display
			resultset2zero[15] <= 1'd0;
			outp_result15_mem <= 16'd0;
			addr_r_result15_mem <= 1'd0;
			res_temp_conc[15] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[15] == 0)
       	begin
       		en_r_result15_mem <= 1'd1;
			en_w_result15_mem <= 1'd1;
			we_result15_mem <= 1'd1;
			addr_w_result15_mem <= addr_w_result15_mem + 1'd1;
			inp_result15_mem <= 16'd0;
			if ( addr_w_result15_mem >= CONV_ED)
			begin
				addr_w_result15_mem <= 15'd0;
				resultset2zero[15] <= 1'd1;
				we_result15_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[15] == 1 && 
       			biases_recieved == 1 &&	conv_done[15] == 0 &&
       			resultset2zero[15] == 1)
		begin
			en_r_kernel15_mem <= 1'd1;
			en_w_result15_mem <= 1'd1;
			we_result15_mem <= 1'd1;
			//artificial delays
			delay_cnt[15] <= delay_cnt[15] + 1;
			delay2_cnt[15] <= delay2_cnt[15] + 1;
			if(delay_cnt[15] >= 10'd6) begin
				delay_done[15] <= 1'd1;
				delay_cnt[15] <= 7'd0;
			end
			if(delay2_cnt[15] >= 10'd6) begin
				delay2_done[15] <= 1'd1;
			end
			if(delay_done[15] == 1'd0) 
			begin
				inp_result15_mem <= 16'd0;
			end
			res_temp_conc[15] <= res_temp_w_conc[15];
			if(delay_done[15] == 1'd1) 
			begin
				inp_result15_mem <= res_temp_conc[15];
			end
			addr_r_kernel15_mem <= (M1_var2[15])*M1_PARAM*C1_PARAM + (N1_var2[15])*C1_PARAM + (C1_var4[15]) + 1;
			addr_w_result15_mem <= M3_var[15]*N3_PARAM + N3_var[15];
			addr_r_result15_mem <= M3_var[15]*N3_PARAM + N3_var[15];
			if(delay2_done[15] == 1'd1) begin
				N1_var2[15] <= N1_var2[15] + 1;
			end
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
						inp_result15_mem <= res_temp_w_conc[15] + dat_read_biases_mem;	
						result15 <= dat_read_result15_mem;										
						if (N3_var[15] >= N3_PARAM-1)
						begin
							N3_var[15] <= 8'd0;
							M3_var[15] <= M3_var[15] + 1;
							if (M3_var[15] >= M3_PARAM-1)
							begin
								conv_done[15] <= 1'd0;
								en_r_kernel15_mem <= 1'd0;
								en_w_result15_mem <= 1'd0;
								we_result15_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [16]
   assign mult_temp_w_16 = dat_read_kernel16_mem * dat_read_img_mem;
   assign mult_temp_w_conc[16] = mult_temp_w_16[24:5]; 
   assign res_temp_w_conc[16] = mult_temp_w_conc[16] + dat_read_result16_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[16] <= 10'd1;
       		delay_done[16] <= 1'd0;
       		delay2_cnt[16] <= 10'd1;
			delay2_done[16] <= 1'd0;
       		N1_var2[16] <= 8'd0;
       		M1_var2[16] <= 9'd0;
       		C1_var4[16] <= 6'd0;
       		N3_var[16] <= 9'd0;
			M3_var[16] <= 9'd0;
			en_r_kernel16_mem <= 1'd0;
			addr_r_kernel16_mem <= 16'd0;
			en_w_result16_mem <= 1'd0;
			we_result16_mem <= 1'd0;
			addr_w_result16_mem <= 16'd0;
			inp_result16_mem <= 16'd0;
			conv_done[16] <= 1'd0;
			result_temp[16] <= 16'd0;// aux reg for $display
			resultset2zero[16] <= 1'd0;
			outp_result16_mem <= 16'd0;
			addr_r_result16_mem <= 1'd0;
			res_temp_conc[16] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[16] == 0)
       	begin
       		en_r_result16_mem <= 1'd1;
			en_w_result16_mem <= 1'd1;
			we_result16_mem <= 1'd1;
			addr_w_result16_mem <= addr_w_result16_mem + 1'd1;
			inp_result16_mem <= 16'd0;
			if ( addr_w_result16_mem >= CONV_ED)
			begin
				addr_w_result16_mem <= 15'd0;
				resultset2zero[16] <= 1'd1;
				we_result16_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[16] == 1 && 
       			biases_recieved == 1 &&	conv_done[16] == 0 &&
       			resultset2zero[16] == 1)
		begin
			en_r_kernel16_mem <= 1'd1;
			en_w_result16_mem <= 1'd1;
			we_result16_mem <= 1'd1;
			//artificial delays
			delay_cnt[16] <= delay_cnt[16] + 1;
			delay2_cnt[16] <= delay2_cnt[16] + 1;
			if(delay_cnt[16] >= 10'd6) begin
				delay_done[16] <= 1'd1;
				delay_cnt[16] <= 7'd0;
			end
			if(delay2_cnt[16] >= 10'd6) begin
				delay2_done[16] <= 1'd1;
			end
			if(delay_done[16] == 1'd0) 
			begin
				inp_result16_mem <= 16'd0;
			end
			res_temp_conc[16] <= res_temp_w_conc[16];
			if(delay_done[16] == 1'd1) 
			begin
				inp_result16_mem <= res_temp_conc[16];
			end
			addr_r_kernel16_mem <= (M1_var2[16])*M1_PARAM*C1_PARAM + (N1_var2[16])*C1_PARAM + (C1_var4[16]) + 1;
			addr_w_result16_mem <= M3_var[16]*N3_PARAM + N3_var[16];
			addr_r_result16_mem <= M3_var[16]*N3_PARAM + N3_var[16];
			if(delay2_done[16] == 1'd1) begin
				N1_var2[16] <= N1_var2[16] + 1;
			end
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
						inp_result16_mem <= res_temp_w_conc[16] + dat_read_biases_mem;	
						result16 <= dat_read_result16_mem;										
						if (N3_var[16] >= N3_PARAM-1)
						begin
							N3_var[16] <= 8'd0;
							M3_var[16] <= M3_var[16] + 1;
							if (M3_var[16] >= M3_PARAM-1)
							begin
								conv_done[16] <= 1'd0;
								en_r_kernel16_mem <= 1'd0;
								en_w_result16_mem <= 1'd0;
								we_result16_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [17]
   assign mult_temp_w_17 = dat_read_kernel17_mem * dat_read_img_mem;
   assign mult_temp_w_conc[17] = mult_temp_w_17[24:5]; 
   assign res_temp_w_conc[17] = mult_temp_w_conc[17] + dat_read_result17_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[17] <= 10'd1;
       		delay_done[17] <= 1'd0;
       		delay2_cnt[17] <= 10'd1;
			delay2_done[17] <= 1'd0;
       		N1_var2[17] <= 8'd0;
       		M1_var2[17] <= 9'd0;
       		C1_var4[17] <= 6'd0;
       		N3_var[17] <= 9'd0;
			M3_var[17] <= 9'd0;
			en_r_kernel17_mem <= 1'd0;
			addr_r_kernel17_mem <= 16'd0;
			en_w_result17_mem <= 1'd0;
			we_result17_mem <= 1'd0;
			addr_w_result17_mem <= 16'd0;
			inp_result17_mem <= 16'd0;
			conv_done[17] <= 1'd0;
			result_temp[17] <= 16'd0;// aux reg for $display
			resultset2zero[17] <= 1'd0;
			outp_result17_mem <= 16'd0;
			addr_r_result17_mem <= 1'd0;
			res_temp_conc[17] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[17] == 0)
       	begin
       		en_r_result17_mem <= 1'd1;
			en_w_result17_mem <= 1'd1;
			we_result17_mem <= 1'd1;
			addr_w_result17_mem <= addr_w_result17_mem + 1'd1;
			inp_result17_mem <= 16'd0;
			if ( addr_w_result17_mem >= CONV_ED)
			begin
				addr_w_result17_mem <= 15'd0;
				resultset2zero[17] <= 1'd1;
				we_result17_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[17] == 1 && 
       			biases_recieved == 1 &&	conv_done[17] == 0 &&
       			resultset2zero[17] == 1)
		begin
			en_r_kernel17_mem <= 1'd1;
			en_w_result17_mem <= 1'd1;
			we_result17_mem <= 1'd1;
			//artificial delays
			delay_cnt[17] <= delay_cnt[17] + 1;
			delay2_cnt[17] <= delay2_cnt[17] + 1;
			if(delay_cnt[17] >= 10'd6) begin
				delay_done[17] <= 1'd1;
				delay_cnt[17] <= 7'd0;
			end
			if(delay2_cnt[17] >= 10'd6) begin
				delay2_done[17] <= 1'd1;
			end
			if(delay_done[17] == 1'd0) 
			begin
				inp_result17_mem <= 16'd0;
			end
			res_temp_conc[17] <= res_temp_w_conc[17];
			if(delay_done[17] == 1'd1) 
			begin
				inp_result17_mem <= res_temp_conc[17];
			end
			addr_r_kernel17_mem <= (M1_var2[17])*M1_PARAM*C1_PARAM + (N1_var2[17])*C1_PARAM + (C1_var4[17]) + 1;
			addr_w_result17_mem <= M3_var[17]*N3_PARAM + N3_var[17];
			addr_r_result17_mem <= M3_var[17]*N3_PARAM + N3_var[17];
			if(delay2_done[17] == 1'd1) begin
				N1_var2[17] <= N1_var2[17] + 1;
			end
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
						inp_result17_mem <= res_temp_w_conc[17] + dat_read_biases_mem;	
						result17 <= dat_read_result17_mem;										
						if (N3_var[17] >= N3_PARAM-1)
						begin
							N3_var[17] <= 8'd0;
							M3_var[17] <= M3_var[17] + 1;
							if (M3_var[17] >= M3_PARAM-1)
							begin
								conv_done[17] <= 1'd0;
								en_r_kernel17_mem <= 1'd0;
								en_w_result17_mem <= 1'd0;
								we_result17_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [18]
   assign mult_temp_w_18 = dat_read_kernel18_mem * dat_read_img_mem;
   assign mult_temp_w_conc[18] = mult_temp_w_18[24:5]; 
   assign res_temp_w_conc[18] = mult_temp_w_conc[18] + dat_read_result18_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[18] <= 10'd1;
       		delay_done[18] <= 1'd0;
       		delay2_cnt[18] <= 10'd1;
			delay2_done[18] <= 1'd0;
       		N1_var2[18] <= 8'd0;
       		M1_var2[18] <= 9'd0;
       		C1_var4[18] <= 6'd0;
       		N3_var[18] <= 9'd0;
			M3_var[18] <= 9'd0;
			en_r_kernel18_mem <= 1'd0;
			addr_r_kernel18_mem <= 16'd0;
			en_w_result18_mem <= 1'd0;
			we_result18_mem <= 1'd0;
			addr_w_result18_mem <= 16'd0;
			inp_result18_mem <= 16'd0;
			conv_done[18] <= 1'd0;
			result_temp[18] <= 16'd0;// aux reg for $display
			resultset2zero[18] <= 1'd0;
			outp_result18_mem <= 16'd0;
			addr_r_result18_mem <= 1'd0;
			res_temp_conc[18] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[18] == 0)
       	begin
       		en_r_result18_mem <= 1'd1;
			en_w_result18_mem <= 1'd1;
			we_result18_mem <= 1'd1;
			addr_w_result18_mem <= addr_w_result18_mem + 1'd1;
			inp_result18_mem <= 16'd0;
			if ( addr_w_result18_mem >= CONV_ED)
			begin
				addr_w_result18_mem <= 15'd0;
				resultset2zero[18] <= 1'd1;
				we_result18_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[18] == 1 && 
       			biases_recieved == 1 &&	conv_done[18] == 0 &&
       			resultset2zero[18] == 1)
		begin
			en_r_kernel18_mem <= 1'd1;
			en_w_result18_mem <= 1'd1;
			we_result18_mem <= 1'd1;
			//artificial delays
			delay_cnt[18] <= delay_cnt[18] + 1;
			delay2_cnt[18] <= delay2_cnt[18] + 1;
			if(delay_cnt[18] >= 10'd6) begin
				delay_done[18] <= 1'd1;
				delay_cnt[18] <= 7'd0;
			end
			if(delay2_cnt[18] >= 10'd6) begin
				delay2_done[18] <= 1'd1;
			end
			if(delay_done[18] == 1'd0) 
			begin
				inp_result18_mem <= 16'd0;
			end
			res_temp_conc[18] <= res_temp_w_conc[18];
			if(delay_done[18] == 1'd1) 
			begin
				inp_result18_mem <= res_temp_conc[18];
			end
			addr_r_kernel18_mem <= (M1_var2[18])*M1_PARAM*C1_PARAM + (N1_var2[18])*C1_PARAM + (C1_var4[18]) + 1;
			addr_w_result18_mem <= M3_var[18]*N3_PARAM + N3_var[18];
			addr_r_result18_mem <= M3_var[18]*N3_PARAM + N3_var[18];
			if(delay2_done[18] == 1'd1) begin
				N1_var2[18] <= N1_var2[18] + 1;
			end
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
						inp_result18_mem <= res_temp_w_conc[18] + dat_read_biases_mem;	
						result18 <= dat_read_result18_mem;										
						if (N3_var[18] >= N3_PARAM-1)
						begin
							N3_var[18] <= 8'd0;
							M3_var[18] <= M3_var[18] + 1;
							if (M3_var[18] >= M3_PARAM-1)
							begin
								conv_done[18] <= 1'd0;
								en_r_kernel18_mem <= 1'd0;
								en_w_result18_mem <= 1'd0;
								we_result18_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [19]
   assign mult_temp_w_19 = dat_read_kernel19_mem * dat_read_img_mem;
   assign mult_temp_w_conc[19] = mult_temp_w_19[24:5]; 
   assign res_temp_w_conc[19] = mult_temp_w_conc[19] + dat_read_result19_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[19] <= 10'd1;
       		delay_done[19] <= 1'd0;
       		delay2_cnt[19] <= 10'd1;
			delay2_done[19] <= 1'd0;
       		N1_var2[19] <= 8'd0;
       		M1_var2[19] <= 9'd0;
       		C1_var4[19] <= 6'd0;
       		N3_var[19] <= 9'd0;
			M3_var[19] <= 9'd0;
			en_r_kernel19_mem <= 1'd0;
			addr_r_kernel19_mem <= 16'd0;
			en_w_result19_mem <= 1'd0;
			we_result19_mem <= 1'd0;
			addr_w_result19_mem <= 16'd0;
			inp_result19_mem <= 16'd0;
			conv_done[19] <= 1'd0;
			result_temp[19] <= 16'd0;// aux reg for $display
			resultset2zero[19] <= 1'd0;
			outp_result19_mem <= 16'd0;
			addr_r_result19_mem <= 1'd0;
			res_temp_conc[19] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[19] == 0)
       	begin
       		en_r_result19_mem <= 1'd1;
			en_w_result19_mem <= 1'd1;
			we_result19_mem <= 1'd1;
			addr_w_result19_mem <= addr_w_result19_mem + 1'd1;
			inp_result19_mem <= 16'd0;
			if ( addr_w_result19_mem >= CONV_ED)
			begin
				addr_w_result19_mem <= 15'd0;
				resultset2zero[19] <= 1'd1;
				we_result19_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[19] == 1 && 
       			biases_recieved == 1 &&	conv_done[19] == 0 &&
       			resultset2zero[19] == 1)
		begin
			en_r_kernel19_mem <= 1'd1;
			en_w_result19_mem <= 1'd1;
			we_result19_mem <= 1'd1;
			//artificial delays
			delay_cnt[19] <= delay_cnt[19] + 1;
			delay2_cnt[19] <= delay2_cnt[19] + 1;
			if(delay_cnt[19] >= 10'd6) begin
				delay_done[19] <= 1'd1;
				delay_cnt[19] <= 7'd0;
			end
			if(delay2_cnt[19] >= 10'd6) begin
				delay2_done[19] <= 1'd1;
			end
			if(delay_done[19] == 1'd0) 
			begin
				inp_result19_mem <= 16'd0;
			end
			res_temp_conc[19] <= res_temp_w_conc[19];
			if(delay_done[19] == 1'd1) 
			begin
				inp_result19_mem <= res_temp_conc[19];
			end
			addr_r_kernel19_mem <= (M1_var2[19])*M1_PARAM*C1_PARAM + (N1_var2[19])*C1_PARAM + (C1_var4[19]) + 1;
			addr_w_result19_mem <= M3_var[19]*N3_PARAM + N3_var[19];
			addr_r_result19_mem <= M3_var[19]*N3_PARAM + N3_var[19];
			if(delay2_done[19] == 1'd1) begin
				N1_var2[19] <= N1_var2[19] + 1;
			end
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
						inp_result19_mem <= res_temp_w_conc[19] + dat_read_biases_mem;	
						result19 <= dat_read_result19_mem;										
						if (N3_var[19] >= N3_PARAM-1)
						begin
							N3_var[19] <= 8'd0;
							M3_var[19] <= M3_var[19] + 1;
							if (M3_var[19] >= M3_PARAM-1)
							begin
								conv_done[19] <= 1'd0;
								en_r_kernel19_mem <= 1'd0;
								en_w_result19_mem <= 1'd0;
								we_result19_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [20]
   assign mult_temp_w_20 = dat_read_kernel20_mem * dat_read_img_mem;
   assign mult_temp_w_conc[20] = mult_temp_w_20[24:5]; 
   assign res_temp_w_conc[20] = mult_temp_w_conc[20] + dat_read_result20_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[20] <= 10'd1;
       		delay_done[20] <= 1'd0;
       		delay2_cnt[20] <= 10'd1;
			delay2_done[20] <= 1'd0;
       		N1_var2[20] <= 8'd0;
       		M1_var2[20] <= 9'd0;
       		C1_var4[20] <= 6'd0;
       		N3_var[20] <= 9'd0;
			M3_var[20] <= 9'd0;
			en_r_kernel20_mem <= 1'd0;
			addr_r_kernel20_mem <= 16'd0;
			en_w_result20_mem <= 1'd0;
			we_result20_mem <= 1'd0;
			addr_w_result20_mem <= 16'd0;
			inp_result20_mem <= 16'd0;
			conv_done[20] <= 1'd0;
			result_temp[20] <= 16'd0;// aux reg for $display
			resultset2zero[20] <= 1'd0;
			outp_result20_mem <= 16'd0;
			addr_r_result20_mem <= 1'd0;
			res_temp_conc[20] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[20] == 0)
       	begin
       		en_r_result20_mem <= 1'd1;
			en_w_result20_mem <= 1'd1;
			we_result20_mem <= 1'd1;
			addr_w_result20_mem <= addr_w_result20_mem + 1'd1;
			inp_result20_mem <= 16'd0;
			if ( addr_w_result20_mem >= CONV_ED)
			begin
				addr_w_result20_mem <= 15'd0;
				resultset2zero[20] <= 1'd1;
				we_result20_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[20] == 1 && 
       			biases_recieved == 1 &&	conv_done[20] == 0 &&
       			resultset2zero[20] == 1)
		begin
			en_r_kernel20_mem <= 1'd1;
			en_w_result20_mem <= 1'd1;
			we_result20_mem <= 1'd1;
			//artificial delays
			delay_cnt[20] <= delay_cnt[20] + 1;
			delay2_cnt[20] <= delay2_cnt[20] + 1;
			if(delay_cnt[20] >= 10'd6) begin
				delay_done[20] <= 1'd1;
				delay_cnt[20] <= 7'd0;
			end
			if(delay2_cnt[20] >= 10'd6) begin
				delay2_done[20] <= 1'd1;
			end
			if(delay_done[20] == 1'd0) 
			begin
				inp_result20_mem <= 16'd0;
			end
			res_temp_conc[20] <= res_temp_w_conc[20];
			if(delay_done[20] == 1'd1) 
			begin
				inp_result20_mem <= res_temp_conc[20];
			end
			addr_r_kernel20_mem <= (M1_var2[20])*M1_PARAM*C1_PARAM + (N1_var2[20])*C1_PARAM + (C1_var4[20]) + 1;
			addr_w_result20_mem <= M3_var[20]*N3_PARAM + N3_var[20];
			addr_r_result20_mem <= M3_var[20]*N3_PARAM + N3_var[20];
			if(delay2_done[20] == 1'd1) begin
				N1_var2[20] <= N1_var2[20] + 1;
			end
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
						inp_result20_mem <= res_temp_w_conc[20] + dat_read_biases_mem;	
						result20 <= dat_read_result20_mem;										
						if (N3_var[20] >= N3_PARAM-1)
						begin
							N3_var[20] <= 8'd0;
							M3_var[20] <= M3_var[20] + 1;
							if (M3_var[20] >= M3_PARAM-1)
							begin
								conv_done[20] <= 1'd0;
								en_r_kernel20_mem <= 1'd0;
								en_w_result20_mem <= 1'd0;
								we_result20_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [21]
   assign mult_temp_w_21 = dat_read_kernel21_mem * dat_read_img_mem;
   assign mult_temp_w_conc[21] = mult_temp_w_21[24:5]; 
   assign res_temp_w_conc[21] = mult_temp_w_conc[21] + dat_read_result21_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[21] <= 10'd1;
       		delay_done[21] <= 1'd0;
       		delay2_cnt[21] <= 10'd1;
			delay2_done[21] <= 1'd0;
       		N1_var2[21] <= 8'd0;
       		M1_var2[21] <= 9'd0;
       		C1_var4[21] <= 6'd0;
       		N3_var[21] <= 9'd0;
			M3_var[21] <= 9'd0;
			en_r_kernel21_mem <= 1'd0;
			addr_r_kernel21_mem <= 16'd0;
			en_w_result21_mem <= 1'd0;
			we_result21_mem <= 1'd0;
			addr_w_result21_mem <= 16'd0;
			inp_result21_mem <= 16'd0;
			conv_done[21] <= 1'd0;
			result_temp[21] <= 16'd0;// aux reg for $display
			resultset2zero[21] <= 1'd0;
			outp_result21_mem <= 16'd0;
			addr_r_result21_mem <= 1'd0;
			res_temp_conc[21] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[21] == 0)
       	begin
       		en_r_result21_mem <= 1'd1;
			en_w_result21_mem <= 1'd1;
			we_result21_mem <= 1'd1;
			addr_w_result21_mem <= addr_w_result21_mem + 1'd1;
			inp_result21_mem <= 16'd0;
			if ( addr_w_result21_mem >= CONV_ED)
			begin
				addr_w_result21_mem <= 15'd0;
				resultset2zero[21] <= 1'd1;
				we_result21_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[21] == 1 && 
       			biases_recieved == 1 &&	conv_done[21] == 0 &&
       			resultset2zero[21] == 1)
		begin
			en_r_kernel21_mem <= 1'd1;
			en_w_result21_mem <= 1'd1;
			we_result21_mem <= 1'd1;
			//artificial delays
			delay_cnt[21] <= delay_cnt[21] + 1;
			delay2_cnt[21] <= delay2_cnt[21] + 1;
			if(delay_cnt[21] >= 10'd6) begin
				delay_done[21] <= 1'd1;
				delay_cnt[21] <= 7'd0;
			end
			if(delay2_cnt[21] >= 10'd6) begin
				delay2_done[21] <= 1'd1;
			end
			if(delay_done[21] == 1'd0) 
			begin
				inp_result21_mem <= 16'd0;
			end
			res_temp_conc[21] <= res_temp_w_conc[21];
			if(delay_done[21] == 1'd1) 
			begin
				inp_result21_mem <= res_temp_conc[21];
			end
			addr_r_kernel21_mem <= (M1_var2[21])*M1_PARAM*C1_PARAM + (N1_var2[21])*C1_PARAM + (C1_var4[21]) + 1;
			addr_w_result21_mem <= M3_var[21]*N3_PARAM + N3_var[21];
			addr_r_result21_mem <= M3_var[21]*N3_PARAM + N3_var[21];
			if(delay2_done[21] == 1'd1) begin
				N1_var2[21] <= N1_var2[21] + 1;
			end
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
						inp_result21_mem <= res_temp_w_conc[21] + dat_read_biases_mem;	
						result21 <= dat_read_result21_mem;										
						if (N3_var[21] >= N3_PARAM-1)
						begin
							N3_var[21] <= 8'd0;
							M3_var[21] <= M3_var[21] + 1;
							if (M3_var[21] >= M3_PARAM-1)
							begin
								conv_done[21] <= 1'd0;
								en_r_kernel21_mem <= 1'd0;
								en_w_result21_mem <= 1'd0;
								we_result21_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [22]
   assign mult_temp_w_22 = dat_read_kernel22_mem * dat_read_img_mem;
   assign mult_temp_w_conc[22] = mult_temp_w_22[24:5]; 
   assign res_temp_w_conc[22] = mult_temp_w_conc[22] + dat_read_result22_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[22] <= 10'd1;
       		delay_done[22] <= 1'd0;
       		delay2_cnt[22] <= 10'd1;
			delay2_done[22] <= 1'd0;
       		N1_var2[22] <= 8'd0;
       		M1_var2[22] <= 9'd0;
       		C1_var4[22] <= 6'd0;
       		N3_var[22] <= 9'd0;
			M3_var[22] <= 9'd0;
			en_r_kernel22_mem <= 1'd0;
			addr_r_kernel22_mem <= 16'd0;
			en_w_result22_mem <= 1'd0;
			we_result22_mem <= 1'd0;
			addr_w_result22_mem <= 16'd0;
			inp_result22_mem <= 16'd0;
			conv_done[22] <= 1'd0;
			result_temp[22] <= 16'd0;// aux reg for $display
			resultset2zero[22] <= 1'd0;
			outp_result22_mem <= 16'd0;
			addr_r_result22_mem <= 1'd0;
			res_temp_conc[22] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[22] == 0)
       	begin
       		en_r_result22_mem <= 1'd1;
			en_w_result22_mem <= 1'd1;
			we_result22_mem <= 1'd1;
			addr_w_result22_mem <= addr_w_result22_mem + 1'd1;
			inp_result22_mem <= 16'd0;
			if ( addr_w_result22_mem >= CONV_ED)
			begin
				addr_w_result22_mem <= 15'd0;
				resultset2zero[22] <= 1'd1;
				we_result22_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[22] == 1 && 
       			biases_recieved == 1 &&	conv_done[22] == 0 &&
       			resultset2zero[22] == 1)
		begin
			en_r_kernel22_mem <= 1'd1;
			en_w_result22_mem <= 1'd1;
			we_result22_mem <= 1'd1;
			//artificial delays
			delay_cnt[22] <= delay_cnt[22] + 1;
			delay2_cnt[22] <= delay2_cnt[22] + 1;
			if(delay_cnt[22] >= 10'd6) begin
				delay_done[22] <= 1'd1;
				delay_cnt[22] <= 7'd0;
			end
			if(delay2_cnt[22] >= 10'd6) begin
				delay2_done[22] <= 1'd1;
			end
			if(delay_done[22] == 1'd0) 
			begin
				inp_result22_mem <= 16'd0;
			end
			res_temp_conc[22] <= res_temp_w_conc[22];
			if(delay_done[22] == 1'd1) 
			begin
				inp_result22_mem <= res_temp_conc[22];
			end
			addr_r_kernel22_mem <= (M1_var2[22])*M1_PARAM*C1_PARAM + (N1_var2[22])*C1_PARAM + (C1_var4[22]) + 1;
			addr_w_result22_mem <= M3_var[22]*N3_PARAM + N3_var[22];
			addr_r_result22_mem <= M3_var[22]*N3_PARAM + N3_var[22];
			if(delay2_done[22] == 1'd1) begin
				N1_var2[22] <= N1_var2[22] + 1;
			end
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
						inp_result22_mem <= res_temp_w_conc[22] + dat_read_biases_mem;	
						result22 <= dat_read_result22_mem;										
						if (N3_var[22] >= N3_PARAM-1)
						begin
							N3_var[22] <= 8'd0;
							M3_var[22] <= M3_var[22] + 1;
							if (M3_var[22] >= M3_PARAM-1)
							begin
								conv_done[22] <= 1'd0;
								en_r_kernel22_mem <= 1'd0;
								en_w_result22_mem <= 1'd0;
								we_result22_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [23]
   assign mult_temp_w_23 = dat_read_kernel23_mem * dat_read_img_mem;
   assign mult_temp_w_conc[23] = mult_temp_w_23[24:5]; 
   assign res_temp_w_conc[23] = mult_temp_w_conc[23] + dat_read_result23_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[23] <= 10'd1;
       		delay_done[23] <= 1'd0;
       		delay2_cnt[23] <= 10'd1;
			delay2_done[23] <= 1'd0;
       		N1_var2[23] <= 8'd0;
       		M1_var2[23] <= 9'd0;
       		C1_var4[23] <= 6'd0;
       		N3_var[23] <= 9'd0;
			M3_var[23] <= 9'd0;
			en_r_kernel23_mem <= 1'd0;
			addr_r_kernel23_mem <= 16'd0;
			en_w_result23_mem <= 1'd0;
			we_result23_mem <= 1'd0;
			addr_w_result23_mem <= 16'd0;
			inp_result23_mem <= 16'd0;
			conv_done[23] <= 1'd0;
			result_temp[23] <= 16'd0;// aux reg for $display
			resultset2zero[23] <= 1'd0;
			outp_result23_mem <= 16'd0;
			addr_r_result23_mem <= 1'd0;
			res_temp_conc[23] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[23] == 0)
       	begin
       		en_r_result23_mem <= 1'd1;
			en_w_result23_mem <= 1'd1;
			we_result23_mem <= 1'd1;
			addr_w_result23_mem <= addr_w_result23_mem + 1'd1;
			inp_result23_mem <= 16'd0;
			if ( addr_w_result23_mem >= CONV_ED)
			begin
				addr_w_result23_mem <= 15'd0;
				resultset2zero[23] <= 1'd1;
				we_result23_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[23] == 1 && 
       			biases_recieved == 1 &&	conv_done[23] == 0 &&
       			resultset2zero[23] == 1)
		begin
			en_r_kernel23_mem <= 1'd1;
			en_w_result23_mem <= 1'd1;
			we_result23_mem <= 1'd1;
			//artificial delays
			delay_cnt[23] <= delay_cnt[23] + 1;
			delay2_cnt[23] <= delay2_cnt[23] + 1;
			if(delay_cnt[23] >= 10'd6) begin
				delay_done[23] <= 1'd1;
				delay_cnt[23] <= 7'd0;
			end
			if(delay2_cnt[23] >= 10'd6) begin
				delay2_done[23] <= 1'd1;
			end
			if(delay_done[23] == 1'd0) 
			begin
				inp_result23_mem <= 16'd0;
			end
			res_temp_conc[23] <= res_temp_w_conc[23];
			if(delay_done[23] == 1'd1) 
			begin
				inp_result23_mem <= res_temp_conc[23];
			end
			addr_r_kernel23_mem <= (M1_var2[23])*M1_PARAM*C1_PARAM + (N1_var2[23])*C1_PARAM + (C1_var4[23]) + 1;
			addr_w_result23_mem <= M3_var[23]*N3_PARAM + N3_var[23];
			addr_r_result23_mem <= M3_var[23]*N3_PARAM + N3_var[23];
			if(delay2_done[23] == 1'd1) begin
				N1_var2[23] <= N1_var2[23] + 1;
			end
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
						inp_result23_mem <= res_temp_w_conc[23] + dat_read_biases_mem;	
						result23 <= dat_read_result23_mem;										
						if (N3_var[23] >= N3_PARAM-1)
						begin
							N3_var[23] <= 8'd0;
							M3_var[23] <= M3_var[23] + 1;
							if (M3_var[23] >= M3_PARAM-1)
							begin
								conv_done[23] <= 1'd0;
								en_r_kernel23_mem <= 1'd0;
								en_w_result23_mem <= 1'd0;
								we_result23_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [24]
   assign mult_temp_w_24 = dat_read_kernel24_mem * dat_read_img_mem;
   assign mult_temp_w_conc[24] = mult_temp_w_24[24:5]; 
   assign res_temp_w_conc[24] = mult_temp_w_conc[24] + dat_read_result24_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[24] <= 10'd1;
       		delay_done[24] <= 1'd0;
       		delay2_cnt[24] <= 10'd1;
			delay2_done[24] <= 1'd0;
       		N1_var2[24] <= 8'd0;
       		M1_var2[24] <= 9'd0;
       		C1_var4[24] <= 6'd0;
       		N3_var[24] <= 9'd0;
			M3_var[24] <= 9'd0;
			en_r_kernel24_mem <= 1'd0;
			addr_r_kernel24_mem <= 16'd0;
			en_w_result24_mem <= 1'd0;
			we_result24_mem <= 1'd0;
			addr_w_result24_mem <= 16'd0;
			inp_result24_mem <= 16'd0;
			conv_done[24] <= 1'd0;
			result_temp[24] <= 16'd0;// aux reg for $display
			resultset2zero[24] <= 1'd0;
			outp_result24_mem <= 16'd0;
			addr_r_result24_mem <= 1'd0;
			res_temp_conc[24] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[24] == 0)
       	begin
       		en_r_result24_mem <= 1'd1;
			en_w_result24_mem <= 1'd1;
			we_result24_mem <= 1'd1;
			addr_w_result24_mem <= addr_w_result24_mem + 1'd1;
			inp_result24_mem <= 16'd0;
			if ( addr_w_result24_mem >= CONV_ED)
			begin
				addr_w_result24_mem <= 15'd0;
				resultset2zero[24] <= 1'd1;
				we_result24_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[24] == 1 && 
       			biases_recieved == 1 &&	conv_done[24] == 0 &&
       			resultset2zero[24] == 1)
		begin
			en_r_kernel24_mem <= 1'd1;
			en_w_result24_mem <= 1'd1;
			we_result24_mem <= 1'd1;
			//artificial delays
			delay_cnt[24] <= delay_cnt[24] + 1;
			delay2_cnt[24] <= delay2_cnt[24] + 1;
			if(delay_cnt[24] >= 10'd6) begin
				delay_done[24] <= 1'd1;
				delay_cnt[24] <= 7'd0;
			end
			if(delay2_cnt[24] >= 10'd6) begin
				delay2_done[24] <= 1'd1;
			end
			if(delay_done[24] == 1'd0) 
			begin
				inp_result24_mem <= 16'd0;
			end
			res_temp_conc[24] <= res_temp_w_conc[24];
			if(delay_done[24] == 1'd1) 
			begin
				inp_result24_mem <= res_temp_conc[24];
			end
			addr_r_kernel24_mem <= (M1_var2[24])*M1_PARAM*C1_PARAM + (N1_var2[24])*C1_PARAM + (C1_var4[24]) + 1;
			addr_w_result24_mem <= M3_var[24]*N3_PARAM + N3_var[24];
			addr_r_result24_mem <= M3_var[24]*N3_PARAM + N3_var[24];
			if(delay2_done[24] == 1'd1) begin
				N1_var2[24] <= N1_var2[24] + 1;
			end
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
						inp_result24_mem <= res_temp_w_conc[24] + dat_read_biases_mem;	
						result24 <= dat_read_result24_mem;										
						if (N3_var[24] >= N3_PARAM-1)
						begin
							N3_var[24] <= 8'd0;
							M3_var[24] <= M3_var[24] + 1;
							if (M3_var[24] >= M3_PARAM-1)
							begin
								conv_done[24] <= 1'd0;
								en_r_kernel24_mem <= 1'd0;
								en_w_result24_mem <= 1'd0;
								we_result24_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [25]
   assign mult_temp_w_25 = dat_read_kernel25_mem * dat_read_img_mem;
   assign mult_temp_w_conc[25] = mult_temp_w_25[24:5]; 
   assign res_temp_w_conc[25] = mult_temp_w_conc[25] + dat_read_result25_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[25] <= 10'd1;
       		delay_done[25] <= 1'd0;
       		delay2_cnt[25] <= 10'd1;
			delay2_done[25] <= 1'd0;
       		N1_var2[25] <= 8'd0;
       		M1_var2[25] <= 9'd0;
       		C1_var4[25] <= 6'd0;
       		N3_var[25] <= 9'd0;
			M3_var[25] <= 9'd0;
			en_r_kernel25_mem <= 1'd0;
			addr_r_kernel25_mem <= 16'd0;
			en_w_result25_mem <= 1'd0;
			we_result25_mem <= 1'd0;
			addr_w_result25_mem <= 16'd0;
			inp_result25_mem <= 16'd0;
			conv_done[25] <= 1'd0;
			result_temp[25] <= 16'd0;// aux reg for $display
			resultset2zero[25] <= 1'd0;
			outp_result25_mem <= 16'd0;
			addr_r_result25_mem <= 1'd0;
			res_temp_conc[25] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[25] == 0)
       	begin
       		en_r_result25_mem <= 1'd1;
			en_w_result25_mem <= 1'd1;
			we_result25_mem <= 1'd1;
			addr_w_result25_mem <= addr_w_result25_mem + 1'd1;
			inp_result25_mem <= 16'd0;
			if ( addr_w_result25_mem >= CONV_ED)
			begin
				addr_w_result25_mem <= 15'd0;
				resultset2zero[25] <= 1'd1;
				we_result25_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[25] == 1 && 
       			biases_recieved == 1 &&	conv_done[25] == 0 &&
       			resultset2zero[25] == 1)
		begin
			en_r_kernel25_mem <= 1'd1;
			en_w_result25_mem <= 1'd1;
			we_result25_mem <= 1'd1;
			//artificial delays
			delay_cnt[25] <= delay_cnt[25] + 1;
			delay2_cnt[25] <= delay2_cnt[25] + 1;
			if(delay_cnt[25] >= 10'd6) begin
				delay_done[25] <= 1'd1;
				delay_cnt[25] <= 7'd0;
			end
			if(delay2_cnt[25] >= 10'd6) begin
				delay2_done[25] <= 1'd1;
			end
			if(delay_done[25] == 1'd0) 
			begin
				inp_result25_mem <= 16'd0;
			end
			res_temp_conc[25] <= res_temp_w_conc[25];
			if(delay_done[25] == 1'd1) 
			begin
				inp_result25_mem <= res_temp_conc[25];
			end
			addr_r_kernel25_mem <= (M1_var2[25])*M1_PARAM*C1_PARAM + (N1_var2[25])*C1_PARAM + (C1_var4[25]) + 1;
			addr_w_result25_mem <= M3_var[25]*N3_PARAM + N3_var[25];
			addr_r_result25_mem <= M3_var[25]*N3_PARAM + N3_var[25];
			if(delay2_done[25] == 1'd1) begin
				N1_var2[25] <= N1_var2[25] + 1;
			end
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
						inp_result25_mem <= res_temp_w_conc[25] + dat_read_biases_mem;	
						result25 <= dat_read_result25_mem;										
						if (N3_var[25] >= N3_PARAM-1)
						begin
							N3_var[25] <= 8'd0;
							M3_var[25] <= M3_var[25] + 1;
							if (M3_var[25] >= M3_PARAM-1)
							begin
								conv_done[25] <= 1'd0;
								en_r_kernel25_mem <= 1'd0;
								en_w_result25_mem <= 1'd0;
								we_result25_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [26]
   assign mult_temp_w_26 = dat_read_kernel26_mem * dat_read_img_mem;
   assign mult_temp_w_conc[26] = mult_temp_w_26[24:5]; 
   assign res_temp_w_conc[26] = mult_temp_w_conc[26] + dat_read_result26_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[26] <= 10'd1;
       		delay_done[26] <= 1'd0;
       		delay2_cnt[26] <= 10'd1;
			delay2_done[26] <= 1'd0;
       		N1_var2[26] <= 8'd0;
       		M1_var2[26] <= 9'd0;
       		C1_var4[26] <= 6'd0;
       		N3_var[26] <= 9'd0;
			M3_var[26] <= 9'd0;
			en_r_kernel26_mem <= 1'd0;
			addr_r_kernel26_mem <= 16'd0;
			en_w_result26_mem <= 1'd0;
			we_result26_mem <= 1'd0;
			addr_w_result26_mem <= 16'd0;
			inp_result26_mem <= 16'd0;
			conv_done[26] <= 1'd0;
			result_temp[26] <= 16'd0;// aux reg for $display
			resultset2zero[26] <= 1'd0;
			outp_result26_mem <= 16'd0;
			addr_r_result26_mem <= 1'd0;
			res_temp_conc[26] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[26] == 0)
       	begin
       		en_r_result26_mem <= 1'd1;
			en_w_result26_mem <= 1'd1;
			we_result26_mem <= 1'd1;
			addr_w_result26_mem <= addr_w_result26_mem + 1'd1;
			inp_result26_mem <= 16'd0;
			if ( addr_w_result26_mem >= CONV_ED)
			begin
				addr_w_result26_mem <= 15'd0;
				resultset2zero[26] <= 1'd1;
				we_result26_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[26] == 1 && 
       			biases_recieved == 1 &&	conv_done[26] == 0 &&
       			resultset2zero[26] == 1)
		begin
			en_r_kernel26_mem <= 1'd1;
			en_w_result26_mem <= 1'd1;
			we_result26_mem <= 1'd1;
			//artificial delays
			delay_cnt[26] <= delay_cnt[26] + 1;
			delay2_cnt[26] <= delay2_cnt[26] + 1;
			if(delay_cnt[26] >= 10'd6) begin
				delay_done[26] <= 1'd1;
				delay_cnt[26] <= 7'd0;
			end
			if(delay2_cnt[26] >= 10'd6) begin
				delay2_done[26] <= 1'd1;
			end
			if(delay_done[26] == 1'd0) 
			begin
				inp_result26_mem <= 16'd0;
			end
			res_temp_conc[26] <= res_temp_w_conc[26];
			if(delay_done[26] == 1'd1) 
			begin
				inp_result26_mem <= res_temp_conc[26];
			end
			addr_r_kernel26_mem <= (M1_var2[26])*M1_PARAM*C1_PARAM + (N1_var2[26])*C1_PARAM + (C1_var4[26]) + 1;
			addr_w_result26_mem <= M3_var[26]*N3_PARAM + N3_var[26];
			addr_r_result26_mem <= M3_var[26]*N3_PARAM + N3_var[26];
			if(delay2_done[26] == 1'd1) begin
				N1_var2[26] <= N1_var2[26] + 1;
			end
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
						inp_result26_mem <= res_temp_w_conc[26] + dat_read_biases_mem;	
						result26 <= dat_read_result26_mem;										
						if (N3_var[26] >= N3_PARAM-1)
						begin
							N3_var[26] <= 8'd0;
							M3_var[26] <= M3_var[26] + 1;
							if (M3_var[26] >= M3_PARAM-1)
							begin
								conv_done[26] <= 1'd0;
								en_r_kernel26_mem <= 1'd0;
								en_w_result26_mem <= 1'd0;
								we_result26_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [27]
   assign mult_temp_w_27 = dat_read_kernel27_mem * dat_read_img_mem;
   assign mult_temp_w_conc[27] = mult_temp_w_27[24:5]; 
   assign res_temp_w_conc[27] = mult_temp_w_conc[27] + dat_read_result27_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[27] <= 10'd1;
       		delay_done[27] <= 1'd0;
       		delay2_cnt[27] <= 10'd1;
			delay2_done[27] <= 1'd0;
       		N1_var2[27] <= 8'd0;
       		M1_var2[27] <= 9'd0;
       		C1_var4[27] <= 6'd0;
       		N3_var[27] <= 9'd0;
			M3_var[27] <= 9'd0;
			en_r_kernel27_mem <= 1'd0;
			addr_r_kernel27_mem <= 16'd0;
			en_w_result27_mem <= 1'd0;
			we_result27_mem <= 1'd0;
			addr_w_result27_mem <= 16'd0;
			inp_result27_mem <= 16'd0;
			conv_done[27] <= 1'd0;
			result_temp[27] <= 16'd0;// aux reg for $display
			resultset2zero[27] <= 1'd0;
			outp_result27_mem <= 16'd0;
			addr_r_result27_mem <= 1'd0;
			res_temp_conc[27] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[27] == 0)
       	begin
       		en_r_result27_mem <= 1'd1;
			en_w_result27_mem <= 1'd1;
			we_result27_mem <= 1'd1;
			addr_w_result27_mem <= addr_w_result27_mem + 1'd1;
			inp_result27_mem <= 16'd0;
			if ( addr_w_result27_mem >= CONV_ED)
			begin
				addr_w_result27_mem <= 15'd0;
				resultset2zero[27] <= 1'd1;
				we_result27_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[27] == 1 && 
       			biases_recieved == 1 &&	conv_done[27] == 0 &&
       			resultset2zero[27] == 1)
		begin
			en_r_kernel27_mem <= 1'd1;
			en_w_result27_mem <= 1'd1;
			we_result27_mem <= 1'd1;
			//artificial delays
			delay_cnt[27] <= delay_cnt[27] + 1;
			delay2_cnt[27] <= delay2_cnt[27] + 1;
			if(delay_cnt[27] >= 10'd6) begin
				delay_done[27] <= 1'd1;
				delay_cnt[27] <= 7'd0;
			end
			if(delay2_cnt[27] >= 10'd6) begin
				delay2_done[27] <= 1'd1;
			end
			if(delay_done[27] == 1'd0) 
			begin
				inp_result27_mem <= 16'd0;
			end
			res_temp_conc[27] <= res_temp_w_conc[27];
			if(delay_done[27] == 1'd1) 
			begin
				inp_result27_mem <= res_temp_conc[27];
			end
			addr_r_kernel27_mem <= (M1_var2[27])*M1_PARAM*C1_PARAM + (N1_var2[27])*C1_PARAM + (C1_var4[27]) + 1;
			addr_w_result27_mem <= M3_var[27]*N3_PARAM + N3_var[27];
			addr_r_result27_mem <= M3_var[27]*N3_PARAM + N3_var[27];
			if(delay2_done[27] == 1'd1) begin
				N1_var2[27] <= N1_var2[27] + 1;
			end
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
						inp_result27_mem <= res_temp_w_conc[27] + dat_read_biases_mem;	
						result27 <= dat_read_result27_mem;										
						if (N3_var[27] >= N3_PARAM-1)
						begin
							N3_var[27] <= 8'd0;
							M3_var[27] <= M3_var[27] + 1;
							if (M3_var[27] >= M3_PARAM-1)
							begin
								conv_done[27] <= 1'd0;
								en_r_kernel27_mem <= 1'd0;
								en_w_result27_mem <= 1'd0;
								we_result27_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [28]
   assign mult_temp_w_28 = dat_read_kernel28_mem * dat_read_img_mem;
   assign mult_temp_w_conc[28] = mult_temp_w_28[24:5]; 
   assign res_temp_w_conc[28] = mult_temp_w_conc[28] + dat_read_result28_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[28] <= 10'd1;
       		delay_done[28] <= 1'd0;
       		delay2_cnt[28] <= 10'd1;
			delay2_done[28] <= 1'd0;
       		N1_var2[28] <= 8'd0;
       		M1_var2[28] <= 9'd0;
       		C1_var4[28] <= 6'd0;
       		N3_var[28] <= 9'd0;
			M3_var[28] <= 9'd0;
			en_r_kernel28_mem <= 1'd0;
			addr_r_kernel28_mem <= 16'd0;
			en_w_result28_mem <= 1'd0;
			we_result28_mem <= 1'd0;
			addr_w_result28_mem <= 16'd0;
			inp_result28_mem <= 16'd0;
			conv_done[28] <= 1'd0;
			result_temp[28] <= 16'd0;// aux reg for $display
			resultset2zero[28] <= 1'd0;
			outp_result28_mem <= 16'd0;
			addr_r_result28_mem <= 1'd0;
			res_temp_conc[28] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[28] == 0)
       	begin
       		en_r_result28_mem <= 1'd1;
			en_w_result28_mem <= 1'd1;
			we_result28_mem <= 1'd1;
			addr_w_result28_mem <= addr_w_result28_mem + 1'd1;
			inp_result28_mem <= 16'd0;
			if ( addr_w_result28_mem >= CONV_ED)
			begin
				addr_w_result28_mem <= 15'd0;
				resultset2zero[28] <= 1'd1;
				we_result28_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[28] == 1 && 
       			biases_recieved == 1 &&	conv_done[28] == 0 &&
       			resultset2zero[28] == 1)
		begin
			en_r_kernel28_mem <= 1'd1;
			en_w_result28_mem <= 1'd1;
			we_result28_mem <= 1'd1;
			//artificial delays
			delay_cnt[28] <= delay_cnt[28] + 1;
			delay2_cnt[28] <= delay2_cnt[28] + 1;
			if(delay_cnt[28] >= 10'd6) begin
				delay_done[28] <= 1'd1;
				delay_cnt[28] <= 7'd0;
			end
			if(delay2_cnt[28] >= 10'd6) begin
				delay2_done[28] <= 1'd1;
			end
			if(delay_done[28] == 1'd0) 
			begin
				inp_result28_mem <= 16'd0;
			end
			res_temp_conc[28] <= res_temp_w_conc[28];
			if(delay_done[28] == 1'd1) 
			begin
				inp_result28_mem <= res_temp_conc[28];
			end
			addr_r_kernel28_mem <= (M1_var2[28])*M1_PARAM*C1_PARAM + (N1_var2[28])*C1_PARAM + (C1_var4[28]) + 1;
			addr_w_result28_mem <= M3_var[28]*N3_PARAM + N3_var[28];
			addr_r_result28_mem <= M3_var[28]*N3_PARAM + N3_var[28];
			if(delay2_done[28] == 1'd1) begin
				N1_var2[28] <= N1_var2[28] + 1;
			end
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
						inp_result28_mem <= res_temp_w_conc[28] + dat_read_biases_mem;	
						result28 <= dat_read_result28_mem;										
						if (N3_var[28] >= N3_PARAM-1)
						begin
							N3_var[28] <= 8'd0;
							M3_var[28] <= M3_var[28] + 1;
							if (M3_var[28] >= M3_PARAM-1)
							begin
								conv_done[28] <= 1'd0;
								en_r_kernel28_mem <= 1'd0;
								en_w_result28_mem <= 1'd0;
								we_result28_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [29]
   assign mult_temp_w_29 = dat_read_kernel29_mem * dat_read_img_mem;
   assign mult_temp_w_conc[29] = mult_temp_w_29[24:5]; 
   assign res_temp_w_conc[29] = mult_temp_w_conc[29] + dat_read_result29_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[29] <= 10'd1;
       		delay_done[29] <= 1'd0;
       		delay2_cnt[29] <= 10'd1;
			delay2_done[29] <= 1'd0;
       		N1_var2[29] <= 8'd0;
       		M1_var2[29] <= 9'd0;
       		C1_var4[29] <= 6'd0;
       		N3_var[29] <= 9'd0;
			M3_var[29] <= 9'd0;
			en_r_kernel29_mem <= 1'd0;
			addr_r_kernel29_mem <= 16'd0;
			en_w_result29_mem <= 1'd0;
			we_result29_mem <= 1'd0;
			addr_w_result29_mem <= 16'd0;
			inp_result29_mem <= 16'd0;
			conv_done[29] <= 1'd0;
			result_temp[29] <= 16'd0;// aux reg for $display
			resultset2zero[29] <= 1'd0;
			outp_result29_mem <= 16'd0;
			addr_r_result29_mem <= 1'd0;
			res_temp_conc[29] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[29] == 0)
       	begin
       		en_r_result29_mem <= 1'd1;
			en_w_result29_mem <= 1'd1;
			we_result29_mem <= 1'd1;
			addr_w_result29_mem <= addr_w_result29_mem + 1'd1;
			inp_result29_mem <= 16'd0;
			if ( addr_w_result29_mem >= CONV_ED)
			begin
				addr_w_result29_mem <= 15'd0;
				resultset2zero[29] <= 1'd1;
				we_result29_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[29] == 1 && 
       			biases_recieved == 1 &&	conv_done[29] == 0 &&
       			resultset2zero[29] == 1)
		begin
			en_r_kernel29_mem <= 1'd1;
			en_w_result29_mem <= 1'd1;
			we_result29_mem <= 1'd1;
			//artificial delays
			delay_cnt[29] <= delay_cnt[29] + 1;
			delay2_cnt[29] <= delay2_cnt[29] + 1;
			if(delay_cnt[29] >= 10'd6) begin
				delay_done[29] <= 1'd1;
				delay_cnt[29] <= 7'd0;
			end
			if(delay2_cnt[29] >= 10'd6) begin
				delay2_done[29] <= 1'd1;
			end
			if(delay_done[29] == 1'd0) 
			begin
				inp_result29_mem <= 16'd0;
			end
			res_temp_conc[29] <= res_temp_w_conc[29];
			if(delay_done[29] == 1'd1) 
			begin
				inp_result29_mem <= res_temp_conc[29];
			end
			addr_r_kernel29_mem <= (M1_var2[29])*M1_PARAM*C1_PARAM + (N1_var2[29])*C1_PARAM + (C1_var4[29]) + 1;
			addr_w_result29_mem <= M3_var[29]*N3_PARAM + N3_var[29];
			addr_r_result29_mem <= M3_var[29]*N3_PARAM + N3_var[29];
			if(delay2_done[29] == 1'd1) begin
				N1_var2[29] <= N1_var2[29] + 1;
			end
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
						inp_result29_mem <= res_temp_w_conc[29] + dat_read_biases_mem;	
						result29 <= dat_read_result29_mem;										
						if (N3_var[29] >= N3_PARAM-1)
						begin
							N3_var[29] <= 8'd0;
							M3_var[29] <= M3_var[29] + 1;
							if (M3_var[29] >= M3_PARAM-1)
							begin
								conv_done[29] <= 1'd0;
								en_r_kernel29_mem <= 1'd0;
								en_w_result29_mem <= 1'd0;
								we_result29_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [30]
   assign mult_temp_w_30 = dat_read_kernel30_mem * dat_read_img_mem;
   assign mult_temp_w_conc[30] = mult_temp_w_30[24:5]; 
   assign res_temp_w_conc[30] = mult_temp_w_conc[30] + dat_read_result30_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[30] <= 10'd1;
       		delay_done[30] <= 1'd0;
       		delay2_cnt[30] <= 10'd1;
			delay2_done[30] <= 1'd0;
       		N1_var2[30] <= 8'd0;
       		M1_var2[30] <= 9'd0;
       		C1_var4[30] <= 6'd0;
       		N3_var[30] <= 9'd0;
			M3_var[30] <= 9'd0;
			en_r_kernel30_mem <= 1'd0;
			addr_r_kernel30_mem <= 16'd0;
			en_w_result30_mem <= 1'd0;
			we_result30_mem <= 1'd0;
			addr_w_result30_mem <= 16'd0;
			inp_result30_mem <= 16'd0;
			conv_done[30] <= 1'd0;
			result_temp[30] <= 16'd0;// aux reg for $display
			resultset2zero[30] <= 1'd0;
			outp_result30_mem <= 16'd0;
			addr_r_result30_mem <= 1'd0;
			res_temp_conc[30] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[30] == 0)
       	begin
       		en_r_result30_mem <= 1'd1;
			en_w_result30_mem <= 1'd1;
			we_result30_mem <= 1'd1;
			addr_w_result30_mem <= addr_w_result30_mem + 1'd1;
			inp_result30_mem <= 16'd0;
			if ( addr_w_result30_mem >= CONV_ED)
			begin
				addr_w_result30_mem <= 15'd0;
				resultset2zero[30] <= 1'd1;
				we_result30_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[30] == 1 && 
       			biases_recieved == 1 &&	conv_done[30] == 0 &&
       			resultset2zero[30] == 1)
		begin
			en_r_kernel30_mem <= 1'd1;
			en_w_result30_mem <= 1'd1;
			we_result30_mem <= 1'd1;
			//artificial delays
			delay_cnt[30] <= delay_cnt[30] + 1;
			delay2_cnt[30] <= delay2_cnt[30] + 1;
			if(delay_cnt[30] >= 10'd6) begin
				delay_done[30] <= 1'd1;
				delay_cnt[30] <= 7'd0;
			end
			if(delay2_cnt[30] >= 10'd6) begin
				delay2_done[30] <= 1'd1;
			end
			if(delay_done[30] == 1'd0) 
			begin
				inp_result30_mem <= 16'd0;
			end
			res_temp_conc[30] <= res_temp_w_conc[30];
			if(delay_done[30] == 1'd1) 
			begin
				inp_result30_mem <= res_temp_conc[30];
			end
			addr_r_kernel30_mem <= (M1_var2[30])*M1_PARAM*C1_PARAM + (N1_var2[30])*C1_PARAM + (C1_var4[30]) + 1;
			addr_w_result30_mem <= M3_var[30]*N3_PARAM + N3_var[30];
			addr_r_result30_mem <= M3_var[30]*N3_PARAM + N3_var[30];
			if(delay2_done[30] == 1'd1) begin
				N1_var2[30] <= N1_var2[30] + 1;
			end
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
						inp_result30_mem <= res_temp_w_conc[30] + dat_read_biases_mem;	
						result30 <= dat_read_result30_mem;										
						if (N3_var[30] >= N3_PARAM-1)
						begin
							N3_var[30] <= 8'd0;
							M3_var[30] <= M3_var[30] + 1;
							if (M3_var[30] >= M3_PARAM-1)
							begin
								conv_done[30] <= 1'd0;
								en_r_kernel30_mem <= 1'd0;
								en_w_result30_mem <= 1'd0;
								we_result30_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

   ////////////////////////
   // convolution [31]
   assign mult_temp_w_31 = dat_read_kernel31_mem * dat_read_img_mem;
   assign mult_temp_w_conc[31] = mult_temp_w_31[24:5]; 
   assign res_temp_w_conc[31] = mult_temp_w_conc[31] + dat_read_result31_mem;
   always@(posedge clk)
       	if (reset == 1) 
       	begin
       		delay_cnt[31] <= 10'd1;
       		delay_done[31] <= 1'd0;
       		delay2_cnt[31] <= 10'd1;
			delay2_done[31] <= 1'd0;
       		N1_var2[31] <= 8'd0;
       		M1_var2[31] <= 9'd0;
       		C1_var4[31] <= 6'd0;
       		N3_var[31] <= 9'd0;
			M3_var[31] <= 9'd0;
			en_r_kernel31_mem <= 1'd0;
			addr_r_kernel31_mem <= 16'd0;
			en_w_result31_mem <= 1'd0;
			we_result31_mem <= 1'd0;
			addr_w_result31_mem <= 16'd0;
			inp_result31_mem <= 16'd0;
			conv_done[31] <= 1'd0;
			result_temp[31] <= 16'd0;// aux reg for $display
			resultset2zero[31] <= 1'd0;
			outp_result31_mem <= 16'd0;
			addr_r_result31_mem <= 1'd0;
			res_temp_conc[31] <= 16'd0;
       	end
       	else if (reset == 0 && resultset2zero[31] == 0)
       	begin
       		en_r_result31_mem <= 1'd1;
			en_w_result31_mem <= 1'd1;
			we_result31_mem <= 1'd1;
			addr_w_result31_mem <= addr_w_result31_mem + 1'd1;
			inp_result31_mem <= 16'd0;
			if ( addr_w_result31_mem >= CONV_ED)
			begin
				addr_w_result31_mem <= 15'd0;
				resultset2zero[31] <= 1'd1;
				we_result31_mem <= 1'd0; 
			end	
       	end
       	else if (kernel_recieved[31] == 1 && 
       			biases_recieved == 1 &&	conv_done[31] == 0 &&
       			resultset2zero[31] == 1)
		begin
			en_r_kernel31_mem <= 1'd1;
			en_w_result31_mem <= 1'd1;
			we_result31_mem <= 1'd1;
			//artificial delays
			delay_cnt[31] <= delay_cnt[31] + 1;
			delay2_cnt[31] <= delay2_cnt[31] + 1;
			if(delay_cnt[31] >= 10'd6) begin
				delay_done[31] <= 1'd1;
				delay_cnt[31] <= 7'd0;
			end
			if(delay2_cnt[31] >= 10'd6) begin
				delay2_done[31] <= 1'd1;
			end
			if(delay_done[31] == 1'd0) 
			begin
				inp_result31_mem <= 16'd0;
			end
			res_temp_conc[31] <= res_temp_w_conc[31];
			if(delay_done[31] == 1'd1) 
			begin
				inp_result31_mem <= res_temp_conc[31];
			end
			addr_r_kernel31_mem <= (M1_var2[31])*M1_PARAM*C1_PARAM + (N1_var2[31])*C1_PARAM + (C1_var4[31]) + 1;
			addr_w_result31_mem <= M3_var[31]*N3_PARAM + N3_var[31];
			addr_r_result31_mem <= M3_var[31]*N3_PARAM + N3_var[31];
			if(delay2_done[31] == 1'd1) begin
				N1_var2[31] <= N1_var2[31] + 1;
			end
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
						inp_result31_mem <= res_temp_w_conc[31] + dat_read_biases_mem;	
						result31 <= dat_read_result31_mem;										
						if (N3_var[31] >= N3_PARAM-1)
						begin
							N3_var[31] <= 8'd0;
							M3_var[31] <= M3_var[31] + 1;
							if (M3_var[31] >= M3_PARAM-1)
							begin
								conv_done[31] <= 1'd0;
								en_r_kernel31_mem <= 1'd0;
								en_w_result31_mem <= 1'd0;
								we_result31_mem <= 1'd0;
							end
						end
					end
				end
			end
   		end

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

reg [4:0] out_mux_cnt;	
always@(posedge clk)
begin
	out_mux_cnt <= out_mux_cnt + 5'd1;
end

always @(out_mux_cnt, result0, result1, result2, result3, result4, result5, result6, result7, result8, result9, result10, 
result11, result12, result13, result14, result15, result16, result17, result18, result19, result20, result21, result22, result23, 
result24, result25, result26, result27, result28, result29, result30, result31)
	case (out_mux_cnt)
	 5'd0: result_all = result0;
	 5'd1: result_all = result1;
	 5'd2: result_all = result2;
	 5'd3: result_all = result3;
 	 5'd4: result_all = result4;
 	 5'd5: result_all = result5;
 	 5'd6: result_all = result6;
 	 5'd7: result_all = result7;
 	 5'd8: result_all = result8;
 	 5'd9: result_all = result9;
 	 5'd10: result_all = result10;
 	 5'd11: result_all = result11;
 	 5'd12: result_all = result12;
 	 5'd13: result_all = result13;
 	 5'd14: result_all = result14;
 	 5'd15: result_all = result15;
 	 5'd16: result_all = result16;
 	 5'd17: result_all = result17;
 	 5'd18: result_all = result18;
 	 5'd19: result_all = result19;
 	 5'd20: result_all = result20;
 	 5'd21: result_all = result21;
 	 5'd22: result_all = result22;
 	 5'd23: result_all = result23;
 	 5'd24: result_all = result24;
 	 5'd25: result_all = result25;
 	 5'd26: result_all = result26;
 	 5'd27: result_all = result27;
 	 5'd28: result_all = result28;
 	 5'd29: result_all = result29;
 	 5'd30: result_all = result30;
 	 5'd31: result_all = result31;
	endcase

/**/
endmodule
