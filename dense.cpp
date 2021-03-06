#include "dense.h"
#include <math.h>
#include <assert.h>
void softmax(sc_fixed<W_LEN_s, I_LEN_s> *input, size_t size) {
    cout<<"------------------------------------------------------\n";
    auto out(input);
    size_t sz = size;
    sc_fixed<W_LEN_s, I_LEN_s> sum = 0;
    const sc_fixed<W_LEN_s, I_LEN_s> zero = 0;
    for (int i = 0; i < sz; ++i) {
        //cout<<"softmax_out["<<i<<"]="<<out[i]<<"\n";
        out[i] = exp(out[i]);
        //cout<<"softmax_out["<<i<<"]="<<out[i]<<"\n";
        sum += out[i];
        //cout<<"softmax_sum="<<sum<<"\n";
    }/**/
    if (sum != zero) {
        for (size_t i = 0; i < sz; ++i) {
            out[i] /= sum;
        }
    }
    cout<<"------------------------------------------------------\n";
}

void dense::recieve_input(void){
    input_rdy.write(0);
    while(true){
        if(input_recieved == sc_logic(0)){
            for(int i = 0; i < IN_param; i++){ 
                input_rdy.write(1);
                do{
                    wait(clk->posedge_event());
                }while(!input_vld.read());
                dense_input[i]=input.read();
                input_rdy.write(0);
            }
            /*
            cout<<"@"<<sc_time_stamp()<<" dense input recieved ["<<this<<"]"<<endl;
            for(int i = 0; i < IN_param; i++){
                cout<<dense_input[i]<<endl;
            }
            cout<<endl;/**/
            input_recieved = sc_logic(1);
                
        }
        else if(input_recieved == sc_logic(1)){
            wait(clk->posedge_event());
            
        }
    }
};
 
void dense::recieve_coeff(void){
    coeff_rdy.write(0);
    while(true){
        if(coeff_recieved == sc_logic(0)){
            for(int i = 0; i < DENSE_COEFF_param; i++){
                coeff_rdy.write(1);
                do{
                    wait(clk->posedge_event());
                }while(!coeff_vld.read());
                coeff_flattened[i] = coeff.read();
                coeff_rdy.write(0);
            }
            for(int j = 0; j < DENSE_COEFF1_param; j++){
                for(int i = 0; i < DENSE_COEFF2_param; i++){
                    coeff_arr[j][i] = coeff_flattened[DENSE_COEFF2_param * j + i];
                }
            }/*
             cout<<"---------------------------coeffs:["<<this<<"]----------------------------------"<<endl;
           for(int j = 0; j < DENSE_COEFF1_param; j++){
                for(int i = 0; i < DENSE_COEFF2_param; i++){
                    cout<<"coeff_arr["<<j<<"]["<<i<<"]="<<coeff_arr[j][i]<<"\n";
                }
            }
            cout<<endl<<endl<<endl<<endl;/**/
            coeff_recieved = sc_logic(1);
            cout<<"@"<<sc_time_stamp()<<" dense coeff recieved ["<<this<<"]"<<endl;
        }
        else{
            coeff_rdy.write(0);
            wait(clk->posedge_event());
        }   
    }
};

void dense::recieve_biases(void){
    biases_rdy.write(0);
    while(true){
        if(biases_recieved == sc_logic(0)){
            for(int i = 0; i < BIASES_param; i++){
                biases_rdy.write(1);
                do{
                    wait(clk->posedge_event());
                }while(!biases_vld.read());
                biases_arr[i]=biases.read();
                biases_rdy.write(0);
            }/*
            cout<<"---------------------------biases:["<<this<<"]----------------------------------"<<endl;
            for(int i = 0; i < BIASES_param; i++){
                cout<<"biases_arr["<<i<<"]="<<biases_arr[i]<<'\n';
            }/**/
            biases_recieved = sc_logic(1);
            cout<<"@"<<sc_time_stamp()<<" dense biases recieved ["
            <<this<<"]"<<endl;

        }
        else{
            biases_rdy.write(0);
            wait(clk->posedge_event());
        }
    }
};

