`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/13/2022 03:45:18 PM
// Design Name: 
// Module Name: tb_driver
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


module tb_driver;

localparam kerSF = 2.0**-14.00;  // Q4.4 scaling factor is 2^-4
localparam imgSF = 2.0**-14.00;
// parameters for BRAM blocks
parameter	RAM_WIDTH_KER = 16;  //16 + 4 because of two excess LSBs and MSBs 
parameter	RAM_ADDR_BITS_KER = 5; // 27 memory rows => we take 2^5=32
parameter	RAM_WIDTH_IMG = 20;
parameter	RAM_ADDR_BITS_IMG = 16; // 49152 memory rows => we take 2^5=32
parameter	RAM_WIDTH_BIAS = 16;
parameter	RAM_ADDR_BITS_BIAS = 6; //


reg								clk;
reg								clk05;
reg								reset;
reg								ram_enable;
reg								write_enable;



reg 	[RAM_ADDR_BITS_KER-1:0]	address_kernel[31:0];
reg 	[RAM_WIDTH_KER-1:0] 	input_kernel_ram[31:0];
reg	signed	[RAM_WIDTH_KER-1:0] 	output_kernel_ram[31:0];


reg 	[RAM_ADDR_BITS_IMG-1:0]	address_image;
reg 	[RAM_WIDTH_IMG-1:0] 	input_image_ram;
wire signed	[RAM_WIDTH_IMG-1:0] 	output_image_ram;


reg 	[RAM_ADDR_BITS_BIAS-1:0]address_biases;
reg 	[RAM_WIDTH_BIAS-1:0] 	input_biases_ram;
wire signed	[RAM_WIDTH_BIAS-1:0] 	output_biases_ram;



////////////////////////////
//generating 32 bram blocks for kernel
////////////////////////////
/*
genvar i;
generate
	for (i = 0; i < 32; i = i + 1) begin:ker_mem*/

bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem1.txt"		),
	.INIT_START_ADDR(0				),
	.INIT_END_ADDR	(31					)
)
ker_mem1
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[0]	),
	.input_data		(input_kernel_ram[0]),
	.output_data    (output_kernel_ram[0])
);
	/*end
endgenerate*/
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem2.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem2
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[1]	),
	.input_data		(input_kernel_ram[1]),
	.output_data    (output_kernel_ram[1])
);

bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem3.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem3
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[2]	),
	.input_data		(input_kernel_ram[2]),
	.output_data    (output_kernel_ram[2])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem4.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem4
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[3]	),
	.input_data		(input_kernel_ram[3]),
	.output_data    (output_kernel_ram[3])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem5.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem5
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[4]	),
	.input_data		(input_kernel_ram[4]),
	.output_data    (output_kernel_ram[4])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem6.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem6
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[5]	),
	.input_data		(input_kernel_ram[5]),
	.output_data    (output_kernel_ram[5])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem7.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem7
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[6]	),
	.input_data		(input_kernel_ram[6]),
	.output_data    (output_kernel_ram[6])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem8.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem8
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[7]	),
	.input_data		(input_kernel_ram[7]),
	.output_data    (output_kernel_ram[7])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem9.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem9
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[8]	),
	.input_data		(input_kernel_ram[8]),
	.output_data    (output_kernel_ram[8])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem10.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem10
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[9]	),
	.input_data		(input_kernel_ram[9]),
	.output_data    (output_kernel_ram[9])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem11.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem11
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[10]	),
	.input_data		(input_kernel_ram[10]),
	.output_data    (output_kernel_ram[10])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem12.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem12
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[11]	),
	.input_data		(input_kernel_ram[11]),
	.output_data    (output_kernel_ram[11])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem13.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem13
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[12]	),
	.input_data		(input_kernel_ram[12]),
	.output_data    (output_kernel_ram[12])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem14.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem14
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[13]	),
	.input_data		(input_kernel_ram[13]),
	.output_data    (output_kernel_ram[13])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem15.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem15
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[14]	),
	.input_data		(input_kernel_ram[14]),
	.output_data    (output_kernel_ram[14])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem16.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem16
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[15]	),
	.input_data		(input_kernel_ram[15]),
	.output_data    (output_kernel_ram[15])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem17.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem17
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[16]	),
	.input_data		(input_kernel_ram[16]),
	.output_data    (output_kernel_ram[16])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem18.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem18
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[17]	),
	.input_data		(input_kernel_ram[17]),
	.output_data    (output_kernel_ram[17])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem19.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem19
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[18]	),
	.input_data		(input_kernel_ram[18]),
	.output_data    (output_kernel_ram[18])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem20.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem20
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[19]	),
	.input_data		(input_kernel_ram[19]),
	.output_data    (output_kernel_ram[19])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem21.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem21
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[20]	),
	.input_data		(input_kernel_ram[20]),
	.output_data    (output_kernel_ram[20])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem22.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem22
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[21]	),
	.input_data		(input_kernel_ram[21]),
	.output_data    (output_kernel_ram[21])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem23.txt"	),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem23
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[22]	),
	.input_data		(input_kernel_ram[22]),
	.output_data    (output_kernel_ram[22])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem24.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem24
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[23]	),
	.input_data		(input_kernel_ram[23]),
	.output_data    (output_kernel_ram[23])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem25.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem25
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[24]	),
	.input_data		(input_kernel_ram[24]),
	.output_data    (output_kernel_ram[24])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem26.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem26
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[25]	),
	.input_data		(input_kernel_ram[25]),
	.output_data    (output_kernel_ram[25])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem27.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem27
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[26]	),
	.input_data		(input_kernel_ram[26]),
	.output_data    (output_kernel_ram[26])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem28.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem28
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[27]	),
	.input_data		(input_kernel_ram[27]),
	.output_data    (output_kernel_ram[27])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem29.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem29
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[28]	),
	.input_data		(input_kernel_ram[28]),
	.output_data    (output_kernel_ram[28])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem30.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem30
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[29]	),
	.input_data		(input_kernel_ram[29]),
	.output_data    (output_kernel_ram[29])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem31.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem31
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[30]	),
	.input_data		(input_kernel_ram[30]),
	.output_data    (output_kernel_ram[30])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_KER 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
	.DATA_FILE 		("ker_mem32.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
)
ker_mem32
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_kernel[31]	),
	.input_data		(input_kernel_ram[31]),
	.output_data    (output_kernel_ram[31])
);
////////////////////////////
//generating 1 bram blocks for image
////////////////////////////
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("tulip1.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(49152				)
)
image_mem_bram
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image		),
	.input_data		(input_image_ram	),
	.output_data    (output_image_ram	)
);

////////////////////////////
//generating 1 bram blocks for biases
////////////////////////////
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_BIAS	),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_BIAS	),
	.DATA_FILE 		("biases.txt"		),
	.INIT_START_ADDR(0				),
	.INIT_END_ADDR	(31				)
)
biases_mem_bram
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_biases		),
	.input_data		(input_biases_ram	),
	.output_data    (output_biases_ram	)
);

////////////////////////////
//firstConv block
////////////////////////////
wire 							ker_vld_next[31:0];
wire 							ker_rdy_next[31:0];
reg	 [RAM_WIDTH_KER-1:0]		ker0;

reg								img_rdy;
reg								img_vld;
wire 							img_vld_next;
wire 							img_rdy_next;
reg	 [RAM_WIDTH_IMG-1:0]		img;
reg								bias_rdy;
reg								bias_vld;
wire 							bias_vld_next;
wire 							bias_rdy_next;
reg	 [RAM_WIDTH_BIAS-1:0]		bias;
firstConv
#(
	.RAM_WIDTH_KER	(RAM_WIDTH_KER		),
	.RAM_WIDTH_BIAS	(RAM_WIDTH_BIAS		),
	.RAM_WIDTH_IMG	(RAM_WIDTH_IMG		),
	.KER_MEM_LENGTH (27					),
	.IMAGE_MEM_LENGTH(49152				)
)
Conv1
(
	.clk			(clk				 ),
	.reset			(reset				 ),
	
	.image			(img				 ),
	.image_vld		(img_vld_next		 ),
	.image_rdy		(img_rdy_next		 ),
	
	.biases			(bias				 ),
	.biases_vld		(bias_vld_next		 ),
	.biases_rdy		(bias_rdy_next		 ),
	
	.kernel0		(ker0				 ),
	.kernel_vld0	(ker_vld_next[0]	 ),
	.kernel_rdy0	(ker_rdy_next[0]	 ),
	.kernel1		(output_kernel_ram[1]),
	.kernel2		(output_kernel_ram[2]),
	.kernel3		(output_kernel_ram[3]),
	.kernel4		(output_kernel_ram[4]),
	.kernel5		(output_kernel_ram[5]),
	.kernel6		(output_kernel_ram[6]),
	.kernel7		(output_kernel_ram[7]),
	.kernel8		(output_kernel_ram[8]),
	.kernel9		(output_kernel_ram[9]),
	.kernel10		(output_kernel_ram[10]),
	.kernel11		(output_kernel_ram[11]),
	.kernel12		(output_kernel_ram[12]),
	.kernel13		(output_kernel_ram[13]),
	.kernel14		(output_kernel_ram[14]),
	.kernel15		(output_kernel_ram[15]),
	.kernel16		(output_kernel_ram[16]),
	.kernel17		(output_kernel_ram[17]),
	.kernel18		(output_kernel_ram[18]),
	.kernel19		(output_kernel_ram[19]),
	.kernel20		(output_kernel_ram[20]),
	.kernel21		(output_kernel_ram[21]),
	.kernel22		(output_kernel_ram[22]),
	.kernel23		(output_kernel_ram[23]),
	.kernel24		(output_kernel_ram[24]),
	.kernel25		(output_kernel_ram[25]),
	.kernel26		(output_kernel_ram[26]),
	.kernel27		(output_kernel_ram[27]),
	.kernel28		(output_kernel_ram[28]),
	.kernel29		(output_kernel_ram[29]),
	.kernel30		(output_kernel_ram[30]),
	.kernel31		(output_kernel_ram[31])
);	
reg								ker_rdy[31:0];
reg								ker_vld[31:0];
rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker0
(
	.vld			(ker_vld[0]			  ),
	.rdy			(ker_rdy[0]			  ),
	.i_dat			(output_kernel_ram[0] ),
	.vld_nxt		(ker_vld_next[0]      ),
	.rdy_nxt		(ker_rdy_next[0]	  ),
	.o_dat			(ker0				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);



rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_image
(
	.vld			(img_vld			  ),
	.rdy			(img_rdy			  ),
	.i_dat			(output_image_ram     ),
	.vld_nxt		(img_vld_next         ),
	.rdy_nxt		(img_rdy_next	      ),
	.o_dat			(img				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_BIAS		  )
)
rdyval_bias
(
	.vld			(bias_vld			  ),
	.rdy			(bias_rdy			  ),
	.i_dat			(output_biases_ram     ),
	.vld_nxt		(bias_vld_next         ),
	.rdy_nxt		(bias_rdy_next	      ),
	.o_dat			(bias				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

//////////////////
///generate clocks
initial
begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial
begin
	clk05 = 0;
	forever #10 clk05 = ~clk05;
end

//////////////////
//variables for testbench
integer j;
integer disp_address = address_kernel[0];

/////////////////
//kernel initial block
initial
begin
	$dumpfile("wave.vcd");
	$dumpvars(0, tb_driver);
	reset				= 1;
	for(j = 0; j < 31; j = j + 1) begin
		address_kernel[j] 	= 0;
		input_kernel_ram[j]	= 0;
	end
	
	#10;
	reset				= 0;
	ram_enable			= 1;
	write_enable		= 0;
	input_image_ram		= 0;
	
	////////////////////////////
	//read kernel BRAM		
	//each loop cycle switches to next address inside BRAM
	repeat(2) @(posedge clk);
	for (address_kernel[0] = 0; address_kernel[0] < 27; 
			address_kernel[0] = address_kernel[0] +1)
			begin
				if (address_kernel[0] > 0)
				begin
					ker_vld[0]			= 1;
				end
				begin
					repeat(2) @(posedge clk);/*
					$display ("KERNEL0[%d] = %f | %b",
							 address_kernel[0], 
							 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
				end
			end	
	
	//////////////////////////
	//loops for displaying values in console
	/*
	$display("Reading data from BRAM");
		repeat(2) @(posedge clk);
		for (address_biases = 0; address_biases < 31; 
		address_biases = address_biases +1)
		begin
			@(posedge clk);
			#1 $display ("DATA[%d] = %h | %f",
						 address_biases, 
						output_biases_ram, $itor(output_biases_ram*kerSF));
		end
		
		repeat(2) @(posedge clk);
		*/
end


initial begin
	
	#11
	////////////////////////////
	//read image BRAM		
	//each loop cycle switches to next address inside BRAM
	repeat(2) @(posedge clk);
	for (address_image = 0; address_image < 49152; 
		address_image = address_image +1)
		begin
			if (address_image > 0)
			begin
				img_vld	= 1;
			end
			repeat(2) @(posedge clk);/*
			$display ("IMG[%d] = %f | %b",
					 address_image, 
					$itor(imgSF*output_image_ram), output_image_ram);//$itor(output_biases_ram*imgSF));*/
		end
	
end

initial begin
	
	#11
	
	////////////////////////////
	//read biases BRAM		
	//each loop cycle switches to next address inside BRAM
	repeat(2) @(posedge clk);
	for (address_biases = 0; address_biases < 32; 
			address_biases = address_biases +1)
			begin
				
				if (address_biases > 0)
				begin
					bias_vld				= 1;
				end
				begin
					repeat(2) @(posedge clk);/*
					$display ("BIASES[%d] = %h | %b",
							 address_biases, 
							output_biases_ram, output_biases_ram);/**/
				end
			end
end		
 	

endmodule
