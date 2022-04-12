#include "conv1_unrlld.h"
#include <iomanip>
#include "weights.hpp"
void conv1_unrlld::recieve_image(void) {
	//инициализируем хэндшейк
	image_rdy.write(0);
	wait(clk->posedge_event());
	while(true){
		if(image_recieved == sc_logic(1)){
				wait(clk->posedge_event());
		}
		else{
			for (int i = 0; i < IMG; i++){
				image_rdy.write(1);
				do{
					wait(clk->posedge_event());
				}while (!image_vld.read());
				image_in_flattened[i]=image.read();
				image_rdy.write(0);			
			}
			for (int k = 0; k < N2; ++k){
				for (int j = 0; j < M2; j++){
					for (int i = 0; i < C1; ++i){
						image_in[k][j][i] = 
						image_in_flattened[k * M2 * C1 + j *C1 + i]; 
					}
				}
			}/*
			cout << "[отладочный вывод]["<< this <<"] изображение:" << endl;
			cout <<"размеры: "<< M2 <<" "<< N2<<" " << C1<<endl;
			for (int k = 0; k < N2; ++k) {
				for (int j = 0; j < M2; j++){
					for (int i = 0; i < C1; ++i) {
						cout<<"image_in["<<k<<"]["<<j<<"]["<<i<<"]="<< image_in[k][j][i] << "\n ";
					}
				}
			}
			cout << endl;
			/**/
			image_recieved = sc_logic(1);
            cout<<"@"<<sc_time_stamp()<<" conv input recieved ["<<this<<"]"<<endl;/*
			cout<<"conv_2d ["<<this<<"]: IMG RECIEVED = "
			<<image_recieved<<" "<<" KER RECIEVED = "<<kernel_recieved
			<<" BIASES RECIEVED = "<<biases_recieved<<endl;/**/	
			}	
		}
	
};/**/

void conv1_unrlld::zero_padding(void){
	while(true){
		if(image_recieved == sc_logic(1) and zero_pad == 1 and zero_pad_done == sc_logic(0)){
			for (int k = 0; k < N2+2*ZERO_PAD; ++k) {
				for (int j = 0; j < M2+2*ZERO_PAD; j++){
					for (int i = 0; i < C1; ++i) {
						image_in_padded[k][j][i] = 0;
					}
				}
			}			
			for (int k = 0; k < N2; ++k) {
				for (int j = 0; j < M2; j++){
					for (int i = 0; i < C1; ++i) {
						image_in_padded[k + ZERO_PAD][j + ZERO_PAD][i] = image_in[k][j][i];
						wait(clk->posedge_event());
					}
				}
			}/*
			for (int k = 0; k < N2+2*ZERO_PAD; ++k) {
				for (int j = 0; j < M2+2*ZERO_PAD; j++){
					for (int i = 0; i < C1; ++i) {
						cout<<"image_in_padded["<<k<<"]["<<j<<"]["<<i<<"] = "<<
						image_in_padded[k][j][i]<<'\n';
					}
				}
			}/**/			
			zero_pad_done = sc_logic(1);
			cout<<"@"<<sc_time_stamp()<<" zero padding done ["<<this<<"]"<<endl;
		}
		else if(image_recieved == sc_logic(1) and zero_pad == 0 and zero_pad_done == sc_logic(0)){
			zero_pad_done = sc_logic(1);
			cout<<"@"<<sc_time_stamp()<<" zero padding skiped ["<<this<<"]"<<endl;
		}
		else{
			wait(clk->posedge_event());
		}
	}

};

