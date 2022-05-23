`timescale 1ns / 1ps


module tb_driver;

localparam kerSF = 2.0**-14.00;  // 
localparam imgSF = 2.0**-14.00;
// parameters for BRAM blocks
parameter	RAM_WIDTH_KER = 16;  //16 + 4 because of two excess LSBs and MSBs 
parameter	RAM_ADDR_BITS_KER = 5; // 27 memory rows => we take 2^5=32
parameter	RAM_WIDTH_IMG = 16;
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
);/**/
////////////////////////////
//generating 1 bram blocks for image
////////////////////////////
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("tulip_zpadded_flat.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(130*130*3)//49152				)
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
reg	 [RAM_WIDTH_KER-1:0]		ker[31:0];

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
	
	.kernel0		(ker[0]				 ),
	.kernel1		(ker[1]				 ),
	.kernel2		(ker[2]				 ),
	.kernel3		(ker[3]				 ),
	.kernel4		(ker[4]				 ),
	.kernel5		(ker[5]				 ),
	.kernel6		(ker[6]				 ),
	.kernel7		(ker[7]				 ),
	.kernel8		(ker[8]				 ),
	.kernel9		(ker[9]				 ),
	.kernel10		(ker[10]				 ),
	.kernel11		(ker[11]				 ),
	.kernel12		(ker[12]				 ),
	.kernel13		(ker[13]				 ),
	.kernel14		(ker[14]				 ),
	.kernel15		(ker[15]				 ),
	.kernel16		(ker[16]				 ),
	.kernel17		(ker[17]				 ),
	.kernel18		(ker[18]				 ),
	.kernel19		(ker[19]				 ),
	.kernel20		(ker[20]				 ),
	.kernel21		(ker[21]				 ),
	.kernel22		(ker[22]				 ),
	.kernel23		(ker[23]				 ),
	.kernel24		(ker[24]				 ),
	.kernel25		(ker[25]				 ),
	.kernel26		(ker[26]				 ),
	.kernel27		(ker[27]				 ),
	.kernel28		(ker[28]				 ),
	.kernel29		(ker[29]				 ),
	.kernel30		(ker[30]				 ),
	.kernel31		(ker[31]				 ),/**/
	.kernel_vld0	(ker_vld_next[0]	 ),
	.kernel_rdy0	(ker_rdy_next[0]	 ),
	.kernel_vld1	(ker_vld_next[1]	 ),
	.kernel_rdy1	(ker_rdy_next[1]	 ),
	.kernel_vld2	(ker_vld_next[2]	 ),
	.kernel_rdy2	(ker_rdy_next[2]	 ),
	.kernel_vld3	(ker_vld_next[3]	 ),
	.kernel_rdy3	(ker_rdy_next[3]	 ),
	.kernel_vld4	(ker_vld_next[4]	 ),
	.kernel_rdy4	(ker_rdy_next[4]	 ),
	.kernel_vld5	(ker_vld_next[5]	 ),
	.kernel_rdy5	(ker_rdy_next[5]	 ),
	.kernel_vld6	(ker_vld_next[6]	 ),
	.kernel_rdy6	(ker_rdy_next[6]	 ),
	.kernel_vld7	(ker_vld_next[7]	 ),
	.kernel_rdy7	(ker_rdy_next[7]	 ),
	.kernel_vld8	(ker_vld_next[8]	 ),
	.kernel_rdy8	(ker_rdy_next[8]	 ),
	.kernel_vld9	(ker_vld_next[9]	 ),
	.kernel_rdy9	(ker_rdy_next[9]	 ),
	.kernel_vld10	(ker_vld_next[10]	 ),
	.kernel_rdy10	(ker_rdy_next[10]	 ),
	.kernel_vld11	(ker_vld_next[11]	 ),
	.kernel_rdy11	(ker_rdy_next[11]	 ),
	.kernel_vld12	(ker_vld_next[12]	 ),
	.kernel_rdy12	(ker_rdy_next[12]	 ),
	.kernel_vld13	(ker_vld_next[13]	 ),
	.kernel_rdy13	(ker_rdy_next[13]	 ),
	.kernel_vld14	(ker_vld_next[14]	 ),
	.kernel_rdy14	(ker_rdy_next[14]	 ),
	.kernel_vld15	(ker_vld_next[15]	 ),
	.kernel_rdy15	(ker_rdy_next[15]	 ),	
	.kernel_rdy16	(ker_rdy_next[16]	 ),
	.kernel_vld16	(ker_vld_next[16]	 ),
	.kernel_rdy17	(ker_rdy_next[17]	 ),
	.kernel_vld17	(ker_vld_next[17]	 ),
	.kernel_rdy18	(ker_rdy_next[18]	 ),
	.kernel_vld18	(ker_vld_next[18]	 ),
	.kernel_rdy19	(ker_rdy_next[19]	 ),
	.kernel_vld19	(ker_vld_next[19]	 ),
	.kernel_rdy20	(ker_rdy_next[20]	 ),
	.kernel_vld20	(ker_vld_next[20]	 ),
	.kernel_rdy21	(ker_rdy_next[21]	 ),
	.kernel_vld21	(ker_vld_next[21]	 ),
	.kernel_rdy22	(ker_rdy_next[22]	 ),
	.kernel_vld22	(ker_vld_next[22]	 ),
	.kernel_rdy23	(ker_rdy_next[23]	 ),
	.kernel_vld23	(ker_vld_next[23]	 ),
	.kernel_rdy24	(ker_rdy_next[24]	 ),
	.kernel_vld24	(ker_vld_next[24]	 ),
	.kernel_rdy25	(ker_rdy_next[25]	 ),
	.kernel_vld25	(ker_vld_next[25]	 ),
	.kernel_rdy26	(ker_rdy_next[26]	 ),		
	.kernel_vld26	(ker_vld_next[26]	 ),
	.kernel_rdy27	(ker_rdy_next[27]	 ),
	.kernel_vld27	(ker_vld_next[27]	 ),
	.kernel_rdy28	(ker_rdy_next[28]	 ),
	.kernel_vld28	(ker_vld_next[28]	 ),
	.kernel_rdy29	(ker_rdy_next[29]	 ),
	.kernel_vld29	(ker_vld_next[29]	 ),
	.kernel_rdy30	(ker_rdy_next[30]	 ),
	.kernel_vld30	(ker_vld_next[30]	 ),
	.kernel_rdy31	(ker_rdy_next[31]	 ),
	.kernel_vld31	(ker_vld_next[31]	 )/**/

);	
//-----------------------------------------------------------------------------------------------
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
	.o_dat			(ker[0]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker1
(
	.vld			(ker_vld[1]			  ),
	.rdy			(ker_rdy[1]			  ),
	.i_dat			(output_kernel_ram[1] ),
	.vld_nxt		(ker_vld_next[1]      ),
	.rdy_nxt		(ker_rdy_next[1]	  ),
	.o_dat			(ker[1]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker2
(
	.vld			(ker_vld[2]			  ),
	.rdy			(ker_rdy[2]			  ),
	.i_dat			(output_kernel_ram[2] ),
	.vld_nxt		(ker_vld_next[2]      ),
	.rdy_nxt		(ker_rdy_next[2]	  ),
	.o_dat			(ker[2]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker3
(
	.vld			(ker_vld[3]			  ),
	.rdy			(ker_rdy[3]			  ),
	.i_dat			(output_kernel_ram[3] ),
	.vld_nxt		(ker_vld_next[3]      ),
	.rdy_nxt		(ker_rdy_next[3]	  ),
	.o_dat			(ker[3]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);
rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)

rdyval_ker4
(
	.vld			(ker_vld[4]			  ),
	.rdy			(ker_rdy[4]			  ),
	.i_dat			(output_kernel_ram[4] ),
	.vld_nxt		(ker_vld_next[4]      ),
	.rdy_nxt		(ker_rdy_next[4]	  ),
	.o_dat			(ker[4]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker5
(
	.vld			(ker_vld[5]			  ),
	.rdy			(ker_rdy[5]			  ),
	.i_dat			(output_kernel_ram[5] ),
	.vld_nxt		(ker_vld_next[5]      ),
	.rdy_nxt		(ker_rdy_next[5]	  ),
	.o_dat			(ker[5]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);


rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker6
(
	.vld			(ker_vld[6]			  ),
	.rdy			(ker_rdy[6]			  ),
	.i_dat			(output_kernel_ram[6] ),
	.vld_nxt		(ker_vld_next[6]      ),
	.rdy_nxt		(ker_rdy_next[6]	  ),
	.o_dat			(ker[6]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker7
(
	.vld			(ker_vld[7]			  ),
	.rdy			(ker_rdy[7]			  ),
	.i_dat			(output_kernel_ram[7] ),
	.vld_nxt		(ker_vld_next[7]      ),
	.rdy_nxt		(ker_rdy_next[7]	  ),
	.o_dat			(ker[7]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker8
(
	.vld			(ker_vld[8]			  ),
	.rdy			(ker_rdy[8]			  ),
	.i_dat			(output_kernel_ram[8] ),
	.vld_nxt		(ker_vld_next[8]      ),
	.rdy_nxt		(ker_rdy_next[8]	  ),
	.o_dat			(ker[8]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker9
(
	.vld			(ker_vld[9]			  ),
	.rdy			(ker_rdy[9]			  ),
	.i_dat			(output_kernel_ram[9] ),
	.vld_nxt		(ker_vld_next[9]      ),
	.rdy_nxt		(ker_rdy_next[9]	  ),
	.o_dat			(ker[9]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker10
(
	.vld			(ker_vld[10]			  ),
	.rdy			(ker_rdy[10]			  ),
	.i_dat			(output_kernel_ram[10] ),
	.vld_nxt		(ker_vld_next[10]      ),
	.rdy_nxt		(ker_rdy_next[10]	  ),
	.o_dat			(ker[10]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker11
(
	.vld			(ker_vld[11]			  ),
	.rdy			(ker_rdy[11]			  ),
	.i_dat			(output_kernel_ram[11] ),
	.vld_nxt		(ker_vld_next[11]      ),
	.rdy_nxt		(ker_rdy_next[11]	  ),
	.o_dat			(ker[11]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker12
(
	.vld			(ker_vld[12]			  ),
	.rdy			(ker_rdy[12]			  ),
	.i_dat			(output_kernel_ram[12] ),
	.vld_nxt		(ker_vld_next[12]      ),
	.rdy_nxt		(ker_rdy_next[12]	  ),
	.o_dat			(ker[12]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker13
(
	.vld			(ker_vld[13]			  ),
	.rdy			(ker_rdy[13]			  ),
	.i_dat			(output_kernel_ram[13] ),
	.vld_nxt		(ker_vld_next[13]      ),
	.rdy_nxt		(ker_rdy_next[13]	  ),
	.o_dat			(ker[13]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker14
(
	.vld			(ker_vld[14]			  ),
	.rdy			(ker_rdy[14]			  ),
	.i_dat			(output_kernel_ram[14] ),
	.vld_nxt		(ker_vld_next[14]      ),
	.rdy_nxt		(ker_rdy_next[14]	  ),
	.o_dat			(ker[14]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker15
(
	.vld			(ker_vld[15]			  ),
	.rdy			(ker_rdy[15]			  ),
	.i_dat			(output_kernel_ram[15] ),
	.vld_nxt		(ker_vld_next[15]      ),
	.rdy_nxt		(ker_rdy_next[15]	  ),
	.o_dat			(ker[15]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker16
(
	.vld			(ker_vld[16]			  ),
	.rdy			(ker_rdy[16]			  ),
	.i_dat			(output_kernel_ram[16] ),
	.vld_nxt		(ker_vld_next[16]      ),
	.rdy_nxt		(ker_rdy_next[16]	  ),
	.o_dat			(ker[16]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker17
(
	.vld			(ker_vld[17]			  ),
	.rdy			(ker_rdy[17]			  ),
	.i_dat			(output_kernel_ram[17] ),
	.vld_nxt		(ker_vld_next[17]      ),
	.rdy_nxt		(ker_rdy_next[17]	  ),
	.o_dat			(ker[17]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker18
(
	.vld			(ker_vld[18]			  ),
	.rdy			(ker_rdy[18]			  ),
	.i_dat			(output_kernel_ram[18] ),
	.vld_nxt		(ker_vld_next[18]      ),
	.rdy_nxt		(ker_rdy_next[18]	  ),
	.o_dat			(ker[18]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker19
(
	.vld			(ker_vld[19]			  ),
	.rdy			(ker_rdy[19]			  ),
	.i_dat			(output_kernel_ram[19] ),
	.vld_nxt		(ker_vld_next[19]      ),
	.rdy_nxt		(ker_rdy_next[19]	  ),
	.o_dat			(ker[19]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker20
(
	.vld			(ker_vld[20]			  ),
	.rdy			(ker_rdy[20]			  ),
	.i_dat			(output_kernel_ram[20] ),
	.vld_nxt		(ker_vld_next[20]      ),
	.rdy_nxt		(ker_rdy_next[20]	  ),
	.o_dat			(ker[20]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker21
(
	.vld			(ker_vld[21]			  ),
	.rdy			(ker_rdy[21]			  ),
	.i_dat			(output_kernel_ram[21] ),
	.vld_nxt		(ker_vld_next[21]      ),
	.rdy_nxt		(ker_rdy_next[21]	  ),
	.o_dat			(ker[21]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker22
(
	.vld			(ker_vld[22]			  ),
	.rdy			(ker_rdy[22]			  ),
	.i_dat			(output_kernel_ram[22] ),
	.vld_nxt		(ker_vld_next[22]      ),
	.rdy_nxt		(ker_rdy_next[22]	  ),
	.o_dat			(ker[22]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker23
(
	.vld			(ker_vld[23]			  ),
	.rdy			(ker_rdy[23]			  ),
	.i_dat			(output_kernel_ram[23] ),
	.vld_nxt		(ker_vld_next[23]      ),
	.rdy_nxt		(ker_rdy_next[23]	  ),
	.o_dat			(ker[23]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker24
(
	.vld			(ker_vld[24]			  ),
	.rdy			(ker_rdy[24]			  ),
	.i_dat			(output_kernel_ram[24] ),
	.vld_nxt		(ker_vld_next[24]      ),
	.rdy_nxt		(ker_rdy_next[24]	  ),
	.o_dat			(ker[24]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker25
(
	.vld			(ker_vld[25]			  ),
	.rdy			(ker_rdy[25]			  ),
	.i_dat			(output_kernel_ram[25] ),
	.vld_nxt		(ker_vld_next[25]      ),
	.rdy_nxt		(ker_rdy_next[25]	  ),
	.o_dat			(ker[25]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker26
(
	.vld			(ker_vld[26]			  ),
	.rdy			(ker_rdy[26]			  ),
	.i_dat			(output_kernel_ram[26] ),
	.vld_nxt		(ker_vld_next[26]      ),
	.rdy_nxt		(ker_rdy_next[26]	  ),
	.o_dat			(ker[26]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker27
(
	.vld			(ker_vld[27]			  ),
	.rdy			(ker_rdy[27]			  ),
	.i_dat			(output_kernel_ram[27] ),
	.vld_nxt		(ker_vld_next[27]      ),
	.rdy_nxt		(ker_rdy_next[27]	  ),
	.o_dat			(ker[27]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker28
(
	.vld			(ker_vld[28]			  ),
	.rdy			(ker_rdy[28]			  ),
	.i_dat			(output_kernel_ram[28] ),
	.vld_nxt		(ker_vld_next[28]      ),
	.rdy_nxt		(ker_rdy_next[28]	  ),
	.o_dat			(ker[28]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker29
(
	.vld			(ker_vld[29]			  ),
	.rdy			(ker_rdy[29]			  ),
	.i_dat			(output_kernel_ram[29] ),
	.vld_nxt		(ker_vld_next[29]      ),
	.rdy_nxt		(ker_rdy_next[29]	  ),
	.o_dat			(ker[29]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker30
(
	.vld			(ker_vld[30]			  ),
	.rdy			(ker_rdy[30]			  ),
	.i_dat			(output_kernel_ram[30] ),
	.vld_nxt		(ker_vld_next[30]      ),
	.rdy_nxt		(ker_rdy_next[30]	  ),
	.o_dat			(ker[30]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_KER		  )
)
rdyval_ker31
(
	.vld			(ker_vld[31]			  ),
	.rdy			(ker_rdy[31]			  ),
	.i_dat			(output_kernel_ram[31] ),
	.vld_nxt		(ker_vld_next[31]      ),
	.rdy_nxt		(ker_rdy_next[31]	  ),
	.o_dat			(ker[31]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);
/**/
//----------------------------------------------------------------------------------------------
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
integer j, p;
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
end	

initial begin
	
	#11		
	repeat(2) @(posedge clk);
	for (address_kernel[1] = 0; address_kernel[1] < 27; 
			address_kernel[1] = address_kernel[1] +1)
	begin
		if (address_kernel[1] > 0)
		begin
			ker_vld[1]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	

initial begin
	
	#11	
	p = 2;
	repeat(2) @(posedge clk);
	for (address_kernel[2] = 0; address_kernel[2] < 27; 
			address_kernel[2] = address_kernel[2] +1)
	begin
		if (address_kernel[2] > 0)
		begin
			ker_vld[2]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
	
	initial begin
		
		#11		
	p = 3;
	repeat(2) @(posedge clk);
	for (address_kernel[3] = 0; address_kernel[3] < 27; 
			address_kernel[3] = address_kernel[3] +1)
	begin
		if (address_kernel[3] > 0)
		begin
			ker_vld[3]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
	
	initial begin
		
		#11		
	p = 4;
	repeat(2) @(posedge clk);
	for (address_kernel[4] = 0; address_kernel[4] < 27; 
			address_kernel[4] = address_kernel[4] +1)
	begin
		if (address_kernel[4] > 0)
		begin
			ker_vld[4]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
	
	initial begin
		
		#11		
	p = 5;
	repeat(2) @(posedge clk);
	for (address_kernel[5] = 0; address_kernel[5] < 27; 
			address_kernel[5] = address_kernel[5] +1)
	begin
		if (address_kernel[5] > 0)
		begin
			ker_vld[5]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
	
	initial begin
		
		#11		
	p = 6;
	repeat(2) @(posedge clk);
	for (address_kernel[6] = 0; address_kernel[6] < 27; 
			address_kernel[6] = address_kernel[6] +1)
	begin
		if (address_kernel[6] > 0)
		begin
			ker_vld[6]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
	
initial begin
		
		#11		
	p = 7;
	repeat(2) @(posedge clk);
	for (address_kernel[7] = 0; address_kernel[7] < 27; 
			address_kernel[7] = address_kernel[7] +1)
	begin
		if (address_kernel[7] > 0)
		begin
			ker_vld[7]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 8;
	repeat(2) @(posedge clk);
	for (address_kernel[8] = 0; address_kernel[8] < 27; 
			address_kernel[8] = address_kernel[8] +1)
	begin
		if (address_kernel[8] > 0)
		begin
			ker_vld[8]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 9;
	repeat(2) @(posedge clk);
	for (address_kernel[9] = 0; address_kernel[9] < 27; 
			address_kernel[9] = address_kernel[9] +1)
	begin
		if (address_kernel[9] > 0)
		begin
			ker_vld[9]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 10;
	repeat(2) @(posedge clk);
	for (address_kernel[10] = 0; address_kernel[10] < 27; 
			address_kernel[10] = address_kernel[10] +1)
	begin
		if (address_kernel[10] > 0)
		begin
			ker_vld[10]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 11;
	repeat(2) @(posedge clk);
	for (address_kernel[11] = 0; address_kernel[11] < 27; 
			address_kernel[11] = address_kernel[11] +1)
	begin
		if (address_kernel[11] > 0)
		begin
			ker_vld[11]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 12;
	repeat(2) @(posedge clk);
	for (address_kernel[12] = 0; address_kernel[12] < 27; 
			address_kernel[12] = address_kernel[12] +1)
	begin
		if (address_kernel[12] > 0)
		begin
			ker_vld[12]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 13;
	repeat(2) @(posedge clk);
	for (address_kernel[13] = 0; address_kernel[13] < 27; 
			address_kernel[13] = address_kernel[13] +1)
	begin
		if (address_kernel[13] > 0)
		begin
			ker_vld[13]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 14;
	repeat(2) @(posedge clk);
	for (address_kernel[14] = 0; address_kernel[14] < 27; 
			address_kernel[14] = address_kernel[14] +1)
	begin
		if (address_kernel[14] > 0)
		begin
			ker_vld[14]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 15;
	repeat(2) @(posedge clk);
	for (address_kernel[15] = 0; address_kernel[15] < 27; 
			address_kernel[15] = address_kernel[15] +1)
	begin
		if (address_kernel[15] > 0)
		begin
			ker_vld[15]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 16;
	repeat(2) @(posedge clk);
	for (address_kernel[16] = 0; address_kernel[16] < 27; 
			address_kernel[16] = address_kernel[16] +1)
	begin
		if (address_kernel[16] > 0)
		begin
			ker_vld[16]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 17;
	repeat(2) @(posedge clk);
	for (address_kernel[17] = 0; address_kernel[17] < 27; 
			address_kernel[17] = address_kernel[17] +1)
	begin
		if (address_kernel[17] > 0)
		begin
			ker_vld[17]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 18;
	repeat(2) @(posedge clk);
	for (address_kernel[18] = 0; address_kernel[18] < 27; 
			address_kernel[18] = address_kernel[18] +1)
	begin
		if (address_kernel[18] > 0)
		begin
			ker_vld[18]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 19;
	repeat(2) @(posedge clk);
	for (address_kernel[29] = 0; address_kernel[19] < 27; 
			address_kernel[19] = address_kernel[19] +1)
	begin
		if (address_kernel[19] > 0)
		begin
			ker_vld[19]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 20;
	repeat(2) @(posedge clk);
	for (address_kernel[20] = 0; address_kernel[20] < 27; 
			address_kernel[20] = address_kernel[20] +1)
	begin
		if (address_kernel[20] > 0)
		begin
			ker_vld[20]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 21;
	repeat(2) @(posedge clk);
	for (address_kernel[21] = 0; address_kernel[21] < 27; 
			address_kernel[21] = address_kernel[21] +1)
	begin
		if (address_kernel[21] > 0)
		begin
			ker_vld[21]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 22;
	repeat(2) @(posedge clk);
	for (address_kernel[22] = 0; address_kernel[22] < 27; 
			address_kernel[22] = address_kernel[22] +1)
	begin
		if (address_kernel[22] > 0)
		begin
			ker_vld[22]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 23;
	repeat(2) @(posedge clk);
	for (address_kernel[23] = 0; address_kernel[23] < 27; 
			address_kernel[23] = address_kernel[23] +1)
	begin
		if (address_kernel[23] > 0)
		begin
			ker_vld[23]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 24;
	repeat(2) @(posedge clk);
	for (address_kernel[24] = 0; address_kernel[24] < 27; 
			address_kernel[24] = address_kernel[24] +1)
	begin
		if (address_kernel[24] > 0)
		begin
			ker_vld[24]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 25;
	repeat(2) @(posedge clk);
	for (address_kernel[25] = 0; address_kernel[25] < 27; 
			address_kernel[25] = address_kernel[25] +1)
	begin
		if (address_kernel[25] > 0)
		begin
			ker_vld[25]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 26;
	repeat(2) @(posedge clk);
	for (address_kernel[26] = 0; address_kernel[26] < 27; 
			address_kernel[26] = address_kernel[26] +1)
	begin
		if (address_kernel[26] > 0)
		begin
			ker_vld[26]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 27;
	repeat(2) @(posedge clk);
	for (address_kernel[27] = 0; address_kernel[27] < 27; 
			address_kernel[27] = address_kernel[27] +1)
	begin
		if (address_kernel[27] > 0)
		begin
			ker_vld[27]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 28;
	repeat(2) @(posedge clk);
	for (address_kernel[28] = 0; address_kernel[28] < 27; 
			address_kernel[28] = address_kernel[28] +1)
	begin
		if (address_kernel[28] > 0)
		begin
			ker_vld[28]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
	
end	
		
	initial begin
			
			#11		
		
	p = 29;
	repeat(2) @(posedge clk);
	for (address_kernel[29] = 0; address_kernel[29] < 27; 
			address_kernel[29] = address_kernel[29] +1)
	begin
		if (address_kernel[29] > 0)
		begin
			ker_vld[29]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	p = 30;
	repeat(2) @(posedge clk);
	for (address_kernel[30] = 0; address_kernel[30] < 27; 
			address_kernel[30] = address_kernel[30] +1)
	begin
		if (address_kernel[30] > 0)
		begin
			ker_vld[30]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("KERNEL0[%d] = %f | %b",
					 address_kernel[0], 
					 $itor(output_kernel_ram[0]*kerSF), output_kernel_ram[0]);/**/
		end
	end	
end	
		
initial begin		
			#11		
	p = 31;
	repeat(2) @(posedge clk);
	for (address_kernel[31] = 0; address_kernel[31] < 27; 
			address_kernel[31] = address_kernel[31] +1)
	begin
		if (address_kernel[31] > 0)
		begin
			ker_vld[31]			= 1;
		end
		begin
			repeat(2) @(posedge clk);
			$display ("KERNEL31[%d] = %f | %b",
					 address_kernel[31], 
					 $itor(output_kernel_ram[31]*kerSF), output_kernel_ram[31]);/**/
		end
	end	
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
					$display ("BIASES[%d] = %f | %b",
							 address_biases, 
							$itor(kerSF*output_biases_ram), output_biases_ram);/**/
				end
			end
end		
 	
endmodule
