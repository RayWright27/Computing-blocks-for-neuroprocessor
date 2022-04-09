#include "conv1_unrlld.h"
#include <iomanip>
#include "weights.hpp"
void conv::recieve_image(void) {
	//инициализируем хэндшейк
	image_rdy.write(0);
	wait(clk->posedge_event());
	while(true){
		if(image_recieved == sc_logic(1)){
				wait(clk->posedge_event());
		}
		else{
			for (int i = 0; i < IMG_param; i++){
				image_rdy.write(1);
				do{
					wait(clk->posedge_event());
				}while (!image_vld.read());
				image_in_flattened[i]=image.read();
				image_rdy.write(0);			
			}
			for (int k = 0; k < N2_param; ++k){
				for (int j = 0; j < M2_param; j++){
					for (int i = 0; i < C1_param; ++i){
						image_in[k][j][i] = 
						image_in_flattened[k * M2_param * C1_param + j *C1_param + i]; 
					}
				}
			}/*
			cout << "[отладочный вывод]["<< this <<"] изображение:" << endl;
			cout <<"размеры: "<< M2_param <<" "<< N2_param<<" " << C1_param<<endl;
			for (int k = 0; k < N2_param; ++k) {
				for (int j = 0; j < M2_param; j++){
					for (int i = 0; i < C1_param; ++i) {
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

void conv::zero_padding(void){
	while(true){
		if(image_recieved == sc_logic(1) and zero_pad == 1 and zero_pad_done == sc_logic(0)){
			for (int k = 0; k < N2_param+2*ZERO_PAD_param; ++k) {
				for (int j = 0; j < M2_param+2*ZERO_PAD_param; j++){
					for (int i = 0; i < C1_param; ++i) {
						image_in_padded[k][j][i] = 0;
					}
				}
			}			
			for (int k = 0; k < N2_param; ++k) {
				for (int j = 0; j < M2_param; j++){
					for (int i = 0; i < C1_param; ++i) {
						image_in_padded[k + ZERO_PAD_param][j + ZERO_PAD_param][i] = image_in[k][j][i];
						wait(clk->posedge_event());
					}
				}
			}/*
			for (int k = 0; k < N2_param+2*ZERO_PAD_param; ++k) {
				for (int j = 0; j < M2_param+2*ZERO_PAD_param; j++){
					for (int i = 0; i < C1_param; ++i) {
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

void conv::recieve_biases(void) {
	biases_rdy.write(0);
	while(true){
		if(biases_recieved == sc_logic(1)){
			while(true){
				biases_rdy.write(0);
				wait(clk->posedge_event());
//				next_trigger();
			}
		}
		for (int k = 0; k < BIASES_param; ++k) {
			biases_rdy.write(1);
			do{
				wait(clk->posedge_event());
//				next_trigger();
			}while(!biases_vld.read());
			biases_in[k]=biases.read();
			biases_rdy.write(0);
		}
		if(verbose==1){
			cout << "[отладочный вывод]["<<this <<"] баесы:" << endl;
			for (int k = 0; k < BIASES_param; ++k) {
					cout<<"biases_in["<<k<<"]="<<biases_in[k]<<endl;
			}/**/
		}
		biases_recieved=sc_logic(1);
		cout<<"@"<<sc_time_stamp()<<" conv biases recieved ["<<this<<"]"<<endl;
	}
};
/**/ 
void conv::recieve_kernel(void) {
	//инициализируем хэндшейк
	kernel_rdy.write(0);
	wait(clk->posedge_event());
	double kernel_in_flattened[KER_param]={};//вектор, принимающий значения из порта
	while(true){
		if(kernel_recieved == sc_logic(1)){
			while(true){
				kernel_rdy.write(0);
				wait(clk->posedge_event());
			}
		}
		for (int i = 0; i < KER_param; i++){
			kernel_rdy.write(1);
			do{
				wait(clk->posedge_event());
			}while (!kernel_vld.read());
			kernel_in_flattened[i] = kernel.read();
			kernel_rdy.write(0);
		}/*
		cout<<"kernel_in_flattened "<<this<<"\n";
		cout <<"kernel_in_flattened["<<1<<"]="<< kernel_in_flattened[1] << "\n ";/**/
		if(verbose==1){
			cout<<"kernel_in_flattened "<<this<<"\n";
			for (int i = 0; i < KER_param; i++){
				cout <<"kernel_in_flattened["<<i<<"]="<< kernel_in_flattened[i] << "\n ";
				
			} 
			cout<<"\n\n\n\n\n";/**/ 
		}

		//разворачивание вектора в 3D массив (сделать в отдельный метод) 
		for (int i = 0; i < M1_param; ++i) {
			for (int k = 0; k < N1_param; ++k) {
				for (int j = 0; j < C1_param; ++j) {
					for (int c = 0; c < L1_param; ++c){
						//cout<<i<<" "<<k<<" "<<j<<" "<<c<<"\n";
						kernel_in[i][k][j][c] = kernel_in_flattened[i * N1_param * C1_param * L1_param + 
						k * C1_param * L1_param + j * L1_param + c];
					}
				}
			}
		}/**/
		if(verbose==1){
			cout << "M1_param= " << M1_param << " N1_param= " << N1_param <<"\n"
			<<"C1_param= " << C1_param << " L1_param= " << L1_param<<"\n";
			cout<<endl<< "[отладочный вывод CONV]["<< this <<"] кернел:" << endl; 
			for (int i = 0; i < M1_param; ++i){	
				for (int k = 0; k < N1_param; ++k) {	
					for (int j = 0; j < C1_param; ++j) {
						for (int c = 0; c < L1_param; ++c) {
							cout<<"kernel_in["<<i<<"]["<<k<<"]["<<j<<"]["
							<<c<<"]="<< kernel_in[i][k][j][c] << "\n";
						}
					}
				}
			}
		}/**/
		kernel_recieved=sc_logic(1);
		cout<<"@"<<sc_time_stamp()<<" conv kernels recieved ["<<this<<"]"<<endl;
	}
};

