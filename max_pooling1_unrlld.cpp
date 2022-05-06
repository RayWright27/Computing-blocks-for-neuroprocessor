#include "max_pooling1_unrlld.h"
#include <iomanip>
#include <fstream>
sc_fixed<W_LEN_i, I_LEN_i> max_pooling1_unrlld::maximum(sc_fixed<W_LEN_i, I_LEN_i> a, sc_fixed<W_LEN_i, I_LEN_i> b){
        if (a > b) {
            return a;
        }
        else if (a < b) {
            return b;
        }
        else if (a = b) {
            return a;
        }
        return 0;
};

void max_pooling1_unrlld::recieve_image(int c, sc_fixed<W_LEN_i, I_LEN_i>* featuremap,
					                    sc_fixed<W_LEN_i, I_LEN_i>*** featuremap_in){
    image_rdy[c].write(0);
    if( image_recieved[c] == sc_logic(0)){
        for (int i = 0; i < POOL_IN_param; i++){
            image_rdy[c].write(1);
            do{
                wait(clk->posedge_event());
            }while (!image_vld[c].read());
            featuremap[i] = image[c].read();
            image_rdy[c].write(0);
        }
        
        for (int k = 0; k < F_M2_param; k++) {
            for (int i = 0; i < F_M1_param; i++) {
                for (int j = 0; j < 1; j++) {
                    featuremap_in[k][i][j] = 
                    featuremap[k * F_M1_param * 1 + i * 1 + j];/*
                    cout<<"featuremap_in["<<k<<"]["<<j<<"]["<<i<<"]="
                    << featuremap_in[k][j][i].to_hex() 
					<<" | "<< featuremap_in[k][j][i].to_bin()<< "\n ";/**/
                }
            }
        }
        image_recieved[c] = sc_logic(1);
        cout <<"@"<<sc_time_stamp()<<" max_pooling input recieved "<<c<<" ["<<this<<"]\n";
        /*
        for (int k = 0; k < F_M2_param; k++) {
            for (int i = 0; i < F_M1_param; i++) {
                for (int j = 0; j < F_M3_param; j++) {
                    cout <<std::setprecision(35)<<std::fixed<< 
                    featuremap[k * F_M1_param * F_M3_param + i * F_M3_param + j] << "\n ";
                }
            }
        }
        cout << endl;
        /**/
        /*
        cout << "[отладочный вывод][max_pooling] размеры кернела:"<< " P1_param = " << P1_param
        << " P2_param = " << P2_param<< endl;
        cout << "размеры выходной матрицы: " << endl;
        cout << "POOLOUT1_param= " << POOLOUT1_param << " POOLOUT2_param= " << POOLOUT2_param 
        << " POOLOUT3_param= " << POOLOUT3_param<< endl;
        cout << endl;
        /**/
    }
    else{
        wait(clk->posedge_event());
    }

};

void max_pooling1_unrlld::max_pooling(int c, sc_fixed<W_LEN_i, I_LEN_i>*** featuremap_in,
                     sc_fixed<W_LEN_i, I_LEN_i>*** result,
					 sc_fixed<W_LEN_i, I_LEN_i>* max_pooled) 
{
    for (int k = 0; k < POOLOUT2_param; k++) {
        for (int i = 0; i < POOLOUT1_param; i++) {
            for (int j = 0; j < 1; j++) {
                result[k][i][j]=0;
            }
        }
    }
    while(true){
        if( image_recieved[c] == sc_logic(1) and max_pool_done[c] == sc_logic(0)){
            for (int k = 0; k < POOLOUT2_param; k++) {
                for (int i = 0; i < POOLOUT1_param; i++) {//сдвиг кернела в матрице признаков
                    for (int j = 0; j < P2_param; j++) {
                        for (int m = 0; m < P1_param; m++) {
                            for (int n = 0; n < POOLOUT3_param; n++) {
                                value = featuremap_in[k * P2_param + j][i * P1_param + m][n];
                                result[k][i][n] = std::max(result[k][i][n], value);
                                wait(clk->posedge_event());
                            }       
                        }
                    }
                }
            }
              
            cout << "[отладочный вывод][max_pooling] результат" << endl;
            for (int k = 0; k < POOLOUT2; k++) {
                for (int i = 0; i < POOLOUT1; i++) {
                    for (int j = 0; j < 1; j++) {
                        cout<<"result["<<k<<"]["<<i<<"]["<<j<<"] = " << result[k][i][j].to_bin()<<" ";
                    }
                    cout << endl;
                }
            }        
            cout << endl;
            /**/
            for (int k = 0; k < POOLOUT2_param; k++) {
				for (int i = 0; i < POOLOUT1_param; i++) {
					for (int j = 0; j < POOLOUT3_param; j++) {
						max_pooled[k*POOLOUT1_param*POOLOUT3_param+i*POOLOUT3_param+j]=
                        result[k][i][j]; 
                        wait(clk->posedge_event());
                    }
				}
			}
            if (verbose_param == 1){
                cout<<"отладочный вывод ["<<this<<"] max_pooling\n";
                for(int i =0; i < POOL_ED_param/POOLOUT3_param; i++){
                    cout<<"max_pooled["<<i<<"] = "<<max_pooled[i]<<endl;
                }/**/
            }
            max_pool_done[c] = sc_logic(1);
            cout<<"@"<<sc_time_stamp()<<" max_pooling done ["<<this<<"]\n";
           
        }
        else{
            wait(clk->posedge_event());
        }
    }
};
/*
void max_pool::send_to_dri_tb(void){
    max_pool_result_vld_tb.write(0);
    while(true){
        if( max_pool_done == sc_logic(1) and max_pool_result_sent_tb == sc_logic(0)){
            for(int i = 0; i < POOL_ED_param; i++){
                max_pool_result_vld_tb.write(1);
                max_pool_result_tb.write(max_pooled[i]);
                do{
                    wait(clk->posedge_event());
                }while (!max_pool_result_rdy_tb.read());
                
                max_pool_result_vld_tb.write(0);
            }
            max_pool_result_tb.write(0);
            cout<<"@"<<sc_time_stamp()<<" max_pool_2d_1 ["<<this<<"] data transmitted to tb"<<endl;
            max_pool_result_sent_tb = sc_logic(1);
        }
        else{
            wait(clk->posedge_event());
        }
    }
};

void max_pool::send_to_next(void){
    max_pool_result_vld_next.write(0);
    while(true){
        if( max_pool_done == sc_logic(1) and max_pool_result_sent_next == sc_logic(0)){
            for(int i = 0; i < POOL_ED_param; i++){
                max_pool_result_vld_next.write(1);
                max_pool_result_next.write(max_pooled[i]);
                do{
                    wait(clk->posedge_event());
                }while (!max_pool_result_rdy_next.read());
                
                max_pool_result_vld_next.write(0);
            }
            max_pool_result_next.write(0);
            cout<<"@"<<sc_time_stamp()<<" max_pool_2d_1 ["<<this<<"] data transmitted to next layer"<<endl;
            max_pool_result_sent_next = sc_logic(1);
        }
        else{
            wait(clk->posedge_event());
        }
    }
};/**/