void conv1_unrlld::recieve_biases(void) {
	biases_rdy.write(0);
	while(true){
		if(biases_recieved == sc_logic(1)){
			while(true){
				biases_rdy.write(0);
				wait(clk->posedge_event());
//				next_trigger();
			}
		}
		for (int k = 0; k < BIASES; ++k) {
			biases_rdy.write(1);
			do{
				wait(clk->posedge_event());
//				next_trigger();
			}while(!biases_vld.read());
			biases_in[k]=biases.read();
			biases_rdy.write(0);
		}
		
			cout << "[отладочный вывод]["<<this <<"] баесы:" << endl;
			for (int k = 0; k < BIASES; ++k) {
					cout<<"biases_in["<<k<<"]="<<biases_in[k]<<endl;
			}/**/
		
		biases_recieved=sc_logic(1);
		cout<<"@"<<sc_time_stamp()<<" conv biases recieved ["<<this<<"]"<<endl;
	}
};
/**/ 
void conv1_unrlld::recieve_kernel(int c, sc_fixed<W_LEN_w, I_LEN_w>* kernel_in_flat_mem, 
								sc_fixed<W_LEN_w, I_LEN_w>**** kernel_in_mem) {
	//инициализируем хэндшейк
	
	kernel_rdy[c].write(0);
	wait(clk->posedge_event());
	while(true){
		if(kernel_recieved[c] == sc_logic(1)){
			while(true){
				kernel_rdy[c].write(0);
				wait(clk->posedge_event());
			}
		}
		for (int i = 0; i < KER/L1; i++){   
			kernel_rdy[c].write(1);
			
			do{ 
				wait(clk->posedge_event());
			}while (!kernel_vld[c].read());
			kernel_in_flat_mem[i] = kernel[c].read();
			kernel_rdy[c].write(0);
		}/*
		cout<<"kernel_in_flat_mem"<<c<<" "<<this<<"\n";
		for (int i = 0; i < KER/L1; i++){
			cout <<"kernel_in_flat_mem"<<c<<"["<<i<<"]"<<"="<< kernel_in_flat_mem[i] << "\n ";
			
		} 
		cout<<"\n\n\n\n\n";/**/ 
		
		//разворачивание вектора в 3D массив 
		for (int i = 0; i < M1; ++i) {
			for (int k = 0; k < N1; ++k) {
				for (int j = 0; j < C1; ++j) {
					for (int c = 0; c < 1; ++c){
					//cout<<i<<" "<<k<<" "<<j<<" "<<c<<"\n";
						kernel_in_mem[i][k][j][c] = kernel_in_flat_mem[i * N1 * C1 + k * C1 + j + c];
					}
				}
			}
		}/**/
		/*
		cout << "M1= " << M1 << " N1= " << N1 <<"\n"
		<<"C1= " << C1 << " L1= " << L1<<"\n";
		cout<<endl<< "[отладочный вывод CONV]["<< this <<"] кернел:" << endl; 
		for (int i = 0; i < M1; ++i){	
			for (int k = 0; k < N1; ++k) {	
				for (int j = 0; j < C1; ++j) {
					cout<<"kernel_in_mem["<<i<<"]["<<k<<"]["<<j<<"]="
					<< kernel_in_mem[i][k][j] << "\n";
				}
			}
		}
		/**/	
		kernel_recieved[c]=sc_logic(1);
		cout<<"kernel_recieved["<<c<<"]="<<kernel_recieved[c]<<"\n";
		
		if( kernel_recieved[0] == sc_logic(1) and kernel_recieved[1] == sc_logic(1) and
			kernel_recieved[2] == sc_logic(1) and kernel_recieved[3] == sc_logic(1) and
			kernel_recieved[4] == sc_logic(1) and kernel_recieved[5] == sc_logic(1) and
			kernel_recieved[6] == sc_logic(1) and kernel_recieved[7] == sc_logic(1) and
			kernel_recieved[8] == sc_logic(1) and kernel_recieved[9] == sc_logic(1) and
			kernel_recieved[10] == sc_logic(1) and kernel_recieved[11] == sc_logic(1) and
			kernel_recieved[12] == sc_logic(1) and kernel_recieved[13] == sc_logic(1) and
			kernel_recieved[14] == sc_logic(1) and kernel_recieved[15] == sc_logic(1) and
			kernel_recieved[16] == sc_logic(1) and kernel_recieved[17] == sc_logic(1) and
			kernel_recieved[18] == sc_logic(1) and kernel_recieved[19] == sc_logic(1) and
			kernel_recieved[20] == sc_logic(1) and kernel_recieved[21] == sc_logic(1) and
			kernel_recieved[22] == sc_logic(1) and kernel_recieved[23] == sc_logic(1) and
			kernel_recieved[24] == sc_logic(1) and kernel_recieved[25] == sc_logic(1) and
			kernel_recieved[26] == sc_logic(1) and kernel_recieved[27] == sc_logic(1) and
			kernel_recieved[28] == sc_logic(1) and kernel_recieved[29] == sc_logic(1) and
			kernel_recieved[30] == sc_logic(1) and kernel_recieved[31] == sc_logic(1) )
		{
			cout<<"@"<<sc_time_stamp()<<" all conv kernels recieved ["<<this<<"]"<<endl;/**/
			cout<< kernel_recieved[0]<<image_recieved<<biases_recieved<<
			conv_done<<zero_pad_done<<"\n";
		}
		
	}
};