void conv::convolution(void) {
	if(conv_done == sc_logic(1)){ 
		//while(true){
			//wait(clk->posedge_event());
			next_trigger();
		//}
	}
	else if (kernel_recieved == sc_logic(1) and image_recieved == sc_logic(1) and biases_recieved == sc_logic(1) and 
				conv_done == sc_logic(0) and zero_pad_done == sc_logic(1))
	{
		//свёртка	
		if(verbose==1){
			cout<<"[отладочный вывод CONV]["<< this <<"] результат:"<<endl;	
		}
		int k=0;
		for (int i = 0; i < M3_param; i++) {//(высота/кол-во строк) выходного изображения
			for (int j = 0; j < N3_param; j++) {//(ширина/кол-во столбцов) выходного изображения
				for (int c = 0; c < C1_param; c++){//количество входных изображений
					for (int m = 0; m < M1_param; m++) {//(высота/кол-во строк) кернела
						for (int n = 0; n < N1_param; n++) {//(ширина/кол-во столбцов) кернела
							result[i][j][k] += 
							kernel_in[m][n][c][k] * image_in_padded[i + m][j + n][c];/**/
							if(verbose==1){
								cout<<std::scientific<<"result["<<i<<"]["<<j<<"]["<<k<<"]+=kernel_in["<<m<<"]["<<n<<"]["<<c<<"]["<<k<<
								"]*image_in["<<i<<"+"<<m<<"]["<<j<<"+"<<n<<"]["<<c<<"] | ";
								cout<<"result["<<i<<"]["<<j<<"]["<<k<<"]+="<<kernel_in[m][n][c][k]<<"*"
								<< image_in_padded[i + m][j + n][c]<<"="<<result[i][j][k]<<"\n";/**/
							}
							next_trigger();
						}		
					}
				}
				if(verbose==1){
					cout<<"result_unbiased["<<i<<"]["<<j<<"]["<<k<<"]="<<result[i][j][k]<<"\n";/**/
				}
				result[i][j][k] += biases_in[k];
				if(verbose==1){
					cout<<"result_biased["<<i<<"]["<<j<<"]["<<k<<"]="<<result[i][j][k]<<"\n";/**/
				}
				
				
			}
		}
		
		//-----------------------------------------------------------------------------------------------------------------------------
		/*
		for (int k = 0; k < L1_param; k++) {//число кернелов и выходных матрицы соотв-но
			for (int i = 0; i < M3_param; i++) {//(высота/кол-во строк) выходного изображения
				for (int j = 0; j < N3_param; j++) {//(ширина/кол-во столбцов) выходного изображения
					for (int c = 0; c < C1_param; c++){//количество входных изображений
						for (int m = 0; m < M1_param; m++) {//(высота/кол-во строк) кернела
							for (int n = 0; n < N1_param; n++) {//(ширина/кол-во столбцов) кернела
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
		}/**/
		/*
		cout << "размеры выходной матрицы: " << endl;
		cout << "M3_param= " << M3_param << " N3_param= " << N3_param << " " << endl << endl;
		/**/
		if(verbose==1){
			cout<<"результат после ReLU ["<< this <<"]---------------------------------\n";
		}
		sc_fixed<W_LEN_i, I_LEN_i> zero = 0;
		for (int i = 0; i < M3_param; i++){
				for (int j = 0; j < N3_param; j++){
					for (int k = 0; k < L3_param; k++){
					if (result[i][j][k] < zero) {
						result[i][j][k] = zero;
						//wait(clk->posedge_event());
						next_trigger();
					}
					else {
						//wait(clk->posedge_event());
						next_trigger();
					}	
					if(verbose==1){
						cout<<"result["<<i<<"]["<<j<<"]["<<k<<"]="<<result[i][j][k]<<"\n";/**/
					}
				}
			}
		}	
		
		/**/
/*
		cout<<"[отладочный вывод CONV]["<< this <<"] результат:"<<endl;
		for (int k = 0; k < N3_param; ++k) {
			for (int i = 0; i < M3_param; ++i) {
				for (int j = 0; j < L3_param; ++j) {
					cout << result[k][i][j] << " ";
				}
				cout << endl;
			}
			cout << endl << endl;
		}
		cout << endl<<endl;   
		/**/  
		
		for (int i = 0; i < M3_param; i++) {
				for (int j = 0; j < N3_param; j++) {
					for (int k = 0; k < L3_param; k++) {
					convolved_mat[i*N3_param*L3_param+j*L3_param+k]=result[i][j][k];
					
				}
			}
		}

		/*
		cout<<this<<" CONV results ["<<this<<"]\n";
		for (int i = 0; i < CONV_ED_param; i++){
			cout<<"convolved_mat["<<i<<"]"<<convolved_mat[i]<<endl;
		}
		cout<<endl<<endl;
		/**/
		conv_done = sc_logic(1);
		cout << "@" << sc_time_stamp() <<" "<<this<<" layer calculated"<<endl;
	}
	else{
		//wait(clk->posedge_event());
		next_trigger();
	}
};/**/

void conv::send_to_dri_tb(void){
	//conv_2d_result_tb.write(0);
	conv_2d_result_vld_tb.write(0);
	while(true){
		if ( conv_done == sc_logic(1) and conv_result_sent_tb == sc_logic(0)){
			for (int i = 0; i < CONV_ED_param; i++){
				conv_2d_result_vld_tb.write(1);
				conv_2d_result_tb.write(convolved_mat[i]);
				do{
					wait(clk->posedge_event());
				}while (!conv_2d_result_rdy_tb.read());
				
				conv_2d_result_vld_tb.write(0);
			}	
			conv_2d_result_tb.write(0);
			cout<<"@" << sc_time_stamp() <<" "<<this<<" data transmitted"<<endl;
			conv_result_sent_tb = sc_logic(1);
		}
		else{
			wait(clk->posedge_event());
		}
	}
};/**/

void conv::send_to_next_layer(void){
	//conv_2d_result_next.write(0);
	conv_2d_result_vld_next.write(0);
	while(true){
		if (conv_done == sc_logic(1) and conv_result_sent_next == sc_logic(0)){
			for (int i=0;i<CONV_ED_param;i++){
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