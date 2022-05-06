#define SC_INCLUDE_FX
#include <systemc.h>
#include <macro.h>
#include <sysc/kernel/sc_boost.h>
#include <sysc/kernel/sc_spawn.h>

SC_MODULE(max_pooling1_unrlld) {
	//some of _params I substituted and some were left as they were in
	//default version 
	int POOLOUT1_param = POOLOUT1;
	int POOLOUT2_param = POOLOUT2;
	int POOLOUT3_param = 1; //because we unroll this module
	int F_M2_param = F_M2;
	int F_M1_param = F_M1;
	int POOL_ED_param = POOL_ED;
	int POOL_IN_param = POOL_IN;
	int P1_param = P1;
	int P2_param = P2;
	int verbose_param = 1;
	//порты
	sc_in<bool> 		clk, rst;

	static const int ker_port = L1;
	sc_in<sc_fixed<W_LEN_i, I_LEN_i>> 	image[ker_port];
	sc_in<bool> 		image_vld[ker_port];
	sc_out<bool> 		image_rdy[ker_port];

	sc_in<bool> 		max_pool_result_rdy_tb;
	sc_out<bool> 		max_pool_result_vld_tb;
	sc_in<bool> 		max_pool_result_rdy_next;
	sc_out<bool> 		max_pool_result_vld_next;

	
	sc_out<sc_fixed<W_LEN_i, I_LEN_i>> 		max_pool_result_tb;
	sc_out<sc_fixed<W_LEN_i, I_LEN_i>> 		max_pool_result_next;
	

	sc_logic 			image_recieved[ker_port] = {sc_logic(0)};
	sc_logic 			max_pool_done[ker_port] = {sc_logic(0)};
	sc_logic			max_pool_result_sent_tb[ker_port] = {sc_logic(0)};
	sc_logic			max_pool_result_sent_next[ker_port] = {sc_logic(0)};

	sc_fixed<W_LEN_i, I_LEN_i> 				value = 0;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap1;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap2;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap3;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap4;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap5;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap6;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap7;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap8;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap9;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap10;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap11;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap12;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap13;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap14;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap15;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap16;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap17;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap18;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap19;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap20;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap21;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap22;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap23;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap24;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap25;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap26;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap27;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap28;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap29;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap30;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap31;
	sc_fixed<W_LEN_i, I_LEN_i>* 			featuremap32;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in1;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in2;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in3;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in4;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in5;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in6;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in7;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in8;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in9;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in10;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in11;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in12;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in13;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in14;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in15;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in16;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in17;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in18;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in19;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in20;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in21;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in22;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in23;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in24;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in25;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in26;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in27;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in28;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in29;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in30;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in31;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			featuremap_in32;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result1;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result2;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result3;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result4;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result5;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result6;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result7;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result8;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result9;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result10;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result11;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result12;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result13;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result14;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result15;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result16;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result17;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result18;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result19;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result20;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result21;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result22;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result23;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result24;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result25;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result26;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result27;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result28;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result29;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result30;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result31;
	sc_fixed<W_LEN_i, I_LEN_i>*** 			result32;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled1;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled2;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled3;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled4;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled5;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled6;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled7;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled8;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled9;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled10;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled11;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled12;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled13;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled14;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled15;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled16;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled17;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled18;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled19;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled20;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled21;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled22;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled23;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled24;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled25;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled26;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled27;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled28;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled29;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled30;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled31;
	sc_fixed<W_LEN_i, I_LEN_i>* 			max_pooled32;


	sc_fixed<W_LEN_i, I_LEN_i> maximum (sc_fixed<W_LEN_i, I_LEN_i> a, 
										sc_fixed<W_LEN_i, I_LEN_i> b);
	void recieve_image(int c, sc_fixed<W_LEN_i, I_LEN_i>* featuremap,
					   sc_fixed<W_LEN_i, I_LEN_i>*** featuremap_in);
	void recieve_image_wrapper(){
		sc_spawn(sc_bind(&max_pooling1_unrlld::recieve_image, this, 0, featuremap1, featuremap_in1));
	}
	void max_pooling(int c, sc_fixed<W_LEN_i, I_LEN_i>*** featuremap_in,
					 sc_fixed<W_LEN_i, I_LEN_i>*** result,
					 sc_fixed<W_LEN_i, I_LEN_i>* max_pooled);
	void max_pooling_wrapper(){
		sc_spawn(sc_bind(&max_pooling1_unrlld::max_pooling, this, 0, featuremap_in1, result1, max_pooled1));
	}/**/
	//void send_to_dri_tb(void);
	void send_to_next(int c, sc_fixed<W_LEN_i, I_LEN_i>* max_pooled);
	void send_to_next_wrapper(){
		sc_spawn(sc_bind(&max_pooling1_unrlld::send_to_next, this, 0, max_pooled1));
	}

	SC_CTOR(max_pooling1_unrlld)
		{
		cout<<""<< this<<" maxpooling1_unrlld"<<"\n";
		featuremap1 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap2 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap3 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap4 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap5 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap6 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap7 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap8 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap9 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap10 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap11 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap12 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap13 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap14 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap15 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap16 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap17 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap18 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap19 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap20 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap21 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap22 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap23 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap24 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap25 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap26 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap27 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap28 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap29 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap30 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap31 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];
		featuremap32 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_IN/F_M3];

		featuremap_in1 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in1[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in1[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in2 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in2[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in2[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in3 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in3[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in3[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in4 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in4[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in4[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in5 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in5[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in5[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in6 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in6[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in6[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in7 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in7[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in7[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in8 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in8[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in8[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in9 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in9[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in9[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in10 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in10[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in10[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in11 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in11[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in11[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in12 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in12[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in12[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in13 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in13[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in13[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in14 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in14[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in14[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in15 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in15[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in15[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in16 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in16[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in16[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in17 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in17[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in17[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in18 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in18[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in18[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in19 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in19[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in19[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in20 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in20[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in20[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in21 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in21[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in21[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in22 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in22[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in22[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in23 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in23[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in23[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in24 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in24[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in24[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in25 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in25[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in25[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in26 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in26[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in26[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in27 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in27[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in27[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in28 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in28[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in28[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in29 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in29[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in29[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in30 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in30[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in30[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in31 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in31[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in31[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		featuremap_in32 = new sc_fixed<W_LEN_i, I_LEN_i>**[F_M2];
		for (int j = 0; j < F_M2_param; j++){
			featuremap_in32[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[F_M1];
			for (int i = 0; i < F_M1_param; i++){
				featuremap_in32[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}
		


		result1 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2];
		for (int j = 0; j < POOLOUT2_param; j++){
			result1[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1];
			for (int i = 0; i < POOLOUT1_param; i++){
				result1[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result2 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2];
		for (int j = 0; j < POOLOUT2_param; j++){
			result2[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1];
			for (int i = 0; i < POOLOUT1_param; i++){
				result2[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result3 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2];
		for (int j = 0; j < POOLOUT2_param; j++){
			result3[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1];
			for (int i = 0; i < POOLOUT1_param; i++){
				result3[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result4 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2];
		for (int j = 0; j < POOLOUT2_param; j++){
			result4[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1];
			for (int i = 0; i < POOLOUT1_param; i++){
				result4[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result5 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2];
		for (int j = 0; j < POOLOUT2_param; j++){
			result5[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1];
			for (int i = 0; i < POOLOUT1_param; i++){
				result5[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result6 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2];
		for (int j = 0; j < POOLOUT2_param; j++){
			result6[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1];
			for (int i = 0; i < POOLOUT1_param; i++){
				result6[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result7 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2];
		for (int j = 0; j < POOLOUT2_param; j++){
			result7[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1];
			for (int i = 0; i < POOLOUT1_param; i++){
				result7[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result8 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2];
		for (int j = 0; j < POOLOUT2_param; j++){
			result8[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1];
			for (int i = 0; i < POOLOUT1_param; i++){
				result8[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result9 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2];
		for (int j = 0; j < POOLOUT2_param; j++){
			result9[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1];
			for (int i = 0; i < POOLOUT1_param; i++){
				result9[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result10 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2];
		for (int j = 0; j < POOLOUT2_param; j++){
			result10[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1];
			for (int i = 0; i < POOLOUT1_param; i++){
				result10[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result11 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2];
		for (int j = 0; j < POOLOUT2_param; j++){
			result11[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1];
			for (int i = 0; i < POOLOUT1_param; i++){
				result11[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result12 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2];
		for (int j = 0; j < POOLOUT2_param; j++){
			result12[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1];
			for (int i = 0; i < POOLOUT1_param; i++){
				result12[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[1];
			}
		}

		result13 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result13[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result13[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result14 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result14[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result14[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result15 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result15[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result15[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result16 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result16[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result16[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result17 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result17[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result17[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result18 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result18[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result18[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result19 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result19[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result19[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result20 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result20[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result20[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result21 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result21[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result21[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result22 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result22[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result22[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result23 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result23[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result23[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result24 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result24[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result24[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result25 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result25[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result25[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result26 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result26[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result26[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result27 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result27[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result27[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result28 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result28[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result28[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result29 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result29[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result29[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}


		result30 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result30[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result30[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result31 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result31[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result31[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		result32 = new sc_fixed<W_LEN_i, I_LEN_i>**[POOLOUT2_param];
		for (int j = 0; j < POOLOUT2_param; j++){
			result32[j] = new sc_fixed<W_LEN_i, I_LEN_i>*[POOLOUT1_param];
			for (int i = 0; i < POOLOUT1_param; i++){
				result32[j][i] = new sc_fixed<W_LEN_i, I_LEN_i>[POOLOUT3_param];
			}
		}

		
		max_pooled1 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled2 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled3 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled4 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled5 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled6 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled7 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled8 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled9 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled10 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled11 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled12 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled13 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled14 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled15 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled16 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled17 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled18 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled19 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled20 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled21 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled22 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled23 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled24 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled25 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled26 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled27 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled28 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled29 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled30 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled31 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];
		max_pooled32 = new sc_fixed<W_LEN_i, I_LEN_i>[POOL_ED_param/POOLOUT3];



		SC_THREAD(recieve_image_wrapper);
		SC_THREAD(max_pooling_wrapper);
		//SC_THREAD(send_to_dri_tb);
		//SC_THREAD(send_to_next_wrapper);
		reset_signal_is(rst, true);
	}

	~max_pooling1_unrlld(){
	delete[] featuremap1;

	for (int j = 0; j < F_M2; j++){
		for (int i = 0; i < F_M1; i++){
			delete[] featuremap_in1[j][i];
		}
		delete[] featuremap_in1[j];
	}
	delete[] featuremap_in1;
	

	for (int j = 0; j < POOLOUT2_param; j++){
		for (int i = 0; i < POOLOUT1_param; i++){
			delete[] result1[j][i];
		}
		delete[] result1[j];
	}
	delete[] result1;


	delete[] max_pooled1;
	}
};

