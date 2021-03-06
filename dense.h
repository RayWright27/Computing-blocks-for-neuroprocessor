#define SC_INCLUDE_FX
#include <systemc.h>
#include <macro.h>
#include <iomanip> 

SC_MODULE(dense) {
	SC_HAS_PROCESS(dense);

	int 	IN_param;
	int		DENSE_COEFF_param;
	int		DENSE_COEFF1_param;
	int		DENSE_COEFF2_param;
	int		BIASES_param;
	int		OUT_param;
	char*	module_name;
	int 	func;

	//?????
	sc_in<bool> 	clk, rst;

	sc_in<bool> 	input_vld;
	sc_out<bool> 	input_rdy;

	sc_in<bool>		coeff_vld;
	sc_out<bool>	coeff_rdy;

	sc_in<bool>		biases_vld;
	sc_out<bool>	biases_rdy;

	sc_in<bool>		dense_result_rdy_tb;
	sc_in<bool>		dense_result_rdy_next;
	sc_out<bool>	dense_result_vld_tb;
	sc_out<bool>	dense_result_vld_next;

	sc_in<sc_fixed<W_LEN_i, I_LEN_i>>	input;
	sc_in<sc_fixed<W_LEN_w, I_LEN_w>>	coeff;
	sc_in<sc_fixed<W_LEN_w, I_LEN_w>>	biases;
	sc_out<sc_fixed<W_LEN_i, I_LEN_i>>	dense_result_tb;
	sc_out<sc_fixed<W_LEN_i, I_LEN_i>>	dense_result_next;

	sc_logic		input_recieved = sc_logic(0);
	sc_logic		coeff_recieved = sc_logic(0);
	sc_logic		biases_recieved = sc_logic(0);
	sc_logic		dense_done = sc_logic(0);
	sc_logic		dense_result_sent_tb = sc_logic(0);
	sc_logic		dense_result_sent_next = sc_logic(0);
	
	sc_fixed<W_LEN_i, I_LEN_i>*			dense_input;
	sc_fixed<W_LEN_w, I_LEN_w>**		coeff_arr;
	sc_fixed<W_LEN_w, I_LEN_w>* 		coeff_flattened;
	sc_fixed<W_LEN_w, I_LEN_w>*			biases_arr;
	sc_fixed<W_LEN_i, I_LEN_i>*			dense_result_arr;
	sc_fixed<W_LEN_s, I_LEN_s>*			dense_result_arr_2;
	sc_fixed<W_LEN_i, I_LEN_i>*			dense_result_arr_3;


	void recieve_input(void);
	void recieve_coeff(void);
	void recieve_biases(void);
	void dense_func(void);
	void send_to_dri_tb(void);
	void send_to_next(void);

	dense(sc_module_name module_name, int param1, int param2, int param3, 
	int param4, int param5, int param6, int param7):sc_module(module_name), IN_param(param1), 
	DENSE_COEFF1_param(param2), DENSE_COEFF2_param(param3), DENSE_COEFF_param(param4),
	BIASES_param(param5), OUT_param(param6), func(param7)
	{
		cout<<"------------------------------"<< module_name <<"["<<this<<"]"<< "-------------------------------"<<endl;
		
		coeff_flattened = new sc_fixed<W_LEN_w, I_LEN_w>[DENSE_COEFF_param];
		dense_input = new sc_fixed<W_LEN_i, I_LEN_i>[IN_param];
		biases_arr = new sc_fixed<W_LEN_w, I_LEN_w>[BIASES_param];
		dense_result_arr = new sc_fixed<W_LEN_i, I_LEN_i>[OUT_param];
		dense_result_arr_2 = new sc_fixed<W_LEN_s, I_LEN_s>[OUT_param];
		dense_result_arr_3 = new sc_fixed<W_LEN_i, I_LEN_i>[OUT_param];

		coeff_arr = new sc_fixed<W_LEN_w, I_LEN_w>*[DENSE_COEFF1_param];
		for(int k = 0; k < DENSE_COEFF1_param; k++){
			coeff_arr[k] = new sc_fixed<W_LEN_w, I_LEN_w>[DENSE_COEFF2_param];
		}

		SC_THREAD(recieve_input);
		SC_THREAD(recieve_coeff);
		SC_THREAD(recieve_biases);
		SC_THREAD(dense_func);
		SC_THREAD(send_to_dri_tb);
		SC_THREAD(send_to_next);
		reset_signal_is(rst, true);
	}

	~dense(){
		delete[] coeff_flattened;
		delete[] dense_input;
		delete[] biases_arr;
		delete[] dense_result_arr;
		
		for(int k = 0; k < DENSE_COEFF2_param; k++){
			delete[] coeff_arr[k];
		}
		delete[] coeff_arr;
	}
}; 