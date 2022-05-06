#define SC_INCLUDE_FX
#include <macro.h>
#include <systemc.h>
#include <sysc/kernel/sc_boost.h>
#include <sysc/kernel/sc_spawn.h>
SC_MODULE(conv1_unrlld) {	
	//порты
	int zero_pad = 1;

	sc_in<bool> 	clk, rst;

	static const int ker_port = L1;
	sc_in<bool> 	kernel_vld[ker_port];
	sc_out<bool> 	kernel_rdy[ker_port];

	sc_in<bool> 	image_vld;
	sc_out<bool> 	image_rdy;

	sc_in<bool> 	biases_vld;
	sc_out<bool> 	biases_rdy;

	sc_in<bool> 	conv_2d_result_rdy_tb;
	sc_in<bool> 	conv_2d_result_rdy_next[ker_port];
	sc_out<bool> 	conv_2d_result_vld_tb;
	sc_out<bool> 	conv_2d_result_vld_next[ker_port];

	sc_in<sc_fixed<W_LEN_w, I_LEN_w>> 	biases;
	sc_in<sc_fixed<W_LEN_w, I_LEN_w>> 	kernel[ker_port];
	sc_in<sc_fixed<W_LEN_i, I_LEN_i>> 	image;
	sc_out<sc_fixed<W_LEN_i, I_LEN_i>> 	conv_2d_result_tb;
	sc_out<sc_fixed<W_LEN_i, I_LEN_i>> 	conv_2d_result_next[ker_port];

	sc_logic 		kernel_recieved[ker_port];
	sc_logic 		kernel_recieved_all = sc_logic(0);
	sc_logic 		image_recieved = sc_logic(0);
	sc_logic 		biases_recieved = sc_logic(0);
	sc_logic 		conv_done[ker_port];
	sc_logic		conv_done_all = sc_logic(0);
	sc_logic		conv_result_sent_tb = sc_logic(0);
	sc_logic		conv_result_sent_next[ker_port] = {sc_logic(0)};
	sc_logic		zero_pad_done = sc_logic(0);

	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem1[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem2[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem3[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem4[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem5[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem6[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem7[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem8[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem9[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem10[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem11[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem12[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem13[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem14[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem15[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem16[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem17[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem18[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem19[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem20[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem21[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem22[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem23[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem24[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem25[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem26[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem27[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem28[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem29[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem30[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem31[KER/L1];
	sc_fixed<W_LEN_w, I_LEN_w>			kernel_in_flat_mem32[KER/L1];

	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem1;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem2;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem3;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem4;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem5;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem6;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem7;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem8;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem9;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem10;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem11;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem12;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem13;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem14;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem15;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem16;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem17;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem18;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem19;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem20;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem21;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem22;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem23;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem24;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem25;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem26;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem27;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem28;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem29;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem30;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem31;
	sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in_mem32;/**/
	sc_fixed<W_LEN_i, I_LEN_i>*** 		image_in;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		image_in_padded;
	sc_fixed<W_LEN_w, I_LEN_w>* 		biases_in;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem1;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem2;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem3;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem4;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem5;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem6;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem7;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem8;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem9;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem10;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem11;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem12;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem13;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem14;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem15;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem16;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem17;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem18;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem19;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem20;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem21;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem22;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem23;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem24;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem25;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem26;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem27;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem28;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem29;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem30;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem31;
	sc_fixed<W_LEN_i, I_LEN_i>*** 		result_mem32;

	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat1;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat2;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat3;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat4;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat5;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat6;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat7;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat8;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat9;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat10;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat11;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat12;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat13;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat14;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat15;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat16;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat17;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat18;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat19;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat20;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat21;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat22;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat23;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat24;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat25;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat26;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat27;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat28;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat29;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat30;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat31;
	sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat32;
	sc_fixed<W_LEN_i, I_LEN_i>*			image_in_flattened;
	
	void recieve_image(void);
	void recieve_biases(void);
	void recieve_kernel(int c, sc_fixed<W_LEN_w, I_LEN_w>* kernel_in_flat_mem, 
						sc_fixed<W_LEN_w, I_LEN_w>**** kernel_in_mem); 
	void kernel_wrapper(){
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 0, kernel_in_flat_mem1, kernel_in_mem1));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 1, kernel_in_flat_mem2, kernel_in_mem2));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 2, kernel_in_flat_mem3, kernel_in_mem3));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 3, kernel_in_flat_mem4, kernel_in_mem4));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 4, kernel_in_flat_mem5, kernel_in_mem5));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 5, kernel_in_flat_mem6, kernel_in_mem6));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 6, kernel_in_flat_mem7, kernel_in_mem7));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 7, kernel_in_flat_mem8, kernel_in_mem8));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 8, kernel_in_flat_mem9, kernel_in_mem9));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 9, kernel_in_flat_mem10, kernel_in_mem10));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 10, kernel_in_flat_mem11, kernel_in_mem11));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 11, kernel_in_flat_mem12, kernel_in_mem12));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 12, kernel_in_flat_mem13, kernel_in_mem13));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 13, kernel_in_flat_mem14, kernel_in_mem14));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 14, kernel_in_flat_mem15, kernel_in_mem15));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 15, kernel_in_flat_mem16, kernel_in_mem16));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 16, kernel_in_flat_mem17, kernel_in_mem17));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 17, kernel_in_flat_mem18, kernel_in_mem18));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 18, kernel_in_flat_mem19, kernel_in_mem19));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 19, kernel_in_flat_mem20, kernel_in_mem20));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 20, kernel_in_flat_mem21, kernel_in_mem21));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 21, kernel_in_flat_mem22, kernel_in_mem22));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 22, kernel_in_flat_mem23, kernel_in_mem23));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 23, kernel_in_flat_mem24, kernel_in_mem24));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 24, kernel_in_flat_mem25, kernel_in_mem25));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 25, kernel_in_flat_mem26, kernel_in_mem26));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 26, kernel_in_flat_mem27, kernel_in_mem27));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 27, kernel_in_flat_mem28, kernel_in_mem28));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 28, kernel_in_flat_mem29, kernel_in_mem29));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 29, kernel_in_flat_mem30, kernel_in_mem30));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 30, kernel_in_flat_mem31, kernel_in_mem31));
		sc_spawn(sc_bind(&conv1_unrlld::recieve_kernel, this, 31, kernel_in_flat_mem32, kernel_in_mem32));/**/
		
		 
	}
	void zero_padding(void);
	void convolution(int c, sc_fixed<W_LEN_w, I_LEN_w>**** kernel_in_mem, 
					sc_fixed<W_LEN_i, I_LEN_i>*** result_mem, sc_fixed<W_LEN_i, I_LEN_i>* convolved_mat);
	void convolution_wrapper(void){
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 0, kernel_in_mem1, result_mem1, convolved_mat1));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 1, kernel_in_mem2, result_mem2, convolved_mat2));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 2, kernel_in_mem3, result_mem3, convolved_mat3));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 3, kernel_in_mem4, result_mem4, convolved_mat4));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 4, kernel_in_mem5, result_mem5, convolved_mat5));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 5, kernel_in_mem6, result_mem6, convolved_mat6));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 6, kernel_in_mem7, result_mem7, convolved_mat7));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 7, kernel_in_mem8, result_mem8, convolved_mat8));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 8, kernel_in_mem9, result_mem9, convolved_mat9)); 
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 9, kernel_in_mem10, result_mem10, convolved_mat10));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 10, kernel_in_mem11, result_mem11, convolved_mat11));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 11, kernel_in_mem12, result_mem12, convolved_mat12));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 12, kernel_in_mem13, result_mem13, convolved_mat13));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 13, kernel_in_mem14, result_mem14, convolved_mat14));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 14, kernel_in_mem15, result_mem15, convolved_mat15));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 15, kernel_in_mem16, result_mem16, convolved_mat16));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 16, kernel_in_mem17, result_mem17, convolved_mat17));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 17, kernel_in_mem18, result_mem18, convolved_mat18));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 18, kernel_in_mem19, result_mem19, convolved_mat19));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 19, kernel_in_mem20, result_mem20, convolved_mat20));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 20, kernel_in_mem21, result_mem21, convolved_mat21));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 21, kernel_in_mem22, result_mem22, convolved_mat22));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 22, kernel_in_mem23, result_mem23, convolved_mat23));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 23, kernel_in_mem24, result_mem24, convolved_mat24));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 24, kernel_in_mem25, result_mem25, convolved_mat25));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 25, kernel_in_mem26, result_mem26, convolved_mat26));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 26, kernel_in_mem27, result_mem27, convolved_mat27));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 27, kernel_in_mem28, result_mem28, convolved_mat28));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 28, kernel_in_mem29, result_mem29, convolved_mat29));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 29, kernel_in_mem30, result_mem30, convolved_mat30));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 30, kernel_in_mem31, result_mem31, convolved_mat31));
		sc_spawn(sc_bind(&conv1_unrlld::convolution, this, 31, kernel_in_mem32, result_mem32, convolved_mat32));/**/
		
	}
	void send_to_dri_tb(void);
	void send_to_next_layer(int c, sc_fixed<W_LEN_i, I_LEN_i>* convolved_mat); 
	void send_to_next_layer_wrapper(void){
		sc_spawn(sc_bind(&conv1_unrlld::send_to_next_layer, this, 0, convolved_mat1));
	}

	SC_CTOR(conv1_unrlld){
		
		for(int i = 0; i < ker_port; i++){
			kernel_recieved[i] = sc_logic(0);
		}
		for(int i = 0; i < ker_port; i++){
			conv_done[i] = sc_logic(0);
		}/**/
		
		image_in_padded = new sc_fixed<W_LEN_i, I_LEN_i>**[N2+2*ZERO_PAD];
		for (int j = 0; j < N2+2*ZERO_PAD; j++){
			image_in_padded[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[M2+2*ZERO_PAD];
			for (int i = 0; i < M2 + 2*ZERO_PAD; i++){
				image_in_padded[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[C1];		
			}
		}
		//----------------------------------------------------------------------------------------
		//объявление динамических банков памяти kernel_in: 
		//по одному на каждую выходную карту признаков (L1 штук)
		kernel_in = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[L1];
				}
			}
		}
		
		kernel_in_mem1 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem1[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem1[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem1[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem2 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem2[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem2[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem2[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem3 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem3[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem3[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem3[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem4 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem4[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem4[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem4[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem5 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem5[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem5[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem5[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem6 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem6[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem6[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem6[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem7 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem7[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem7[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem7[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem8 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem8[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem8[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem8[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem9 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem9[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem9[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem9[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem10 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem10[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem10[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem10[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem11 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem11[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem11[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem11[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem12 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem12[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem12[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem12[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem13 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem13[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem13[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem13[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem14 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem14[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem14[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem14[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem15 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem15[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem15[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem15[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem16 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem16[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem16[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem16[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem17 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem17[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem17[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem17[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem18 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem18[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem18[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem18[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem19 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem19[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem19[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem19[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem20 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem20[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem20[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem20[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem21 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem21[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem21[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem21[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem22 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem22[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem22[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem22[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem23 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem23[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem23[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem23[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem24 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem24[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem24[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem24[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem25 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem25[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem25[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem25[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem26 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem26[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem26[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem26[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem27 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem27[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem27[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem27[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem28 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem28[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem28[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem28[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem29 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem29[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem29[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem29[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem30 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem30[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem30[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem30[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem31 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem31[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem31[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem31[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}

		kernel_in_mem32 = new sc_fixed<W_LEN_w, I_LEN_w>***[M1];//выходные
		for (int k = 0; k < M1; k++){
			kernel_in_mem32[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1];//входные
			for (int i=0; i < N1; i++){
				kernel_in_mem32[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1];
				for (int j = 0; j < C1; j++){
					kernel_in_mem32[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[1];
				}
			}
		}
		/**/
		//----------------------------------------------------------------------------------------
		//объявление динамического image_in
		image_in = new sc_fixed<W_LEN_i, I_LEN_i>**[N2];
		for (int j = 0; j < N2; j++){
			image_in[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[M2];
			for (int i = 0; i < M2; i++){
				image_in[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[C1];		
			}
		}
		
		//объявление динамического result
		result = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[L3];
			}
		}

		result_mem1 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem1[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem1[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result_mem2 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem2[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem2[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem3 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem3[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem3[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem4 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem4[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem4[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem5 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem5[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem5[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem6 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem6[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem6[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem7 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem7[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem7[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem8 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem8[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem8[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem9 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem9[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem9[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem10 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem10[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem10[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem11 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem11[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem11[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem12 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem12[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem12[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem13 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem13[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem13[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem14 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem14[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem14[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem15 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem15[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem15[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem16 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem16[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem16[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem17 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem17[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem17[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem18 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem18[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem18[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem19 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem19[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem19[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem20 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem20[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem20[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem21 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem21[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem21[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem22 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem22[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem22[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem23 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem23[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem23[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem24 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem24[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem24[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem25 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem25[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem25[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result_mem26 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem26[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem26[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem27 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem27[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem27[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem28 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem28[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem28[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem29 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem29[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem29[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem30 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem30[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem30[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem31 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem31[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem31[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		
		result_mem32 = new sc_fixed<W_LEN_i, I_LEN_i>**[N3];
		for (int i=0; i<N3;i++){
			result_mem32[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3];
			for (int j=0;j<M3;j++){
				result_mem32[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		biases_in = new sc_fixed<W_LEN_w, I_LEN_w>[BIASES];
		convolved_mat1 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat2 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat3 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat4 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat5 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat6 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat7 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat8 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat9 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat10 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat11 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat12 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat13 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat14 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat15 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat16 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat17 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat18 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat19 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat20 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat21 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat22 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat23 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat24 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat25 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat26 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat27 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat28 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat29 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat30 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat31 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
		convolved_mat32 = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED/L1];
				
		image_in_flattened = new sc_fixed<W_LEN_i, I_LEN_i>[IMG];//вектор, принимающий значения из порта
		
		SC_THREAD(kernel_wrapper);
		SC_THREAD(recieve_image);
		SC_THREAD(recieve_biases);
		SC_THREAD(zero_padding);
		SC_THREAD(convolution_wrapper);
		//SC_THREAD(send_to_dri_tb); 
		SC_THREAD(send_to_next_layer_wrapper);
		/**/
//			reset_signal_is(rst, true);
	}

	~conv1_unrlld(){
		for (int k=0; k<M1;k++){
			for (int i=0; i<N1;i++){
				for (int j=0;j<C1;j++){
					delete[] kernel_in[k][i][j];
				}
				delete[] kernel_in[k][i];
			}
			delete[] kernel_in[k];
		}
		delete[] kernel_in;

		for (int j = 0; j < N2; j++){
			for (int i = 0; i < M2; i++){
				delete[] image_in[j][i];
			}
			delete[] image_in[j];
		}
		delete[] image_in;
/*
		for (int j = 0; j < N2; j++){
			for (int i = 0; i < M2; i++){
				delete[] image_in_padded[j][i];
			}
			delete[] image_in_padded[j];
		}
		delete[] image_in_padded;
*/
		delete[] biases_in;

		for (int i=0; i<N3;i++){
			for (int j=0;j<M3;j++){
				delete[] result[i][j];
			}
			delete[] result[i];
		}
		delete[] result;

		delete[] convolved_mat1;
		delete[] convolved_mat2;
		delete[] convolved_mat3;
		delete[] convolved_mat4;
		delete[] convolved_mat5;
		delete[] convolved_mat6;
		delete[] convolved_mat7;
		delete[] convolved_mat8;
		delete[] convolved_mat9;
		delete[] convolved_mat10;
		delete[] convolved_mat11;
		delete[] convolved_mat12;
		delete[] convolved_mat13;
		delete[] convolved_mat14;
		delete[] convolved_mat15;
		delete[] convolved_mat16;
		delete[] convolved_mat17;
		delete[] convolved_mat18;
		delete[] convolved_mat19;
		delete[] convolved_mat20;
		delete[] convolved_mat21;
		delete[] convolved_mat22;
		delete[] convolved_mat23; 
		delete[] convolved_mat24;
		delete[] convolved_mat25;
		delete[] convolved_mat26;
		delete[] convolved_mat27;
		delete[] convolved_mat28;
		delete[] convolved_mat30;
		delete[] convolved_mat31;
		delete[] convolved_mat32;
		delete[] image_in_flattened;
	} 
};


		
	