#include <systemc.h>
#include <macro.h>

SC_MODULE(max_pool) {
	SC_HAS_PROCESS(max_pool);
	//параметры
	int				    P1_param;
	int					P2_param;
	int					F_M1_param;
	int					F_M2_param;
	int					F_M3_param;
	int					POOL_IN_param;
	int					POOLOUT1_param;
	int					POOLOUT2_param;
	int					POOLOUT3_param;
	int					POOL_ED_param;
	int					verbose_param;
	char*				module_name;
	//порты
	sc_in<bool> 		clk, rst;

	sc_in<bool> 		image_vld;
	sc_out<bool> 		image_rdy;

	sc_in<bool> 		max_pool_result_rdy_tb;
	sc_out<bool> 		max_pool_result_vld_tb;
	sc_in<bool> 		max_pool_result_rdy_next;
	sc_out<bool> 		max_pool_result_vld_next;

	sc_in<double> 		image;
	sc_out<double> 		max_pool_result_tb;
	sc_out<double> 		max_pool_result_next;
	

	sc_logic 			image_recieved = sc_logic(0);
	sc_logic 			max_pool_done = sc_logic(0);
	sc_logic			max_pool_result_sent_tb = sc_logic(0);
	sc_logic			max_pool_result_sent_next = sc_logic(0);

	double 				value = 0;
	double* 			featuremap;
	double*** 			featuremap_in;
	double*** 			result;
	double* 			max_pooled;


	double maximum (double a, double b);
	void recieve_image(void);
	void max_pooling(void);
	void send_to_dri_tb(void);
	void send_to_next(void);

	max_pool(sc_module_name module_name, 
			 int param1, int param2, int param3, int param4, int param5, int param6, int param7, int param8, int param9, int param10, bool param11)
			 :sc_module(module_name),
			 P1_param(param1),
			 P2_param(param2),
			 F_M1_param(param3),
			 F_M2_param(param4),
			 F_M3_param(param5),
			 POOL_IN_param(param6),
			 POOLOUT1_param(param7),
			 POOLOUT2_param(param8),
			 POOLOUT3_param(param9),
			 POOL_ED_param(param10),
			 verbose_param(param11)
		{
		cout<<"-------------------------------"<<module_name<<"["<<this<<"]"<< "-------------------------------"<<endl;
		cout<<"размеры 'ядра' пулинга = "<<P1_param<<"x"<<P2_param<<" | входное изображение = "<<F_M1_param<<"x"<<F_M2_param<<"x"<<F_M3_param<<
		" | выходное изображение = "<<POOLOUT1_param<<"x"<<POOLOUT2_param<<"x"<<POOLOUT3_param<<"\n";
		cout<<"------------------------------------------------------------------------------------------------"<<endl<<endl;
		featuremap = new double[POOL_IN_param];

		featuremap_in = new double**[F_M2_param];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in[j] = new double*[F_M1_param];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in[j][i] = new double[F_M3_param];
			}
		}
		result = new double**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result[j] = new double*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result[j][i] = new double[POOLOUT3_param];
			}
		}
		max_pooled = new double[POOL_ED_param];

		SC_THREAD(recieve_image);
		SC_THREAD(max_pooling);
		SC_THREAD(send_to_dri_tb);
		SC_THREAD(send_to_next);
		reset_signal_is(rst, true);
	}

	~max_pool(){
	delete[] featuremap;

	for (int j = 0; j < F_M2_param; j++){
		for (int i = 0; i < F_M1_param; i++){
			delete[] featuremap_in[j][i];
		}
		delete[] featuremap_in[j];
	}
	delete[] featuremap_in;

	for (int j = 0; j < POOLOUT2_param; j++){
		for (int i = 0; i < POOLOUT1_param; i++){
			delete[] result[j][i];
		}
		delete[] result[j];
	}
	delete[] result;

	delete[] max_pooled;
}
};

