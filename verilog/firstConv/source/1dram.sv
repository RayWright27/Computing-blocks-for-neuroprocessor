`timescale 1ns / 1ps

module oneDRAM#(parameter A_WIDTH = 7,
						  ADDR_WIDTH = 10, 
						  D_WIDTH = 15
			  )(clk, we, en_w, en_r, addr_w, addr_r, di, dout, dat_read, reset);
			  
	input 				   clk;
	input				   reset;
	input 				   we;
	input 				   en_w;
	input				   en_r;
	input  [ADDR_WIDTH-1:0]addr_w;
	input  [ADDR_WIDTH-1:0]addr_r;
	input  [D_WIDTH-1:0]   di;
	output [D_WIDTH-1:0]   dout;
	output [D_WIDTH-1:0]   dat_read;
	
	(* RAM_STYLE="BLOCK" *)
	reg [D_WIDTH-1:0] RAM [2**A_WIDTH-1:0];
	reg [D_WIDTH-1:0] dout;
	reg [D_WIDTH-1:0] dat_read;
	integer i;
	always @(posedge clk)
	begin
	if (en_w)
	begin
		if (we)
		begin
			RAM[addr_w] <= di;/*
			$display("");
			$display("%m :");
			$display("di = %h", di);
			$display("RAM[%d] = %h", addr_w, RAM[addr_w]);
			$display("dout = %h", dout);/**/
			dout <= di;
		end
		else
			dout <= RAM[addr_w];
		end
	end
	
	always @(posedge clk) begin
	if (en_r)
		dat_read <= RAM[addr_r];
	end
endmodule

