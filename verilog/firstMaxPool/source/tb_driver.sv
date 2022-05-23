`timescale 1ns / 1ps

module tb_driver;

localparam kerSF = 2.0**-14.00;  // Q4.4 scaling factor is 2^-4
localparam imgSF = 2.0**-14.00;
// parameters for BRAM blocks
parameter	RAM_WIDTH_IMG = 20;
parameter	RAM_ADDR_BITS_IMG = 16; // 16384 memory rows => we take 2^16=65536

reg								    clk;
reg								    reset;
reg								    ram_enable;
reg								    write_enable;

reg 	    [RAM_ADDR_BITS_IMG-1:0]	address_image[31:0];
reg 	    [RAM_WIDTH_IMG-1:0] 	input_image_ram[31:0];
wire signed	[RAM_WIDTH_IMG-1:0]     output_image_ram[31:0];

reg								    img_rdy[31:0];
reg								    img_vld[31:0];
wire 							    img_vld_next[31:0];
wire 							    img_rdy_next[31:0];
reg	        [RAM_WIDTH_IMG-1:0]		img[31:0];

//recieveing side
wire								result_rdy[31:0];
wire								result_vld[31:0];
reg 							    result_vld_next[31:0];
reg 							    result_rdy_next[31:0];
wire signed  [RAM_WIDTH_IMG-1:0]	result_wire[31:0];
reg  signed  [RAM_WIDTH_IMG-1:0]    result_mem[31:0];
////////////////////////////
//generating 32 bram blocks for image feature maps
////////////////////////////
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp1.txt"		),
	.INIT_START_ADDR(0				    ),
	.INIT_END_ADDR	(16384   			)
)
maxpInp1
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[0]	),
	.input_data		(input_image_ram[0]),
	.output_data    (output_image_ram[0])
);

bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp2.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp2
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[1]	),
	.input_data		(input_image_ram[1]),
	.output_data    (output_image_ram[1])
);

bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp3.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp3
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[2]	),
	.input_data		(input_image_ram[2]),
	.output_data    (output_image_ram[2])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp4.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp4
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[3]	),
	.input_data		(input_image_ram[3]),
	.output_data    (output_image_ram[3])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp5.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp5
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[4]	),
	.input_data		(input_image_ram[4]),
	.output_data    (output_image_ram[4])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp6.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp6
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[5]	),
	.input_data		(input_image_ram[5]),
	.output_data    (output_image_ram[5])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp7.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp7
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[6]	),
	.input_data		(input_image_ram[6]),
	.output_data    (output_image_ram[6])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp8.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp8
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[7]	),
	.input_data		(input_image_ram[7]),
	.output_data    (output_image_ram[7])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp9.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp9
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[8]	),
	.input_data		(input_image_ram[8]),
	.output_data    (output_image_ram[8])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp10.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp10
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[9]	),
	.input_data		(input_image_ram[9]),
	.output_data    (output_image_ram[9])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp11.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp11
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[10]	),
	.input_data		(input_image_ram[10]),
	.output_data    (output_image_ram[10])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp12.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp12
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[11]	),
	.input_data		(input_image_ram[11]),
	.output_data    (output_image_ram[11])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp13.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp13
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[12]	),
	.input_data		(input_image_ram[12]),
	.output_data    (output_image_ram[12])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp14.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp14
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[13]	),
	.input_data		(input_image_ram[13]),
	.output_data    (output_image_ram[13])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp15.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp15
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[14]	),
	.input_data		(input_image_ram[14]),
	.output_data    (output_image_ram[14])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp16.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp16
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[15]	),
	.input_data		(input_image_ram[15]),
	.output_data    (output_image_ram[15])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp17.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp17
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[16]	),
	.input_data		(input_image_ram[16]),
	.output_data    (output_image_ram[16])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp18.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp18
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[17]	),
	.input_data		(input_image_ram[17]),
	.output_data    (output_image_ram[17])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp19.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp19
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[18]	),
	.input_data		(input_image_ram[18]),
	.output_data    (output_image_ram[18])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp20.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp20
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[19]	),
	.input_data		(input_image_ram[19]),
	.output_data    (output_image_ram[19])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp21.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp21
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[20]	),
	.input_data		(input_image_ram[20]),
	.output_data    (output_image_ram[20])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp22.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp22
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[21]	),
	.input_data		(input_image_ram[21]),
	.output_data    (output_image_ram[21])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp23.txt"	),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp23
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[22]	),
	.input_data		(input_image_ram[22]),
	.output_data    (output_image_ram[22])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp24.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp24
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[23]	),
	.input_data		(input_image_ram[23]),
	.output_data    (output_image_ram[23])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp25.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp25
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[24]	),
	.input_data		(input_image_ram[24]),
	.output_data    (output_image_ram[24])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp26.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp26
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[25]	),
	.input_data		(input_image_ram[25]),
	.output_data    (output_image_ram[25])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp27.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp27
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[26]	),
	.input_data		(input_image_ram[26]),
	.output_data    (output_image_ram[26])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp28.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp28
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[27]	),
	.input_data		(input_image_ram[27]),
	.output_data    (output_image_ram[27])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp29.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp29
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[28]	),
	.input_data		(input_image_ram[28]),
	.output_data    (output_image_ram[28])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp30.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp30
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[29]	),
	.input_data		(input_image_ram[29]),
	.output_data    (output_image_ram[29])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp31.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp31
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[30]	),
	.input_data		(input_image_ram[30]),
	.output_data    (output_image_ram[30])
);
bram
#(
	.RAM_WIDTH 		(RAM_WIDTH_IMG 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS_IMG 	),
	.DATA_FILE 		("maxpInp32.txt"		),
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(16383					)
)
maxpInp32
(
	.clock			(clk				),
	.ram_enable		(ram_enable			),
	.write_enable	(write_enable		),
	.address		(address_image[31]	),
	.input_data		(input_image_ram[31]),
	.output_data    (output_image_ram[31])
);/**/
//-------------------------------------------------------------------------------------
firstMaxPool MaxPool1
(
	.clk			(clk				 ),
	.reset			(reset				 ),
	
	.image0		    (img[0]				 ),
	.image2		    (img[2]				 ),
	.image3		    (img[3]				 ),
	.image4		    (img[4]				 ),
	.image5		    (img[5]				 ),
	.image6		    (img[6]				 ),
	.image7		    (img[7]				 ),
	.image8		    (img[8]				 ),
	.image9		    (img[9]				 ),
	.image10		(img[10]		     ),
	.image11		(img[11]		     ),
	.image12		(img[12]		     ),
	.image13		(img[13]		     ),
	.image14		(img[14]		     ),
	.image15		(img[15]		     ),
	.image16		(img[16]		     ),
	.image17		(img[17]		     ),
	.image18		(img[18]		     ),
	.image19		(img[19]		     ),
	.image20		(img[20]		     ),
	.image21		(img[21]		     ),
	.image22		(img[22]		     ),
	.image23		(img[23]		     ),
	.image24		(img[24]		     ),
	.image25		(img[25]		     ),
	.image26		(img[26]		     ),
	.image27		(img[27]		     ),
	.image28		(img[28]		     ),
	.image29		(img[29]		     ),
	.image30		(img[30]		     ),
	.image31		(img[31]		     ),
	.image_vld0	    (img_vld_next[0]	 ),
	.image_rdy0	    (img_rdy_next[0]	 ),
	.image_vld1	    (img_vld_next[1]	 ),
	.image_rdy1	    (img_rdy_next[1]	 ),
	.image_vld2	    (img_vld_next[2]	 ),
	.image_rdy2	    (img_rdy_next[2]	 ),
	.image_vld3	    (img_vld_next[3]	 ),
	.image_rdy3	    (img_rdy_next[3]	 ),
	.image_vld4	    (img_vld_next[4]	 ),
	.image_rdy4	    (img_rdy_next[4]	 ),
	.image_vld5	    (img_vld_next[5]	 ),
	.image_rdy5	    (img_rdy_next[5]	 ),
	.image_vld6	    (img_vld_next[6]	 ),
	.image_rdy6	    (img_rdy_next[6]	 ),
	.image_vld7	    (img_vld_next[7]	 ),
	.image_rdy7	    (img_rdy_next[7]	 ),
	.image_vld8	    (img_vld_next[8]	 ),
	.image_rdy8	    (img_rdy_next[8]	 ),
	.image_vld9	    (img_vld_next[9]	 ),
	.image_rdy9	    (img_rdy_next[9]	 ),
	.image_vld10	(img_vld_next[10]	 ),
	.image_rdy10	(img_rdy_next[10]	 ),
	.image_vld11	(img_vld_next[11]	 ),
	.image_rdy11	(img_rdy_next[11]	 ),
	.image_vld12	(img_vld_next[12]	 ),
	.image_rdy12	(img_rdy_next[12]	 ),
	.image_vld13	(img_vld_next[13]	 ),
	.image_rdy13	(img_rdy_next[13]	 ),
	.image_vld14	(img_vld_next[14]	 ),
	.image_rdy14	(img_rdy_next[14]	 ),
	.image_vld15	(img_vld_next[15]	 ),
	.image_rdy15	(img_rdy_next[15]	 ),	
	.image_rdy16	(img_rdy_next[16]	 ),
	.image_vld16	(img_vld_next[16]	 ),
	.image_rdy17	(img_rdy_next[17]	 ),
	.image_vld17	(img_vld_next[17]	 ),
	.image_rdy18	(img_rdy_next[18]	 ),
	.image_vld18	(img_vld_next[18]	 ),
	.image_rdy19	(img_rdy_next[19]	 ),
	.image_vld19	(img_vld_next[19]	 ),
	.image_rdy20	(img_rdy_next[20]	 ),
	.image_vld20	(img_vld_next[20]	 ),
	.image_rdy21	(img_rdy_next[21]	 ),
	.image_vld21	(img_vld_next[21]	 ),
	.image_rdy22	(img_rdy_next[22]	 ),
	.image_vld22	(img_vld_next[22]	 ),
	.image_rdy23	(img_rdy_next[23]	 ),
	.image_vld23	(img_vld_next[23]	 ),
	.image_rdy24	(img_rdy_next[24]	 ),
	.image_vld24	(img_vld_next[24]	 ),
	.image_rdy25	(img_rdy_next[25]	 ),
	.image_vld25	(img_vld_next[25]	 ),
	.image_rdy26	(img_rdy_next[26]	 ),		
	.image_vld26	(img_vld_next[26]	 ),
	.image_rdy27	(img_rdy_next[27]	 ),
	.image_vld27	(img_vld_next[27]	 ),
	.image_rdy28	(img_rdy_next[28]	 ),
	.image_vld28	(img_vld_next[28]	 ),
	.image_rdy29	(img_rdy_next[29]	 ),
	.image_vld29	(img_vld_next[29]	 ),
	.image_rdy30	(img_rdy_next[30]	 ),
	.image_vld30	(img_vld_next[30]	 ),
	.image_rdy31	(img_rdy_next[31]	 ),
	.image_vld31	(img_vld_next[31]	 )/**/,
	.result0		(result_wire[0]		 )
);
//-------------------------------------------------------------------------------------
rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img0
(
	.vld			(img_vld[0]			  ),
	.rdy			(img_rdy[0]			  ),
	.i_dat			(output_image_ram[0] ),
	.vld_nxt		(img_vld_next[0]      ),
	.rdy_nxt		(img_rdy_next[0]	  ),
	.o_dat			(img[0]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img1
(
	.vld			(img_vld[1]			  ),
	.rdy			(img_rdy[1]			  ),
	.i_dat			(output_image_ram[1] ),
	.vld_nxt		(img_vld_next[1]      ),
	.rdy_nxt		(img_rdy_next[1]	  ),
	.o_dat			(img[1]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img2
(
	.vld			(img_vld[2]			  ),
	.rdy			(img_rdy[2]			  ),
	.i_dat			(output_image_ram[2] ),
	.vld_nxt		(img_vld_next[2]      ),
	.rdy_nxt		(img_rdy_next[2]	  ),
	.o_dat			(img[2]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img3
(
	.vld			(img_vld[3]			  ),
	.rdy			(img_rdy[3]			  ),
	.i_dat			(output_image_ram[3] ),
	.vld_nxt		(img_vld_next[3]      ),
	.rdy_nxt		(img_rdy_next[3]	  ),
	.o_dat			(img[3]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);
rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)

rdyval_img4
(
	.vld			(img_vld[4]			  ),
	.rdy			(img_rdy[4]			  ),
	.i_dat			(output_image_ram[4] ),
	.vld_nxt		(img_vld_next[4]      ),
	.rdy_nxt		(img_rdy_next[4]	  ),
	.o_dat			(img[4]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img5
(
	.vld			(img_vld[5]			  ),
	.rdy			(img_rdy[5]			  ),
	.i_dat			(output_image_ram[5] ),
	.vld_nxt		(img_vld_next[5]      ),
	.rdy_nxt		(img_rdy_next[5]	  ),
	.o_dat			(img[5]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);


rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img6
(
	.vld			(img_vld[6]			  ),
	.rdy			(img_rdy[6]			  ),
	.i_dat			(output_image_ram[6] ),
	.vld_nxt		(img_vld_next[6]      ),
	.rdy_nxt		(img_rdy_next[6]	  ),
	.o_dat			(img[6]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img7
(
	.vld			(img_vld[7]			  ),
	.rdy			(img_rdy[7]			  ),
	.i_dat			(output_image_ram[7] ),
	.vld_nxt		(img_vld_next[7]      ),
	.rdy_nxt		(img_rdy_next[7]	  ),
	.o_dat			(img[7]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img8
(
	.vld			(img_vld[8]			  ),
	.rdy			(img_rdy[8]			  ),
	.i_dat			(output_image_ram[8] ),
	.vld_nxt		(img_vld_next[8]      ),
	.rdy_nxt		(img_rdy_next[8]	  ),
	.o_dat			(img[8]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img9
(
	.vld			(img_vld[9]			  ),
	.rdy			(img_rdy[9]			  ),
	.i_dat			(output_image_ram[9] ),
	.vld_nxt		(img_vld_next[9]      ),
	.rdy_nxt		(img_rdy_next[9]	  ),
	.o_dat			(img[9]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img10
(
	.vld			(img_vld[10]			  ),
	.rdy			(img_rdy[10]			  ),
	.i_dat			(output_image_ram[10] ),
	.vld_nxt		(img_vld_next[10]      ),
	.rdy_nxt		(img_rdy_next[10]	  ),
	.o_dat			(img[10]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img11
(
	.vld			(img_vld[11]			  ),
	.rdy			(img_rdy[11]			  ),
	.i_dat			(output_image_ram[11] ),
	.vld_nxt		(img_vld_next[11]      ),
	.rdy_nxt		(img_rdy_next[11]	  ),
	.o_dat			(img[11]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img12
(
	.vld			(img_vld[12]			  ),
	.rdy			(img_rdy[12]			  ),
	.i_dat			(output_image_ram[12] ),
	.vld_nxt		(img_vld_next[12]      ),
	.rdy_nxt		(img_rdy_next[12]	  ),
	.o_dat			(img[12]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img13
(
	.vld			(img_vld[13]			  ),
	.rdy			(img_rdy[13]			  ),
	.i_dat			(output_image_ram[13] ),
	.vld_nxt		(img_vld_next[13]      ),
	.rdy_nxt		(img_rdy_next[13]	  ),
	.o_dat			(img[13]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img14
(
	.vld			(img_vld[14]			  ),
	.rdy			(img_rdy[14]			  ),
	.i_dat			(output_image_ram[14] ),
	.vld_nxt		(img_vld_next[14]      ),
	.rdy_nxt		(img_rdy_next[14]	  ),
	.o_dat			(img[14]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img15
(
	.vld			(img_vld[15]			  ),
	.rdy			(img_rdy[15]			  ),
	.i_dat			(output_image_ram[15] ),
	.vld_nxt		(img_vld_next[15]      ),
	.rdy_nxt		(img_rdy_next[15]	  ),
	.o_dat			(img[15]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img16
(
	.vld			(img_vld[16]			  ),
	.rdy			(img_rdy[16]			  ),
	.i_dat			(output_image_ram[16] ),
	.vld_nxt		(img_vld_next[16]      ),
	.rdy_nxt		(img_rdy_next[16]	  ),
	.o_dat			(img[16]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img17
(
	.vld			(img_vld[17]			  ),
	.rdy			(img_rdy[17]			  ),
	.i_dat			(output_image_ram[17] ),
	.vld_nxt		(img_vld_next[17]      ),
	.rdy_nxt		(img_rdy_next[17]	  ),
	.o_dat			(img[17]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img18
(
	.vld			(img_vld[18]			  ),
	.rdy			(img_rdy[18]			  ),
	.i_dat			(output_image_ram[18] ),
	.vld_nxt		(img_vld_next[18]      ),
	.rdy_nxt		(img_rdy_next[18]	  ),
	.o_dat			(img[18]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img19
(
	.vld			(img_vld[19]			  ),
	.rdy			(img_rdy[19]			  ),
	.i_dat			(output_image_ram[19] ),
	.vld_nxt		(img_vld_next[19]      ),
	.rdy_nxt		(img_rdy_next[19]	  ),
	.o_dat			(img[19]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img20
(
	.vld			(img_vld[20]			  ),
	.rdy			(img_rdy[20]			  ),
	.i_dat			(output_image_ram[20] ),
	.vld_nxt		(img_vld_next[20]      ),
	.rdy_nxt		(img_rdy_next[20]	  ),
	.o_dat			(img[20]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img21
(
	.vld			(img_vld[21]			  ),
	.rdy			(img_rdy[21]			  ),
	.i_dat			(output_image_ram[21] ),
	.vld_nxt		(img_vld_next[21]      ),
	.rdy_nxt		(img_rdy_next[21]	  ),
	.o_dat			(img[21]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img22
(
	.vld			(img_vld[22]			  ),
	.rdy			(img_rdy[22]			  ),
	.i_dat			(output_image_ram[22] ),
	.vld_nxt		(img_vld_next[22]      ),
	.rdy_nxt		(img_rdy_next[22]	  ),
	.o_dat			(img[22]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img23
(
	.vld			(img_vld[23]			  ),
	.rdy			(img_rdy[23]			  ),
	.i_dat			(output_image_ram[23] ),
	.vld_nxt		(img_vld_next[23]      ),
	.rdy_nxt		(img_rdy_next[23]	  ),
	.o_dat			(img[23]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img24
(
	.vld			(img_vld[24]			  ),
	.rdy			(img_rdy[24]			  ),
	.i_dat			(output_image_ram[24] ),
	.vld_nxt		(img_vld_next[24]      ),
	.rdy_nxt		(img_rdy_next[24]	  ),
	.o_dat			(img[24]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img25
(
	.vld			(img_vld[25]			  ),
	.rdy			(img_rdy[25]			  ),
	.i_dat			(output_image_ram[25] ),
	.vld_nxt		(img_vld_next[25]      ),
	.rdy_nxt		(img_rdy_next[25]	  ),
	.o_dat			(img[25]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img26
(
	.vld			(img_vld[26]			  ),
	.rdy			(img_rdy[26]			  ),
	.i_dat			(output_image_ram[26] ),
	.vld_nxt		(img_vld_next[26]      ),
	.rdy_nxt		(img_rdy_next[26]	  ),
	.o_dat			(img[26]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img27
(
	.vld			(img_vld[27]			  ),
	.rdy			(img_rdy[27]			  ),
	.i_dat			(output_image_ram[27] ),
	.vld_nxt		(img_vld_next[27]      ),
	.rdy_nxt		(img_rdy_next[27]	  ),
	.o_dat			(img[27]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img28
(
	.vld			(img_vld[28]			  ),
	.rdy			(img_rdy[28]			  ),
	.i_dat			(output_image_ram[28] ),
	.vld_nxt		(img_vld_next[28]      ),
	.rdy_nxt		(img_rdy_next[28]	  ),
	.o_dat			(img[28]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img29
(
	.vld			(img_vld[29]			  ),
	.rdy			(img_rdy[29]			  ),
	.i_dat			(output_image_ram[29] ),
	.vld_nxt		(img_vld_next[29]      ),
	.rdy_nxt		(img_rdy_next[29]	  ),
	.o_dat			(img[29]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img30
(
	.vld			(img_vld[30]			  ),
	.rdy			(img_rdy[30]			  ),
	.i_dat			(output_image_ram[30] ),
	.vld_nxt		(img_vld_next[30]      ),
	.rdy_nxt		(img_rdy_next[30]	  ),
	.o_dat			(img[30]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdyval_img31
(
	.vld			(img_vld[31]			  ),
	.rdy			(img_rdy[31]			  ),
	.i_dat			(output_image_ram[31] ),
	.vld_nxt		(img_vld_next[31]      ),
	.rdy_nxt		(img_rdy_next[31]	  ),
	.o_dat			(img[31]				  ),
	.clk			(clk				  ),
	.rst_n			(!reset				  )
);/**/

//-------------------------------------------------------------------------------------

rdyval_pipe_stage 
#(
	.DWIDTH			(RAM_WIDTH_IMG		  )
)
rdy_val_result0
(
	.vld			(result_vld[0]		  ),
	.rdy			(result_rdy[0]		  ),
	.i_dat			(result_wire[0]		  ),
	.vld_nxt		(result_vld_next[0]   ),
	.rdy_nxt		(result_rdy_next[0]	  ),
	.o_dat			(result_mem[0]		  ),
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

/////////////////
//image initial block
integer j;
initial
begin
	$dumpfile("wave.vcd");
	$dumpvars(0, tb_driver);
	reset				= 1;
	for(j = 0; j < 31; j = j + 1) begin
		address_image[j] 	= 0;
		input_image_ram[j]	= 0;
	end
	
	#10;
	reset				= 0;
	ram_enable			= 1;
	write_enable		= 0;
	
    repeat(2) @(posedge clk);
	for (address_image[0] = 0; address_image[0] < 16383; 
			address_image[0] = address_image[0] +1)
	begin
		if (address_image[0] > 0 )
		begin
			img_vld[0]			= 1;
		end
		begin
			repeat(2) @(posedge clk);
			$display ("image0[%d] = %f | %h",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
		
	 	
	end	
	if (address_image[0] >= 16385 )
	begin
		img_vld[0]			= 0;
	end
end	



initial begin
	
	#11		
	repeat(2) @(posedge clk);
	for (address_image[1] = 0; address_image[1] < 16383; 
			address_image[1] = address_image[1] +1)
	begin
		if (address_image[1] > 0)
		begin
			img_vld[1]			= 1;
		end
		begin
			repeat(2) @(posedge clk);
			$display ("image1[%d] = %f | %b",
					 address_image[1], 
					 $itor(output_image_ram[1]*imgSF), output_image_ram[1]);/**/
		end
	end	
end	

initial begin
	
	#11	
	
	repeat(2) @(posedge clk);
	for (address_image[2] = 0; address_image[2] < 16383; 
			address_image[2] = address_image[2] +1)
	begin
		if (address_image[2] > 0)
		begin
			img_vld[2]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
	
	initial begin
		
		#11		
	
	repeat(2) @(posedge clk);
	for (address_image[3] = 0; address_image[3] < 16383; 
			address_image[3] = address_image[3] +1)
	begin
		if (address_image[3] > 0)
		begin
			img_vld[3]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
	
	initial begin
		
		#11		
	
	repeat(2) @(posedge clk);
	for (address_image[4] = 0; address_image[4] < 16383; 
			address_image[4] = address_image[4] +1)
	begin
		if (address_image[4] > 0)
		begin
			img_vld[4]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
	
	initial begin
		
		#11		
	
	repeat(2) @(posedge clk);
	for (address_image[5] = 0; address_image[5] < 16383; 
			address_image[5] = address_image[5] +1)
	begin
		if (address_image[5] > 0)
		begin
			img_vld[5]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
	
	initial begin
		
		#11		
	
	repeat(2) @(posedge clk);
	for (address_image[6] = 0; address_image[6] < 16383; 
			address_image[6] = address_image[6] +1)
	begin
		if (address_image[6] > 0)
		begin
			img_vld[6]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
	
initial begin
		
		#11		
	
	repeat(2) @(posedge clk);
	for (address_image[7] = 0; address_image[7] < 16383; 
			address_image[7] = address_image[7] +1)
	begin
		if (address_image[7] > 0)
		begin
			img_vld[7]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[8] = 0; address_image[8] < 16383; 
			address_image[8] = address_image[8] +1)
	begin
		if (address_image[8] > 0)
		begin
			img_vld[8]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[9] = 0; address_image[9] < 16383; 
			address_image[9] = address_image[9] +1)
	begin
		if (address_image[9] > 0)
		begin
			img_vld[9]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[10] = 0; address_image[10] < 16383; 
			address_image[10] = address_image[10] +1)
	begin
		if (address_image[10] > 0)
		begin
			img_vld[10]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[11] = 0; address_image[11] < 16383; 
			address_image[11] = address_image[11] +1)
	begin
		if (address_image[11] > 0)
		begin
			img_vld[11]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[12] = 0; address_image[12] < 16383; 
			address_image[12] = address_image[12] +1)
	begin
		if (address_image[12] > 0)
		begin
			img_vld[12]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[13] = 0; address_image[13] < 16383; 
			address_image[13] = address_image[13] +1)
	begin
		if (address_image[13] > 0)
		begin
			img_vld[13]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[14] = 0; address_image[14] < 16383; 
			address_image[14] = address_image[14] +1)
	begin
		if (address_image[14] > 0)
		begin
			img_vld[14]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[15] = 0; address_image[15] < 16383; 
			address_image[15] = address_image[15] +1)
	begin
		if (address_image[15] > 0)
		begin
			img_vld[15]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[16] = 0; address_image[16] < 16383; 
			address_image[16] = address_image[16] +1)
	begin
		if (address_image[16] > 0)
		begin
			img_vld[16]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[17] = 0; address_image[17] < 16383; 
			address_image[17] = address_image[17] +1)
	begin
		if (address_image[17] > 0)
		begin
			img_vld[17]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[18] = 0; address_image[18] < 16383; 
			address_image[18] = address_image[18] +1)
	begin
		if (address_image[18] > 0)
		begin
			img_vld[18]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[29] = 0; address_image[19] < 16383; 
			address_image[19] = address_image[19] +1)
	begin
		if (address_image[19] > 0)
		begin
			img_vld[19]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[20] = 0; address_image[20] < 16383; 
			address_image[20] = address_image[20] +1)
	begin
		if (address_image[20] > 0)
		begin
			img_vld[20]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[21] = 0; address_image[21] < 16383; 
			address_image[21] = address_image[21] +1)
	begin
		if (address_image[21] > 0)
		begin
			img_vld[21]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[22] = 0; address_image[22] < 16383; 
			address_image[22] = address_image[22] +1)
	begin
		if (address_image[22] > 0)
		begin
			img_vld[22]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[23] = 0; address_image[23] < 16383; 
			address_image[23] = address_image[23] +1)
	begin
		if (address_image[23] > 0)
		begin
			img_vld[23]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
	
	
	repeat(2) @(posedge clk);
	for (address_image[24] = 0; address_image[24] < 16383; 
			address_image[24] = address_image[24] +1)
	begin
		if (address_image[24] > 0)
		begin
			img_vld[24]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[25] = 0; address_image[25] < 16383; 
			address_image[25] = address_image[25] +1)
	begin
		if (address_image[25] > 0)
		begin
			img_vld[25]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[26] = 0; address_image[26] < 16383; 
			address_image[26] = address_image[26] +1)
	begin
		if (address_image[26] > 0)
		begin
			img_vld[26]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[16383] = 0; address_image[27] < 16383; 
			address_image[27] = address_image[27] +1)
	begin
		if (address_image[27] > 0)
		begin
			img_vld[27]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[28] = 0; address_image[28] < 16383; 
			address_image[28] = address_image[28] +1)
	begin
		if (address_image[28] > 0)
		begin
			img_vld[28]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[29] = 0; address_image[29] < 16383; 
			address_image[29] = address_image[29] +1)
	begin
		if (address_image[29] > 0)
		begin
			img_vld[29]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
	initial begin
			
			#11		
		
	
	repeat(2) @(posedge clk);
	for (address_image[30] = 0; address_image[30] < 16383; 
			address_image[30] = address_image[30] +1)
	begin
		if (address_image[30] > 0)
		begin
			img_vld[30]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image0[%d] = %f | %b",
					 address_image[0], 
					 $itor(output_image_ram[0]*imgSF), output_image_ram[0]);/**/
		end
	end	
end	
		
initial begin		
			#11		
	
	repeat(2) @(posedge clk);
	for (address_image[31] = 0; address_image[31] < 16383; 
			address_image[31] = address_image[31] +1)
	begin
		if (address_image[31] > 0)
		begin
			img_vld[31]			= 1;
		end
		begin
			repeat(2) @(posedge clk);/*
			$display ("image31[%d] = %f | %b",
					 address_image[31], 
					 $itor(output_image_ram[31]*imgSF), output_image_ram[31]);/**/
		end
	end	
end

/**/


endmodule