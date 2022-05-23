`timescale 1ns / 1ps

// 3-D Ram Inference Example (True Dual port)
// File:rams_tdp_3d.sv

module threeDRAMdualport #(
		parameter NUM_RAMS = 128,
		A_WID = 10,
		D_WID = 32
)
(
		input clka,
		input 	clkb,
		input [NUM_RAMS-1:0] 	wea,
		input [NUM_RAMS-1:0] 	web,
		input [NUM_RAMS-1:0] 	ena,
		input [NUM_RAMS-1:0] 	enb,
		input [A_WID-1:0] 		addra [NUM_RAMS-1:0],
		input [A_WID-1:0] 		addrb [NUM_RAMS-1:0],
		input signed[D_WID-1:0] dina [NUM_RAMS-1:0],
		input signed[D_WID-1:0] dinb [NUM_RAMS-1:0],
		output reg signed[D_WID-1:0] douta [NUM_RAMS-1:0],
		output reg signed[D_WID-1:0] doutb [NUM_RAMS-1:0]
);
	(* RAM_STYLE="BLOCK" *)
	reg signed [D_WID-1:0] mem [NUM_RAMS-1:0][2**A_WID-1:0];
	// PORT_A
	genvar i;
	generate
	for(i=0;i<NUM_RAMS;i=i+1)
	begin:port_a_ops
		always @ (posedge clka)
		begin
			if (ena[i]) begin
				if(wea[i])
				begin
					mem[i][addra[i]] <= dina[i];
				end
				douta[i] <= mem[i][addra[i]];
			end
		end
	end
	endgenerate
	
	//PORT_B
	generate
	for(i=0;i<NUM_RAMS;i=i+1)
	begin:port_b_ops
		always @ (posedge clkb)
		begin
			if (enb[i]) begin
				if(web[i])
				begin
					mem[i][addrb[i]] <= dinb[i];
				end
				doutb[i] <= mem[i][addrb[i]];
			end
		end
	end
	endgenerate
	
endmodule