void conv1_unrlld::convolution(int c, sc_fixed<W_LEN_w, I_LEN_w>**** kernel_in_mem, 
							   sc_fixed<W_LEN_i, I_LEN_i>*** result_mem) {
	while(true){/*
		cout<<"c="<<c<<" kernel_recieved["<<c<<"]="<<kernel_recieved[c]<<" "	
		<<"image_recieved="<<image_recieved<<" "
		<<"biases_recieved="<<biases_recieved<<" "
		<<"conv_done["<<c<<"]="<<conv_done[c]<<" "
		<<"zero_pad_done="<<zero_pad_done<<"\n";/**/
		if(conv_done[c] == sc_logic(1)){ 
				wait(clk->posedge_event());
			//	cout<<"ooo\n";
			//	next_trigger();
		}
		else if (kernel_recieved[c] == sc_logic(1) and 
				image_recieved == sc_logic(1) and biases_recieved == sc_logic(1) and 
				conv_done[c] == sc_logic(0) and zero_pad_done == sc_logic(1))
		{
			//свёртка	
			//cout<<"[отладочный вывод CONV]["<< this <<"] результат:"<<endl;
			for (int k = 0; k < 1; k++){
				for (int i = 0; i < M3; i++) {//(высота/кол-во строк) выходного изображения
					for (int j = 0; j < N3; j++) {//(ширина/кол-во столбцов) выходного изображения
						for (int c = 0; c < C1; c++){//количество входных изображений
							for (int m = 0; m < M1; m++) {//(высота/кол-во строк) кернела
								for (int n = 0; n < N1; n++) {//(ширина/кол-во столбцов) кернела
									result_mem[i][j][k] += 
									kernel_in_mem[m][n][c][k] * 
									image_in_padded[i + m][j + n][c];/**/
									/*
									cout<<"result_mem["<<i<<"]["<<j<<"]["<<k<<"]+=kernel_in["<<m
									<<"]["<<n<<"]["<<c<<"]["<<k<<
									"]*image_in["<<i<<"+"<<m<<"]["<<j<<"+"<<n<<"]["<<c<<"] | ";
									cout<<"result_mem["<<i<<"]["<<j<<"]["<<k<<"]+="<<kernel_in_mem[m][n][c][k]<<"*"
									<< image_in_padded[i + m][j + n][c]<<"="<<result_mem[i][j][k]<<"\n";/**/
									wait(clk->posedge_event());
								}
							}		
						}
					
					cout<<"result_mem_unb["<<i<<"]["<<j<<"]["<<c<<"]="<<result_mem[i][j][k]<<"\n";/**/
					/*
					result[i][j][k] += biases_in[c];
					/*

					cout<<"result_biased["<<i<<"]["<<j<<"]["<<k<<"]="<<result[i][j][k]<<"\n";/**/
					}
					
				}
			}		
			//-----------------------------------------------------------------------------------------------------------------------------
			/*
			for (int k = 0; k < L1; k++) {//число кернелов и выходных матрицы соотв-но
				for (int i = 0; i < M3; i++) {//(высота/кол-во строк) выходного изображения
					for (int j = 0; j < N3; j++) {//(ширина/кол-во столбцов) выходного изображения
						for (int c = 0; c < C1; c++){//количество входных изображений
							for (int m = 0; m < M1; m++) {//(высота/кол-во строк) кернела
								for (int n = 0; n < N1; n++) {//(ширина/кол-во столбцов) кернела
									result[i][j][k] += 
									kernel_in[m][n][c][k] * image_in_padded[i + m][j + n][c];/**//*
									if(verbose==1){
										cout<<std::scientific<<"result["<<i<<"]["<<j<<"]["<<k<<"]+=kernel_in["<<m<<"]["<<n<<"]["<<c<<"]["<<k<<
										"]*image_in["<<i<<"+"<<m<<"]["<<j<<"+"<<n<<"]["<<c<<"] | ";
										cout<<"result["<<i<<"]["<<j<<"]["<<k<<"]+="<<kernel_in[m][n][c][k]<<"*"
										<< image_in_padded[i + m][j + n][c]<<"="<<result[i][j][k]<<"\n";/**//*
									}
									next_trigger();
								}		
							}
						}
						if(verbose==1){
							cout<<"result_unbiased["<<i<<"]["<<j<<"]["<<k<<"]="<<result[i][j][k]<<"\n";/**//*
						}
						result[i][j][k] += biases_in[k];
						if(verbose==1){
							cout<<"result_biased["<<i<<"]["<<j<<"]["<<k<<"]="<<result[i][j][k]<<"\n";/**//*
						}
						
						
					}
				}
			}/*
			for (int i = 0; i < M3; i++){
				for (int j = 0; j < N3; j++){
					for (int k = 0; k < 1; k++){
						cout<<"result_pre["<<i<<"]["<<j<<"]["<<c<<"]="<<result[i][j][k]<<"\n";
					}
				}
			}/**//*
			cout << "размеры выходной матрицы: " << endl;
			cout << "M3= " << M3 << " N3= " << N3 << " " << endl << endl;
			cout<<"результат после ReLU ["<< this <<"]---------------------------------\n";
			sc_fixed<W_LEN_i, I_LEN_i> zero = 0;
			for (int i = 0; i < M3; i++){
					for (int j = 0; j < N3; j++){
						for (int k = 0; k < 1; k++){
						if (result[i][j][k] < zero) {
							result[i][j][k] = zero;
							wait(clk->posedge_event());
							//next_trigger();
						}
						else {
							wait(clk->posedge_event());
							//next_trigger();
						}	
						cout<<"result["<<i<<"]["<<j<<"]["<<k<<"]="<<result[i][j][k]<<"\n";/**//*
					}
				}
			}	
			
			/**/
			/*
			cout<<"[отладочный вывод CONV]["<< this <<"] результат:"<<endl;
			for (int k = 0; k < N3; ++k) {
				for (int i = 0; i < M3; ++i) {
					for (int j = 0; j < L3; ++j) {
						cout << result[k][i][j] << " ";
					}
					cout << endl;
				}
				cout << endl << endl;
			}
			cout << endl<<endl;   
			/**/  
			/*
			for (int i = 0; i < M3; i++) {
					for (int j = 0; j < N3; j++) {
						for (int k = 0; k < L3; k++) {
						convolved_mat[i*N3*L3+j*L3+k]=result[i][j][k];
						
					}
				}
			}

			/*
			cout<<this<<" CONV results ["<<this<<"]\n";
			for (int i = 0; i < CONV_ED; i++){
				cout<<"convolved_mat["<<i<<"]"<<convolved_mat[i]<<endl;
			}
			cout<<endl<<endl;
			/**/
			conv_done[c] = sc_logic(1);
			if (conv_done[0] == sc_logic(1) and conv_done[1] == sc_logic(1) and
				conv_done[2] == sc_logic(1) and conv_done[3] == sc_logic(1) and
				conv_done[4] == sc_logic(1) and conv_done[5] == sc_logic(1) and
				conv_done[6] == sc_logic(1) and conv_done[7] == sc_logic(1) and
				conv_done[8] == sc_logic(1) and conv_done[9] == sc_logic(1) and
				conv_done[10] == sc_logic(1) and conv_done[11] == sc_logic(1) and
				conv_done[12] == sc_logic(1) and conv_done[13] == sc_logic(1) and
				conv_done[14] == sc_logic(1) and conv_done[15] == sc_logic(1) and
				conv_done[16] == sc_logic(1) and conv_done[17] == sc_logic(1) and
				conv_done[18] == sc_logic(1) and conv_done[19] == sc_logic(1) and
				conv_done[20] == sc_logic(1) and conv_done[21] == sc_logic(1) and
				conv_done[22] == sc_logic(1) and conv_done[23] == sc_logic(1) and
				conv_done[24] == sc_logic(1) and conv_done[25] == sc_logic(1) and
				conv_done[26] == sc_logic(1) and conv_done[27] == sc_logic(1) and
				conv_done[28] == sc_logic(1) and conv_done[29] == sc_logic(1) and
				conv_done[30] == sc_logic(1) and conv_done[31] == sc_logic(1) ){
					cout << "@" << sc_time_stamp() <<" "<<this<<" layer calculated"<<endl;
					conv_done_all = sc_logic(1);
				}
			
		}
		else{
			wait(clk->posedge_event());
			//next_trigger();
		}/**/
	}
};

