`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// 3-D Ram Inference Example (Single port)

module threeDRAM #(
	parameter NUM_RAMS = 128,
			  A_WID = 7,
			  D_WID = 20
)
(
	input 				   	          clk,
	input             [NUM_RAMS-1:0]  we,
	input             [NUM_RAMS-1:0]  ena,
	input             [A_WID-1:0] 	  addr[NUM_RAMS-1:0],
	input      signed [D_WID-1:0] 	  din [NUM_RAMS-1:0],
	output reg signed [D_WID-1:0] 	  dout[NUM_RAMS-1:0]
);
	(* RAM_STYLE="BLOCK" *)
	reg signed [D_WID-1:0] mem [NUM_RAMS-1:0][2**A_WID-1:0];//[2**B_WID-1:0];
	genvar i;
	generate	
	for(i=0;i<NUM_RAMS;i=i+1)
	begin
//	integer i;
		always @ (posedge clk)
		begin
//		for(i=0;i<NUM_RAMS;i=i+1) begin
		$display("i = %0d", i);
		$display("addr[0] = %d | addr[1] = %d", addr[0] , addr[1]);
		$display("@%0t ena[%0d] = %0b", $time, i, ena[i]);
		if (ena[i]) begin
			$display("@%0t we[%0d] = %0b", $time, i, we[i]);
			if(we[i])
				begin
					$display("mem[%0d][%0d] = %b", i, addr[i], mem[i][addr[i]]);
					mem[i][addr[i]] <= din[i];
				end
				dout[i] <= mem[i][addr[i]];
			end
		end
	end
	endgenerate
endmodule