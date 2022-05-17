#define SC_INCLUDE_FX
#include <macro.h>
#include <systemc.h>
	SC_MODULE(conv) {
		SC_HAS_PROCESS(conv);
		int 			M1_param;
		int 			L1_param;
		int 			N1_param;
		int 			KER_param;
		int				M2_param;
		int 			N2_param;
		int 			C1_param;
		int 			IMG_param;
		int 			M3_param;
		int 			N3_param;
		int 			L3_param;
		int 			CONV_ED_param;
		int 			BIASES_param;
		int				ZERO_PAD_param;
		bool 			verbose;
		bool			zero_pad;
		char* 			module_name;
		
		//порты
		sc_in<bool> 	clk, rst;

		sc_in<bool> 	kernel_vld;
		sc_out<bool> 	kernel_rdy;

		sc_in<bool> 	image_vld;
		sc_out<bool> 	image_rdy;

		sc_in<bool> 	biases_vld;
		sc_out<bool> 	biases_rdy;

		sc_in<bool> 	conv_2d_result_rdy_tb;
		sc_in<bool> 	conv_2d_result_rdy_next;
		sc_out<bool> 	conv_2d_result_vld_tb;
		sc_out<bool> 	conv_2d_result_vld_next;

		sc_in<sc_fixed<W_LEN_w, I_LEN_w>> 	biases;
		sc_in<sc_fixed<W_LEN_w, I_LEN_w>> 	kernel;
		sc_in<sc_fixed<W_LEN_i, I_LEN_i>> 	image;
		sc_out<sc_fixed<W_LEN_i, I_LEN_i>> 	conv_2d_result_tb;
		sc_out<sc_fixed<W_LEN_i, I_LEN_i>> 	conv_2d_result_next;

		sc_logic 		kernel_recieved = sc_logic(0);
		sc_logic 		image_recieved = sc_logic(0);
		sc_logic 		biases_recieved = sc_logic(0);
		sc_logic 		conv_done = sc_logic(0);
		sc_logic		conv_result_sent_tb = sc_logic(0);
		sc_logic		conv_result_sent_next = sc_logic(0);
		sc_logic		zero_pad_done = sc_logic(0);

		
		sc_fixed<W_LEN_w, I_LEN_w>**** 		kernel_in;//указатель на динамический массив т.к. в С++ недоступна инициализация массива переменной длинны
		sc_fixed<W_LEN_i, I_LEN_i>*** 		image_in;
		sc_fixed<W_LEN_i, I_LEN_i>*** 		image_in_padded;
		sc_fixed<W_LEN_w, I_LEN_w>* 		biases_in;
		sc_fixed<W_LEN_i, I_LEN_i>*** 		result;
		sc_fixed<W_LEN_i, I_LEN_i>* 		convolved_mat;
		sc_fixed<W_LEN_i, I_LEN_i>*			image_in_flattened;
		
		void recieve_image(void);
		void recieve_biases(void);
		void recieve_kernel(void);
		void zero_padding(void);
		void convolution(void);
		void send_to_dri_tb(void);
		void send_to_next_layer(void);

		conv(sc_module_name module_name, int param1, int param2, int param3, int param4,// кастомный конструктор с параметрами для SystemC модуля 
			int param5, int param6, int param7,	int param8, int param9, int param10, int param11, int param12, int param13, int param14 ,bool param15, bool param16)
			:sc_module(module_name),
			M1_param(param1),
			N1_param(param2),
			L1_param(param3), 
			KER_param(param4),
			M2_param(param5),
			N2_param(param6),
			C1_param(param7),
			IMG_param(param8),
			M3_param(param9),
			N3_param(param10),
			L3_param(param11),
			CONV_ED_param(param12),
			BIASES_param(param13),
			ZERO_PAD_param(param14),
			verbose(param15),
			zero_pad(param16)
		{
			cout<<"------------------------------"<< module_name <<"["<<this<<"]"<< "-------------------------------"<<endl;
			cout<<"N1_param="<<N1_param<<" M1_param="<<M1_param<<" N2_param="<<N2_param<<" M2_param="<<M2_param
			<<"\n C1_param="<<C1_param<<" N3_param="<<N3_param<<" M3_param="<<M3_param<<" L1_param="<<L1_param<<endl
			<<"IMG_param="<<IMG_param<<" BIASES_param="<<BIASES_param<<" KER_param="<<KER_param<<" zero_pad="<<zero_pad<<endl;
			cout<<"-------------------------------------------------------------------------------------------------"<<endl<<endl;	
		//	cout<<M1_param<<" "<<L1_param<<" "<<N1_param<<" "<< endl;
			
			image_in_padded = new sc_fixed<W_LEN_i, I_LEN_i>**[N2_param+2*ZERO_PAD_param];
			for (int j = 0; j < N2_param+2*ZERO_PAD_param; j++){
				image_in_padded[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[M2_param+2*ZERO_PAD_param];
				for (int i = 0; i < M2_param + 2*ZERO_PAD_param; i++){
					image_in_padded[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[C1_param];		
				}
			}/*
			*/
			//объявление динамического kernel_in
			kernel_in = new sc_fixed<W_LEN_w, I_LEN_w>***[M1_param];//выходные
			for (int k = 0; k < M1_param; k++){
				kernel_in[k] = new sc_fixed<W_LEN_w, I_LEN_w>**[N1_param];//входные
				for (int i=0; i < N1_param; i++){
					kernel_in[k][i] = new sc_fixed<W_LEN_w, I_LEN_w>*[C1_param];
					for (int j = 0; j < C1_param; j++){
						kernel_in[k][i][j] = new sc_fixed<W_LEN_w, I_LEN_w>[L1_param];
					}
				}
			}
			//объявление динамического image_in
			image_in = new sc_fixed<W_LEN_i, I_LEN_i>**[N2_param];
			for (int j = 0; j < N2_param; j++){
				image_in[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[M2_param];
				for (int i = 0; i < M2_param; i++){
					image_in[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[C1_param];		
				}
			}
			
			//объявление динамического result
			result = new sc_fixed<W_LEN_i, I_LEN_i>**[N3_param];
			for (int i=0; i<N3_param;i++){
				result[i] = new sc_fixed<W_LEN_i, I_LEN_i>*[M3_param];
				for (int j=0;j<M3_param;j++){
					result[i][j] = new sc_fixed<W_LEN_i, I_LEN_i>[L3_param];
				}
			}

			biases_in = new sc_fixed<W_LEN_w, I_LEN_w>[BIASES_param];
			convolved_mat = new sc_fixed<W_LEN_i, I_LEN_i>[CONV_ED_param];

			image_in_flattened = new sc_fixed<W_LEN_i, I_LEN_i>[IMG_param];//вектор, принимающий значения из порта
			
			SC_THREAD(recieve_kernel);
			
			SC_THREAD(recieve_image);
			
			SC_THREAD(recieve_biases);
//			SC_METHOD(recieve_biases);
//			sensitive<<clk.pos();
			SC_THREAD(zero_padding);
			SC_METHOD(convolution);
			sensitive<<clk.pos();
			SC_THREAD(send_to_dri_tb); 
			SC_THREAD(send_to_next_layer);/**/
//			reset_signal_is(rst, true);
		}

		~conv(){
			for (int k=0; k<M1_param;k++){
				for (int i=0; i<N1_param;i++){
					for (int j=0;j<C1_param;j++){
						delete[] kernel_in[k][i][j];
					}
					delete[] kernel_in[k][i];
				}
				delete[] kernel_in[k];
			}
			delete[] kernel_in;

			for (int j = 0; j < N2_param; j++){
				for (int i = 0; i < M2_param; i++){
					delete[] image_in[j][i];
				}
				delete[] image_in[j];
			}
			delete[] image_in;
/*
			for (int j = 0; j < N2_param; j++){
				for (int i = 0; i < M2_param; i++){
					delete[] image_in_padded[j][i];
				}
				delete[] image_in_padded[j];
			}
			delete[] image_in_padded;
*/
			delete[] biases_in;

			for (int i=0; i<N3_param;i++){
				for (int j=0;j<M3_param;j++){
					delete[] result[i][j];
				}
				delete[] result[i];
			}
			delete[] result;

			delete[] convolved_mat;
			delete[] image_in_flattened;
		} 
	};


		
	