void dense::dense_func(void) {
    while(true){
        if(biases_recieved == sc_logic(1) and coeff_recieved == sc_logic(1) and input_recieved == sc_logic(1) and dense_done == sc_logic(0)){
            for(int i = 0; i < DENSE_COEFF1_param; i++) {
                for (int j = 0; j < DENSE_COEFF2_param; j++) {
                    dense_result_arr[j] += coeff_arr[i][j] * dense_input[i];
                    /*
                    cout<<"dense_result_arr["<<j<<"]+="<<dense_result_arr[j]<<" | coeff_arr["<<i<<"]["<<j<<"]="<<
                    coeff_arr[i][j]<<" |  dense_input["<<i<<"]="<< dense_input[i]<<'\n';
                    /**/
                    wait(clk->posedge_event());    
                }			
            }
           // cout<<"dense_result_arr PRE activation func ["<<this<<"]\n";
            for (int i = 0; i < DENSE_COEFF2_param; i++){
                dense_result_arr[i] += biases_arr[i];
                //cout<<"dense_result_arr["<<i<<"]="<<dense_result_arr[i]<<"\n";
                wait(clk->posedge_event());
            }
            for (int i = 0; i < DENSE_COEFF2_param; i++){
                if (func==1){
                    if (dense_result_arr[i] <= 0) {
                        dense_result_arr[i]=0;
                        //wait(clk->posedge_event());
                        //next_trigger();
                    }
                }
            }
            for (int i = 0; i < DENSE_COEFF2_param; i++){
                dense_result_arr_2[i]=dense_result_arr[i];
            }
            if (func==2){
                softmax(dense_result_arr_2, DENSE_COEFF2_param);
            }
             for (int i = 0; i < DENSE_COEFF2_param; i++){
                dense_result_arr_3[i]=dense_result_arr_2[i];
            }
            
           // cout<<"dense_result_arr AFTER activation func ["<<this<<"]----------------------------------"<<endl;
            for (int i = 0; i < OUT_param; i++) {
                cout<<"dense_result["<<i<<"]="<<dense_result_arr_3[i] <<endl;
            }
            cout<<"-------------------------------------------------------------"<<endl;
            cout <<endl<< endl;
            /**/
             cout<<"@" << sc_time_stamp() <<" dense layer calculated ["
            <<this<<"]"<<endl;
            dense_done = sc_logic(1);
        }
        else{
            wait(clk->posedge_event());
        }
    }
    /**/
};

void dense::send_to_dri_tb(void){
    dense_result_tb.write(0);
    while(true){
        if(dense_done == sc_logic(1) and dense_result_sent_tb == sc_logic(0)){
            for(int i = 0; i < OUT_param; i++){
                dense_result_vld_tb.write(1);
                dense_result_tb.write(dense_result_arr_3[i]);
                do{
                    wait(clk->posedge_event());
                }while(!dense_result_rdy_tb.read());
                dense_result_vld_tb.write(0);
            }
            dense_result_tb.write(0);
            cout<<"@" << sc_time_stamp() 
            <<" dense layer output sent to dri_tb ["
            <<this<<"]"<<endl;
            dense_result_sent_tb == sc_logic(1);
        }
        else{
            wait(clk->posedge_event());
        }
    }
};

void dense::send_to_next(void){
    dense_result_next.write(0);
    while(true){
        if(dense_done == sc_logic(1) and dense_result_sent_next == sc_logic(0)){
            for(int i = 0; i < OUT_param; i++){
                dense_result_vld_next.write(1);
                dense_result_next.write(dense_result_arr_3[i]);
                do{
                    wait(clk->posedge_event());
                }while(!dense_result_rdy_next.read());
                
                dense_result_vld_next.write(0);
            }
            dense_result_next.write(0);
            cout<<"@" << sc_time_stamp() <<" dense layer output sent to next layer ["
            <<this<<"]"<<endl;
            dense_result_sent_next = sc_logic(1);
        }
        else{
            wait(clk->posedge_event());
        }
    }
};