void conv1_unrlld::send_to_dri_tb(void){
	//conv_2d_result_tb.write(0);
	conv_2d_result_vld_tb.write(0);
	while(true){
		if ( conv_done_all == sc_logic(1) and conv_result_sent_tb == sc_logic(0)){
			cout<<"OK!\n";
			
			/*
			for (int i = 0; i < CONV_ED; i++){
				conv_2d_result_vld_tb.write(1);
				conv_2d_result_tb.write(convolved_mat[i]);
				do{
					wait(clk->posedge_event());
				}while (!conv_2d_result_rdy_tb.read());
				
				conv_2d_result_vld_tb.write(0);
			}	
			conv_2d_result_tb.write(0);
			cout<<"@" << sc_time_stamp() <<" "<<this<<" data transmitted"<<endl;/**/
			conv_result_sent_tb = sc_logic(1);
		}
		else{
			wait(clk->posedge_event());
		}
	}
};/**/

void conv1_unrlld::send_to_next_layer(void){
	//conv_2d_result_next.write(0);
	conv_2d_result_vld_next.write(0);
	while(true){
		if (conv_done == sc_logic(1) and conv_result_sent_next == sc_logic(0)){
			for (int i=0;i<CONV_ED;i++){
				conv_2d_result_vld_next.write(1);
				conv_2d_result_next.write(convolved_mat[i]);
				
				do{
					wait(clk->posedge_event());
				}while (!conv_2d_result_rdy_next.read());
				conv_2d_result_vld_next.write(0);
				
			}	
			conv_2d_result_next.write(0);
			cout<<"@" << sc_time_stamp() <<" "<< this << " data transmitted"<<endl;
			conv_result_sent_next = sc_logic(1);
		}
		else{
			wait(clk->posedge_event());
		}
	
	}
};/**/