`timescale 1ns / 1ps

module firstMaxPool
	#(
        parameter	RAM_WIDTH_IMG = 16,
        parameter   P1 = 2,
        parameter   P2 = 2,
        parameter   F_M1 = 128,
        parameter   F_M2 = 128,
        parameter   POOL_IN = 16384,//16384,
        parameter   POOLOUT1 = 64,
        parameter   POOLOUT2 = 64,
		parameter   POOL_ED = 4096
	)
	(
	input 									clk,
	input									reset,
	
	input				[RAM_WIDTH_IMG-1:0] image0,
	input									image_vld0,
	output reg 								image_rdy0,
	
	input				[RAM_WIDTH_IMG-1:0] image1,
	input									 image_vld1,
	output reg 						 image_rdy1,
	
	input				[RAM_WIDTH_IMG-1:0] image2,
	input									image_vld2,
	output reg 						 image_rdy2,	
	
	input				[RAM_WIDTH_IMG-1:0] image3,
	input									image_vld3,
	output reg signed						image_rdy3,
	
	input				[RAM_WIDTH_IMG-1:0] image4,
	input									image_vld4,
	output reg signed						image_rdy4,
	
	input				[RAM_WIDTH_IMG-1:0] image5,
	input									image_vld5,
	output reg signed						image_rdy5,
	
	input				[RAM_WIDTH_IMG-1:0] image6,
	input		 							image_vld6,
	output reg								 image_rdy6,
		
	input				[RAM_WIDTH_IMG-1:0] image7,
	input		 							image_vld7,
	output reg								image_rdy7,
	
	input		        [RAM_WIDTH_IMG-1:0] image8,
	input		         image_vld8,
	output reg	        	 image_rdy8,
        
	input		        [RAM_WIDTH_IMG-1:0] image9,
	input		         image_vld9,
	output reg	        	image_rdy9,
        
	input		        [RAM_WIDTH_IMG-1:0] image10,
	input		         image_vld10,
	output reg	        	 image_rdy10,
        
	input		        [RAM_WIDTH_IMG-1:0] image11,
	input		         image_vld11,
	output reg	        	 image_rdy11,
        
	input		        [RAM_WIDTH_IMG-1:0] image12,
	input		         image_vld12,
	output reg	        	 image_rdy12,
        
	input		        [RAM_WIDTH_IMG-1:0] image13,
	input		        image_vld13,
	output reg	        	image_rdy13,
        
	input		        [RAM_WIDTH_IMG-1:0] image14,
	input		         image_vld14,
	output reg	        	 image_rdy14,
        
	input		        [RAM_WIDTH_IMG-1:0] image15,
	input		         image_vld15,
	output reg	        	 image_rdy15,
        
	input		        [RAM_WIDTH_IMG-1:0] image16,
	input		         image_vld16,
	output reg	        	 image_rdy16,
        
	input		        [RAM_WIDTH_IMG-1:0] image17,
	input		         image_vld17,
	output reg	        	 image_rdy17,
        
	input		        [RAM_WIDTH_IMG-1:0] image18,
	input		         image_vld18,
	output reg	        	 image_rdy18,
        
	input		        [RAM_WIDTH_IMG-1:0] image19,
	input		         image_vld19,
	output reg	        	 image_rdy19,
	
	input		        [RAM_WIDTH_IMG-1:0] image20,
	input		        					image_vld20,
	output reg	        					image_rdy20,
        
	input		        [RAM_WIDTH_IMG-1:0] image21,
	input		        					image_vld21,
	output reg	        					image_rdy21,
        
	input		        [RAM_WIDTH_IMG-1:0] image22,
	input		        					image_vld22,
	output reg	        					image_rdy22,
        
	input		        [RAM_WIDTH_IMG-1:0] image23,
	input		        					image_vld23,
	output reg	        					image_rdy23,
        
	input		        [RAM_WIDTH_IMG-1:0] image24,
	input		        					image_vld24,
	output reg	        					image_rdy24,
        
	input		        [RAM_WIDTH_IMG-1:0] image25,
	input		        					image_vld25,
	output reg	        					image_rdy25,
        
	input		        [RAM_WIDTH_IMG-1:0] image26,
	input		        					image_vld26,
	output reg	        					image_rdy26,
        
	input		        [RAM_WIDTH_IMG-1:0] image27,
	input		        					image_vld27,
	output reg	        					image_rdy27,	
        
	input		        [RAM_WIDTH_IMG-1:0] image28,
	input		        					image_vld28,
	output reg	        					image_rdy28,
        
	input		        [RAM_WIDTH_IMG-1:0] image29,
	input		        					image_vld29,
	output reg	        					image_rdy29,
        
	input		        [RAM_WIDTH_IMG-1:0] image30,
	input		        					image_vld30,
	output reg	        					image_rdy30,
        
	input		        [RAM_WIDTH_IMG-1:0] image31,
	input		        					image_vld31,
	output reg	        					image_rdy31,
	
	
	output reg  signed 	[RAM_WIDTH_IMG-1:0] result0,
	input									result_vld0,
	output reg 								result_rdy0,
	
	output reg signed	[RAM_WIDTH_IMG-1:0] result1,
    input									result_vld1,
	output reg 								result_rdy1,

	output reg signed	[RAM_WIDTH_IMG-1:0] result2,
    input									result_vld2,
	output reg 								result_rdy2,

	output reg signed	[RAM_WIDTH_IMG-1:0] result3,
    input									result_vld3,
	output reg 								result_rdy3,

	output reg signed	[RAM_WIDTH_IMG-1:0] result4,
    input									result_vld4,
	output reg 								result_rdy4,

	output reg signed	[RAM_WIDTH_IMG-1:0] result5,
    input									result_vld5,
	output reg 								result_rdy5,

	output reg signed	[RAM_WIDTH_IMG-1:0] result6,
    input									result_vld6,
	output reg 								result_rdy6,

	output reg signed	[RAM_WIDTH_IMG-1:0] result7,
    input									result_vld7,
	output reg 								result_rdy7,

	output reg signed	[RAM_WIDTH_IMG-1:0] result8,
    input									result_vld8,
	output reg 								result_rdy8,

	output reg signed	[RAM_WIDTH_IMG-1:0] result9,
    input									result_vld9,
	output reg 								result_rdy9,

	output reg signed	[RAM_WIDTH_IMG-1:0] result10,
    input									result_vld10,
	output reg 								result_rdy10,

	output reg signed	[RAM_WIDTH_IMG-1:0] result11,
    input									result_vld11,
	output reg 								result_rdy11,

	output reg signed	[RAM_WIDTH_IMG-1:0] result12,
    input									result_vld12,
	output reg 								result_rdy12,

	output reg signed	[RAM_WIDTH_IMG-1:0] result13,
    input									result_vld13,
	output reg 								result_rdy13,

	output reg signed	[RAM_WIDTH_IMG-1:0] result14,
    input									result_vld14,
	output reg 								result_rdy14,

	output reg signed	[RAM_WIDTH_IMG-1:0] result15,
    input									result_vld15,
	output reg 								result_rdy15,

	output reg signed	[RAM_WIDTH_IMG-1:0] result16,
    input									result_vld16,
	output reg 								result_rdy16,

	output reg signed	[RAM_WIDTH_IMG-1:0] result17,
    input									result_vld17,
	output reg 								result_rdy17,

	output reg signed	[RAM_WIDTH_IMG-1:0] result18,
    input									result_vld18,
	output reg 								result_rdy18,

	output reg signed	[RAM_WIDTH_IMG-1:0] result19,
    input									result_vld19,
	output reg 								result_rdy19,

	output reg signed	[RAM_WIDTH_IMG-1:0] result20,
    input									result_vld20,
	output reg 								result_rdy20,

	output reg signed	[RAM_WIDTH_IMG-1:0] result21,
    input									result_vld21,
	output reg 								result_rdy21,

	output reg signed	[RAM_WIDTH_IMG-1:0] result22,
    input									result_vld22,
	output reg 								result_rdy22,

	output reg signed	[RAM_WIDTH_IMG-1:0] result23,
    input									result_vld23,
	output reg 								result_rdy23,

	output reg signed	[RAM_WIDTH_IMG-1:0] result24,
    input									result_vld24,
	output reg 								result_rdy24,

	output reg signed	[RAM_WIDTH_IMG-1:0] result25,
    input									result_vld25,
	output reg 								result_rdy25,

	output reg signed	[RAM_WIDTH_IMG-1:0] result26,
    input									result_vld26,
	output reg 								result_rdy26,

	output reg signed	[RAM_WIDTH_IMG-1:0] result27,
    input									result_vld27,
	output reg 								result_rdy27,

	output reg signed	[RAM_WIDTH_IMG-1:0] result28,
    input									result_vld28,
	output reg 								result_rdy28,

	output reg signed	[RAM_WIDTH_IMG-1:0] result29,
    input									result_vld29,
	output reg 								result_rdy29,

	output reg signed	[RAM_WIDTH_IMG-1:0] result30,
    input									result_vld30,
	output reg 								result_rdy30,

	output reg signed	[RAM_WIDTH_IMG-1:0] result31,
    input									result_vld31,
	output reg 								result_rdy31
    );	
//---------------------------------------------------------
	reg 		        		   we_img0_mem ;
    reg 		        		   en_w_img0_mem ;
    reg 		        		   en_r_img0_mem ;
    reg 	   [16-1:0]		       addr_w_img0_mem;
    reg 	   [16-1:0]		       addr_r_img0_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img0_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img0_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img0_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img0_mem(.clk(clk),
              .reset(reset),
              .we(we_img0_mem),
              .en_w(en_w_img0_mem),
              .en_r(en_r_img0_mem),
              .addr_w(addr_w_img0_mem),
              .addr_r(addr_r_img0_mem),
              .di(inp_img0_mem),
              .dout(outp_img0_mem),
              .dat_read(dat_read_img0_mem)
    );

    reg 		        		   we_img1_mem ;
    reg 		        		   en_w_img1_mem ;
    reg 		        		   en_r_img1_mem ;
    reg 	   [16-1:0]		       addr_w_img1_mem;
    reg 	   [16-1:0]		       addr_r_img1_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img1_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img1_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img1_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img1_mem(.clk(clk),
              .reset(reset),
              .we(we_img1_mem),
              .en_w(en_w_img1_mem),
              .en_r(en_r_img1_mem),
              .addr_w(addr_w_img1_mem),
              .addr_r(addr_r_img1_mem),
              .di(inp_img1_mem),
              .dout(outp_img1_mem),
              .dat_read(dat_read_img1_mem)
    );
    
    reg 		        		   we_img2_mem ;
    reg 		        		   en_w_img2_mem ;
    reg 		        		   en_r_img2_mem ;
    reg 	   [16-1:0]		       addr_w_img2_mem;
    reg 	   [16-1:0]		       addr_r_img2_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img2_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img2_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img2_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img2_mem(.clk(clk),
              .reset(reset),
              .we(we_img2_mem),
              .en_w(en_w_img2_mem),
              .en_r(en_r_img2_mem),
              .addr_w(addr_w_img2_mem),
              .addr_r(addr_r_img2_mem),
              .di(inp_img2_mem),
              .dout(outp_img2_mem),
              .dat_read(dat_read_img2_mem)
    );
    
    reg 		        		   we_img3_mem ;
    reg 		        		   en_w_img3_mem ;
    reg 		        		   en_r_img3_mem ;
    reg 	   [16-1:0]		       addr_w_img3_mem;
    reg 	   [16-1:0]		       addr_r_img3_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img3_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img3_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img3_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img3_mem(.clk(clk),
              .reset(reset),
              .we(we_img3_mem),
              .en_w(en_w_img3_mem),
              .en_r(en_r_img3_mem),
              .addr_w(addr_w_img3_mem),
              .addr_r(addr_r_img3_mem),
              .di(inp_img3_mem),
              .dout(outp_img3_mem),
              .dat_read(dat_read_img3_mem)
    );
    
    reg 		        		   we_img4_mem ;
    reg 		        		   en_w_img4_mem ;
    reg 		        		   en_r_img4_mem ;
    reg 	   [16-1:0]		       addr_w_img4_mem;
    reg 	   [16-1:0]		       addr_r_img4_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img4_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img4_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img4_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img4_mem(.clk(clk),
              .reset(reset),
              .we(we_img4_mem),
              .en_w(en_w_img4_mem),
              .en_r(en_r_img4_mem),
              .addr_w(addr_w_img4_mem),
              .addr_r(addr_r_img4_mem),
              .di(inp_img4_mem),
              .dout(outp_img4_mem),
              .dat_read(dat_read_img4_mem)
    );
    
    reg 		        		   we_img5_mem ;
    reg 		        		   en_w_img5_mem ;
    reg 		        		   en_r_img5_mem ;
    reg 	   [16-1:0]		       addr_w_img5_mem;
    reg 	   [16-1:0]		       addr_r_img5_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img5_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img5_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img5_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img5_mem(.clk(clk),
              .reset(reset),
              .we(we_img5_mem),
              .en_w(en_w_img5_mem),
              .en_r(en_r_img5_mem),
              .addr_w(addr_w_img5_mem),
              .addr_r(addr_r_img5_mem),
              .di(inp_img5_mem),
              .dout(outp_img5_mem),
              .dat_read(dat_read_img5_mem)
    );
    
    reg 		        		   we_img6_mem ;
    reg 		        		   en_w_img6_mem ;
    reg 		        		   en_r_img6_mem ;
    reg 	   [16-1:0]		       addr_w_img6_mem;
    reg 	   [16-1:0]		       addr_r_img6_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img6_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img6_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img6_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img6_mem(.clk(clk),
              .reset(reset),
              .we(we_img6_mem),
              .en_w(en_w_img6_mem),
              .en_r(en_r_img6_mem),
              .addr_w(addr_w_img6_mem),
              .addr_r(addr_r_img6_mem),
              .di(inp_img6_mem),
              .dout(outp_img6_mem),
              .dat_read(dat_read_img6_mem)
    );
    
    reg 		        		   we_img7_mem ;
    reg 		        		   en_w_img7_mem ;
    reg 		        		   en_r_img7_mem ;
    reg 	   [16-1:0]		       addr_w_img7_mem;
    reg 	   [16-1:0]		       addr_r_img7_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img7_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img7_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img7_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img7_mem(.clk(clk),
              .reset(reset),
              .we(we_img7_mem),
              .en_w(en_w_img7_mem),
              .en_r(en_r_img7_mem),
              .addr_w(addr_w_img7_mem),
              .addr_r(addr_r_img7_mem),
              .di(inp_img7_mem),
              .dout(outp_img7_mem),
              .dat_read(dat_read_img7_mem)
    );
    
    reg 		        		   we_img8_mem ;
    reg 		        		   en_w_img8_mem ;
    reg 		        		   en_r_img8_mem ;
    reg 	   [16-1:0]		       addr_w_img8_mem;
    reg 	   [16-1:0]		       addr_r_img8_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img8_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img8_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img8_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img8_mem(.clk(clk),
              .reset(reset),
              .we(we_img8_mem),
              .en_w(en_w_img8_mem),
              .en_r(en_r_img8_mem),
              .addr_w(addr_w_img8_mem),
              .addr_r(addr_r_img8_mem),
              .di(inp_img8_mem),
              .dout(outp_img8_mem),
              .dat_read(dat_read_img8_mem)
    );
    
    reg 		        		   we_img9_mem ;
    reg 		        		   en_w_img9_mem ;
    reg 		        		   en_r_img9_mem ;
    reg 	   [16-1:0]		       addr_w_img9_mem;
    reg 	   [16-1:0]		       addr_r_img9_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img9_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img9_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img9_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img9_mem(.clk(clk),
              .reset(reset),
              .we(we_img9_mem),
              .en_w(en_w_img9_mem),
              .en_r(en_r_img9_mem),
              .addr_w(addr_w_img9_mem),
              .addr_r(addr_r_img9_mem),
              .di(inp_img9_mem),
              .dout(outp_img9_mem),
              .dat_read(dat_read_img9_mem)
    );
    
    reg 		        		   we_img10_mem ;
    reg 		        		   en_w_img10_mem ;
    reg 		        		   en_r_img10_mem ;
    reg 	   [16-1:0]		       addr_w_img10_mem;
    reg 	   [16-1:0]		       addr_r_img10_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img10_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img10_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img10_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img10_mem(.clk(clk),
              .reset(reset),
              .we(we_img10_mem),
              .en_w(en_w_img10_mem),
              .en_r(en_r_img10_mem),
              .addr_w(addr_w_img10_mem),
              .addr_r(addr_r_img10_mem),
              .di(inp_img10_mem),
              .dout(outp_img10_mem),
              .dat_read(dat_read_img10_mem)
    );
    
    reg 		        		   we_img11_mem ;
    reg 		        		   en_w_img11_mem ;
    reg 		        		   en_r_img11_mem ;
    reg 	   [16-1:0]		       addr_w_img11_mem;
    reg 	   [16-1:0]		       addr_r_img11_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img11_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img11_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img11_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img11_mem(.clk(clk),
              .reset(reset),
              .we(we_img11_mem),
              .en_w(en_w_img11_mem),
              .en_r(en_r_img11_mem),
              .addr_w(addr_w_img11_mem),
              .addr_r(addr_r_img11_mem),
              .di(inp_img11_mem),
              .dout(outp_img11_mem),
              .dat_read(dat_read_img11_mem)
    );
    
    reg 		        		   we_img12_mem ;
    reg 		        		   en_w_img12_mem ;
    reg 		        		   en_r_img12_mem ;
    reg 	   [16-1:0]		       addr_w_img12_mem;
    reg 	   [16-1:0]		       addr_r_img12_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img12_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img12_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img12_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img12_mem(.clk(clk),
              .reset(reset),
              .we(we_img12_mem),
              .en_w(en_w_img12_mem),
              .en_r(en_r_img12_mem),
              .addr_w(addr_w_img12_mem),
              .addr_r(addr_r_img12_mem),
              .di(inp_img12_mem),
              .dout(outp_img12_mem),
              .dat_read(dat_read_img12_mem)
    );
    
    reg 		        		   we_img13_mem ;
    reg 		        		   en_w_img13_mem ;
    reg 		        		   en_r_img13_mem ;
    reg 	   [16-1:0]		       addr_w_img13_mem;
    reg 	   [16-1:0]		       addr_r_img13_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img13_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img13_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img13_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img13_mem(.clk(clk),
              .reset(reset),
              .we(we_img13_mem),
              .en_w(en_w_img13_mem),
              .en_r(en_r_img13_mem),
              .addr_w(addr_w_img13_mem),
              .addr_r(addr_r_img13_mem),
              .di(inp_img13_mem),
              .dout(outp_img13_mem),
              .dat_read(dat_read_img13_mem)
    );
    
    reg 		        		   we_img14_mem ;
    reg 		        		   en_w_img14_mem ;
    reg 		        		   en_r_img14_mem ;
    reg 	   [16-1:0]		       addr_w_img14_mem;
    reg 	   [16-1:0]		       addr_r_img14_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img14_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img14_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img14_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img14_mem(.clk(clk),
              .reset(reset),
              .we(we_img14_mem),
              .en_w(en_w_img14_mem),
              .en_r(en_r_img14_mem),
              .addr_w(addr_w_img14_mem),
              .addr_r(addr_r_img14_mem),
              .di(inp_img14_mem),
              .dout(outp_img14_mem),
              .dat_read(dat_read_img14_mem)
    );
    
    reg 		        		   we_img15_mem ;
    reg 		        		   en_w_img15_mem ;
    reg 		        		   en_r_img15_mem ;
    reg 	   [16-1:0]		       addr_w_img15_mem;
    reg 	   [16-1:0]		       addr_r_img15_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img15_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img15_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img15_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img15_mem(.clk(clk),
              .reset(reset),
              .we(we_img15_mem),
              .en_w(en_w_img15_mem),
              .en_r(en_r_img15_mem),
              .addr_w(addr_w_img15_mem),
              .addr_r(addr_r_img15_mem),
              .di(inp_img15_mem),
              .dout(outp_img15_mem),
              .dat_read(dat_read_img15_mem)
    );
        
    reg 		        		   we_img16_mem ;
    reg 		        		   en_w_img16_mem ;
    reg 		        		   en_r_img16_mem ;
    reg 	   [16-1:0]		       addr_w_img16_mem;
    reg 	   [16-1:0]		       addr_r_img16_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img16_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img16_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img16_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img16_mem(.clk(clk),
              .reset(reset),
              .we(we_img16_mem),
              .en_w(en_w_img16_mem),
              .en_r(en_r_img16_mem),
              .addr_w(addr_w_img16_mem),
              .addr_r(addr_r_img16_mem),
              .di(inp_img16_mem),
              .dout(outp_img16_mem),
              .dat_read(dat_read_img16_mem)
    );
        
    reg 		        		   we_img17_mem ;
    reg 		        		   en_w_img17_mem ;
    reg 		        		   en_r_img17_mem ;
    reg 	   [16-1:0]		       addr_w_img17_mem;
    reg 	   [16-1:0]		       addr_r_img17_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img17_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img17_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img17_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img17_mem(.clk(clk),
              .reset(reset),
              .we(we_img17_mem),
              .en_w(en_w_img17_mem),
              .en_r(en_r_img17_mem),
              .addr_w(addr_w_img17_mem),
              .addr_r(addr_r_img17_mem),
              .di(inp_img17_mem),
              .dout(outp_img17_mem),
              .dat_read(dat_read_img17_mem)
    );
        
    reg 		        		   we_img18_mem ;
    reg 		        		   en_w_img18_mem ;
    reg 		        		   en_r_img18_mem ;
    reg 	   [16-1:0]		       addr_w_img18_mem;
    reg 	   [16-1:0]		       addr_r_img18_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img18_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img18_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img18_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img18_mem(.clk(clk),
              .reset(reset),
              .we(we_img18_mem),
              .en_w(en_w_img18_mem),
              .en_r(en_r_img18_mem),
              .addr_w(addr_w_img18_mem),
              .addr_r(addr_r_img18_mem),
              .di(inp_img18_mem),
              .dout(outp_img18_mem),
              .dat_read(dat_read_img18_mem)
    );
        
    reg 		        		   we_img19_mem ;
    reg 		        		   en_w_img19_mem ;
    reg 		        		   en_r_img19_mem ;
    reg 	   [16-1:0]		       addr_w_img19_mem;
    reg 	   [16-1:0]		       addr_r_img19_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img19_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img19_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img19_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img19_mem(.clk(clk),
              .reset(reset),
              .we(we_img19_mem),
              .en_w(en_w_img19_mem),
              .en_r(en_r_img19_mem),
              .addr_w(addr_w_img19_mem),
              .addr_r(addr_r_img19_mem),
              .di(inp_img19_mem),
              .dout(outp_img19_mem),
              .dat_read(dat_read_img19_mem)
    );
        
    reg 		        		   we_img20_mem ;
    reg 		        		   en_w_img20_mem ;
    reg 		        		   en_r_img20_mem ;
    reg 	   [16-1:0]		       addr_w_img20_mem;
    reg 	   [16-1:0]		       addr_r_img20_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img20_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img20_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img20_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img20_mem(.clk(clk),
              .reset(reset),
              .we(we_img20_mem),
              .en_w(en_w_img20_mem),
              .en_r(en_r_img20_mem),
              .addr_w(addr_w_img20_mem),
              .addr_r(addr_r_img20_mem),
              .di(inp_img20_mem),
              .dout(outp_img20_mem),
              .dat_read(dat_read_img20_mem)
    );
        
    reg 		        		   we_img21_mem ;
    reg 		        		   en_w_img21_mem ;
    reg 		        		   en_r_img21_mem ;
    reg 	   [16-1:0]		       addr_w_img21_mem;
    reg 	   [16-1:0]		       addr_r_img21_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img21_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img21_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img21_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img21_mem(.clk(clk),
              .reset(reset),
              .we(we_img21_mem),
              .en_w(en_w_img21_mem),
              .en_r(en_r_img21_mem),
              .addr_w(addr_w_img21_mem),
              .addr_r(addr_r_img21_mem),
              .di(inp_img21_mem),
              .dout(outp_img21_mem),
              .dat_read(dat_read_img21_mem)
    );
        
    reg 		        		   we_img22_mem ;
    reg 		        		   en_w_img22_mem ;
    reg 		        		   en_r_img22_mem ;
    reg 	   [16-1:0]		       addr_w_img22_mem;
    reg 	   [16-1:0]		       addr_r_img22_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img22_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img22_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img22_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img22_mem(.clk(clk),
              .reset(reset),
              .we(we_img22_mem),
              .en_w(en_w_img22_mem),
              .en_r(en_r_img22_mem),
              .addr_w(addr_w_img22_mem),
              .addr_r(addr_r_img22_mem),
              .di(inp_img22_mem),
              .dout(outp_img22_mem),
              .dat_read(dat_read_img22_mem)
    );
        
    reg 		        		   we_img23_mem ;
    reg 		        		   en_w_img23_mem ;
    reg 		        		   en_r_img23_mem ;
    reg 	   [16-1:0]		       addr_w_img23_mem;
    reg 	   [16-1:0]		       addr_r_img23_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img23_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img23_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img23_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img23_mem(.clk(clk),
              .reset(reset),
              .we(we_img23_mem),
              .en_w(en_w_img23_mem),
              .en_r(en_r_img23_mem),
              .addr_w(addr_w_img23_mem),
              .addr_r(addr_r_img23_mem),
              .di(inp_img23_mem),
              .dout(outp_img23_mem),
              .dat_read(dat_read_img23_mem)
    );
        
    reg 		        		   we_img24_mem ;
    reg 		        		   en_w_img24_mem ;
    reg 		        		   en_r_img24_mem ;
    reg 	   [16-1:0]		       addr_w_img24_mem;
    reg 	   [16-1:0]		       addr_r_img24_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img24_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img24_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img24_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img24_mem(.clk(clk),
              .reset(reset),
              .we(we_img24_mem),
              .en_w(en_w_img24_mem),
              .en_r(en_r_img24_mem),
              .addr_w(addr_w_img24_mem),
              .addr_r(addr_r_img24_mem),
              .di(inp_img24_mem),
              .dout(outp_img24_mem),
              .dat_read(dat_read_img24_mem)
    );
        
    reg 		        		   we_img25_mem ;
    reg 		        		   en_w_img25_mem ;
    reg 		        		   en_r_img25_mem ;
    reg 	   [16-1:0]		       addr_w_img25_mem;
    reg 	   [16-1:0]		       addr_r_img25_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img25_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img25_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img25_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img25_mem(.clk(clk),
              .reset(reset),
              .we(we_img25_mem),
              .en_w(en_w_img25_mem),
              .en_r(en_r_img25_mem),
              .addr_w(addr_w_img25_mem),
              .addr_r(addr_r_img25_mem),
              .di(inp_img25_mem),
              .dout(outp_img25_mem),
              .dat_read(dat_read_img25_mem)
    );
        
    reg 		        		   we_img26_mem ;
    reg 		        		   en_w_img26_mem ;
    reg 		        		   en_r_img26_mem ;
    reg 	   [16-1:0]		       addr_w_img26_mem;
    reg 	   [16-1:0]		       addr_r_img26_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img26_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img26_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img26_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img26_mem(.clk(clk),
              .reset(reset),
              .we(we_img26_mem),
              .en_w(en_w_img26_mem),
              .en_r(en_r_img26_mem),
              .addr_w(addr_w_img26_mem),
              .addr_r(addr_r_img26_mem),
              .di(inp_img26_mem),
              .dout(outp_img26_mem),
              .dat_read(dat_read_img26_mem)
    );
        
    reg 		        		   we_img27_mem ;
    reg 		        		   en_w_img27_mem ;
    reg 		        		   en_r_img27_mem ;
    reg 	   [16-1:0]		       addr_w_img27_mem;
    reg 	   [16-1:0]		       addr_r_img27_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img27_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img27_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img27_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img27_mem(.clk(clk),
              .reset(reset),
              .we(we_img27_mem),
              .en_w(en_w_img27_mem),
              .en_r(en_r_img27_mem),
              .addr_w(addr_w_img27_mem),
              .addr_r(addr_r_img27_mem),
              .di(inp_img27_mem),
              .dout(outp_img27_mem),
              .dat_read(dat_read_img27_mem)
    );
        
    reg 		        		   we_img28_mem ;
    reg 		        		   en_w_img28_mem ;
    reg 		        		   en_r_img28_mem ;
    reg 	   [16-1:0]		       addr_w_img28_mem;
    reg 	   [16-1:0]		       addr_r_img28_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img28_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img28_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img28_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img28_mem(.clk(clk),
              .reset(reset),
              .we(we_img28_mem),
              .en_w(en_w_img28_mem),
              .en_r(en_r_img28_mem),
              .addr_w(addr_w_img28_mem),
              .addr_r(addr_r_img28_mem),
              .di(inp_img28_mem),
              .dout(outp_img28_mem),
              .dat_read(dat_read_img28_mem)
    );
        
    reg 		        		   we_img29_mem ;
    reg 		        		   en_w_img29_mem ;
    reg 		        		   en_r_img29_mem ;
    reg 	   [16-1:0]		       addr_w_img29_mem;
    reg 	   [16-1:0]		       addr_r_img29_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img29_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img29_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img29_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img29_mem(.clk(clk),
              .reset(reset),
              .we(we_img29_mem),
              .en_w(en_w_img29_mem),
              .en_r(en_r_img29_mem),
              .addr_w(addr_w_img29_mem),
              .addr_r(addr_r_img29_mem),
              .di(inp_img29_mem),
              .dout(outp_img29_mem),
              .dat_read(dat_read_img29_mem)
    );

    reg 		        		   we_img30_mem ;
    reg 		        		   en_w_img30_mem ;
    reg 		        		   en_r_img30_mem ;
    reg 	   [16-1:0]		       addr_w_img30_mem;
    reg 	   [16-1:0]		       addr_r_img30_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img30_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img30_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img30_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img30_mem(.clk(clk),
              .reset(reset),
              .we(we_img30_mem),
              .en_w(en_w_img30_mem),
              .en_r(en_r_img30_mem),
              .addr_w(addr_w_img30_mem),
              .addr_r(addr_r_img30_mem),
              .di(inp_img30_mem),
              .dout(outp_img30_mem),
              .dat_read(dat_read_img30_mem)
    );
        
    reg 		        		   we_img31_mem ;
    reg 		        		   en_w_img31_mem ;
    reg 		        		   en_r_img31_mem ;
    reg 	   [16-1:0]		       addr_w_img31_mem;
    reg 	   [16-1:0]		       addr_r_img31_mem;
    reg signed [RAM_WIDTH_IMG-1:0] inp_img31_mem ;
    reg signed [RAM_WIDTH_IMG-1:0] outp_img31_mem;
    reg signed [RAM_WIDTH_IMG-1:0] dat_read_img31_mem;   
	
	oneDRAM #(.A_WIDTH(15),
			  .ADDR_WIDTH(16), 
			  .D_WIDTH(RAM_WIDTH_IMG)
    )img31_mem(.clk(clk),
              .reset(reset),
              .we(we_img31_mem),
              .en_w(en_w_img31_mem),
              .en_r(en_r_img31_mem),
              .addr_w(addr_w_img31_mem),
              .addr_r(addr_r_img31_mem),
              .di(inp_img31_mem),
              .dout(outp_img31_mem),
              .dat_read(dat_read_img31_mem)
    );
            
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
      
    reg 		        		   we_result0_mem ;
	reg 		        		   en_w_result0_mem ;
	reg 		        		   en_r_result0_mem ;
	reg 	   [16-1:0]	           addr_w_result0_mem;
	reg 	   [16-1:0]	           addr_r_result0_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result0_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result0_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result0_mem;
	
	oneDRAM #(.A_WIDTH(12),
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
              .dout(outp_result0_mem),
              .dat_read(dat_read_result0_mem)
    );
      
    reg 		        		   we_result1_mem ;
	reg 		        		   en_w_result1_mem ;
	reg 		        		   en_r_result1_mem ;
	reg 	   [16-1:0]	           addr_w_result1_mem;
	reg 	   [16-1:0]	           addr_r_result1_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result1_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result1_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result1_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result1_mem(.clk(clk),
              .reset(reset),
              .we(we_result1_mem),
              .en_w(en_w_result1_mem),
              .en_r(en_r_result1_mem),
              .addr_w(addr_w_result1_mem),
              .addr_r(addr_r_result1_mem),
              .di(inp_result1_mem),
              .dout(outp_result1_mem),
              .dat_read(dat_read_result1_mem)
    );
      
    reg 		        		   we_result2_mem ;
	reg 		        		   en_w_result2_mem ;
	reg 		        		   en_r_result2_mem ;
	reg 	   [16-1:0]	           addr_w_result2_mem;
	reg 	   [16-1:0]	           addr_r_result2_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result2_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result2_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result2_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result2_mem(.clk(clk),
              .reset(reset),
              .we(we_result2_mem),
              .en_w(en_w_result2_mem),
              .en_r(en_r_result2_mem),
              .addr_w(addr_w_result2_mem),
              .addr_r(addr_r_result2_mem),
              .di(inp_result2_mem),
              .dout(outp_result2_mem),
              .dat_read(dat_read_result2_mem)
    );
      
    reg 		        		   we_result3_mem ;
	reg 		        		   en_w_result3_mem ;
	reg 		        		   en_r_result3_mem ;
	reg 	   [16-1:0]	           addr_w_result3_mem;
	reg 	   [16-1:0]	           addr_r_result3_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result3_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result3_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result3_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result3_mem(.clk(clk),
              .reset(reset),
              .we(we_result3_mem),
              .en_w(en_w_result3_mem),
              .en_r(en_r_result3_mem),
              .addr_w(addr_w_result3_mem),
              .addr_r(addr_r_result3_mem),
              .di(inp_result3_mem),
              .dout(outp_result3_mem),
              .dat_read(dat_read_result3_mem)
    );
      
    reg 		        		   we_result4_mem ;
	reg 		        		   en_w_result4_mem ;
	reg 		        		   en_r_result4_mem ;
	reg 	   [16-1:0]	           addr_w_result4_mem;
	reg 	   [16-1:0]	           addr_r_result4_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result4_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result4_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result4_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result4_mem(.clk(clk),
              .reset(reset),
              .we(we_result4_mem),
              .en_w(en_w_result4_mem),
              .en_r(en_r_result4_mem),
              .addr_w(addr_w_result4_mem),
              .addr_r(addr_r_result4_mem),
              .di(inp_result4_mem),
              .dout(outp_result4_mem),
              .dat_read(dat_read_result4_mem)
    );
      
    reg 		        		   we_result5_mem ;
	reg 		        		   en_w_result5_mem ;
	reg 		        		   en_r_result5_mem ;
	reg 	   [16-1:0]	           addr_w_result5_mem;
	reg 	   [16-1:0]	           addr_r_result5_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result5_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result5_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result5_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result5_mem(.clk(clk),
              .reset(reset),
              .we(we_result5_mem),
              .en_w(en_w_result5_mem),
              .en_r(en_r_result5_mem),
              .addr_w(addr_w_result5_mem),
              .addr_r(addr_r_result5_mem),
              .di(inp_result5_mem),
              .dout(outp_result5_mem),
              .dat_read(dat_read_result5_mem)
    );
      
    reg 		        		   we_result6_mem ;
	reg 		        		   en_w_result6_mem ;
	reg 		        		   en_r_result6_mem ;
	reg 	   [16-1:0]	           addr_w_result6_mem;
	reg 	   [16-1:0]	           addr_r_result6_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result6_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result6_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result6_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result6_mem(.clk(clk),
              .reset(reset),
              .we(we_result6_mem),
              .en_w(en_w_result6_mem),
              .en_r(en_r_result6_mem),
              .addr_w(addr_w_result6_mem),
              .addr_r(addr_r_result6_mem),
              .di(inp_result6_mem),
              .dout(outp_result6_mem),
              .dat_read(dat_read_result6_mem)
    );
      
    reg 		        		   we_result7_mem ;
	reg 		        		   en_w_result7_mem ;
	reg 		        		   en_r_result7_mem ;
	reg 	   [16-1:0]	           addr_w_result7_mem;
	reg 	   [16-1:0]	           addr_r_result7_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result7_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result7_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result7_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result7_mem(.clk(clk),
              .reset(reset),
              .we(we_result7_mem),
              .en_w(en_w_result7_mem),
              .en_r(en_r_result7_mem),
              .addr_w(addr_w_result7_mem),
              .addr_r(addr_r_result7_mem),
              .di(inp_result7_mem),
              .dout(outp_result7_mem),
              .dat_read(dat_read_result7_mem)
    );
      
    reg 		        		   we_result8_mem ;
	reg 		        		   en_w_result8_mem ;
	reg 		        		   en_r_result8_mem ;
	reg 	   [16-1:0]	           addr_w_result8_mem;
	reg 	   [16-1:0]	           addr_r_result8_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result8_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result8_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result8_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result8_mem(.clk(clk),
              .reset(reset),
              .we(we_result8_mem),
              .en_w(en_w_result8_mem),
              .en_r(en_r_result8_mem),
              .addr_w(addr_w_result8_mem),
              .addr_r(addr_r_result8_mem),
              .di(inp_result8_mem),
              .dout(outp_result8_mem),
              .dat_read(dat_read_result8_mem)
    );
      
    reg 		        		   we_result9_mem ;
	reg 		        		   en_w_result9_mem ;
	reg 		        		   en_r_result9_mem ;
	reg 	   [16-1:0]	           addr_w_result9_mem;
	reg 	   [16-1:0]	           addr_r_result9_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result9_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result9_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result9_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result9_mem(.clk(clk),
              .reset(reset),
              .we(we_result9_mem),
              .en_w(en_w_result9_mem),
              .en_r(en_r_result9_mem),
              .addr_w(addr_w_result9_mem),
              .addr_r(addr_r_result9_mem),
              .di(inp_result9_mem),
              .dout(outp_result9_mem),
              .dat_read(dat_read_result9_mem)
    );
      
    reg 		        		   we_result10_mem ;
	reg 		        		   en_w_result10_mem ;
	reg 		        		   en_r_result10_mem ;
	reg 	   [16-1:0]	           addr_w_result10_mem;
	reg 	   [16-1:0]	           addr_r_result10_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result10_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result10_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result10_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result10_mem(.clk(clk),
              .reset(reset),
              .we(we_result10_mem),
              .en_w(en_w_result10_mem),
              .en_r(en_r_result10_mem),
              .addr_w(addr_w_result10_mem),
              .addr_r(addr_r_result10_mem),
              .di(inp_result10_mem),
              .dout(outp_result10_mem),
              .dat_read(dat_read_result10_mem)
    );
      
    reg 		        		   we_result11_mem ;
	reg 		        		   en_w_result11_mem ;
	reg 		        		   en_r_result11_mem ;
	reg 	   [16-1:0]	           addr_w_result11_mem;
	reg 	   [16-1:0]	           addr_r_result11_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result11_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result11_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result11_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result11_mem(.clk(clk),
              .reset(reset),
              .we(we_result11_mem),
              .en_w(en_w_result11_mem),
              .en_r(en_r_result11_mem),
              .addr_w(addr_w_result11_mem),
              .addr_r(addr_r_result11_mem),
              .di(inp_result11_mem),
              .dout(outp_result11_mem),
              .dat_read(dat_read_result11_mem)
    );
      
    reg 		        		   we_result12_mem ;
	reg 		        		   en_w_result12_mem ;
	reg 		        		   en_r_result12_mem ;
	reg 	   [16-1:0]	           addr_w_result12_mem;
	reg 	   [16-1:0]	           addr_r_result12_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result12_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result12_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result12_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result12_mem(.clk(clk),
              .reset(reset),
              .we(we_result12_mem),
              .en_w(en_w_result12_mem),
              .en_r(en_r_result12_mem),
              .addr_w(addr_w_result12_mem),
              .addr_r(addr_r_result12_mem),
              .di(inp_result12_mem),
              .dout(outp_result12_mem),
              .dat_read(dat_read_result12_mem)
    );
      
    reg 		        		   we_result13_mem ;
	reg 		        		   en_w_result13_mem ;
	reg 		        		   en_r_result13_mem ;
	reg 	   [16-1:0]	           addr_w_result13_mem;
	reg 	   [16-1:0]	           addr_r_result13_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result13_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result13_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result13_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result13_mem(.clk(clk),
              .reset(reset),
              .we(we_result13_mem),
              .en_w(en_w_result13_mem),
              .en_r(en_r_result13_mem),
              .addr_w(addr_w_result13_mem),
              .addr_r(addr_r_result13_mem),
              .di(inp_result13_mem),
              .dout(outp_result13_mem),
              .dat_read(dat_read_result13_mem)
    );
      
    reg 		        		   we_result14_mem ;
	reg 		        		   en_w_result14_mem ;
	reg 		        		   en_r_result14_mem ;
	reg 	   [16-1:0]	           addr_w_result14_mem;
	reg 	   [16-1:0]	           addr_r_result14_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result14_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result14_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result14_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result14_mem(.clk(clk),
              .reset(reset),
              .we(we_result14_mem),
              .en_w(en_w_result14_mem),
              .en_r(en_r_result14_mem),
              .addr_w(addr_w_result14_mem),
              .addr_r(addr_r_result14_mem),
              .di(inp_result14_mem),
              .dout(outp_result14_mem),
              .dat_read(dat_read_result14_mem)
    );
      
    reg 		        		   we_result15_mem ;
	reg 		        		   en_w_result15_mem ;
	reg 		        		   en_r_result15_mem ;
	reg 	   [16-1:0]	           addr_w_result15_mem;
	reg 	   [16-1:0]	           addr_r_result15_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result15_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result15_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result15_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result15_mem(.clk(clk),
              .reset(reset),
              .we(we_result15_mem),
              .en_w(en_w_result15_mem),
              .en_r(en_r_result15_mem),
              .addr_w(addr_w_result15_mem),
              .addr_r(addr_r_result15_mem),
              .di(inp_result15_mem),
              .dout(outp_result15_mem),
              .dat_read(dat_read_result15_mem)
    );
      
    reg 		        		   we_result16_mem ;
	reg 		        		   en_w_result16_mem ;
	reg 		        		   en_r_result16_mem ;
	reg 	   [16-1:0]	           addr_w_result16_mem;
	reg 	   [16-1:0]	           addr_r_result16_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result16_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result16_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result16_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result16_mem(.clk(clk),
              .reset(reset),
              .we(we_result16_mem),
              .en_w(en_w_result16_mem),
              .en_r(en_r_result16_mem),
              .addr_w(addr_w_result16_mem),
              .addr_r(addr_r_result16_mem),
              .di(inp_result16_mem),
              .dout(outp_result16_mem),
              .dat_read(dat_read_result16_mem)
    );
      
    reg 		        		   we_result17_mem ;
	reg 		        		   en_w_result17_mem ;
	reg 		        		   en_r_result17_mem ;
	reg 	   [16-1:0]	           addr_w_result17_mem;
	reg 	   [16-1:0]	           addr_r_result17_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result17_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result17_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result17_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result17_mem(.clk(clk),
              .reset(reset),
              .we(we_result17_mem),
              .en_w(en_w_result17_mem),
              .en_r(en_r_result17_mem),
              .addr_w(addr_w_result17_mem),
              .addr_r(addr_r_result17_mem),
              .di(inp_result17_mem),
              .dout(outp_result17_mem),
              .dat_read(dat_read_result17_mem)
    );
      
    reg 		        		   we_result18_mem ;
	reg 		        		   en_w_result18_mem ;
	reg 		        		   en_r_result18_mem ;
	reg 	   [16-1:0]	           addr_w_result18_mem;
	reg 	   [16-1:0]	           addr_r_result18_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result18_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result18_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result18_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result18_mem(.clk(clk),
              .reset(reset),
              .we(we_result18_mem),
              .en_w(en_w_result18_mem),
              .en_r(en_r_result18_mem),
              .addr_w(addr_w_result18_mem),
              .addr_r(addr_r_result18_mem),
              .di(inp_result18_mem),
              .dout(outp_result18_mem),
              .dat_read(dat_read_result18_mem)
    );
      
    reg 		        		   we_result19_mem ;
	reg 		        		   en_w_result19_mem ;
	reg 		        		   en_r_result19_mem ;
	reg 	   [16-1:0]	           addr_w_result19_mem;
	reg 	   [16-1:0]	           addr_r_result19_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result19_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result19_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result19_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result19_mem(.clk(clk),
              .reset(reset),
              .we(we_result19_mem),
              .en_w(en_w_result19_mem),
              .en_r(en_r_result19_mem),
              .addr_w(addr_w_result19_mem),
              .addr_r(addr_r_result19_mem),
              .di(inp_result19_mem),
              .dout(outp_result19_mem),
              .dat_read(dat_read_result19_mem)
    );
      
    reg 		        		   we_result20_mem ;
	reg 		        		   en_w_result20_mem ;
	reg 		        		   en_r_result20_mem ;
	reg 	   [16-1:0]	           addr_w_result20_mem;
	reg 	   [16-1:0]	           addr_r_result20_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result20_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result20_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result20_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result20_mem(.clk(clk),
              .reset(reset),
              .we(we_result20_mem),
              .en_w(en_w_result20_mem),
              .en_r(en_r_result20_mem),
              .addr_w(addr_w_result20_mem),
              .addr_r(addr_r_result20_mem),
              .di(inp_result20_mem),
              .dout(outp_result20_mem),
              .dat_read(dat_read_result20_mem)
    );
      
    reg 		        		   we_result21_mem ;
	reg 		        		   en_w_result21_mem ;
	reg 		        		   en_r_result21_mem ;
	reg 	   [16-1:0]	           addr_w_result21_mem;
	reg 	   [16-1:0]	           addr_r_result21_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result21_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result21_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result21_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result21_mem(.clk(clk),
              .reset(reset),
              .we(we_result21_mem),
              .en_w(en_w_result21_mem),
              .en_r(en_r_result21_mem),
              .addr_w(addr_w_result21_mem),
              .addr_r(addr_r_result21_mem),
              .di(inp_result21_mem),
              .dout(outp_result21_mem),
              .dat_read(dat_read_result21_mem)
    );
      
    reg 		        		   we_result22_mem ;
	reg 		        		   en_w_result22_mem ;
	reg 		        		   en_r_result22_mem ;
	reg 	   [16-1:0]	           addr_w_result22_mem;
	reg 	   [16-1:0]	           addr_r_result22_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result22_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result22_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result22_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result22_mem(.clk(clk),
              .reset(reset),
              .we(we_result22_mem),
              .en_w(en_w_result22_mem),
              .en_r(en_r_result22_mem),
              .addr_w(addr_w_result22_mem),
              .addr_r(addr_r_result22_mem),
              .di(inp_result22_mem),
              .dout(outp_result22_mem),
              .dat_read(dat_read_result22_mem)
    );
      
    reg 		        		   we_result23_mem ;
	reg 		        		   en_w_result23_mem ;
	reg 		        		   en_r_result23_mem ;
	reg 	   [16-1:0]	           addr_w_result23_mem;
	reg 	   [16-1:0]	           addr_r_result23_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result23_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result23_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result23_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result23_mem(.clk(clk),
              .reset(reset),
              .we(we_result23_mem),
              .en_w(en_w_result23_mem),
              .en_r(en_r_result23_mem),
              .addr_w(addr_w_result23_mem),
              .addr_r(addr_r_result23_mem),
              .di(inp_result23_mem),
              .dout(outp_result23_mem),
              .dat_read(dat_read_result23_mem)
    );
      
    reg 		        		   we_result24_mem ;
	reg 		        		   en_w_result24_mem ;
	reg 		        		   en_r_result24_mem ;
	reg 	   [16-1:0]	           addr_w_result24_mem;
	reg 	   [16-1:0]	           addr_r_result24_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result24_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result24_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result24_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result24_mem(.clk(clk),
              .reset(reset),
              .we(we_result24_mem),
              .en_w(en_w_result24_mem),
              .en_r(en_r_result24_mem),
              .addr_w(addr_w_result24_mem),
              .addr_r(addr_r_result24_mem),
              .di(inp_result24_mem),
              .dout(outp_result24_mem),
              .dat_read(dat_read_result24_mem)
    );
      
    reg 		        		   we_result25_mem ;
	reg 		        		   en_w_result25_mem ;
	reg 		        		   en_r_result25_mem ;
	reg 	   [16-1:0]	           addr_w_result25_mem;
	reg 	   [16-1:0]	           addr_r_result25_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result25_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result25_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result25_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result25_mem(.clk(clk),
              .reset(reset),
              .we(we_result25_mem),
              .en_w(en_w_result25_mem),
              .en_r(en_r_result25_mem),
              .addr_w(addr_w_result25_mem),
              .addr_r(addr_r_result25_mem),
              .di(inp_result25_mem),
              .dout(outp_result25_mem),
              .dat_read(dat_read_result25_mem)
    );
      
    reg 		        		   we_result26_mem ;
	reg 		        		   en_w_result26_mem ;
	reg 		        		   en_r_result26_mem ;
	reg 	   [16-1:0]	           addr_w_result26_mem;
	reg 	   [16-1:0]	           addr_r_result26_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result26_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result26_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result26_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result26_mem(.clk(clk),
              .reset(reset),
              .we(we_result26_mem),
              .en_w(en_w_result26_mem),
              .en_r(en_r_result26_mem),
              .addr_w(addr_w_result26_mem),
              .addr_r(addr_r_result26_mem),
              .di(inp_result26_mem),
              .dout(outp_result26_mem),
              .dat_read(dat_read_result26_mem)
    );
      
    reg 		        		   we_result27_mem ;
	reg 		        		   en_w_result27_mem ;
	reg 		        		   en_r_result27_mem ;
	reg 	   [16-1:0]	           addr_w_result27_mem;
	reg 	   [16-1:0]	           addr_r_result27_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result27_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result27_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result27_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result27_mem(.clk(clk),
              .reset(reset),
              .we(we_result27_mem),
              .en_w(en_w_result27_mem),
              .en_r(en_r_result27_mem),
              .addr_w(addr_w_result27_mem),
              .addr_r(addr_r_result27_mem),
              .di(inp_result27_mem),
              .dout(outp_result27_mem),
              .dat_read(dat_read_result27_mem)
    );
      
    reg 		        		   we_result28_mem ;
	reg 		        		   en_w_result28_mem ;
	reg 		        		   en_r_result28_mem ;
	reg 	   [16-1:0]	           addr_w_result28_mem;
	reg 	   [16-1:0]	           addr_r_result28_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result28_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result28_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result28_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result28_mem(.clk(clk),
              .reset(reset),
              .we(we_result28_mem),
              .en_w(en_w_result28_mem),
              .en_r(en_r_result28_mem),
              .addr_w(addr_w_result28_mem),
              .addr_r(addr_r_result28_mem),
              .di(inp_result28_mem),
              .dout(outp_result28_mem),
              .dat_read(dat_read_result28_mem)
    );
      
    reg 		        		   we_result29_mem ;
	reg 		        		   en_w_result29_mem ;
	reg 		        		   en_r_result29_mem ;
	reg 	   [16-1:0]	           addr_w_result29_mem;
	reg 	   [16-1:0]	           addr_r_result29_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result29_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result29_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result29_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result29_mem(.clk(clk),
              .reset(reset),
              .we(we_result29_mem),
              .en_w(en_w_result29_mem),
              .en_r(en_r_result29_mem),
              .addr_w(addr_w_result29_mem),
              .addr_r(addr_r_result29_mem),
              .di(inp_result29_mem),
              .dout(outp_result29_mem),
              .dat_read(dat_read_result29_mem)
    );
      
    reg 		        		   we_result30_mem ;
	reg 		        		   en_w_result30_mem ;
	reg 		        		   en_r_result30_mem ;
	reg 	   [16-1:0]	           addr_w_result30_mem;
	reg 	   [16-1:0]	           addr_r_result30_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result30_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result30_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result30_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result30_mem(.clk(clk),
              .reset(reset),
              .we(we_result30_mem),
              .en_w(en_w_result30_mem),
              .en_r(en_r_result30_mem),
              .addr_w(addr_w_result30_mem),
              .addr_r(addr_r_result30_mem),
              .di(inp_result30_mem),
              .dout(outp_result30_mem),
              .dat_read(dat_read_result30_mem)
    );
      
    reg 		        		   we_result31_mem ;
	reg 		        		   en_w_result31_mem ;
	reg 		        		   en_r_result31_mem ;
	reg 	   [16-1:0]	           addr_w_result31_mem;
	reg 	   [16-1:0]	           addr_r_result31_mem;
	reg signed [RAM_WIDTH_IMG-1:0] dat_read_result31_mem;   
	reg signed [RAM_WIDTH_IMG-1:0] inp_result31_mem ;
	reg signed [RAM_WIDTH_IMG-1:0] outp_result31_mem;
	
	oneDRAM #(.A_WIDTH(12),
		      .ADDR_WIDTH(16), 
		      .D_WIDTH(RAM_WIDTH_IMG)
    )result31_mem(.clk(clk),
              .reset(reset),
              .we(we_result31_mem),
              .en_w(en_w_result31_mem),
              .en_r(en_r_result31_mem),
              .addr_w(addr_w_result31_mem),
              .addr_r(addr_r_result31_mem),
              .di(inp_result31_mem),
              .dout(outp_result31_mem),
              .dat_read(dat_read_result31_mem)
    );
    
//---------------------------------------------------------
    reg								image_recieved[31:0];
    reg 		[16:0]				image_vals_cnt[31:0];
    reg								result_mem_reset[31:0];
    
    reg         [9:0]              F_M1_var[31:0];
    reg         [9:0]              F_M2_var[31:0];
    reg                            image_deflattened[31:0];

    reg         [2:0]               P1_var[31:0];
    reg         [2:0]               P2_var[31:0];
    reg         [7:0]               POOLOUT1_var[31:0];
    reg         [7:0]               POOLOUT2_var[31:0];
    reg                            	max_pooled[31:0];
    reg signed  [RAM_WIDTH_IMG-1:0] value[31:0];
    
    reg 		[12:0]				POOL_ED_var[31:0];
    reg			[31:0]			    result_sent;
    
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    ////////////////////////
	// recieving image[0]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy0 <= 0;
        addr_w_img0_mem <= 15'd0;
        image_recieved[0] <= 0;
        we_img0_mem <= 0;
        en_w_img0_mem <= 0;
        inp_img0_mem <=19'd0 ;
    end
    else 
    begin
    	we_img0_mem <= 1;
        en_w_img0_mem <= 1;
        if (image_recieved[0] == 0)		 
            image_rdy0 <= 1; 
            if((image_vld0 == 1) 
                || (addr_w_img0_mem == POOL_IN ) ) 
            begin
            
            //counter clicks if new value came to kernel data port or 
            //it's the last value  
                addr_w_img0_mem <= addr_w_img0_mem + 1;
                inp_img0_mem  <= image0;
            end	
            if (addr_w_img0_mem >= POOL_IN) 
			begin
				image_recieved[0] <= 1'b1;
				we_img0_mem <= 0;
				en_w_img0_mem <= 0;
				image_rdy0 <= 0; 
			end
        
    end
    

    ////////////////////////
	// recieving image[1]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy1 <= 0;
        addr_w_img1_mem <= 15'd0;
        image_recieved[1] <= 0;
        we_img1_mem <= 0;
        en_w_img1_mem <= 0;
        inp_img1_mem <=19'd0 ;
    end
    else 
    begin
    	we_img1_mem <= 1;
        en_w_img1_mem <= 1;
        if (image_recieved[1] == 0)		 
            image_rdy1 <= 1; 
            if((image_vld1 == 1) 
                || (addr_w_img1_mem == POOL_IN ) ) 
            begin  
                addr_w_img1_mem <= addr_w_img1_mem + 1;
                inp_img1_mem  <= image1;
            end	
            if (addr_w_img1_mem >= POOL_IN) 
			begin
				image_recieved[1] <= 1'b1;
				we_img1_mem <= 0;
				en_w_img1_mem <= 0;
				image_rdy1 <= 0; 
			end
        
    end
   

    ////////////////////////
	// recieving image[2]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy2 <= 1'd0;
        addr_w_img2_mem <= 15'd0;
        image_recieved[2] <= 1'd0;
        we_img2_mem <= 1'd0;
        en_w_img2_mem <= 1'd0;
        inp_img2_mem <=19'd0 ;
    end
    else 
    begin
    	we_img2_mem <= 1'd1;
        en_w_img2_mem <= 1'd1;
        if (image_recieved[2] == 0)		 
            image_rdy2 <= 1'd1; 
            if((image_vld2 == 1) 
                || (addr_w_img2_mem == POOL_IN ) ) 
            begin  
                addr_w_img2_mem <= addr_w_img2_mem + 1;
                inp_img2_mem  <= image2;
            end	
            if (addr_w_img2_mem >= POOL_IN) 
			begin
				image_recieved[2] <= 1'b1;
				we_img2_mem <= 1'd0;
				en_w_img2_mem <= 1'd0;
				image_rdy2 <= 1'd0; 
			end
        
    end
   

    ////////////////////////
	// recieving image[3]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy3 <= 1'd0;
        addr_w_img3_mem <= 15'd0;
        image_recieved[3] <= 1'd0;
        we_img3_mem <= 1'd0;
        en_w_img3_mem <= 1'd0;
        inp_img3_mem <=19'd0 ;
    end
    else 
    begin
    	we_img3_mem <= 1'd1;
        en_w_img3_mem <= 1'd1;
        if (image_recieved[3] == 0)		 
            image_rdy3 <= 1'd1; 
            if((image_vld3 == 1) 
                || (addr_w_img3_mem == POOL_IN ) ) 
            begin  
                addr_w_img3_mem <= addr_w_img3_mem + 1;
                inp_img3_mem  <= image3;
            end	
            if (addr_w_img3_mem >= POOL_IN) 
			begin
				image_recieved[3] <= 1'b1;
				we_img3_mem <= 1'd0;
				en_w_img3_mem <= 1'd0;
				image_rdy3 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[4]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy4 <= 1'd0;
        addr_w_img4_mem <= 15'd0;
        image_recieved[4] <= 1'd0;
        we_img4_mem <= 1'd0;
        en_w_img4_mem <= 1'd0;
        inp_img4_mem <=19'd0 ;
    end
    else 
    begin
    	we_img4_mem <= 1'd1;
        en_w_img4_mem <= 1'd1;
        if (image_recieved[4] == 0)		 
            image_rdy4 <= 1'd1; 
            if((image_vld4 == 1) 
                || (addr_w_img4_mem == POOL_IN ) ) 
            begin  
                addr_w_img4_mem <= addr_w_img4_mem + 1;
                inp_img4_mem  <= image4;
            end	
            if (addr_w_img4_mem >= POOL_IN) 
			begin
				image_recieved[4] <= 1'b1;
				we_img4_mem <= 1'd0;
				en_w_img4_mem <= 1'd0;
				image_rdy4 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[5]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy5 <= 1'd0;
        addr_w_img5_mem <= 15'd0;
        image_recieved[5] <= 1'd0;
        we_img5_mem <= 1'd0;
        en_w_img5_mem <= 1'd0;
        inp_img5_mem <=19'd0 ;
    end
    else 
    begin
    	we_img5_mem <= 1'd1;
        en_w_img5_mem <= 1'd1;
        if (image_recieved[5] == 0)		 
            image_rdy5 <= 1'd1; 
            if((image_vld5 == 1) 
                || (addr_w_img5_mem == POOL_IN ) ) 
            begin  
                addr_w_img5_mem <= addr_w_img5_mem + 1;
                inp_img5_mem  <= image5;
            end	
            if (addr_w_img5_mem >= POOL_IN) 
			begin
				image_recieved[5] <= 1'b1;
				we_img5_mem <= 1'd0;
				en_w_img5_mem <= 1'd0;
				image_rdy5 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[6]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy6 <= 1'd0;
        addr_w_img6_mem <= 15'd0;
        image_recieved[6] <= 1'd0;
        we_img6_mem <= 1'd0;
        en_w_img6_mem <= 1'd0;
        inp_img6_mem <=19'd0 ;
    end
    else 
    begin
    	we_img6_mem <= 1'd1;
        en_w_img6_mem <= 1'd1;
        if (image_recieved[6] == 0)		 
            image_rdy6 <= 1'd1; 
            if((image_vld6 == 1) 
                || (addr_w_img6_mem == POOL_IN ) ) 
            begin  
                addr_w_img6_mem <= addr_w_img6_mem + 1;
                inp_img6_mem  <= image6;
            end	
            if (addr_w_img6_mem >= POOL_IN) 
			begin
				image_recieved[6] <= 1'b1;
				we_img6_mem <= 1'd0;
				en_w_img6_mem <= 1'd0;
				image_rdy6 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[7]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy7 <= 1'd0;
        addr_w_img7_mem <= 15'd0;
        image_recieved[7] <= 1'd0;
        we_img7_mem <= 1'd0;
        en_w_img7_mem <= 1'd0;
        inp_img7_mem <=19'd0 ;
    end
    else 
    begin
    	we_img7_mem <= 1'd1;
        en_w_img7_mem <= 1'd1;
        if (image_recieved[7] == 0)		 
            image_rdy7 <= 1'd1; 
            if((image_vld7 == 1) 
                || (addr_w_img7_mem == POOL_IN ) ) 
            begin  
                addr_w_img7_mem <= addr_w_img7_mem + 1;
                inp_img7_mem  <= image7;
            end	
            if (addr_w_img7_mem >= POOL_IN) 
			begin
				image_recieved[7] <= 1'b1;
				we_img7_mem <= 1'd0;
				en_w_img7_mem <= 1'd0;
				image_rdy7 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[8]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy8 <= 1'd0;
        addr_w_img8_mem <= 15'd0;
        image_recieved[8] <= 1'd0;
        we_img8_mem <= 1'd0;
        en_w_img8_mem <= 1'd0;
        inp_img8_mem <=19'd0 ;
    end
    else 
    begin
    	we_img8_mem <= 1'd1;
        en_w_img8_mem <= 1'd1;
        if (image_recieved[8] == 0)		 
            image_rdy8 <= 1'd1; 
            if((image_vld8 == 1) 
                || (addr_w_img8_mem == POOL_IN ) ) 
            begin  
                addr_w_img8_mem <= addr_w_img8_mem + 1;
                inp_img8_mem  <= image8;
            end	
            if (addr_w_img8_mem >= POOL_IN) 
			begin
				image_recieved[8] <= 1'b1;
				we_img8_mem <= 1'd0;
				en_w_img8_mem <= 1'd0;
				image_rdy8 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[9]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy9 <= 1'd0;
        addr_w_img9_mem <= 15'd0;
        image_recieved[9] <= 1'd0;
        we_img9_mem <= 1'd0;
        en_w_img9_mem <= 1'd0;
        inp_img9_mem <=19'd0 ;
    end
    else 
    begin
    	we_img9_mem <= 1'd1;
        en_w_img9_mem <= 1'd1;
        if (image_recieved[9] == 0)		 
            image_rdy9 <= 1'd1; 
            if((image_vld9 == 1) 
                || (addr_w_img9_mem == POOL_IN ) ) 
            begin  
                addr_w_img9_mem <= addr_w_img9_mem + 1;
                inp_img9_mem  <= image9;
            end	
            if (addr_w_img9_mem >= POOL_IN) 
			begin
				image_recieved[9] <= 1'b1;
				we_img9_mem <= 1'd0;
				en_w_img9_mem <= 1'd0;
				image_rdy9 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[10]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy10 <= 1'd0;
        addr_w_img10_mem <= 15'd0;
        image_recieved[10] <= 1'd0;
        we_img10_mem <= 1'd0;
        en_w_img10_mem <= 1'd0;
        inp_img10_mem <=19'd0 ;
    end
    else 
    begin
    	we_img10_mem <= 1'd1;
        en_w_img10_mem <= 1'd1;
        if (image_recieved[10] == 0)		 
            image_rdy10 <= 1'd1; 
            if((image_vld10 == 1) 
                || (addr_w_img10_mem == POOL_IN ) ) 
            begin  
                addr_w_img10_mem <= addr_w_img10_mem + 1;
                inp_img10_mem  <= image10;
            end	
            if (addr_w_img10_mem >= POOL_IN) 
			begin
				image_recieved[10] <= 1'b1;
				we_img10_mem <= 1'd0;
				en_w_img10_mem <= 1'd0;
				image_rdy10 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[11]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy11 <= 1'd0;
        addr_w_img11_mem <= 15'd0;
        image_recieved[11] <= 1'd0;
        we_img11_mem <= 1'd0;
        en_w_img11_mem <= 1'd0;
        inp_img11_mem <=19'd0 ;
    end
    else 
    begin
    	we_img11_mem <= 1'd1;
        en_w_img11_mem <= 1'd1;
        if (image_recieved[11] == 0)		 
            image_rdy11 <= 1'd1; 
            if((image_vld11 == 1) 
                || (addr_w_img11_mem == POOL_IN ) ) 
            begin  
                addr_w_img11_mem <= addr_w_img11_mem + 1;
                inp_img11_mem  <= image11;
            end	
            if (addr_w_img11_mem >= POOL_IN) 
			begin
				image_recieved[11] <= 1'b1;
				we_img11_mem <= 1'd0;
				en_w_img11_mem <= 1'd0;
				image_rdy11 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[12]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy12 <= 1'd0;
        addr_w_img12_mem <= 15'd0;
        image_recieved[12] <= 1'd0;
        we_img12_mem <= 1'd0;
        en_w_img12_mem <= 1'd0;
        inp_img12_mem <=19'd0 ;
    end
    else 
    begin
    	we_img12_mem <= 1'd1;
        en_w_img12_mem <= 1'd1;
        if (image_recieved[12] == 0)		 
            image_rdy12 <= 1'd1; 
            if((image_vld12 == 1) 
                || (addr_w_img12_mem == POOL_IN ) ) 
            begin  
                addr_w_img12_mem <= addr_w_img12_mem + 1;
                inp_img12_mem  <= image12;
            end	
            if (addr_w_img12_mem >= POOL_IN) 
			begin
				image_recieved[12] <= 1'b1;
				we_img12_mem <= 1'd0;
				en_w_img12_mem <= 1'd0;
				image_rdy12 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[13]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy13 <= 1'd0;
        addr_w_img13_mem <= 15'd0;
        image_recieved[13] <= 1'd0;
        we_img13_mem <= 1'd0;
        en_w_img13_mem <= 1'd0;
        inp_img13_mem <=19'd0 ;
    end
    else 
    begin
    	we_img13_mem <= 1'd1;
        en_w_img13_mem <= 1'd1;
        if (image_recieved[13] == 0)		 
            image_rdy13 <= 1'd1; 
            if((image_vld13 == 1) 
                || (addr_w_img13_mem == POOL_IN ) ) 
            begin  
                addr_w_img13_mem <= addr_w_img13_mem + 1;
                inp_img13_mem  <= image13;
            end	
            if (addr_w_img13_mem >= POOL_IN) 
			begin
				image_recieved[13] <= 1'b1;
				we_img13_mem <= 1'd0;
				en_w_img13_mem <= 1'd0;
				image_rdy13 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[14]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy14 <= 1'd0;
        addr_w_img14_mem <= 15'd0;
        image_recieved[14] <= 1'd0;
        we_img14_mem <= 1'd0;
        en_w_img14_mem <= 1'd0;
        inp_img14_mem <=19'd0 ;
    end
    else 
    begin
    	we_img14_mem <= 1'd1;
        en_w_img14_mem <= 1'd1;
        if (image_recieved[14] == 0)		 
            image_rdy14 <= 1'd1; 
            if((image_vld14 == 1) 
                || (addr_w_img14_mem == POOL_IN ) ) 
            begin  
                addr_w_img14_mem <= addr_w_img14_mem + 1;
                inp_img14_mem  <= image14;
            end	
            if (addr_w_img14_mem >= POOL_IN) 
			begin
				image_recieved[14] <= 1'b1;
				we_img14_mem <= 1'd0;
				en_w_img14_mem <= 1'd0;
				image_rdy14 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[15]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy15 <= 1'd0;
        addr_w_img15_mem <= 15'd0;
        image_recieved[15] <= 1'd0;
        we_img15_mem <= 1'd0;
        en_w_img15_mem <= 1'd0;
        inp_img15_mem <=19'd0 ;
    end
    else 
    begin
    	we_img15_mem <= 1'd1;
        en_w_img15_mem <= 1'd1;
        if (image_recieved[15] == 0)		 
            image_rdy15 <= 1'd1; 
            if((image_vld15 == 1) 
                || (addr_w_img15_mem == POOL_IN ) ) 
            begin  
                addr_w_img15_mem <= addr_w_img15_mem + 1;
                inp_img15_mem  <= image15;
            end	
            if (addr_w_img15_mem >= POOL_IN) 
			begin
				image_recieved[15] <= 1'b1;
				we_img15_mem <= 1'd0;
				en_w_img15_mem <= 1'd0;
				image_rdy15 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[16]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy16 <= 1'd0;
        addr_w_img16_mem <= 15'd0;
        image_recieved[16] <= 1'd0;
        we_img16_mem <= 1'd0;
        en_w_img16_mem <= 1'd0;
        inp_img16_mem <=19'd0 ;
    end
    else 
    begin
    	we_img16_mem <= 1'd1;
        en_w_img16_mem <= 1'd1;
        if (image_recieved[16] == 0)		 
            image_rdy16 <= 1'd1; 
            if((image_vld16 == 1) 
                || (addr_w_img16_mem == POOL_IN ) ) 
            begin  
                addr_w_img16_mem <= addr_w_img16_mem + 1;
                inp_img16_mem  <= image16;
            end	
            if (addr_w_img16_mem >= POOL_IN) 
			begin
				image_recieved[16] <= 1'b1;
				we_img16_mem <= 1'd0;
				en_w_img16_mem <= 1'd0;
				image_rdy16 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[17]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy17 <= 1'd0;
        addr_w_img17_mem <= 15'd0;
        image_recieved[17] <= 1'd0;
        we_img17_mem <= 1'd0;
        en_w_img17_mem <= 1'd0;
        inp_img17_mem <=19'd0 ;
    end
    else 
    begin
    	we_img17_mem <= 1'd1;
        en_w_img17_mem <= 1'd1;
        if (image_recieved[17] == 0)		 
            image_rdy17 <= 1'd1; 
            if((image_vld17 == 1) 
                || (addr_w_img17_mem == POOL_IN ) ) 
            begin  
                addr_w_img17_mem <= addr_w_img17_mem + 1;
                inp_img17_mem  <= image17;
            end	
            if (addr_w_img17_mem >= POOL_IN) 
			begin
				image_recieved[17] <= 1'b1;
				we_img17_mem <= 1'd0;
				en_w_img17_mem <= 1'd0;
				image_rdy17 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[18]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy18 <= 1'd0;
        addr_w_img18_mem <= 15'd0;
        image_recieved[18] <= 1'd0;
        we_img18_mem <= 1'd0;
        en_w_img18_mem <= 1'd0;
        inp_img18_mem <=19'd0 ;
    end
    else 
    begin
    	we_img18_mem <= 1'd1;
        en_w_img18_mem <= 1'd1;
        if (image_recieved[18] == 0)		 
            image_rdy18 <= 1'd1; 
            if((image_vld18 == 1) 
                || (addr_w_img18_mem == POOL_IN ) ) 
            begin  
                addr_w_img18_mem <= addr_w_img18_mem + 1;
                inp_img18_mem  <= image18;
            end	
            if (addr_w_img18_mem >= POOL_IN) 
			begin
				image_recieved[18] <= 1'b1;
				we_img18_mem <= 1'd0;
				en_w_img18_mem <= 1'd0;
				image_rdy18 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[19]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy19 <= 1'd0;
        addr_w_img19_mem <= 15'd0;
        image_recieved[19] <= 1'd0;
        we_img19_mem <= 1'd0;
        en_w_img19_mem <= 1'd0;
        inp_img19_mem <=19'd0 ;
    end
    else 
    begin
    	we_img19_mem <= 1'd1;
        en_w_img19_mem <= 1'd1;
        if (image_recieved[19] == 0)		 
            image_rdy19 <= 1'd1; 
            if((image_vld19 == 1) 
                || (addr_w_img19_mem == POOL_IN ) ) 
            begin  
                addr_w_img19_mem <= addr_w_img19_mem + 1;
                inp_img19_mem  <= image2;
            end	
            if (addr_w_img19_mem >= POOL_IN) 
			begin
				image_recieved[19] <= 1'b1;
				we_img19_mem <= 1'd0;
				en_w_img19_mem <= 1'd0;
				image_rdy19 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[2]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy20 <= 1'd0;
        addr_w_img20_mem <= 15'd0;
        image_recieved[20] <= 1'd0;
        we_img20_mem <= 1'd0;
        en_w_img20_mem <= 1'd0;
        inp_img20_mem <=19'd0 ;
    end
    else 
    begin
    	we_img20_mem <= 1'd1;
        en_w_img20_mem <= 1'd1;
        if (image_recieved[20] == 0)		 
            image_rdy20 <= 1'd1; 
            if((image_vld20 == 1) 
                || (addr_w_img20_mem == POOL_IN ) ) 
            begin  
                addr_w_img20_mem <= addr_w_img20_mem + 1;
                inp_img20_mem  <= image20;
            end	
            if (addr_w_img20_mem >= POOL_IN) 
			begin
				image_recieved[20] <= 1'b1;
				we_img20_mem <= 1'd0;
				en_w_img20_mem <= 1'd0;
				image_rdy20 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[21]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy21 <= 1'd0;
        addr_w_img21_mem <= 15'd0;
        image_recieved[21] <= 1'd0;
        we_img21_mem <= 1'd0;
        en_w_img21_mem <= 1'd0;
        inp_img21_mem <=19'd0 ;
    end
    else 
    begin
    	we_img21_mem <= 1'd1;
        en_w_img21_mem <= 1'd1;
        if (image_recieved[21] == 0)		 
            image_rdy21 <= 1'd1; 
            if((image_vld21 == 1) 
                || (addr_w_img21_mem == POOL_IN ) ) 
            begin  
                addr_w_img21_mem <= addr_w_img21_mem + 1;
                inp_img21_mem  <= image21;
            end	
            if (addr_w_img21_mem >= POOL_IN) 
			begin
				image_recieved[21] <= 1'b1;
				we_img21_mem <= 1'd0;
				en_w_img21_mem <= 1'd0;
				image_rdy21 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[5]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy22 <= 1'd0;
        addr_w_img22_mem <= 15'd0;
        image_recieved[22] <= 1'd0;
        we_img22_mem <= 1'd0;
        en_w_img22_mem <= 1'd0;
        inp_img22_mem <=19'd0 ;
    end
    else 
    begin
    	we_img22_mem <= 1'd1;
        en_w_img22_mem <= 1'd1;
        if (image_recieved[22] == 0)		 
            image_rdy22 <= 1'd1; 
            if((image_vld22 == 1) 
                || (addr_w_img22_mem == POOL_IN ) ) 
            begin  
                addr_w_img22_mem <= addr_w_img22_mem + 1;
                inp_img22_mem  <= image22;
            end	
            if (addr_w_img22_mem >= POOL_IN) 
			begin
				image_recieved[22] <= 1'b1;
				we_img22_mem <= 1'd0;
				en_w_img22_mem <= 1'd0;
				image_rdy22 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[5]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy23 <= 1'd0;
        addr_w_img23_mem <= 15'd0;
        image_recieved[23] <= 1'd0;
        we_img23_mem <= 1'd0;
        en_w_img23_mem <= 1'd0;
        inp_img23_mem <=19'd0 ;
    end
    else 
    begin
    	we_img23_mem <= 1'd1;
        en_w_img23_mem <= 1'd1;
        if (image_recieved[23] == 0)		 
            image_rdy23 <= 1'd1; 
            if((image_vld23 == 1) 
                || (addr_w_img23_mem == POOL_IN ) ) 
            begin  
                addr_w_img23_mem <= addr_w_img23_mem + 1;
                inp_img23_mem  <= image23;
            end	
            if (addr_w_img23_mem >= POOL_IN) 
			begin
				image_recieved[23] <= 1'b1;
				we_img23_mem <= 1'd0;
				en_w_img23_mem <= 1'd0;
				image_rdy23 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[5]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy24 <= 1'd0;
        addr_w_img24_mem <= 15'd0;
        image_recieved[24] <= 1'd0;
        we_img24_mem <= 1'd0;
        en_w_img24_mem <= 1'd0;
        inp_img24_mem <=19'd0 ;
    end
    else 
    begin
    	we_img24_mem <= 1'd1;
        en_w_img24_mem <= 1'd1;
        if (image_recieved[24] == 0)		 
            image_rdy24 <= 1'd1; 
            if((image_vld24 == 1) 
                || (addr_w_img24_mem == POOL_IN ) ) 
            begin  
                addr_w_img24_mem <= addr_w_img24_mem + 1;
                inp_img24_mem  <= image24;
            end	
            if (addr_w_img24_mem >= POOL_IN) 
			begin
				image_recieved[24] <= 1'b1;
				we_img24_mem <= 1'd0;
				en_w_img24_mem <= 1'd0;
				image_rdy24 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[5]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy25 <= 1'd0;
        addr_w_img25_mem <= 15'd0;
        image_recieved[25] <= 1'd0;
        we_img25_mem <= 1'd0;
        en_w_img25_mem <= 1'd0;
        inp_img25_mem <=19'd0 ;
    end
    else 
    begin
    	we_img25_mem <= 1'd1;
        en_w_img25_mem <= 1'd1;
        if (image_recieved[25] == 0)		 
            image_rdy25 <= 1'd1; 
            if((image_vld25 == 1) 
                || (addr_w_img25_mem == POOL_IN ) ) 
            begin  
                addr_w_img25_mem <= addr_w_img25_mem + 1;
                inp_img25_mem  <= image25;
            end	
            if (addr_w_img25_mem >= POOL_IN) 
			begin
				image_recieved[25] <= 1'b1;
				we_img25_mem <= 1'd0;
				en_w_img25_mem <= 1'd0;
				image_rdy25 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[5]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy26 <= 1'd0;
        addr_w_img26_mem <= 15'd0;
        image_recieved[26] <= 1'd0;
        we_img26_mem <= 1'd0;
        en_w_img26_mem <= 1'd0;
        inp_img26_mem <=19'd0 ;
    end
    else 
    begin
    	we_img26_mem <= 1'd1;
        en_w_img26_mem <= 1'd1;
        if (image_recieved[26] == 0)		 
            image_rdy26 <= 1'd1; 
            if((image_vld26 == 1) 
                || (addr_w_img26_mem == POOL_IN ) ) 
            begin  
                addr_w_img26_mem <= addr_w_img26_mem + 1;
                inp_img26_mem  <= image26;
            end	
            if (addr_w_img26_mem >= POOL_IN) 
			begin
				image_recieved[26] <= 1'b1;
				we_img26_mem <= 1'd0;
				en_w_img26_mem <= 1'd0;
				image_rdy26 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[5]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy27 <= 1'd0;
        addr_w_img27_mem <= 15'd0;
        image_recieved[27] <= 1'd0;
        we_img27_mem <= 1'd0;
        en_w_img27_mem <= 1'd0;
        inp_img27_mem <=19'd0 ;
    end
    else 
    begin
    	we_img27_mem <= 1'd1;
        en_w_img27_mem <= 1'd1;
        if (image_recieved[27] == 0)		 
            image_rdy27 <= 1'd1; 
            if((image_vld27 == 1) 
                || (addr_w_img27_mem == POOL_IN ) ) 
            begin  
                addr_w_img27_mem <= addr_w_img27_mem + 1;
                inp_img27_mem  <= image27;
            end	
            if (addr_w_img27_mem >= POOL_IN) 
			begin
				image_recieved[27] <= 1'b1;
				we_img27_mem <= 1'd0;
				en_w_img27_mem <= 1'd0;
				image_rdy27 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[5]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy28 <= 1'd0;
        addr_w_img28_mem <= 15'd0;
        image_recieved[28] <= 1'd0;
        we_img28_mem <= 1'd0;
        en_w_img28_mem <= 1'd0;
        inp_img28_mem <=19'd0 ;
    end
    else 
    begin
    	we_img28_mem <= 1'd1;
        en_w_img28_mem <= 1'd1;
        if (image_recieved[28] == 0)		 
            image_rdy28 <= 1'd1; 
            if((image_vld28 == 1) 
                || (addr_w_img28_mem == POOL_IN ) ) 
            begin  
                addr_w_img28_mem <= addr_w_img28_mem + 1;
                inp_img28_mem  <= image28;
            end	
            if (addr_w_img28_mem >= POOL_IN) 
			begin
				image_recieved[28] <= 1'b1;
				we_img28_mem <= 1'd0;
				en_w_img28_mem <= 1'd0;
				image_rdy28 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[5]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy29 <= 1'd0;
        addr_w_img29_mem <= 15'd0;
        image_recieved[29] <= 1'd0;
        we_img29_mem <= 1'd0;
        en_w_img29_mem <= 1'd0;
        inp_img29_mem <=19'd0 ;
    end
    else 
    begin
    	we_img29_mem <= 1'd1;
        en_w_img29_mem <= 1'd1;
        if (image_recieved[29] == 0)		 
            image_rdy29 <= 1'd1; 
            if((image_vld29 == 1) 
                || (addr_w_img29_mem == POOL_IN ) ) 
            begin  
                addr_w_img29_mem <= addr_w_img29_mem + 1;
                inp_img29_mem  <= image29;
            end	
            if (addr_w_img29_mem >= POOL_IN) 
			begin
				image_recieved[29] <= 1'b1;
				we_img29_mem <= 1'd0;
				en_w_img29_mem <= 1'd0;
				image_rdy29 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[5]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy30 <= 1'd0;
        addr_w_img30_mem <= 15'd0;
        image_recieved[30] <= 1'd0;
        we_img30_mem <= 1'd0;
        en_w_img30_mem <= 1'd0;
        inp_img30_mem <=19'd0 ;
    end
    else 
    begin
    	we_img30_mem <= 1'd1;
        en_w_img30_mem <= 1'd1;
        if (image_recieved[30] == 0)		 
            image_rdy30 <= 1'd1; 
            if((image_vld30 == 1) 
                || (addr_w_img30_mem == POOL_IN ) ) 
            begin  
                addr_w_img30_mem <= addr_w_img30_mem + 1;
                inp_img30_mem  <= image30;
            end	
            if (addr_w_img30_mem >= POOL_IN) 
			begin
				image_recieved[30] <= 1'b1;
				we_img30_mem <= 1'd0;
				en_w_img30_mem <= 1'd0;
				image_rdy30 <= 1'd0; 
			end
        
    end

    ////////////////////////
	// recieving image[31]
	always@(posedge clk)
    if (reset == 1) 
    begin
        image_rdy31 <= 1'd0;
        addr_w_img31_mem <= 15'd0;
        image_recieved[31] <= 1'd0;
        we_img31_mem <= 1'd0;
        en_w_img31_mem <= 1'd0;
        inp_img31_mem <=19'd0 ;
    end
    else 
    begin
    	we_img31_mem <= 1'd1;
        en_w_img31_mem <= 1'd1;
        if (image_recieved[31] == 0)		 
            image_rdy31 <= 1'd1; 
            if((image_vld31 == 1) 
                || (addr_w_img31_mem == POOL_IN ) ) 
            begin  
                addr_w_img31_mem <= addr_w_img31_mem + 1;
                inp_img31_mem  <= image31;
            end	
            if (addr_w_img31_mem >= POOL_IN) 
			begin
				image_recieved[31] <= 1'b1;
				we_img31_mem <= 1'd0;
				en_w_img31_mem <= 1'd0;
				image_rdy31 <= 1'd0; 
			end
        
    end
/**/
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/////////////////
// max_pooling [0] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[0] <= 8'd0;
			P2_var[0] <= 8'd0;
			POOLOUT1_var[0] <= 3'd0;
			POOLOUT2_var[0] <= 3'd0;
			max_pooled[0] <= 1'd0;
			en_r_img0_mem <= 1'd0;
			addr_r_img0_mem <= 15'd0;
			en_w_result0_mem <= 1'd0;
			we_result0_mem <= 1'd0;
			addr_w_result0_mem <= 15'd0;
			inp_result0_mem <= 19'd0;
			value[0] <= 19'd0;
			/**/
		end
		else
		begin
			if(image_recieved[0] == 1 && reset == 0
					 && max_pooled[0] == 0)
			begin
				en_w_result0_mem <= 1'd1;
				en_r_img0_mem <= 1'd1;
		
				if(inp_result0_mem >= dat_read_img0_mem)
				begin
					inp_result0_mem <= inp_result0_mem;
				end
				if(dat_read_img0_mem > inp_result0_mem)
				begin
					inp_result0_mem <= dat_read_img0_mem;
				end
				if ( 1)
				begin
					addr_r_img0_mem <= (POOLOUT2_var[0]*P2 + P2_var[0])*F_M1 + (POOLOUT1_var[0]*P1 + P1_var[0]);
					addr_w_result0_mem <= POOLOUT1_var[0]*POOLOUT2 + POOLOUT2_var[0];
					value[0] <= dat_read_img0_mem;
					P1_var[0] <= P1_var[0] + 1;
					if (P1_var[0] == 0 && P2_var[0] == 1)
					begin
						we_result0_mem <= 1'd1;
					end
					else begin
						we_result0_mem <= 1'd0;
					end
					if (P1_var[0] >= P1 - 1)
					begin
						P1_var[0] <= 8'd0;
						P2_var[0] <= P2_var[0] + 1;
						if (P2_var[0] >= P2 - 1)
						begin
							P2_var[0] <= 8'd0;
							inp_result0_mem <= 20'b0;
							result0 <= outp_result0_mem;
							POOLOUT1_var[0] <= POOLOUT1_var[0] + 1;
							if (POOLOUT1_var[0] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[0] <= 8'd0;
								POOLOUT2_var[0] <= POOLOUT2_var[0] + 1;
								if(POOLOUT2_var[0] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[0] <= 8'd0;
									en_w_result0_mem <= 1'd1;
									we_result0_mem <= 1'd1;
									addr_w_result0_mem <= 15'd0;
									max_pooled[0] = 1;
								end
							end
						end
					end
				end
			end
		end
	end

/////////////////
// max_pooling [1] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[1] <= 8'd0;
			P2_var[1] <= 8'd0;
			POOLOUT1_var[1] <= 3'd0;
			POOLOUT2_var[1] <= 3'd0;
			max_pooled[1] <= 1'd0;
			en_r_img1_mem <= 1'd0;
			addr_r_img1_mem <= 15'd0;
			en_w_result1_mem <= 1'd0;
			we_result1_mem <= 1'd0;
			addr_w_result1_mem <= 15'd0;
			inp_result1_mem <= 19'd0;
			value[1] <= 19'd0;
		end
		else
		begin
			if(image_recieved[1] == 1 && reset == 0
					 && max_pooled[1] == 0)
			begin
				en_w_result1_mem <= 1'd1;
				en_r_img1_mem <= 1'd1;
		
				if(inp_result1_mem >= dat_read_img1_mem)
				begin
					inp_result1_mem <= inp_result1_mem;
				end
				if(dat_read_img1_mem > inp_result1_mem)
				begin
					inp_result1_mem <= dat_read_img1_mem;
				end
				if ( 1)
				begin
					addr_r_img1_mem <= (POOLOUT2_var[1]*P2 + P2_var[1])*F_M1 + (POOLOUT1_var[1]*P1 + P1_var[1]);
					addr_w_result1_mem <= POOLOUT1_var[1]*POOLOUT2 + POOLOUT2_var[1];
					value[1] <= dat_read_img1_mem;
					P1_var[1] <= P1_var[1] + 1;
					if (P1_var[1] == 0 && P2_var[1] == 1)
					begin
						we_result1_mem <= 1'd1;
					end
					else begin
						we_result1_mem <= 1'd0;
					end
					if (P1_var[1] >= P1 - 1)
					begin
						P1_var[1] <= 8'd0;
						P2_var[1] <= P2_var[1] + 1;
						if (P2_var[1] >= P2 - 1)
						begin
							P2_var[1] <= 8'd0;
							inp_result1_mem <= 20'b0;
							result1 <= outp_result1_mem;
							POOLOUT1_var[1] <= POOLOUT1_var[1] + 1;
							if (POOLOUT1_var[1] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[1] <= 8'd0;
								POOLOUT2_var[1] <= POOLOUT2_var[0] + 1;
								if(POOLOUT2_var[1] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[1] <= 8'd0;
									en_w_result1_mem <= 1'd1;
									we_result1_mem <= 1'd1;
									addr_w_result1_mem <= 15'd0;
									max_pooled[1] = 1;
								end
							end
						end
					end
				end
			end
		end
	end

/////////////////
// max_pooling [2] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[2] <= 8'd0;
			P2_var[2] <= 8'd0;
			POOLOUT1_var[2] <= 3'd0;
			POOLOUT2_var[2] <= 3'd0;
			max_pooled[2] <= 1'd0;
			en_r_img2_mem <= 1'd0;
			addr_r_img2_mem <= 15'd0;
			en_w_result2_mem <= 1'd0;
			we_result2_mem <= 1'd0;
			addr_w_result2_mem <= 15'd0;
			inp_result2_mem <= 19'd0;
			value[2] <= 19'd0;
		end
		else
		begin
			if(image_recieved[2] == 1 && reset == 0
					 && max_pooled[2] == 0)
			begin
				en_w_result2_mem <= 1'd1;
				en_r_img2_mem <= 1'd1;
		
				if(inp_result2_mem >= dat_read_img2_mem)
				begin
					inp_result2_mem <= inp_result2_mem;
				end
				if(dat_read_img2_mem > inp_result2_mem)
				begin
					inp_result2_mem <= dat_read_img2_mem;
				end
				if ( 1)
				begin
					addr_r_img2_mem <= (POOLOUT2_var[2]*P2 + P2_var[2])*F_M1 + (POOLOUT1_var[2]*P1 + P1_var[2]);
					addr_w_result2_mem <= POOLOUT1_var[2]*POOLOUT2 + POOLOUT2_var[2];
					value[2] <= dat_read_img2_mem;
					P1_var[2] <= P1_var[2] + 1;
					if (P1_var[2] == 0 && P2_var[2] == 1)
					begin
						we_result2_mem <= 1'd1;
					end
					else begin
						we_result2_mem <= 1'd0;
					end
					if (P1_var[2] >= P1 - 1)
					begin
						P1_var[2] <= 8'd0;
						P2_var[2] <= P2_var[2] + 1;
						if (P2_var[2] >= P2 - 1)
						begin
							P2_var[2] <= 8'd0;
							inp_result2_mem <= 20'b0;
							result2 <= outp_result2_mem;
							POOLOUT1_var[2] <= POOLOUT1_var[2] + 1;
							if (POOLOUT1_var[2] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[2] <= 8'd0;
								POOLOUT2_var[2] <= POOLOUT2_var[2] + 1;
								if(POOLOUT2_var[2] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[2] <= 8'd0;
									en_w_result2_mem <= 1'd1;
									we_result2_mem <= 1'd1;
									addr_w_result2_mem <= 15'd0;
									max_pooled[2] = 1;
								end
							end
						end
					end
				end
			end
		end
	end

/////////////////
// max_pooling [3] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[3] <= 8'd0;
			P2_var[3] <= 8'd0;
			POOLOUT1_var[3] <= 3'd0;
			POOLOUT2_var[3] <= 3'd0;
			max_pooled[3] <= 1'd0;
			en_r_img3_mem <= 1'd0;
			addr_r_img3_mem <= 15'd0;
			en_w_result3_mem <= 1'd0;
			we_result3_mem <= 1'd0;
			addr_w_result3_mem <= 15'd0;
			inp_result3_mem <= 19'd0;
			value[3] <= 19'd0;
		end
		else
		begin
			if(image_recieved[3] == 1 && reset == 0
					 && max_pooled[3] == 0)
			begin
				en_w_result3_mem <= 1'd1;
				en_r_img3_mem <= 1'd1;
		
				if(inp_result3_mem >= dat_read_img3_mem)
				begin
					inp_result3_mem <= inp_result3_mem;
				end
				if(dat_read_img3_mem > inp_result3_mem)
				begin
					inp_result3_mem <= dat_read_img3_mem;
				end
				if ( 1)
				begin
					addr_r_img3_mem <= (POOLOUT2_var[3]*P2 + P2_var[3])*F_M1 + (POOLOUT1_var[3]*P1 + P1_var[3]);
					addr_w_result3_mem <= POOLOUT1_var[3]*POOLOUT2 + POOLOUT2_var[3];
					value[3] <= dat_read_img3_mem;
					P1_var[3] <= P1_var[3] + 1;
					if (P1_var[3] == 0 && P2_var[3] == 1)
					begin
						we_result3_mem <= 1'd1;
					end
					else begin
						we_result3_mem <= 1'd0;
					end
					if (P1_var[3] >= P1 - 1)
					begin
						P1_var[3] <= 8'd0;
						P2_var[3] <= P2_var[3] + 1;
						if (P2_var[3] >= P2 - 1)
						begin
							P2_var[3] <= 8'd0;
							inp_result3_mem <= 20'b0;
							result3 <= outp_result3_mem;
							POOLOUT1_var[3] <= POOLOUT1_var[3] + 1;
							if (POOLOUT1_var[3] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[3] <= 8'd0;
								POOLOUT2_var[3] <= POOLOUT2_var[3] + 1;
								if(POOLOUT2_var[3] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[3] <= 8'd0;
									en_w_result3_mem <= 1'd1;
									we_result3_mem <= 1'd1;
									addr_w_result3_mem <= 15'd0;
									max_pooled[3] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [4] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[4] <= 8'd0;
			P2_var[4] <= 8'd0;
			POOLOUT1_var[4] <= 3'd0;
			POOLOUT2_var[4] <= 3'd0;
			max_pooled[4] <= 1'd0;
			en_r_img4_mem <= 1'd0;
			addr_r_img4_mem <= 15'd0;
			en_w_result4_mem <= 1'd0;
			we_result4_mem <= 1'd0;
			addr_w_result4_mem <= 15'd0;
			inp_result4_mem <= 19'd0;
			value[4] <= 19'd0;
		end
		else
		begin
			if(image_recieved[4] == 1 && reset == 0
					 && max_pooled[4] == 0)
			begin
				en_w_result4_mem <= 1'd1;
				en_r_img4_mem <= 1'd1;
		
				if(inp_result4_mem >= dat_read_img4_mem)
				begin
					inp_result4_mem <= inp_result4_mem;
				end
				if(dat_read_img4_mem > inp_result4_mem)
				begin
					inp_result4_mem <= dat_read_img4_mem;
				end
				if ( 1)
				begin
					addr_r_img4_mem <= (POOLOUT2_var[4]*P2 + P2_var[4])*F_M1 + (POOLOUT1_var[4]*P1 + P1_var[4]);
					addr_w_result4_mem <= POOLOUT1_var[4]*POOLOUT2 + POOLOUT2_var[4];
					value[4] <= dat_read_img4_mem;
					P1_var[4] <= P1_var[4] + 1;
					if (P1_var[4] == 0 && P2_var[4] == 1)
					begin
						we_result4_mem <= 1'd1;
					end
					else begin
						we_result4_mem <= 1'd0;
					end
					if (P1_var[4] >= P1 - 1)
					begin
						P1_var[4] <= 8'd0;
						P2_var[4] <= P2_var[4] + 1;
						if (P2_var[4] >= P2 - 1)
						begin
							P2_var[4] <= 8'd0;
							inp_result4_mem <= 20'b0;
							result4 <= outp_result4_mem;
							POOLOUT1_var[4] <= POOLOUT1_var[4] + 1;
							if (POOLOUT1_var[4] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[4] <= 8'd0;
								POOLOUT2_var[4] <= POOLOUT2_var[4] + 1;
								if(POOLOUT2_var[4] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[4] <= 8'd0;
									en_w_result4_mem <= 1'd1;
									we_result4_mem <= 1'd1;
									addr_w_result4_mem <= 15'd0;
									max_pooled[4] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [5] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[5] <= 8'd0;
			P2_var[5] <= 8'd0;
			POOLOUT1_var[5] <= 3'd0;
			POOLOUT2_var[5] <= 3'd0;
			max_pooled[5] <= 1'd0;
			en_r_img5_mem <= 1'd0;
			addr_r_img5_mem <= 15'd0;
			en_w_result5_mem <= 1'd0;
			we_result5_mem <= 1'd0;
			addr_w_result5_mem <= 15'd0;
			inp_result5_mem <= 19'd0;
			value[5] <= 19'd0;
		end
		else
		begin
			if(image_recieved[5] == 1 && reset == 0
					 && max_pooled[5] == 0)
			begin
				en_w_result5_mem <= 1'd1;
				en_r_img5_mem <= 1'd1;
		
				if(inp_result5_mem >= dat_read_img5_mem)
				begin
					inp_result5_mem <= inp_result5_mem;
				end
				if(dat_read_img5_mem > inp_result5_mem)
				begin
					inp_result5_mem <= dat_read_img5_mem;
				end
				if ( 1)
				begin
					addr_r_img5_mem <= (POOLOUT2_var[5]*P2 + P2_var[5])*F_M1 + (POOLOUT1_var[5]*P1 + P1_var[5]);
					addr_w_result5_mem <= POOLOUT1_var[5]*POOLOUT2 + POOLOUT2_var[5];
					value[5] <= dat_read_img5_mem;
					P1_var[5] <= P1_var[5] + 1;
					if (P1_var[5] == 0 && P2_var[5] == 1)
					begin
						we_result5_mem <= 1'd1;
					end
					else begin
						we_result5_mem <= 1'd0;
					end
					if (P1_var[5] >= P1 - 1)
					begin
						P1_var[5] <= 8'd0;
						P2_var[5] <= P2_var[5] + 1;
						if (P2_var[5] >= P2 - 1)
						begin
							P2_var[5] <= 8'd0;
							inp_result5_mem <= 20'b0;
							result5 <= outp_result5_mem;
							POOLOUT1_var[5] <= POOLOUT1_var[5] + 1;
							if (POOLOUT1_var[5] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[5] <= 8'd0;
								POOLOUT2_var[5] <= POOLOUT2_var[5] + 1;
								if(POOLOUT2_var[5] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[5] <= 8'd0;
									en_w_result5_mem <= 1'd1;
									we_result5_mem <= 1'd1;
									addr_w_result5_mem <= 15'd0;
									max_pooled[5] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [6] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[6] <= 8'd0;
			P2_var[6] <= 8'd0;
			POOLOUT1_var[6] <= 3'd0;
			POOLOUT2_var[6] <= 3'd0;
			max_pooled[6] <= 1'd0;
			en_r_img6_mem <= 1'd0;
			addr_r_img6_mem <= 15'd0;
			en_w_result6_mem <= 1'd0;
			we_result6_mem <= 1'd0;
			addr_w_result6_mem <= 15'd0;
			inp_result6_mem <= 19'd0;
			value[6] <= 19'd0;
		end
		else
		begin
			if(image_recieved[6] == 1 && reset == 0
					 && max_pooled[6] == 0)
			begin
				en_w_result6_mem <= 1'd1;
				en_r_img6_mem <= 1'd1;
		
				if(inp_result6_mem >= dat_read_img6_mem)
				begin
					inp_result6_mem <= inp_result6_mem;
				end
				if(dat_read_img6_mem > inp_result6_mem)
				begin
					inp_result6_mem <= dat_read_img6_mem;
				end
				if ( 1)
				begin
					addr_r_img6_mem <= (POOLOUT2_var[6]*P2 + P2_var[6])*F_M1 + (POOLOUT1_var[6]*P1 + P1_var[6]);
					addr_w_result6_mem <= POOLOUT1_var[6]*POOLOUT2 + POOLOUT2_var[6];
					value[6] <= dat_read_img6_mem;
					P1_var[6] <= P1_var[6] + 1;
					if (P1_var[6] == 0 && P2_var[6] == 1)
					begin
						we_result6_mem <= 1'd1;
					end
					else begin
						we_result6_mem <= 1'd0;
					end
					if (P1_var[6] >= P1 - 1)
					begin
						P1_var[6] <= 8'd0;
						P2_var[6] <= P2_var[6] + 1;
						if (P2_var[6] >= P2 - 1)
						begin
							P2_var[6] <= 8'd0;
							inp_result6_mem <= 20'b0;
							result6 <= outp_result6_mem;
							POOLOUT1_var[6] <= POOLOUT1_var[6] + 1;
							if (POOLOUT1_var[6] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[6] <= 8'd0;
								POOLOUT2_var[6] <= POOLOUT2_var[6] + 1;
								if(POOLOUT2_var[6] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[6] <= 8'd0;
									en_w_result6_mem <= 1'd1;
									we_result6_mem <= 1'd1;
									addr_w_result6_mem <= 15'd0;
									max_pooled[6] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [7] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[7] <= 8'd0;
			P2_var[7] <= 8'd0;
			POOLOUT1_var[7] <= 3'd0;
			POOLOUT2_var[7] <= 3'd0;
			max_pooled[7] <= 1'd0;
			en_r_img7_mem <= 1'd0;
			addr_r_img7_mem <= 15'd0;
			en_w_result7_mem <= 1'd0;
			we_result7_mem <= 1'd0;
			addr_w_result7_mem <= 15'd0;
			inp_result7_mem <= 19'd0;
			value[7] <= 19'd0;
		end
		else
		begin
			if(image_recieved[7] == 1 && reset == 0
					 && max_pooled[7] == 0)
			begin
				en_w_result7_mem <= 1'd1;
				en_r_img7_mem <= 1'd1;
		
				if(inp_result7_mem >= dat_read_img7_mem)
				begin
					inp_result7_mem <= inp_result7_mem;
				end
				if(dat_read_img7_mem > inp_result7_mem)
				begin
					inp_result7_mem <= dat_read_img7_mem;
				end
				if ( 1)
				begin
					addr_r_img7_mem <= (POOLOUT2_var[7]*P2 + P2_var[7])*F_M1 + (POOLOUT1_var[7]*P1 + P1_var[7]);
					addr_w_result7_mem <= POOLOUT1_var[7]*POOLOUT2 + POOLOUT2_var[7];
					value[7] <= dat_read_img7_mem;
					P1_var[7] <= P1_var[7] + 1;
					if (P1_var[7] == 0 && P2_var[7] == 1)
					begin
						we_result7_mem <= 1'd1;
					end
					else begin
						we_result7_mem <= 1'd0;
					end
					if (P1_var[7] >= P1 - 1)
					begin
						P1_var[7] <= 8'd0;
						P2_var[7] <= P2_var[7] + 1;
						if (P2_var[7] >= P2 - 1)
						begin
							P2_var[7] <= 8'd0;
							inp_result7_mem <= 20'b0;
							result7 <= outp_result7_mem;
							POOLOUT1_var[7] <= POOLOUT1_var[7] + 1;
							if (POOLOUT1_var[7] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[7] <= 8'd0;
								POOLOUT2_var[7] <= POOLOUT2_var[7] + 1;
								if(POOLOUT2_var[7] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[7] <= 8'd0;
									en_w_result7_mem <= 1'd1;
									we_result7_mem <= 1'd1;
									addr_w_result7_mem <= 15'd0;
									max_pooled[7] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [8] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[8] <= 8'd0;
			P2_var[8] <= 8'd0;
			POOLOUT1_var[8] <= 3'd0;
			POOLOUT2_var[8] <= 3'd0;
			max_pooled[8] <= 1'd0;
			en_r_img8_mem <= 1'd0;
			addr_r_img8_mem <= 15'd0;
			en_w_result8_mem <= 1'd0;
			we_result8_mem <= 1'd0;
			addr_w_result8_mem <= 15'd0;
			inp_result8_mem <= 19'd0;
			value[8] <= 19'd0;
		end
		else
		begin
			if(image_recieved[8] == 1 && reset == 0
					 && max_pooled[8] == 0)
			begin
				en_w_result8_mem <= 1'd1;
				en_r_img8_mem <= 1'd1;
		
				if(inp_result8_mem >= dat_read_img8_mem)
				begin
					inp_result8_mem <= inp_result8_mem;
				end
				if(dat_read_img8_mem > inp_result8_mem)
				begin
					inp_result8_mem <= dat_read_img8_mem;
				end
				if ( 1)
				begin
					addr_r_img8_mem <= (POOLOUT2_var[8]*P2 + P2_var[8])*F_M1 + (POOLOUT1_var[8]*P1 + P1_var[8]);
					addr_w_result8_mem <= POOLOUT1_var[8]*POOLOUT2 + POOLOUT2_var[8];
					value[8] <= dat_read_img8_mem;
					P1_var[8] <= P1_var[8] + 1;
					if (P1_var[8] == 0 && P2_var[8] == 1)
					begin
						we_result8_mem <= 1'd1;
					end
					else begin
						we_result8_mem <= 1'd0;
					end
					if (P1_var[8] >= P1 - 1)
					begin
						P1_var[8] <= 8'd0;
						P2_var[8] <= P2_var[8] + 1;
						if (P2_var[8] >= P2 - 1)
						begin
							P2_var[8] <= 8'd0;
							inp_result8_mem <= 20'b0;
							result8 <= outp_result8_mem;
							POOLOUT1_var[8] <= POOLOUT1_var[8] + 1;
							if (POOLOUT1_var[8] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[8] <= 8'd0;
								POOLOUT2_var[8] <= POOLOUT2_var[8] + 1;
								if(POOLOUT2_var[8] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[8] <= 8'd0;
									en_w_result8_mem <= 1'd1;
									we_result8_mem <= 1'd1;
									addr_w_result8_mem <= 15'd0;
									max_pooled[8] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [9] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[9] <= 8'd0;
			P2_var[9] <= 8'd0;
			POOLOUT1_var[9] <= 3'd0;
			POOLOUT2_var[9] <= 3'd0;
			max_pooled[9] <= 1'd0;
			en_r_img9_mem <= 1'd0;
			addr_r_img9_mem <= 15'd0;
			en_w_result9_mem <= 1'd0;
			we_result9_mem <= 1'd0;
			addr_w_result9_mem <= 15'd0;
			inp_result9_mem <= 19'd0;
			value[9] <= 19'd0;
		end
		else
		begin
			if(image_recieved[9] == 1 && reset == 0
					 && max_pooled[9] == 0)
			begin
				en_w_result9_mem <= 1'd1;
				en_r_img9_mem <= 1'd1;
		
				if(inp_result9_mem >= dat_read_img9_mem)
				begin
					inp_result9_mem <= inp_result9_mem;
				end
				if(dat_read_img9_mem > inp_result9_mem)
				begin
					inp_result9_mem <= dat_read_img9_mem;
				end
				if ( 1)
				begin
					addr_r_img9_mem <= (POOLOUT2_var[9]*P2 + P2_var[9])*F_M1 + (POOLOUT1_var[9]*P1 + P1_var[9]);
					addr_w_result9_mem <= POOLOUT1_var[9]*POOLOUT2 + POOLOUT2_var[9];
					value[9] <= dat_read_img9_mem;
					P1_var[9] <= P1_var[9] + 1;
					if (P1_var[9] == 0 && P2_var[9] == 1)
					begin
						we_result9_mem <= 1'd1;
					end
					else begin
						we_result9_mem <= 1'd0;
					end
					if (P1_var[9] >= P1 - 1)
					begin
						P1_var[9] <= 8'd0;
						P2_var[9] <= P2_var[9] + 1;
						if (P2_var[9] >= P2 - 1)
						begin
							P2_var[9] <= 8'd0;
							inp_result9_mem <= 20'b0;
							result9 <= outp_result9_mem;
							POOLOUT1_var[9] <= POOLOUT1_var[9] + 1;
							if (POOLOUT1_var[9] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[9] <= 8'd0;
								POOLOUT2_var[9] <= POOLOUT2_var[9] + 1;
								if(POOLOUT2_var[9] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[9] <= 8'd0;
									en_w_result9_mem <= 1'd1;
									we_result9_mem <= 1'd1;
									addr_w_result9_mem <= 15'd0;
									max_pooled[9] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [10] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[10] <= 8'd0;
			P2_var[10] <= 8'd0;
			POOLOUT1_var[10] <= 3'd0;
			POOLOUT2_var[10] <= 3'd0;
			max_pooled[10] <= 1'd0;
			en_r_img10_mem <= 1'd0;
			addr_r_img10_mem <= 15'd0;
			en_w_result10_mem <= 1'd0;
			we_result10_mem <= 1'd0;
			addr_w_result10_mem <= 15'd0;
			inp_result10_mem <= 19'd0;
			value[10] <= 19'd0;
		end
		else
		begin
			if(image_recieved[10] == 1 && reset == 0
					 && max_pooled[10] == 0)
			begin
				en_w_result10_mem <= 1'd1;
				en_r_img10_mem <= 1'd1;
		
				if(inp_result10_mem >= dat_read_img10_mem)
				begin
					inp_result10_mem <= inp_result10_mem;
				end
				if(dat_read_img10_mem > inp_result10_mem)
				begin
					inp_result10_mem <= dat_read_img10_mem;
				end
				if ( 1)
				begin
					addr_r_img10_mem <= (POOLOUT2_var[10]*P2 + P2_var[10])*F_M1 + (POOLOUT1_var[10]*P1 + P1_var[10]);
					addr_w_result10_mem <= POOLOUT1_var[10]*POOLOUT2 + POOLOUT2_var[10];
					value[10] <= dat_read_img10_mem;
					P1_var[10] <= P1_var[10] + 1;
					if (P1_var[10] == 0 && P2_var[10] == 1)
					begin
						we_result10_mem <= 1'd1;
					end
					else begin
						we_result10_mem <= 1'd0;
					end
					if (P1_var[10] >= P1 - 1)
					begin
						P1_var[10] <= 8'd0;
						P2_var[10] <= P2_var[10] + 1;
						if (P2_var[10] >= P2 - 1)
						begin
							P2_var[10] <= 8'd0;
							inp_result10_mem <= 20'b0;
							result10 <= outp_result10_mem;
							POOLOUT1_var[10] <= POOLOUT1_var[10] + 1;
							if (POOLOUT1_var[10] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[10] <= 8'd0;
								POOLOUT2_var[10] <= POOLOUT2_var[10] + 1;
								if(POOLOUT2_var[10] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[10] <= 8'd0;
									en_w_result10_mem <= 1'd1;
									we_result10_mem <= 1'd1;
									addr_w_result10_mem <= 15'd0;
									max_pooled[10] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [11] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[11] <= 8'd0;
			P2_var[11] <= 8'd0;
			POOLOUT1_var[11] <= 3'd0;
			POOLOUT2_var[11] <= 3'd0;
			max_pooled[11] <= 1'd0;
			en_r_img11_mem <= 1'd0;
			addr_r_img11_mem <= 15'd0;
			en_w_result11_mem <= 1'd0;
			we_result11_mem <= 1'd0;
			addr_w_result11_mem <= 15'd0;
			inp_result11_mem <= 19'd0;
			value[11] <= 19'd0;
		end
		else
		begin
			if(image_recieved[11] == 1 && reset == 0
					 && max_pooled[11] == 0)
			begin
				en_w_result11_mem <= 1'd1;
				en_r_img11_mem <= 1'd1;
		
				if(inp_result11_mem >= dat_read_img11_mem)
				begin
					inp_result11_mem <= inp_result11_mem;
				end
				if(dat_read_img11_mem > inp_result11_mem)
				begin
					inp_result11_mem <= dat_read_img11_mem;
				end
				if ( 1)
				begin
					addr_r_img11_mem <= (POOLOUT2_var[11]*P2 + P2_var[11])*F_M1 + (POOLOUT1_var[11]*P1 + P1_var[11]);
					addr_w_result11_mem <= POOLOUT1_var[11]*POOLOUT2 + POOLOUT2_var[11];
					value[11] <= dat_read_img11_mem;
					P1_var[11] <= P1_var[11] + 1;
					if (P1_var[11] == 0 && P2_var[11] == 1)
					begin
						we_result11_mem <= 1'd1;
					end
					else begin
						we_result11_mem <= 1'd0;
					end
					if (P1_var[11] >= P1 - 1)
					begin
						P1_var[11] <= 8'd0;
						P2_var[11] <= P2_var[11] + 1;
						if (P2_var[11] >= P2 - 1)
						begin
							P2_var[11] <= 8'd0;
							inp_result11_mem <= 20'b0;
							result11 <= outp_result11_mem;
							POOLOUT1_var[11] <= POOLOUT1_var[11] + 1;
							if (POOLOUT1_var[11] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[11] <= 8'd0;
								POOLOUT2_var[11] <= POOLOUT2_var[11] + 1;
								if(POOLOUT2_var[11] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[11] <= 8'd0;
									en_w_result11_mem <= 1'd1;
									we_result11_mem <= 1'd1;
									addr_w_result11_mem <= 15'd0;
									max_pooled[11] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [12] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[12] <= 8'd0;
			P2_var[12] <= 8'd0;
			POOLOUT1_var[12] <= 3'd0;
			POOLOUT2_var[12] <= 3'd0;
			max_pooled[12] <= 1'd0;
			en_r_img12_mem <= 1'd0;
			addr_r_img12_mem <= 15'd0;
			en_w_result12_mem <= 1'd0;
			we_result12_mem <= 1'd0;
			addr_w_result12_mem <= 15'd0;
			inp_result12_mem <= 19'd0;
			value[12] <= 19'd0;
		end
		else
		begin
			if(image_recieved[12] == 1 && reset == 0
					 && max_pooled[12] == 0)
			begin
				en_w_result12_mem <= 1'd1;
				en_r_img12_mem <= 1'd1;
		
				if(inp_result12_mem >= dat_read_img12_mem)
				begin
					inp_result12_mem <= inp_result12_mem;
				end
				if(dat_read_img12_mem > inp_result12_mem)
				begin
					inp_result12_mem <= dat_read_img12_mem;
				end
				if ( 1)
				begin
					addr_r_img12_mem <= (POOLOUT2_var[12]*P2 + P2_var[12])*F_M1 + (POOLOUT1_var[12]*P1 + P1_var[12]);
					addr_w_result12_mem <= POOLOUT1_var[12]*POOLOUT2 + POOLOUT2_var[12];
					value[12] <= dat_read_img12_mem;
					P1_var[12] <= P1_var[12] + 1;
					if (P1_var[12] == 0 && P2_var[12] == 1)
					begin
						we_result12_mem <= 1'd1;
					end
					else begin
						we_result12_mem <= 1'd0;
					end
					if (P1_var[12] >= P1 - 1)
					begin
						P1_var[12] <= 8'd0;
						P2_var[12] <= P2_var[12] + 1;
						if (P2_var[12] >= P2 - 1)
						begin
							P2_var[12] <= 8'd0;
							inp_result12_mem <= 20'b0;
							result12 <= outp_result12_mem;
							POOLOUT1_var[12] <= POOLOUT1_var[12] + 1;
							if (POOLOUT1_var[12] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[12] <= 8'd0;
								POOLOUT2_var[12] <= POOLOUT2_var[12] + 1;
								if(POOLOUT2_var[12] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[12] <= 8'd0;
									en_w_result12_mem <= 1'd1;
									we_result12_mem <= 1'd1;
									addr_w_result12_mem <= 15'd0;
									max_pooled[12] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [13] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[13] <= 8'd0;
			P2_var[13] <= 8'd0;
			POOLOUT1_var[13] <= 3'd0;
			POOLOUT2_var[13] <= 3'd0;
			max_pooled[13] <= 1'd0;
			en_r_img13_mem <= 1'd0;
			addr_r_img13_mem <= 15'd0;
			en_w_result13_mem <= 1'd0;
			we_result13_mem <= 1'd0;
			addr_w_result13_mem <= 15'd0;
			inp_result13_mem <= 19'd0;
			value[13] <= 19'd0;
		end
		else
		begin
			if(image_recieved[13] == 1 && reset == 0
					 && max_pooled[13] == 0)
			begin
				en_w_result13_mem <= 1'd1;
				en_r_img13_mem <= 1'd1;
		
				if(inp_result13_mem >= dat_read_img13_mem)
				begin
					inp_result13_mem <= inp_result13_mem;
				end
				if(dat_read_img13_mem > inp_result13_mem)
				begin
					inp_result13_mem <= dat_read_img13_mem;
				end
				if ( 1)
				begin
					addr_r_img13_mem <= (POOLOUT2_var[13]*P2 + P2_var[13])*F_M1 + (POOLOUT1_var[13]*P1 + P1_var[13]);
					addr_w_result13_mem <= POOLOUT1_var[13]*POOLOUT2 + POOLOUT2_var[13];
					value[13] <= dat_read_img13_mem;
					P1_var[13] <= P1_var[13] + 1;
					if (P1_var[13] == 0 && P2_var[13] == 1)
					begin
						we_result13_mem <= 1'd1;
					end
					else begin
						we_result13_mem <= 1'd0;
					end
					if (P1_var[13] >= P1 - 1)
					begin
						P1_var[13] <= 8'd0;
						P2_var[13] <= P2_var[13] + 1;
						if (P2_var[13] >= P2 - 1)
						begin
							P2_var[13] <= 8'd0;
							inp_result13_mem <= 20'b0;
							result13 <= outp_result13_mem;
							POOLOUT1_var[13] <= POOLOUT1_var[13] + 1;
							if (POOLOUT1_var[13] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[13] <= 8'd0;
								POOLOUT2_var[13] <= POOLOUT2_var[13] + 1;
								if(POOLOUT2_var[13] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[13] <= 8'd0;
									en_w_result13_mem <= 1'd1;
									we_result13_mem <= 1'd1;
									addr_w_result13_mem <= 15'd0;
									max_pooled[13] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [14] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[14] <= 8'd0;
			P2_var[14] <= 8'd0;
			POOLOUT1_var[14] <= 3'd0;
			POOLOUT2_var[14] <= 3'd0;
			max_pooled[14] <= 1'd0;
			en_r_img14_mem <= 1'd0;
			addr_r_img14_mem <= 15'd0;
			en_w_result14_mem <= 1'd0;
			we_result14_mem <= 1'd0;
			addr_w_result14_mem <= 15'd0;
			inp_result14_mem <= 19'd0;
			value[14] <= 19'd0;
		end
		else
		begin
			if(image_recieved[14] == 1 && reset == 0
					 && max_pooled[14] == 0)
			begin
				en_w_result14_mem <= 1'd1;
				en_r_img14_mem <= 1'd1;
		
				if(inp_result14_mem >= dat_read_img14_mem)
				begin
					inp_result14_mem <= inp_result14_mem;
				end
				if(dat_read_img14_mem > inp_result14_mem)
				begin
					inp_result14_mem <= dat_read_img14_mem;
				end
				if ( 1)
				begin
					addr_r_img14_mem <= (POOLOUT2_var[14]*P2 + P2_var[14])*F_M1 + (POOLOUT1_var[14]*P1 + P1_var[14]);
					addr_w_result14_mem <= POOLOUT1_var[14]*POOLOUT2 + POOLOUT2_var[14];
					value[14] <= dat_read_img14_mem;
					P1_var[14] <= P1_var[14] + 1;
					if (P1_var[14] == 0 && P2_var[14] == 1)
					begin
						we_result14_mem <= 1'd1;
					end
					else begin
						we_result14_mem <= 1'd0;
					end
					if (P1_var[14] >= P1 - 1)
					begin
						P1_var[14] <= 8'd0;
						P2_var[14] <= P2_var[14] + 1;
						if (P2_var[14] >= P2 - 1)
						begin
							P2_var[14] <= 8'd0;
							inp_result14_mem <= 20'b0;
							result14 <= outp_result14_mem;
							POOLOUT1_var[14] <= POOLOUT1_var[14] + 1;
							if (POOLOUT1_var[14] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[14] <= 8'd0;
								POOLOUT2_var[14] <= POOLOUT2_var[14] + 1;
								if(POOLOUT2_var[14] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[14] <= 8'd0;
									en_w_result14_mem <= 1'd1;
									we_result14_mem <= 1'd1;
									addr_w_result14_mem <= 15'd0;
									max_pooled[14] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [15] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[15] <= 8'd0;
			P2_var[15] <= 8'd0;
			POOLOUT1_var[15] <= 3'd0;
			POOLOUT2_var[15] <= 3'd0;
			max_pooled[15] <= 1'd0;
			en_r_img15_mem <= 1'd0;
			addr_r_img15_mem <= 15'd0;
			en_w_result15_mem <= 1'd0;
			we_result15_mem <= 1'd0;
			addr_w_result15_mem <= 15'd0;
			inp_result15_mem <= 19'd0;
			value[15] <= 19'd0;
		end
		else
		begin
			if(image_recieved[15] == 1 && reset == 0
					 && max_pooled[15] == 0)
			begin
				en_w_result15_mem <= 1'd1;
				en_r_img15_mem <= 1'd1;
		
				if(inp_result15_mem >= dat_read_img15_mem)
				begin
					inp_result15_mem <= inp_result15_mem;
				end
				if(dat_read_img15_mem > inp_result15_mem)
				begin
					inp_result15_mem <= dat_read_img15_mem;
				end
				if ( 1)
				begin
					addr_r_img15_mem <= (POOLOUT2_var[15]*P2 + P2_var[15])*F_M1 + (POOLOUT1_var[15]*P1 + P1_var[15]);
					addr_w_result15_mem <= POOLOUT1_var[15]*POOLOUT2 + POOLOUT2_var[15];
					value[15] <= dat_read_img15_mem;
					P1_var[15] <= P1_var[15] + 1;
					if (P1_var[15] == 0 && P2_var[15] == 1)
					begin
						we_result15_mem <= 1'd1;
					end
					else begin
						we_result15_mem <= 1'd0;
					end
					if (P1_var[15] >= P1 - 1)
					begin
						P1_var[15] <= 8'd0;
						P2_var[15] <= P2_var[15] + 1;
						if (P2_var[15] >= P2 - 1)
						begin
							P2_var[15] <= 8'd0;
							inp_result15_mem <= 20'b0;
							result15 <= outp_result15_mem;
							POOLOUT1_var[15] <= POOLOUT1_var[15] + 1;
							if (POOLOUT1_var[15] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[15] <= 8'd0;
								POOLOUT2_var[15] <= POOLOUT2_var[15] + 1;
								if(POOLOUT2_var[15] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[15] <= 8'd0;
									en_w_result15_mem <= 1'd1;
									we_result15_mem <= 1'd1;
									addr_w_result15_mem <= 15'd0;
									max_pooled[15] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [16] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[16] <= 8'd0;
			P2_var[16] <= 8'd0;
			POOLOUT1_var[16] <= 3'd0;
			POOLOUT2_var[16] <= 3'd0;
			max_pooled[16] <= 1'd0;
			en_r_img16_mem <= 1'd0;
			addr_r_img16_mem <= 15'd0;
			en_w_result16_mem <= 1'd0;
			we_result16_mem <= 1'd0;
			addr_w_result16_mem <= 15'd0;
			inp_result16_mem <= 19'd0;
			value[16] <= 19'd0;
		end
		else
		begin
			if(image_recieved[16] == 1 && reset == 0
					 && max_pooled[16] == 0)
			begin
				en_w_result16_mem <= 1'd1;
				en_r_img16_mem <= 1'd1;
		
				if(inp_result16_mem >= dat_read_img16_mem)
				begin
					inp_result16_mem <= inp_result16_mem;
				end
				if(dat_read_img16_mem > inp_result16_mem)
				begin
					inp_result16_mem <= dat_read_img16_mem;
				end
				if ( 1)
				begin
					addr_r_img16_mem <= (POOLOUT2_var[16]*P2 + P2_var[16])*F_M1 + (POOLOUT1_var[16]*P1 + P1_var[16]);
					addr_w_result16_mem <= POOLOUT1_var[16]*POOLOUT2 + POOLOUT2_var[16];
					value[16] <= dat_read_img16_mem;
					P1_var[16] <= P1_var[16] + 1;
					if (P1_var[16] == 0 && P2_var[16] == 1)
					begin
						we_result16_mem <= 1'd1;
					end
					else begin
						we_result16_mem <= 1'd0;
					end
					if (P1_var[16] >= P1 - 1)
					begin
						P1_var[16] <= 8'd0;
						P2_var[16] <= P2_var[16] + 1;
						if (P2_var[16] >= P2 - 1)
						begin
							P2_var[16] <= 8'd0;
							inp_result16_mem <= 20'b0;
							result16 <= outp_result16_mem;
							POOLOUT1_var[16] <= POOLOUT1_var[16] + 1;
							if (POOLOUT1_var[16] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[16] <= 8'd0;
								POOLOUT2_var[16] <= POOLOUT2_var[16] + 1;
								if(POOLOUT2_var[16] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[16] <= 8'd0;
									en_w_result16_mem <= 1'd1;
									we_result16_mem <= 1'd1;
									addr_w_result16_mem <= 15'd0;
									max_pooled[16] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [17] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[17] <= 8'd0;
			P2_var[17] <= 8'd0;
			POOLOUT1_var[17] <= 3'd0;
			POOLOUT2_var[17] <= 3'd0;
			max_pooled[17] <= 1'd0;
			en_r_img17_mem <= 1'd0;
			addr_r_img17_mem <= 15'd0;
			en_w_result17_mem <= 1'd0;
			we_result17_mem <= 1'd0;
			addr_w_result17_mem <= 15'd0;
			inp_result17_mem <= 19'd0;
			value[17] <= 19'd0;
		end
		else
		begin
			if(image_recieved[17] == 1 && reset == 0
					 && max_pooled[17] == 0)
			begin
				en_w_result17_mem <= 1'd1;
				en_r_img17_mem <= 1'd1;
		
				if(inp_result17_mem >= dat_read_img17_mem)
				begin
					inp_result17_mem <= inp_result17_mem;
				end
				if(dat_read_img17_mem > inp_result17_mem)
				begin
					inp_result17_mem <= dat_read_img17_mem;
				end
				if ( 1)
				begin
					addr_r_img17_mem <= (POOLOUT2_var[17]*P2 + P2_var[17])*F_M1 + (POOLOUT1_var[17]*P1 + P1_var[17]);
					addr_w_result17_mem <= POOLOUT1_var[17]*POOLOUT2 + POOLOUT2_var[17];
					value[17] <= dat_read_img17_mem;
					P1_var[17] <= P1_var[17] + 1;
					if (P1_var[17] == 0 && P2_var[17] == 1)
					begin
						we_result17_mem <= 1'd1;
					end
					else begin
						we_result17_mem <= 1'd0;
					end
					if (P1_var[17] >= P1 - 1)
					begin
						P1_var[17] <= 8'd0;
						P2_var[17] <= P2_var[17] + 1;
						if (P2_var[17] >= P2 - 1)
						begin
							P2_var[17] <= 8'd0;
							inp_result17_mem <= 20'b0;
							result17 <= outp_result17_mem;
							POOLOUT1_var[17] <= POOLOUT1_var[17] + 1;
							if (POOLOUT1_var[17] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[17] <= 8'd0;
								POOLOUT2_var[17] <= POOLOUT2_var[17] + 1;
								if(POOLOUT2_var[17] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[17] <= 8'd0;
									en_w_result17_mem <= 1'd1;
									we_result17_mem <= 1'd1;
									addr_w_result17_mem <= 15'd0;
									max_pooled[17] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [18] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[18] <= 8'd0;
			P2_var[18] <= 8'd0;
			POOLOUT1_var[18] <= 3'd0;
			POOLOUT2_var[18] <= 3'd0;
			max_pooled[18] <= 1'd0;
			en_r_img18_mem <= 1'd0;
			addr_r_img18_mem <= 15'd0;
			en_w_result18_mem <= 1'd0;
			we_result18_mem <= 1'd0;
			addr_w_result18_mem <= 15'd0;
			inp_result18_mem <= 19'd0;
			value[18] <= 19'd0;
		end
		else
		begin
			if(image_recieved[18] == 1 && reset == 0
					 && max_pooled[18] == 0)
			begin
				en_w_result18_mem <= 1'd1;
				en_r_img18_mem <= 1'd1;
		
				if(inp_result18_mem >= dat_read_img18_mem)
				begin
					inp_result18_mem <= inp_result18_mem;
				end
				if(dat_read_img18_mem > inp_result18_mem)
				begin
					inp_result18_mem <= dat_read_img18_mem;
				end
				if ( 1)
				begin
					addr_r_img18_mem <= (POOLOUT2_var[18]*P2 + P2_var[18])*F_M1 + (POOLOUT1_var[18]*P1 + P1_var[18]);
					addr_w_result18_mem <= POOLOUT1_var[18]*POOLOUT2 + POOLOUT2_var[18];
					value[18] <= dat_read_img18_mem;
					P1_var[18] <= P1_var[18] + 1;
					if (P1_var[18] == 0 && P2_var[18] == 1)
					begin
						we_result18_mem <= 1'd1;
					end
					else begin
						we_result18_mem <= 1'd0;
					end
					if (P1_var[18] >= P1 - 1)
					begin
						P1_var[18] <= 8'd0;
						P2_var[18] <= P2_var[18] + 1;
						if (P2_var[18] >= P2 - 1)
						begin
							P2_var[18] <= 8'd0;
							inp_result18_mem <= 20'b0;
							result18 <= outp_result18_mem;
							POOLOUT1_var[18] <= POOLOUT1_var[18] + 1;
							if (POOLOUT1_var[18] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[18] <= 8'd0;
								POOLOUT2_var[18] <= POOLOUT2_var[18] + 1;
								if(POOLOUT2_var[18] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[18] <= 8'd0;
									en_w_result18_mem <= 1'd1;
									we_result18_mem <= 1'd1;
									addr_w_result18_mem <= 15'd0;
									max_pooled[18] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [19] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[19] <= 8'd0;
			P2_var[19] <= 8'd0;
			POOLOUT1_var[19] <= 3'd0;
			POOLOUT2_var[19] <= 3'd0;
			max_pooled[19] <= 1'd0;
			en_r_img19_mem <= 1'd0;
			addr_r_img19_mem <= 15'd0;
			en_w_result19_mem <= 1'd0;
			we_result19_mem <= 1'd0;
			addr_w_result19_mem <= 15'd0;
			inp_result19_mem <= 19'd0;
			value[19] <= 19'd0;
		end
		else
		begin
			if(image_recieved[19] == 1 && reset == 0
					 && max_pooled[19] == 0)
			begin
				en_w_result19_mem <= 1'd1;
				en_r_img19_mem <= 1'd1;
		
				if(inp_result19_mem >= dat_read_img19_mem)
				begin
					inp_result19_mem <= inp_result19_mem;
				end
				if(dat_read_img19_mem > inp_result19_mem)
				begin
					inp_result19_mem <= dat_read_img19_mem;
				end
				if ( 1)
				begin
					addr_r_img19_mem <= (POOLOUT2_var[19]*P2 + P2_var[19])*F_M1 + (POOLOUT1_var[19]*P1 + P1_var[19]);
					addr_w_result19_mem <= POOLOUT1_var[19]*POOLOUT2 + POOLOUT2_var[19];
					value[19] <= dat_read_img19_mem;
					P1_var[19] <= P1_var[19] + 1;
					if (P1_var[19] == 0 && P2_var[19] == 1)
					begin
						we_result19_mem <= 1'd1;
					end
					else begin
						we_result19_mem <= 1'd0;
					end
					if (P1_var[19] >= P1 - 1)
					begin
						P1_var[19] <= 8'd0;
						P2_var[19] <= P2_var[19] + 1;
						if (P2_var[19] >= P2 - 1)
						begin
							P2_var[19] <= 8'd0;
							inp_result19_mem <= 20'b0;
							result19 <= outp_result19_mem;
							POOLOUT1_var[19] <= POOLOUT1_var[19] + 1;
							if (POOLOUT1_var[19] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[19] <= 8'd0;
								POOLOUT2_var[19] <= POOLOUT2_var[19] + 1;
								if(POOLOUT2_var[19] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[19] <= 8'd0;
									en_w_result19_mem <= 1'd1;
									we_result19_mem <= 1'd1;
									addr_w_result19_mem <= 15'd0;
									max_pooled[19] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [20] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[20] <= 8'd0;
			P2_var[20] <= 8'd0;
			POOLOUT1_var[20] <= 3'd0;
			POOLOUT2_var[20] <= 3'd0;
			max_pooled[20] <= 1'd0;
			en_r_img20_mem <= 1'd0;
			addr_r_img20_mem <= 15'd0;
			en_w_result20_mem <= 1'd0;
			we_result20_mem <= 1'd0;
			addr_w_result20_mem <= 15'd0;
			inp_result20_mem <= 19'd0;
			value[20] <= 19'd0;
		end
		else
		begin
			if(image_recieved[20] == 1 && reset == 0
					 && max_pooled[20] == 0)
			begin
				en_w_result20_mem <= 1'd1;
				en_r_img20_mem <= 1'd1;
		
				if(inp_result20_mem >= dat_read_img20_mem)
				begin
					inp_result20_mem <= inp_result20_mem;
				end
				if(dat_read_img20_mem > inp_result20_mem)
				begin
					inp_result20_mem <= dat_read_img20_mem;
				end
				if ( 1)
				begin
					addr_r_img20_mem <= (POOLOUT2_var[20]*P2 + P2_var[20])*F_M1 + (POOLOUT1_var[20]*P1 + P1_var[20]);
					addr_w_result20_mem <= POOLOUT1_var[20]*POOLOUT2 + POOLOUT2_var[20];
					value[20] <= dat_read_img20_mem;
					P1_var[20] <= P1_var[20] + 1;
					if (P1_var[20] == 0 && P2_var[20] == 1)
					begin
						we_result20_mem <= 1'd1;
					end
					else begin
						we_result20_mem <= 1'd0;
					end
					if (P1_var[20] >= P1 - 1)
					begin
						P1_var[20] <= 8'd0;
						P2_var[20] <= P2_var[20] + 1;
						if (P2_var[20] >= P2 - 1)
						begin
							P2_var[20] <= 8'd0;
							inp_result20_mem <= 20'b0;
							result20 <= outp_result20_mem;
							POOLOUT1_var[20] <= POOLOUT1_var[20] + 1;
							if (POOLOUT1_var[20] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[20] <= 8'd0;
								POOLOUT2_var[20] <= POOLOUT2_var[20] + 1;
								if(POOLOUT2_var[20] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[20] <= 8'd0;
									en_w_result20_mem <= 1'd1;
									we_result20_mem <= 1'd1;
									addr_w_result20_mem <= 15'd0;
									max_pooled[20] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [21] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[21] <= 8'd0;
			P2_var[21] <= 8'd0;
			POOLOUT1_var[21] <= 3'd0;
			POOLOUT2_var[21] <= 3'd0;
			max_pooled[21] <= 1'd0;
			en_r_img21_mem <= 1'd0;
			addr_r_img21_mem <= 15'd0;
			en_w_result21_mem <= 1'd0;
			we_result21_mem <= 1'd0;
			addr_w_result21_mem <= 15'd0;
			inp_result21_mem <= 19'd0;
			value[21] <= 19'd0;
		end
		else
		begin
			if(image_recieved[21] == 1 && reset == 0
					 && max_pooled[21] == 0)
			begin
				en_w_result21_mem <= 1'd1;
				en_r_img21_mem <= 1'd1;
		
				if(inp_result21_mem >= dat_read_img21_mem)
				begin
					inp_result21_mem <= inp_result21_mem;
				end
				if(dat_read_img21_mem > inp_result21_mem)
				begin
					inp_result21_mem <= dat_read_img21_mem;
				end
				if ( 1)
				begin
					addr_r_img21_mem <= (POOLOUT2_var[21]*P2 + P2_var[21])*F_M1 + (POOLOUT1_var[21]*P1 + P1_var[21]);
					addr_w_result21_mem <= POOLOUT1_var[21]*POOLOUT2 + POOLOUT2_var[21];
					value[21] <= dat_read_img21_mem;
					P1_var[21] <= P1_var[21] + 1;
					if (P1_var[21] == 0 && P2_var[21] == 1)
					begin
						we_result21_mem <= 1'd1;
					end
					else begin
						we_result21_mem <= 1'd0;
					end
					if (P1_var[21] >= P1 - 1)
					begin
						P1_var[21] <= 8'd0;
						P2_var[21] <= P2_var[21] + 1;
						if (P2_var[21] >= P2 - 1)
						begin
							P2_var[21] <= 8'd0;
							inp_result21_mem <= 20'b0;
							result21 <= outp_result21_mem;
							POOLOUT1_var[21] <= POOLOUT1_var[21] + 1;
							if (POOLOUT1_var[21] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[21] <= 8'd0;
								POOLOUT2_var[21] <= POOLOUT2_var[21] + 1;
								if(POOLOUT2_var[21] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[21] <= 8'd0;
									en_w_result21_mem <= 1'd1;
									we_result21_mem <= 1'd1;
									addr_w_result21_mem <= 15'd0;
									max_pooled[21] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [22] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[22] <= 8'd0;
			P2_var[22] <= 8'd0;
			POOLOUT1_var[22] <= 3'd0;
			POOLOUT2_var[22] <= 3'd0;
			max_pooled[22] <= 1'd0;
			en_r_img22_mem <= 1'd0;
			addr_r_img22_mem <= 15'd0;
			en_w_result22_mem <= 1'd0;
			we_result22_mem <= 1'd0;
			addr_w_result22_mem <= 15'd0;
			inp_result22_mem <= 19'd0;
			value[22] <= 19'd0;
		end
		else
		begin
			if(image_recieved[22] == 1 && reset == 0
					 && max_pooled[22] == 0)
			begin
				en_w_result22_mem <= 1'd1;
				en_r_img22_mem <= 1'd1;
		
				if(inp_result22_mem >= dat_read_img22_mem)
				begin
					inp_result22_mem <= inp_result22_mem;
				end
				if(dat_read_img22_mem > inp_result22_mem)
				begin
					inp_result22_mem <= dat_read_img22_mem;
				end
				if ( 1)
				begin
					addr_r_img22_mem <= (POOLOUT2_var[22]*P2 + P2_var[22])*F_M1 + (POOLOUT1_var[22]*P1 + P1_var[22]);
					addr_w_result22_mem <= POOLOUT1_var[22]*POOLOUT2 + POOLOUT2_var[22];
					value[22] <= dat_read_img22_mem;
					P1_var[22] <= P1_var[22] + 1;
					if (P1_var[22] == 0 && P2_var[22] == 1)
					begin
						we_result22_mem <= 1'd1;
					end
					else begin
						we_result22_mem <= 1'd0;
					end
					if (P1_var[22] >= P1 - 1)
					begin
						P1_var[22] <= 8'd0;
						P2_var[22] <= P2_var[22] + 1;
						if (P2_var[22] >= P2 - 1)
						begin
							P2_var[22] <= 8'd0;
							inp_result22_mem <= 20'b0;
							result22 <= outp_result22_mem;
							POOLOUT1_var[22] <= POOLOUT1_var[22] + 1;
							if (POOLOUT1_var[22] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[22] <= 8'd0;
								POOLOUT2_var[22] <= POOLOUT2_var[22] + 1;
								if(POOLOUT2_var[22] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[22] <= 8'd0;
									en_w_result22_mem <= 1'd1;
									we_result22_mem <= 1'd1;
									addr_w_result22_mem <= 15'd0;
									max_pooled[22] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [23] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[23] <= 8'd0;
			P2_var[23] <= 8'd0;
			POOLOUT1_var[23] <= 3'd0;
			POOLOUT2_var[23] <= 3'd0;
			max_pooled[23] <= 1'd0;
			en_r_img23_mem <= 1'd0;
			addr_r_img23_mem <= 15'd0;
			en_w_result23_mem <= 1'd0;
			we_result23_mem <= 1'd0;
			addr_w_result23_mem <= 15'd0;
			inp_result23_mem <= 19'd0;
			value[23] <= 19'd0;
		end
		else
		begin
			if(image_recieved[23] == 1 && reset == 0
					 && max_pooled[23] == 0)
			begin
				en_w_result23_mem <= 1'd1;
				en_r_img23_mem <= 1'd1;
		
				if(inp_result23_mem >= dat_read_img23_mem)
				begin
					inp_result23_mem <= inp_result23_mem;
				end
				if(dat_read_img23_mem > inp_result23_mem)
				begin
					inp_result23_mem <= dat_read_img23_mem;
				end
				if ( 1)
				begin
					addr_r_img23_mem <= (POOLOUT2_var[23]*P2 + P2_var[23])*F_M1 + (POOLOUT1_var[23]*P1 + P1_var[23]);
					addr_w_result23_mem <= POOLOUT1_var[23]*POOLOUT2 + POOLOUT2_var[23];
					value[23] <= dat_read_img23_mem;
					P1_var[23] <= P1_var[23] + 1;
					if (P1_var[23] == 0 && P2_var[23] == 1)
					begin
						we_result23_mem <= 1'd1;
					end
					else begin
						we_result23_mem <= 1'd0;
					end
					if (P1_var[23] >= P1 - 1)
					begin
						P1_var[23] <= 8'd0;
						P2_var[23] <= P2_var[23] + 1;
						if (P2_var[23] >= P2 - 1)
						begin
							P2_var[23] <= 8'd0;
							inp_result23_mem <= 20'b0;
							result23 <= outp_result23_mem;
							POOLOUT1_var[23] <= POOLOUT1_var[23] + 1;
							if (POOLOUT1_var[23] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[23] <= 8'd0;
								POOLOUT2_var[23] <= POOLOUT2_var[23] + 1;
								if(POOLOUT2_var[23] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[23] <= 8'd0;
									en_w_result23_mem <= 1'd1;
									we_result23_mem <= 1'd1;
									addr_w_result23_mem <= 15'd0;
									max_pooled[23] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [24] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[24] <= 8'd0;
			P2_var[24] <= 8'd0;
			POOLOUT1_var[24] <= 3'd0;
			POOLOUT2_var[24] <= 3'd0;
			max_pooled[24] <= 1'd0;
			en_r_img24_mem <= 1'd0;
			addr_r_img24_mem <= 15'd0;
			en_w_result24_mem <= 1'd0;
			we_result24_mem <= 1'd0;
			addr_w_result24_mem <= 15'd0;
			inp_result24_mem <= 19'd0;
			value[24] <= 19'd0;
		end
		else
		begin
			if(image_recieved[24] == 1 && reset == 0
					 && max_pooled[24] == 0)
			begin
				en_w_result24_mem <= 1'd1;
				en_r_img24_mem <= 1'd1;
		
				if(inp_result24_mem >= dat_read_img24_mem)
				begin
					inp_result24_mem <= inp_result24_mem;
				end
				if(dat_read_img24_mem > inp_result24_mem)
				begin
					inp_result24_mem <= dat_read_img24_mem;
				end
				if ( 1)
				begin
					addr_r_img24_mem <= (POOLOUT2_var[24]*P2 + P2_var[24])*F_M1 + (POOLOUT1_var[24]*P1 + P1_var[24]);
					addr_w_result24_mem <= POOLOUT1_var[24]*POOLOUT2 + POOLOUT2_var[24];
					value[24] <= dat_read_img24_mem;
					P1_var[24] <= P1_var[24] + 1;
					if (P1_var[24] == 0 && P2_var[24] == 1)
					begin
						we_result24_mem <= 1'd1;
					end
					else begin
						we_result24_mem <= 1'd0;
					end
					if (P1_var[24] >= P1 - 1)
					begin
						P1_var[24] <= 8'd0;
						P2_var[24] <= P2_var[24] + 1;
						if (P2_var[24] >= P2 - 1)
						begin
							P2_var[24] <= 8'd0;
							inp_result24_mem <= 20'b0;
							result24 <= outp_result24_mem;
							POOLOUT1_var[24] <= POOLOUT1_var[24] + 1;
							if (POOLOUT1_var[24] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[24] <= 8'd0;
								POOLOUT2_var[24] <= POOLOUT2_var[24] + 1;
								if(POOLOUT2_var[24] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[24] <= 8'd0;
									en_w_result24_mem <= 1'd1;
									we_result24_mem <= 1'd1;
									addr_w_result24_mem <= 15'd0;
									max_pooled[24] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [25] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[25] <= 8'd0;
			P2_var[25] <= 8'd0;
			POOLOUT1_var[25] <= 3'd0;
			POOLOUT2_var[25] <= 3'd0;
			max_pooled[25] <= 1'd0;
			en_r_img25_mem <= 1'd0;
			addr_r_img25_mem <= 15'd0;
			en_w_result25_mem <= 1'd0;
			we_result25_mem <= 1'd0;
			addr_w_result25_mem <= 15'd0;
			inp_result25_mem <= 19'd0;
			value[25] <= 19'd0;
		end
		else
		begin
			if(image_recieved[25] == 1 && reset == 0
					 && max_pooled[25] == 0)
			begin
				en_w_result25_mem <= 1'd1;
				en_r_img25_mem <= 1'd1;
		
				if(inp_result25_mem >= dat_read_img25_mem)
				begin
					inp_result25_mem <= inp_result25_mem;
				end
				if(dat_read_img25_mem > inp_result25_mem)
				begin
					inp_result25_mem <= dat_read_img25_mem;
				end
				if ( 1)
				begin
					addr_r_img25_mem <= (POOLOUT2_var[25]*P2 + P2_var[25])*F_M1 + (POOLOUT1_var[25]*P1 + P1_var[25]);
					addr_w_result25_mem <= POOLOUT1_var[25]*POOLOUT2 + POOLOUT2_var[25];
					value[25] <= dat_read_img25_mem;
					P1_var[25] <= P1_var[25] + 1;
					if (P1_var[25] == 0 && P2_var[25] == 1)
					begin
						we_result25_mem <= 1'd1;
					end
					else begin
						we_result25_mem <= 1'd0;
					end
					if (P1_var[25] >= P1 - 1)
					begin
						P1_var[25] <= 8'd0;
						P2_var[25] <= P2_var[25] + 1;
						if (P2_var[25] >= P2 - 1)
						begin
							P2_var[25] <= 8'd0;
							inp_result25_mem <= 20'b0;
							result25 <= outp_result25_mem;
							POOLOUT1_var[25] <= POOLOUT1_var[25] + 1;
							if (POOLOUT1_var[25] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[25] <= 8'd0;
								POOLOUT2_var[25] <= POOLOUT2_var[25] + 1;
								if(POOLOUT2_var[25] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[25] <= 8'd0;
									en_w_result25_mem <= 1'd1;
									we_result25_mem <= 1'd1;
									addr_w_result25_mem <= 15'd0;
									max_pooled[25] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [26] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[26] <= 8'd0;
			P2_var[26] <= 8'd0;
			POOLOUT1_var[26] <= 3'd0;
			POOLOUT2_var[26] <= 3'd0;
			max_pooled[26] <= 1'd0;
			en_r_img26_mem <= 1'd0;
			addr_r_img26_mem <= 15'd0;
			en_w_result26_mem <= 1'd0;
			we_result26_mem <= 1'd0;
			addr_w_result26_mem <= 15'd0;
			inp_result26_mem <= 19'd0;
			value[26] <= 19'd0;
		end
		else
		begin
			if(image_recieved[26] == 1 && reset == 0
					 && max_pooled[26] == 0)
			begin
				en_w_result26_mem <= 1'd1;
				en_r_img26_mem <= 1'd1;
		
				if(inp_result26_mem >= dat_read_img26_mem)
				begin
					inp_result26_mem <= inp_result26_mem;
				end
				if(dat_read_img26_mem > inp_result26_mem)
				begin
					inp_result26_mem <= dat_read_img26_mem;
				end
				if ( 1)
				begin
					addr_r_img26_mem <= (POOLOUT2_var[26]*P2 + P2_var[26])*F_M1 + (POOLOUT1_var[26]*P1 + P1_var[26]);
					addr_w_result26_mem <= POOLOUT1_var[26]*POOLOUT2 + POOLOUT2_var[26];
					value[26] <= dat_read_img26_mem;
					P1_var[26] <= P1_var[26] + 1;
					if (P1_var[26] == 0 && P2_var[26] == 1)
					begin
						we_result26_mem <= 1'd1;
					end
					else begin
						we_result26_mem <= 1'd0;
					end
					if (P1_var[26] >= P1 - 1)
					begin
						P1_var[26] <= 8'd0;
						P2_var[26] <= P2_var[26] + 1;
						if (P2_var[26] >= P2 - 1)
						begin
							P2_var[26] <= 8'd0;
							inp_result26_mem <= 20'b0;
							result26 <= outp_result26_mem;
							POOLOUT1_var[26] <= POOLOUT1_var[26] + 1;
							if (POOLOUT1_var[26] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[26] <= 8'd0;
								POOLOUT2_var[26] <= POOLOUT2_var[26] + 1;
								if(POOLOUT2_var[26] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[26] <= 8'd0;
									en_w_result26_mem <= 1'd1;
									we_result26_mem <= 1'd1;
									addr_w_result26_mem <= 15'd0;
									max_pooled[26] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [27] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[27] <= 8'd0;
			P2_var[27] <= 8'd0;
			POOLOUT1_var[27] <= 3'd0;
			POOLOUT2_var[27] <= 3'd0;
			max_pooled[27] <= 1'd0;
			en_r_img27_mem <= 1'd0;
			addr_r_img27_mem <= 15'd0;
			en_w_result27_mem <= 1'd0;
			we_result27_mem <= 1'd0;
			addr_w_result27_mem <= 15'd0;
			inp_result27_mem <= 19'd0;
			value[27] <= 19'd0;
		end
		else
		begin
			if(image_recieved[27] == 1 && reset == 0
					 && max_pooled[27] == 0)
			begin
				en_w_result27_mem <= 1'd1;
				en_r_img27_mem <= 1'd1;
		
				if(inp_result27_mem >= dat_read_img27_mem)
				begin
					inp_result27_mem <= inp_result27_mem;
				end
				if(dat_read_img27_mem > inp_result27_mem)
				begin
					inp_result27_mem <= dat_read_img27_mem;
				end
				if ( 1)
				begin
					addr_r_img27_mem <= (POOLOUT2_var[27]*P2 + P2_var[27])*F_M1 + (POOLOUT1_var[27]*P1 + P1_var[27]);
					addr_w_result27_mem <= POOLOUT1_var[27]*POOLOUT2 + POOLOUT2_var[27];
					value[27] <= dat_read_img27_mem;
					P1_var[27] <= P1_var[27] + 1;
					if (P1_var[27] == 0 && P2_var[27] == 1)
					begin
						we_result27_mem <= 1'd1;
					end
					else begin
						we_result27_mem <= 1'd0;
					end
					if (P1_var[27] >= P1 - 1)
					begin
						P1_var[27] <= 8'd0;
						P2_var[27] <= P2_var[27] + 1;
						if (P2_var[27] >= P2 - 1)
						begin
							P2_var[27] <= 8'd0;
							inp_result27_mem <= 20'b0;
							result27 <= outp_result27_mem;
							POOLOUT1_var[27] <= POOLOUT1_var[27] + 1;
							if (POOLOUT1_var[27] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[27] <= 8'd0;
								POOLOUT2_var[27] <= POOLOUT2_var[27] + 1;
								if(POOLOUT2_var[27] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[27] <= 8'd0;
									en_w_result27_mem <= 1'd1;
									we_result27_mem <= 1'd1;
									addr_w_result27_mem <= 15'd0;
									max_pooled[27] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [28] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[28] <= 8'd0;
			P2_var[28] <= 8'd0;
			POOLOUT1_var[28] <= 3'd0;
			POOLOUT2_var[28] <= 3'd0;
			max_pooled[28] <= 1'd0;
			en_r_img28_mem <= 1'd0;
			addr_r_img28_mem <= 15'd0;
			en_w_result28_mem <= 1'd0;
			we_result28_mem <= 1'd0;
			addr_w_result28_mem <= 15'd0;
			inp_result28_mem <= 19'd0;
			value[28] <= 19'd0;
		end
		else
		begin
			if(image_recieved[28] == 1 && reset == 0
					 && max_pooled[28] == 0)
			begin
				en_w_result28_mem <= 1'd1;
				en_r_img28_mem <= 1'd1;
		
				if(inp_result28_mem >= dat_read_img28_mem)
				begin
					inp_result28_mem <= inp_result28_mem;
				end
				if(dat_read_img28_mem > inp_result28_mem)
				begin
					inp_result28_mem <= dat_read_img28_mem;
				end
				if ( 1)
				begin
					addr_r_img28_mem <= (POOLOUT2_var[28]*P2 + P2_var[28])*F_M1 + (POOLOUT1_var[28]*P1 + P1_var[28]);
					addr_w_result28_mem <= POOLOUT1_var[28]*POOLOUT2 + POOLOUT2_var[28];
					value[28] <= dat_read_img28_mem;
					P1_var[28] <= P1_var[28] + 1;
					if (P1_var[28] == 0 && P2_var[28] == 1)
					begin
						we_result28_mem <= 1'd1;
					end
					else begin
						we_result28_mem <= 1'd0;
					end
					if (P1_var[28] >= P1 - 1)
					begin
						P1_var[28] <= 8'd0;
						P2_var[28] <= P2_var[28] + 1;
						if (P2_var[28] >= P2 - 1)
						begin
							P2_var[28] <= 8'd0;
							inp_result28_mem <= 20'b0;
							result28 <= outp_result28_mem;
							POOLOUT1_var[28] <= POOLOUT1_var[28] + 1;
							if (POOLOUT1_var[28] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[28] <= 8'd0;
								POOLOUT2_var[28] <= POOLOUT2_var[28] + 1;
								if(POOLOUT2_var[28] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[28] <= 8'd0;
									en_w_result28_mem <= 1'd1;
									we_result28_mem <= 1'd1;
									addr_w_result28_mem <= 15'd0;
									max_pooled[28] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [29] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[29] <= 8'd0;
			P2_var[29] <= 8'd0;
			POOLOUT1_var[29] <= 3'd0;
			POOLOUT2_var[29] <= 3'd0;
			max_pooled[29] <= 1'd0;
			en_r_img29_mem <= 1'd0;
			addr_r_img29_mem <= 15'd0;
			en_w_result29_mem <= 1'd0;
			we_result29_mem <= 1'd0;
			addr_w_result29_mem <= 15'd0;
			inp_result29_mem <= 19'd0;
			value[29] <= 19'd0;
		end
		else
		begin
			if(image_recieved[29] == 1 && reset == 0
					 && max_pooled[29] == 0)
			begin
				en_w_result29_mem <= 1'd1;
				en_r_img29_mem <= 1'd1;
		
				if(inp_result29_mem >= dat_read_img29_mem)
				begin
					inp_result29_mem <= inp_result29_mem;
				end
				if(dat_read_img29_mem > inp_result29_mem)
				begin
					inp_result29_mem <= dat_read_img29_mem;
				end
				if ( 1)
				begin
					addr_r_img29_mem <= (POOLOUT2_var[29]*P2 + P2_var[29])*F_M1 + (POOLOUT1_var[29]*P1 + P1_var[29]);
					addr_w_result29_mem <= POOLOUT1_var[29]*POOLOUT2 + POOLOUT2_var[29];
					value[29] <= dat_read_img29_mem;
					P1_var[29] <= P1_var[29] + 1;
					if (P1_var[29] == 0 && P2_var[29] == 1)
					begin
						we_result29_mem <= 1'd1;
					end
					else begin
						we_result29_mem <= 1'd0;
					end
					if (P1_var[29] >= P1 - 1)
					begin
						P1_var[29] <= 8'd0;
						P2_var[29] <= P2_var[29] + 1;
						if (P2_var[29] >= P2 - 1)
						begin
							P2_var[29] <= 8'd0;
							inp_result29_mem <= 20'b0;
							result29 <= outp_result29_mem;
							POOLOUT1_var[29] <= POOLOUT1_var[29] + 1;
							if (POOLOUT1_var[29] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[29] <= 8'd0;
								POOLOUT2_var[29] <= POOLOUT2_var[29] + 1;
								if(POOLOUT2_var[29] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[29] <= 8'd0;
									en_w_result29_mem <= 1'd1;
									we_result29_mem <= 1'd1;
									addr_w_result29_mem <= 15'd0;
									max_pooled[29] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [30] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[30] <= 8'd0;
			P2_var[30] <= 8'd0;
			POOLOUT1_var[30] <= 3'd0;
			POOLOUT2_var[30] <= 3'd0;
			max_pooled[30] <= 1'd0;
			en_r_img30_mem <= 1'd0;
			addr_r_img30_mem <= 15'd0;
			en_w_result30_mem <= 1'd0;
			we_result30_mem <= 1'd0;
			addr_w_result30_mem <= 15'd0;
			inp_result30_mem <= 19'd0;
			value[30] <= 19'd0;
		end
		else
		begin
			if(image_recieved[30] == 1 && reset == 0
					 && max_pooled[30] == 0)
			begin
				en_w_result30_mem <= 1'd1;
				en_r_img30_mem <= 1'd1;
		
				if(inp_result30_mem >= dat_read_img30_mem)
				begin
					inp_result30_mem <= inp_result30_mem;
				end
				if(dat_read_img30_mem > inp_result30_mem)
				begin
					inp_result30_mem <= dat_read_img30_mem;
				end
				if ( 1)
				begin
					addr_r_img30_mem <= (POOLOUT2_var[30]*P2 + P2_var[30])*F_M1 + (POOLOUT1_var[30]*P1 + P1_var[30]);
					addr_w_result30_mem <= POOLOUT1_var[30]*POOLOUT2 + POOLOUT2_var[30];
					value[30] <= dat_read_img30_mem;
					P1_var[30] <= P1_var[30] + 1;
					if (P1_var[30] == 0 && P2_var[30] == 1)
					begin
						we_result30_mem <= 1'd1;
					end
					else begin
						we_result30_mem <= 1'd0;
					end
					if (P1_var[30] >= P1 - 1)
					begin
						P1_var[30] <= 8'd0;
						P2_var[30] <= P2_var[30] + 1;
						if (P2_var[30] >= P2 - 1)
						begin
							P2_var[30] <= 8'd0;
							inp_result30_mem <= 20'b0;
							result30 <= outp_result30_mem;
							POOLOUT1_var[30] <= POOLOUT1_var[30] + 1;
							if (POOLOUT1_var[30] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[30] <= 8'd0;
								POOLOUT2_var[30] <= POOLOUT2_var[30] + 1;
								if(POOLOUT2_var[30] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[30] <= 8'd0;
									en_w_result30_mem <= 1'd1;
									we_result30_mem <= 1'd1;
									addr_w_result30_mem <= 15'd0;
									max_pooled[30] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
    
/////////////////
// max_pooling [31] 
	always@(posedge clk)
	begin
		if(reset == 1)
		begin
			P1_var[31] <= 8'd0;
			P2_var[31] <= 8'd0;
			POOLOUT1_var[31] <= 3'd0;
			POOLOUT2_var[31] <= 3'd0;
			max_pooled[31] <= 1'd0;
			en_r_img31_mem <= 1'd0;
			addr_r_img31_mem <= 15'd0;
			en_w_result31_mem <= 1'd0;
			we_result31_mem <= 1'd0;
			addr_w_result31_mem <= 15'd0;
			inp_result31_mem <= 19'd0;
			value[31] <= 19'd0;
		end
		else
		begin
			if(image_recieved[31] == 1 && reset == 0
					 && max_pooled[31] == 0)
			begin
				en_w_result31_mem <= 1'd1;
				en_r_img31_mem <= 1'd1;
		
				if(inp_result31_mem >= dat_read_img31_mem)
				begin
					inp_result31_mem <= inp_result31_mem;
				end
				if(dat_read_img31_mem > inp_result31_mem)
				begin
					inp_result31_mem <= dat_read_img31_mem;
				end
				if ( 1)
				begin
					addr_r_img31_mem <= (POOLOUT2_var[31]*P2 + P2_var[31])*F_M1 + (POOLOUT1_var[31]*P1 + P1_var[31]);
					addr_w_result31_mem <= POOLOUT1_var[31]*POOLOUT2 + POOLOUT2_var[31];
					value[31] <= dat_read_img31_mem;
					P1_var[31] <= P1_var[31] + 1;
					if (P1_var[31] == 0 && P2_var[31] == 1)
					begin
						we_result31_mem <= 1'd1;
					end
					else begin
						we_result31_mem <= 1'd0;
					end
					if (P1_var[31] >= P1 - 1)
					begin
						P1_var[31] <= 8'd0;
						P2_var[31] <= P2_var[31] + 1;
						if (P2_var[31] >= P2 - 1)
						begin
							P2_var[31] <= 8'd0;
							inp_result31_mem <= 20'b0;
							result31 <= outp_result31_mem;
							POOLOUT1_var[31] <= POOLOUT1_var[31] + 1;
							if (POOLOUT1_var[31] >= POOLOUT1 - 1)
							begin
								POOLOUT1_var[31] <= 8'd0;
								POOLOUT2_var[31] <= POOLOUT2_var[31] + 1;
								if(POOLOUT2_var[31] >= POOLOUT2 - 1)
								begin
									POOLOUT2_var[31] <= 8'd0;
									en_w_result31_mem <= 1'd1;
									we_result31_mem <= 1'd1;
									addr_w_result31_mem <= 15'd0;
									max_pooled[31] = 1;
								end
							end
						end
					end
				end
			end
		end
	end
/**/
endmodule