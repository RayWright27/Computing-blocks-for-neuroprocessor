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
		parameter RAM_WIDTH_IMG		= 20
	)
	(
	input 									clk,
	input									reset,
	
	input				[RAM_WIDTH_KER-1:0] kernel0,
	input									kernel_vld0,
	output reg signed						kernel_rdy0,
	
	input				[RAM_WIDTH_KER-1:0] kernel1,
	input				[RAM_WIDTH_KER-1:0] kernel_vld1,
	output reg signed	[RAM_WIDTH_KER-1:0] kernel_rdy1,
	
	input				[RAM_WIDTH_KER-1:0] kernel2,
	input				[RAM_WIDTH_KER-1:0] kernel_vld2,
	output reg signed	[RAM_WIDTH_KER-1:0] kernel_rdy2,	
	
	input				[RAM_WIDTH_KER-1:0] kernel3,
	input				[RAM_WIDTH_KER-1:0] kernel_vld3,
	output reg signed	[RAM_WIDTH_KER-1:0] kernel_rdy3,
	
	input				[RAM_WIDTH_KER-1:0] kernel4,
	input				[RAM_WIDTH_KER-1:0] kernel_vld4,
	output reg signed	[RAM_WIDTH_KER-1:0] kernel_rdy4,
	
	input				[RAM_WIDTH_KER-1:0] kernel5,
	input				[RAM_WIDTH_KER-1:0] kernel_vld5,
	output reg signed	[RAM_WIDTH_KER-1:0] kernel_rdy5,
	
	input		[RAM_WIDTH_KER-1:0] kernel6,
	input		[RAM_WIDTH_KER-1:0] kernel_vld6,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy6,
	
	input		[RAM_WIDTH_KER-1:0] kernel7,
	input		[RAM_WIDTH_KER-1:0] kernel_vld7,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy7,
	
	input		[RAM_WIDTH_KER-1:0] kernel8,
	input		[RAM_WIDTH_KER-1:0] kernel_vld8,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy8,
	
	input		[RAM_WIDTH_KER-1:0] kernel9,
	input		[RAM_WIDTH_KER-1:0] kernel_vld9,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy9,
	
	input		[RAM_WIDTH_KER-1:0] kernel10,
	input		[RAM_WIDTH_KER-1:0] kernel_vld10,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy10,
	
	input		[RAM_WIDTH_KER-1:0] kernel11,
	input		[RAM_WIDTH_KER-1:0] kernel_vld11,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy11,
	
	input		[RAM_WIDTH_KER-1:0] kernel12,
	input		[RAM_WIDTH_KER-1:0] kernel_vld12,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy12,
	
	input		[RAM_WIDTH_KER-1:0] kernel13,
	input		[RAM_WIDTH_KER-1:0] kernel_vld13,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy13,
	
	input		[RAM_WIDTH_KER-1:0] kernel14,
	input		[RAM_WIDTH_KER-1:0] kernel_vld14,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy14,
	
	input		[RAM_WIDTH_KER-1:0] kernel15,
	input		[RAM_WIDTH_KER-1:0] kernel_vld15,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy15,
	
	input		[RAM_WIDTH_KER-1:0] kernel16,
	input		[RAM_WIDTH_KER-1:0] kernel_vld16,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy16,
	
	input		[RAM_WIDTH_KER-1:0] kernel17,
	input		[RAM_WIDTH_KER-1:0] kernel_vld17,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy17,
	
	input		[RAM_WIDTH_KER-1:0] kernel18,
	input		[RAM_WIDTH_KER-1:0] kernel_vld18,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy18,
	
	input		[RAM_WIDTH_KER-1:0] kernel19,
	input		[RAM_WIDTH_KER-1:0] kernel_vld19,
	output reg		[RAM_WIDTH_KER-1:0] kernel_rdy19,
	
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
	output reg	[RAM_WIDTH_KER-1:0] conv_2d_rdy
    );
    
    reg	signed	[RAM_WIDTH_KER-1:0]kernel0_mem [KER_MEM_LENGTH:0];
    wire signed [RAM_WIDTH_IMG-1:0] kernel0_concat;	
    reg								kernel_recieved[31:0];
    reg 		[5:0]				kernel_vals_cnt[31:0];
    
    reg signed	[RAM_WIDTH_KER-1:0]kernel_arr_in0 [N1_PARAM-1:0][M1_PARAM-1:0][C1_PARAM-1:0][0:0];
	reg			[6:0]				C1_var_def[31:0];
	reg			[8:0]				M1_var_def[31:0];
	reg			[8:0]				N1_var_def[31:0];
	reg 		[2:0]				L1_var_def[31:0];
	reg			[6:0]				C1_var_def0;
	reg			[8:0]				M1_var_def0;
	reg			[8:0]				N1_var_def0;
	reg 		[2:0]				L1_var_def0;
	reg						kernel_deflattened[31:0];
    
 	reg signed	[RAM_WIDTH_IMG-1:0]	image_mem [IMAGE_MEM_LENGTH:0];
 	reg 		[100:0]				image_vals_cnt;
    reg 							image_recieved;
    
    reg	signed	[RAM_WIDTH_BIAS-1:0]biases_mem [BIAS_MEM_LENGTH:0];
    wire signed [RAM_WIDTH_IMG-1:0]biases_concat;	
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
    

    wire signed [2*RAM_WIDTH_IMG-1:0]res_temp_w;
    wire signed	[RAM_WIDTH_IMG-1:0]  res_temp_w_conc;
    reg signed	[RAM_WIDTH_IMG-1:0]	result_mem [(N3_PARAM-1):0][(M3_PARAM-1):0][0:0];
    reg signed	[2*RAM_WIDTH_IMG-1:0]	result_temp;
    reg signed  [RAM_WIDTH_IMG-1:0]	init_delay;// for conv loop sync
    reg								delay_done;
    reg  		[2:0]				dly_cnt;
    reg 		[8:0]				N1_var2;
    reg 		[8:0]    			M1_var2;
    reg			[6:0]				C1_var4;
	reg			[8:0]				M3_var;
	reg			[8:0]				N3_var;
    reg 							conv_done;
      
    
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
				end/*
				if (image_vld == 1) begin				
				 
				end	*/		
				if (image_vals_cnt == IMAGE_MEM_LENGTH) begin
					image_recieved <= 1'b1;
				end
					
			else if(image_recieved == 1)
				image_mem[image_vals_cnt]<=image_mem[image_vals_cnt];	
				//kernel_rdy0<=0; //why does this break all rdy-val protocol?????
		end

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
    		image_mem[N2_var*M2_PARAM*C1_PARAM + M2_var*C1_PARAM + C1_var + 1]; //+1 because костыль in recieving protocol
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
    end 
    
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
				zero_pad_done <= 1'd0;
				for (l=0; l < 130; l=l+1) 
				begin
					for (m=0; m < 130; m=m+1) 
					begin
						for( n=0; n < 3; n=n+1)
						begin
							image_mem_arr_in_zpad[l][m][n] <= 19'd0;//ONLY FOR SIM!!!
						end
					end	
				end    		
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
							//$finish;
						end
				end
			end 
		end     
    end    
    
     ////////////////////////
	// recieving biases
	assign biases_concat[19:16] = 4'd0;
	assign biases_concat[15:0] = {biases[15:0]};
	always@(posedge clk)
		if (reset == 1) begin
			biases_rdy <= 0;
			biases_vals_cnt <= 10'd0;
			biases_recieved <= 0;
		end
		else begin
			if (biases_recieved == 0)		 
				biases_rdy <= 1; 
				if( ((biases_mem[biases_vals_cnt] != biases) || (biases_vld == 1)) || (biases_vals_cnt == BIAS_MEM_LENGTH ) ) 
				begin
				//counter clicks if new value came to kernel data port or it's the last value  
					biases_vals_cnt <= biases_vals_cnt + 1'd1;
					biases_mem[biases_vals_cnt] <= biases_concat;/*
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
    

    ////////////////////////
    // recieving kernel[0]
    assign kernel0_concat[19:16] = 4'd0;
	assign kernel0_concat[15:0] = {kernel0[15:0]};
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
	
    /*
    ////////////////////////
    // recieving kernel[1]
    ////////////////////////
    always@(posedge clk)
    	if (reset == 1) begin
    		kernel_rdy1 <= 0;
    		kernel[1] <= 19'd0;
    		kernel_vals_cnt[1] <= 5'd0;
    		kernel_recieved[1] <= 0;
    	end
    	else begin
    		if (kernel_recieved[1] == 0)		 
				kernel_rdy1 <= 1; 
				kernel[1] <= kernel1;
				kernel_vals_cnt[1] = kernel_vals_cnt[1] + 1'd1;
				if (kernel_vals_cnt[1] == 27)
					kernel_recieved[1] <= 1'b1;
    	end
   /**/
   
   ////////////////////////
   // convolution [0]
   localparam imgSF = 2.0**-16.00;  // Q6.14 scaling factor is 2^-14
   localparam tempSF = 2.0**-32.00; // Q12.28 scaling factor is 2^-28 for result_temp
   assign res_temp_w = kernel_arr_in0[M1_var2][N1_var2][C1_var4][0] * 
						image_mem_arr_in_zpad[M3_var + M1_var2][N3_var + N1_var2][C1_var4] +
						result_mem[M3_var][N3_var][0];
   assign res_temp_w_conc = res_temp_w[35:16];//[25:5] 
   integer j,i,k;
   always@(posedge clk)
       	if (reset == 1) begin
       		N1_var2 <= 8'd0;
       		M1_var2 <= 8'd0;
       		C1_var4 <= 6'd0;
       		N3_var <= 8'd0;
			M3_var <= 8'd0;
			conv_done <= 1'd0;
			result_temp <= 39'd0;
			init_delay <= 19'd0;
			dly_cnt <= 3'd0;
			delay_done <= 1'd0;
			//------------------------ONLY FOR SIM!!!------------------
			for (j=0; j < 128; j=j+1) 
			begin
				for (i=0; i < 128; i=i+1) 
				begin
					for( k=0; k < 1; k=k+1)
					begin
						result_mem[j][i][k] <= 19'd0;
					end
				end	
			end
			//------------------------ONLY FOR SIM!!!------------------
       	end
       	else begin
       		if (kernel_recieved[0] == 1 && zero_pad_done == 1 &&
       			biases_recieved == 1 && image_deflattened == 1 && conv_done == 0)
   			begin
   				/*
   				if (dly_cnt <= 1 && delay_done == 0)
   				begin
   					result_mem[M3_var][N3_var][0] <= init_delay;
   					delay_done <= 1'd1;
   				end
   				dly_cnt <= dly_cnt + 1;*/
   				result_temp <= result_mem[M3_var][N3_var][0] + 
   				kernel_arr_in0[M1_var2][N1_var2][C1_var4][0] * 
   				image_mem_arr_in_zpad[M3_var + M1_var2][N3_var + N1_var2][C1_var4];
   				result_mem[M3_var][N3_var][0] <= res_temp_w_conc;
   				
   				$display ("kernel_arr_in0[%0d][%0d][%0d][0]*img_mem_arr[%0d+%0d][%0d+%0d][%0d]",
   						   M1_var2, N1_var2, C1_var, M3_var, M1_var2, N3_var, N1_var2, C1_var4 );
   				$display ("res_temp_w = %b", res_temp_w);
   				$display ("res_temp_w_conc = %b", res_temp_w_conc);
   				$display ("result_temp = %b", result_temp);
   				$display ("result_mem[%0d][%0d][0] = %b + %b * %b",
						   M3_var, N3_var, result_mem[M3_var][N3_var][0], 
						   kernel_arr_in0[M1_var2][N1_var2][C1_var4][0],
						   image_mem_arr_in_zpad[M3_var + M1_var2][N3_var + N1_var2][C1_var4]);/**//*
				$display ("res_temp_w = %f", $itor(tempSF*res_temp_w));
				$display ("res_temp_w_conc = %f", $itor(imgSF*res_temp_w_conc));
			    $display ("result_mem[%0d][%0d][0] = %f + %f * %f",
						   M3_var, N3_var, $itor(imgSF*result_mem[M3_var][N3_var][0]), 
						   $itor(imgSF*kernel_arr_in0[M1_var2][N1_var2][C1_var4][0]),
						   $itor(imgSF*image_mem_arr_in_zpad[M3_var + M1_var2][N3_var + N1_var2][C1_var4]));/**/
			    $display (" ");
   				N1_var2 <= N1_var2 + 1;
   				if (N1_var2 >= N1_PARAM-1)
   				begin
   					N1_var2 <= 8'd0;
   					M1_var2 <= M1_var2 + 1;
   					if (M1_var2 >= M1_PARAM-1)
   					begin
   						M1_var2 <= 8'd0;
   						C1_var4 <= C1_var4 + 1;
   						if (C1_var4 >= C1_PARAM-1)
   						begin
							$display ("result_mem[%d][%d][0] = %h",
									   M3_var, N3_var, result_mem[M3_var][N3_var][0]);
							$display ("------------------------------------------------");
   							C1_var4 <= 6'd0;
   							N3_var <= N3_var + 1;
   							if (N3_var >= N3_PARAM-1)
   							begin
   								N3_var <= 8'd0;
   								M3_var <= M3_var + 1;
   								if (M3_var >= M3_PARAM-1)
   								begin
   									conv_done <= 1;
   									$finish;
   								end
   							end
   						end
   					end
   				end
   			end
   		end
    
endmodule
