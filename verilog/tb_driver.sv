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

localparam SF = 2.0**-4.00;  // Q4.4 scaling factor is 2^-4

// parameters for BRAM blocks
parameter	RAM_WIDTH_KER = 20;
parameter	RAM_ADDR_BITS_KER = 5; // 27 memory rows => we take 2^5=32
parameter	RAM_WIDTH_IMG = 20;
parameter	RAM_ADDR_BITS_IMG = 16; // 49152 memory rows => we take 2^5=32
parameter	RAM_WIDTH_BIAS = 20;
parameter	RAM_ADDR_BITS_BIAS = 5; // 49152 memory rows => we take 2^5=32


reg								clk;

reg								ram_enable;
reg								write_enable;

reg 	[RAM_ADDR_BITS_KER-1:0]	address_kernel[31:0];
reg 	[RAM_WIDTH_KER-1:0] 	input_kernel_ram[31:0];
wire	[RAM_WIDTH_KER-1:0] 	output_kernel_ram[31:0];
wire							kernel_rdy[31:0];
wire							kernel_vld[31:0];
wire							kernel[31:0];
reg								kernels_generated;

reg 	[RAM_ADDR_BITS_IMG-1:0]	address_image;
reg 	[RAM_WIDTH_IMG-1:0] 	input_image_ram;
wire	[RAM_WIDTH_IMG-1:0] 	output_image_ram;
wire							image_rdy[31:0];
wire							image_vld[31:0];
wire							image[31:0];
reg								image_generated;

reg 	[RAM_ADDR_BITS_BIAS-1:0]address_biases;
reg 	[RAM_WIDTH_BIAS-1:0] 	input_biases_ram;
wire	[RAM_WIDTH_BIAS-1:0] 	output_biases_ram;
wire							biases_rdy[31:0];
wire							biases_vld[31:0];
wire							biases[31:0];
reg								biases_generated;


////////////////////////////
//generating 32 bram blocks for kernel
////////////////////////////
genvar i;
generate
	for (i = 0; i < 32; i = i + 1) begin:ker_mem
		bram
		#(
			.RAM_WIDTH 		(RAM_WIDTH_KER 		),
			.RAM_ADDR_BITS 	(RAM_ADDR_BITS_KER 	),
			.DATA_FILE 		("ker_mem.txt"		),
			.INIT_START_ADDR(0+i*31				),
			.INIT_END_ADDR	(31					)
		)
		bram
		(
			.clock			(clk				),
			.ram_enable		(ram_enable			),
			.write_enable	(write_enable		),
			.address		(address_kernel[i]	),
			.input_data		(input_kernel_ram[i]),
			.output_data    (output_kernel_ram[i])
		);
	end
endgenerate

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
	.INIT_START_ADDR(0					),
	.INIT_END_ADDR	(31					)
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

initial
begin
	clk = 0;
	forever #5 clk = ~clk;
end

integer j;
integer disp_address = address_kernel[0];

initial
begin
	


	$dumpfile("wave.vcd");
	$dumpvars(0, tb_driver);
	
	ram_enable			= 1;
	write_enable		= 0;
	address_image		= 0;
	input_image_ram		= 0;
	
	for(j = 0; j < 31; j = j + 1) begin
		address_kernel[j] 	= 0;
		input_kernel_ram[j]	= 0;
	end
		

	

	repeat(2) @(posedge clk);
	
	$display("Reading data from BRAM");
		repeat(2) @(posedge clk);
		for (address_kernel[0] = 0; address_kernel[0] < 27; address_kernel[0] = address_kernel[0] +1)
		begin
			@(posedge clk);
			#1 $display ("ADDR[%0d], DATA: %h",
						 address_kernel[0], 
						output_kernel_ram[0]);
		end
		
		repeat(2) @(posedge clk);
		$finish;
	end
	
 	

endmodule
