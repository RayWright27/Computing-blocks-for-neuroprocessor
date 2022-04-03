#include "tb_driver.h"
#include <iomanip>
#include <fstream>
#include <vector>
#include <cstring>
#include <png.h>
#include <cstdlib>
using std::vector;


void tb_driver::generate_reset(void){
     //генерация ресета
    rst.write(1);
    wait(clk->posedge_event());//next_trigger();
    rst.write(0);
    wait(clk->posedge_event());//next_trigger();
};
/*
vector<vector<vector<float>>> tb_driver::read_image(std::string filename)
{
    png_image image;
    memset(&image, 0, sizeof(image));
    image.version = PNG_IMAGE_VERSION;

    if (!png_image_begin_read_from_file(&image, filename.c_str())) {
        throw std::runtime_error
            (std::string("Failed to open image file: ") + image.message);
    }

    image.format = PNG_FORMAT_RGB;
    auto size = image.width * image.height * 3;
    vector<png_byte> buffer(size, 255);
    
    vector<vector<vector<float>>> image_tensor;
    
    auto ptr = buffer.begin();
    
    for (png_uint_32 i = 0; i < image.height; ++i) {
        image_tensor.push_back(vector<vector<float>>());
        for (png_uint_32 j = 0; j < image.width; ++j) {
            image_tensor[i].push_back(vector<float>());
            for (png_uint_32 k = 0; k < 3; ++k) {
                image_tensor[i][j].push_back(*ptr++ / 255.f);
            }
        }
    }
         
    return image_tensor;
    
}*/

void tb_driver::generate_biases(void) {
    if(biases_generated1 == sc_logic(0)){ 
        /*std::fstream file(  biases_conv_1_file, std::fstream::in);
        if (!file){
            cout<<"Файл " <<  biases_conv_1_file << " не найден\n";
        }
        for (int i = 0; i < KER; i++){
            file >> biases_flattened[i];
            
        }
        file.close();
        biases.write(0);
        biases_vld.write(0);*/
        for (int i=0;i<BIASES;i++){
            biases_flattened[i] = biases_firstConv[i];
            //cout<<biases_flattened[i]<<endl;
        }

        for (int i=0;i<BIASES;i++){
            biases_vld.write(1);
            biases_tmp=biases_flattened[i];
            biases.write(biases_tmp);
            do{
                wait(clk->posedge_event());
//                next_trigger();
            }while(!biases_rdy.read());
            biases_vld.write(0);
        }
        biases.write(0);
        biases_generated1 = sc_logic(1);
    }
    else{
        wait(clk->posedge_event());
//        next_trigger();
    }
};

void tb_driver::generate_kernel(void) {    
    if(kernels_generated1 == sc_logic(0)){
        /*
        std::fstream file( kernelfile, std::fstream::in);
        if (!file){
            cout<<"Файл " << kernelfile << " не найден\n";
        }
        for (int i = 0; i < KER; i++){
            file >> kernel_flattened[i];
            
       
        cout<<'\n';
        file.close(); 
        }/**/
        cout<<"VECTOR SIZE = "<<weights_firstConv.size()<<" "<<weights_firstConv[0].size()<<" "<<
        weights_firstConv[0][0].size()<<" "<<weights_firstConv[0][0][0].size()<<endl;
        for (int i = 0; i < M1; ++i) {
			for (int k = 0; k < N1; ++k) {
				for (int j = 0; j < C1; ++j) {
					for (int c = 0; c < L1; c++){
						kernel_flattened[i * N1 * C1 * L1 + 
						k * C1 * L1 + j * L1 + c] = weights_firstConv[i][k][j][c];
					}
				}
			}
		}        
        /*
        cout<<"kernel_flattened\n";
        for (int i = 0; i < KER; i++){
            cout <<std::fixed<<std::setprecision(35)<< kernel_flattened[i] << "\n ";
            
        } /**/ 
        kernel.write(0);
        kernel_vld.write(0);

        //поэлементная передача данных на порты
        double kernel_tmp;
        for (int i=0; i<KER; i++){
            kernel_vld.write(1);
            kernel_tmp=kernel_flattened[i];
            kernel.write(kernel_tmp);
            do{
                wait(clk->posedge_event());
        }while(!kernel_rdy.read());
        kernel_vld.write(0);
        }
        kernel.write(0);
        kernels_generated1 = sc_logic(1);
    }
    else{
        wait(clk->posedge_event());
    }
};

void tb_driver::generate_image(void){
    if(image_generated == sc_logic(0)){
        //auto image_tensor = read_image("daisy1.png");
        //cout<<"IMAGE VECTOR SIZE = "<<image_tensor.size();//<<" "<<image_vector[0].size()<<" "<<image_vector[0][0].size();
        /*
        for (int k = 0; k < N2; ++k){
            for (int j = 0; j < M2; j++){
                for (int i = 0; i < C1; ++i){
                    image_flattened[k * M2 * C1 + j *C1 + i] = image_vector[k][j][i]<<"\n";
                }
            } 
		} 
        */
        std::fstream file( imagefile, std::fstream::in);
        if (!file){
            cout<<"Файл " << imagefile << " не найден\n";
        }
        for (int i = 0; i < IMG; i++){
            file >> image_flattened[i];
            
        }
        file.close();
        /**/
        /*
            cout<<"------------image_flattened-----------"<<endl;
        for (int i=0;i<IMG;i++){
            cout<< image_flattened[i]<< " \n";
        } 
        /* */
        //поэлементная передача данных на порты
        image.write(0);
        image_vld.write(0);
            double image_tmp;
            for (int i=0; i<IMG; i++){
                image_vld.write(1);
                image_tmp=image_flattened[i];
                image.write(image_tmp);
                do{
                    wait(clk->posedge_event());
            }while(!image_rdy.read());
            image_vld.write(0);
            }
        image.write(0);
        image_generated = sc_logic(1);
    }
    else{
        wait(clk->posedge_event());
    }
};

void tb_driver::firstConv_sink(void){
    //инициализируем хэндшейк
    firstConv_result_rdy.write(0);
    wait(clk->posedge_event());

    while(true){
        if (firstConv_fetched == sc_logic(0)){
            for(int i=0;i<CONV_ED;i++){
                firstConv_result_rdy.write(1);
                do{
                    wait(clk->posedge_event());
                }while (!firstConv_result_vld.read());
                firstConv_result_flattened[i]=firstConv_result.read();
                firstConv_result_rdy.write(0);
                //fprintf(outfp, "%f\n", firstConv_result.read());
            }
            cout<<"@" << sc_time_stamp() <<" convolution data recieved from firstConv"<<endl;
            /* 
            for (int i=0;i<CONV_ED;i++){
                cout<<firstConv_result_flattened[i]<<" ";
            } */
            
            for (int i = 0; i < N3; i++) {
                    for (int j = 0; j < M3; j++) {
                        for (int k = 0; k < L3; k++) {
                            firstConv_result_arr[i][j][k] = 
                             firstConv_result_flattened[i*L3*M3+j*L3+k]; 
                        }
                    }
            } 
            #ifdef TB_OUTPUT    
                cout<<"[отладочный вывод][DRI_TB] результат firstConv: "<<endl;
                for (int i = 0; i < N3; i++) {
                    for (int j = 0; j < M3; j++) {
                        for (int k = 0; k < L3; k++) {
                            cout<<std::fixed <<std::setprecision(35)<< firstConv_result_arr[i][j][k] << "\n ";
                        }
                    }
                } 
                cout<<"[отладочный вывод][DRI_TB] результат firstConv________________________________________\n\n";
            #endif

            firstConv_fetched = sc_logic(1);
/**/    }
        else{
            wait(clk->posedge_event());
        }
        
        //sc_stop();
    }
};

void tb_driver::firstMaxPool_sink(void){
    firstMaxPool_result_rdy.write(0);
    while(true){
        if (firstMaxPool_fetched == sc_logic(0)){
            for(int i = 0; i < POOL_ED; i++){
                firstMaxPool_result_rdy.write(1);
                do{
                    wait(clk->posedge_event());
                }while (!firstMaxPool_result_vld.read());
                firstMaxPool_result_flattened[i]=firstMaxPool_result.read();
                firstMaxPool_result_rdy.write(0);
            }
            cout<<"@" << sc_time_stamp() <<" data from firstMaxPool recieved"<<endl;
            for (int i = 0; i < POOLOUT1; i++) {
                    for (int j = 0; j < POOLOUT2; j++) {
                        for (int k = 0; k < POOLOUT3; k++) {
                            firstMaxPool_result_arr[i][j][k] =
                             firstMaxPool_result_flattened[i*POOLOUT2*POOLOUT3+j*POOLOUT3+k]; 
                        }
                    }
            } 
            #ifdef TB_OUTPUT 
                cout<<"[отладочный вывод][DRI_TB] результат firstMaxPool:"<<endl;
                for (int i = 0; i < POOLOUT1; i++) {
                    for (int j = 0; j < POOLOUT2; j++) {
                        for (int k = 0; k < POOLOUT3; k++) {
                            cout <<std::setprecision(35)<<std::fixed<< 
                            firstMaxPool_result_arr[i][j][k] << "\n ";
                        }
                    }
                }
                 cout << "_________________[firstMaxPool]" << endl;
            #endif 
            firstMaxPool_fetched == sc_logic(1);
        }
        else{
            wait(clk->posedge_event());
        }
    }
    
};/**/

void tb_driver::generate_kernel2(void){
    if(kernels_generated2 == sc_logic(0)){
    //передача кернелов для secondConv из файла в динамический массив kernel_flattened2
        cout<<"VECTOR SIZE = "<<weights_secondConv.size()<<" "<<weights_secondConv[0].size()<<" "<<
        weights_secondConv[0][0].size()<<" "<<weights_secondConv[0][0][0].size()<<endl;
        for (int i = 0; i < M4; ++i) {
			for (int k = 0; k < N4; ++k) {
				for (int j = 0; j < C2; ++j) {
					for (int c = 0; c < L4; c++){
						kernel2_flattened[i * N4 * C2 * L4 + 
						k * C2 * L4 + j * L4 + c] = weights_secondConv[i][k][j][c];
                        
					}
				}
			}
		} 
        /*
        cout<<"kernel2_flattened\n";
        for (int i = 0; i < KER2; i++){
            cout <<std::fixed<<std::setprecision(35)<< kernel2_flattened[i] << "\n ";
            
        } /**/ 

        kernel2.write(0);
        kernel2_vld.write(0);

        //поэлементная передача данных на порты
        double kernel2_tmp;
        for (int i = 0; i < KER2; i++){
            kernel2_vld.write(1);
            kernel2_tmp=kernel2_flattened[i];
            kernel2.write(kernel2_tmp);
            do{
                wait(clk->posedge_event());
            }while(!kernel2_rdy.read());
            kernel2_vld.write(0);
        }
        kernel2.write(0);
        kernels_generated2 = sc_logic(1);
    }
    else{
        wait(clk->posedge_event());
    }
};

void tb_driver::generate_biases2(void){
    for (int i = 0; i < BIASES2; i++){
        biases2_flattened[i] = biases_secondConv[i];
        
    }

    biases2.write(0);
    biases2_vld.write(0);
    
    double biases2_tmp;
    for (int i = 0 ;i < BIASES2;i++){
        biases2_vld.write(1);
        biases2_tmp=biases2_flattened[i];
        biases2.write(biases2_tmp);
        do{
            wait(clk->posedge_event());
        }while(!biases2_rdy.read());
        biases2_vld.write(0);
    }
    biases2.write(0);
};

void tb_driver::secondConv_sink(void){
    //инициализируем хэндшейк
    secondConv_result_rdy.write(0);
    //wait(clk->posedge_event());
    while(true){
        if (secondConv_fetched == sc_logic(0)){
            for(int i=0;i<CONV_ED2;i++){
                secondConv_result_rdy.write(1);
                do{
                    wait(clk->posedge_event());
                }while (!secondConv_result_vld.read());
                secondConv_result_flattened[i]=secondConv_result.read();
                secondConv_result_rdy.write(0);
                //fprintf(outfp, "%f\n", conv_2d_1_result.read());
            }
            cout<<"@" << sc_time_stamp() <<" convolution data from secondConv recieved"<<endl;
            #ifdef TB_OUTPUT
            /* 
            for(int i=0;i<CONV_ED2+1;i++){
               cout<<std::setprecision(35)<<
               std::fixed<<secondConv_result_flattened[i]<<endl;
            }*/
            for (int i = 0; i < N5; i++) {
                    for (int j = 0; j < M5; j++) {
                        for (int k = 0; k < L4; k++) {
                            secondConv_result_arr[i][j][k]=secondConv_result_flattened[i*M5*L4+j*L4+k]; 
                        }
                    }
            } 
           
                cout<<"[отладочный вывод][DRI_TB] результат secondConv:"<<endl;
                
                for (int i = 0; i < N5; i++) {
                    for (int j = 0; j < M5; j++) {
                            for (int k = 0; k < L4; k++) {
                            cout <<std::setprecision(35)<<std::fixed<<secondConv_result_arr[i][j][k] << "\n ";
                        }
                       
                    } 
                }
                cout << "_________________[secondConv]" << endl;
            #endif 
            secondConv_fetched = sc_logic(1);
        }
        else{
            wait(clk->posedge_event());
        }
    }
};

void tb_driver::secondMaxPool_sink(void){
    secondMaxPool_result_rdy.write(0);
    while(true){
        if (secondMaxPool_fetched == sc_logic(0)){
            for(int i = 0; i < POOL_ED2; i++){
                secondMaxPool_result_rdy.write(1);
                do{
                    wait(clk->posedge_event());
                }while (!secondMaxPool_result_vld.read());
                secondMaxPool_result_flattened[i]=secondMaxPool_result.read();
                secondMaxPool_result_rdy.write(0);
            }
            cout<<"@" << sc_time_stamp() <<" data from secondMaxPool recieved"<<endl;
            for (int i = 0; i < POOLOUT11; i++) {
                    for (int j = 0; j < POOLOUT22; j++) {
                        for (int k = 0; k < POOLOUT33; k++) {
                            secondMaxPool_result_arr[i][j][k] =
                            secondMaxPool_result_flattened[i*POOLOUT22*POOLOUT33+j*POOLOUT33+k]; 
                        }
                    }
            } 
            #ifdef TB_OUTPUT 
                cout<<"[отладочный вывод][DRI_TB] результат secondMaxPool:"<<endl;
                for (int i = 0; i < POOLOUT11; i++) {
                    for (int j = 0; j < POOLOUT22; j++) {
                        for (int k = 0; k < POOLOUT33; k++) {
                            cout <<std::setprecision(35)<<std::fixed<< 
                            secondMaxPool_result_arr[i][j][k] << "\n ";
                        }
                    }
                }
                 cout << "_________________[secondMaxPool]" << endl;
            #endif 
            secondMaxPool_fetched == sc_logic(1);
        }
        else{
            wait(clk->posedge_event());
        }
    }
    
};/**/

void tb_driver::generate_kernel3(void){
    if(kernels_generated3 == sc_logic(0)){
        cout<<"VECTOR SIZE = "<<weights_thirdConv.size()<<" "<<weights_thirdConv[0].size()<<" "<<
        weights_thirdConv[0][0].size()<<" "<<weights_thirdConv[0][0][0].size()<<endl;
        
        for (int i = 0; i < M6; ++i) {
			for (int k = 0; k < N6; ++k) {
				for (int j = 0; j < C3; ++j) {
					for (int c = 0; c < L5; ++c){ 
						kernel3_flattened[i * N6 * C3 * L5 + 
						k * C3 * L5 + j * L5 + c] = weights_thirdConv[i][k][j][c];
                       /*
                        cout<<std::scientific<<"kernel3_flattened["<<i * N6 * C3 * L5 + 
						k * C3 * L5 + j * L5 + c<<"]="<<kernel3_flattened[i * N6 * C3 * L5 + 
						k * C3 * L5 + j * L5 + c]<<" | weights_thirdConv=["<<i<<"]["<<k<<"]["<<j<<"]["<<c<<"]="
                        <<weights_thirdConv[i][k][j][c]<<"\n";/**/

                        lmao[i*N6*C3*L5 + k*C3*L5 + j*L5 + c]=weights_thirdConv[i][k][j][c];
                        
					}
				}
			}
		} 
        /*
        cout<<"kernel3_flattened\n";
        for (int i = 0; i < KER3; i++){
            cout <<std::scientific<<"kernel3_flattened["<<i<<"]="<< kernel3_flattened[i] << "\n ";
            
        } 
        cout<<"\n\n\n\n\n";/**/ 

        kernel3.write(0);
        kernel3_vld.write(0);

        //поэлементная передача данных на порты
        /*
          cout<<"KERNEL3 TEST----------\n";/**/
        double kernel3_tmp;
        for (int i = 0; i < KER3; i++){
            kernel3_vld.write(1);/*
             cout<<"---------------------------------------------\n";
            cout<<"kernel3_tmp="<<kernel3_tmp<<" | kernel3_flattened["<<i<<"]="<<kernel3_flattened[i]<<"\n";
            kernel3_tmp=kernel3_flattened[i];
            kernel3.write(kernel3_tmp); 
            cout<<"kernel3_tmp="<<kernel3_tmp<<" | kernel3_flattened["<<i<<"]="<<kernel3_flattened[i]<<"\n";
            cout<<"---------------------------------------------\n";/**/
            /*
             cout<<"---------------------------------------------\n";
            cout<<"kernel3_tmp="<<kernel3_tmp<<" | lmao["<<i<<"]="<<lmao[i]<<"\n";/**/
            kernel3_tmp=lmao[i];
            kernel3.write(kernel3_tmp); /*
            cout<<"kernel3_tmp="<<kernel3_tmp<<" | lmao["<<i<<"]="<<lmao[i]<<"\n";
            cout<<"---------------------------------------------\n";/**/
            do{
                wait(clk->posedge_event());
            }while(!kernel3_rdy.read());
            kernel3_vld.write(0);
        }
        kernel3.write(0);
        kernels_generated3 = sc_logic(1);
    }
    else{
        wait(clk->posedge_event());
    }
};

void tb_driver::generate_biases3(void){
    for (int i = 0; i < BIASES3; i++){
        biases3_flattened[i] = biases_thirdConv[i];
    }/*
    cout<<"biases3_flattened\n";
        for (int i = 0; i < BIASES3; i++){
            cout <<std::fixed<<std::setprecision(20)<< biases3_flattened[i] << "\n ";
            
        } 
        cout<<"\n\n\n\n\n";/**/

    biases3.write(0);
    biases3_vld.write(0);
    
    double biases3_tmp;
    for (int i = 0 ;i < BIASES3;i++){
        biases3_vld.write(1);
        biases3_tmp=biases3_flattened[i];
        biases3.write(biases3_tmp);
        do{
            wait(clk->posedge_event());
        }while(!biases3_rdy.read());
        biases3_vld.write(0);
    }
    biases3.write(0);
};

void tb_driver::thirdConv_sink(void){
    //инициализируем хэндшейк
    thirdConv_result_rdy.write(0);
    //wait(clk->posedge_event());
    while(true){
        if (thirdConv_fetched == sc_logic(0)){
            for(int i=0;i<CONV_ED3;i++){
                thirdConv_result_rdy.write(1);
                do{
                    wait(clk->posedge_event());
                }while (!thirdConv_result_vld.read());
                thirdConv_result_flattened[i]=thirdConv_result.read();
                thirdConv_result_rdy.write(0);
                //fprintf(outfp, "%f\n", conv_2d_1_result.read());
            }
            cout<<"@" << sc_time_stamp() <<" convolution data from thirdConv recieved"<<endl;
            #ifdef TB_OUTPUT
            /* 
            for(int i=0;i<CONV_ED3+1;i++){
               cout<<std::setprecision(35)<<
               std::fixed<<thirdConv_result_flattened[i]<<endl;
            }*/
            for (int i = 0; i < N7; i++) {
                    for (int j = 0; j < M7; j++) {
                        for (int k = 0; k < L5; k++) {
                            thirdConv_result_arr[i][j][k]=thirdConv_result_flattened[i*M7*L5+j*L5+k]; 
                        }
                    }
            } 
           
                cout<<"[отладочный вывод][DRI_TB] результат thirdConv:"<<endl;
                
                for (int i = 0; i < N7; i++) {
                    for (int j = 0; j < M7; j++) {
                            for (int k = 0; k < L5; k++) {
                            cout <<std::setprecision(35)<<std::fixed<<thirdConv_result_arr[i][j][k] << "\n ";
                        }
                       
                    } 
                }
                cout << "_________________[thirdConv]" << endl;
            #endif 
            thirdConv_fetched = sc_logic(1);
        }
        else{
            wait(clk->posedge_event());
        }
    }
};

void tb_driver::generate_kernel4(void){
    if(kernels_generated4 == sc_logic(0)){
        cout<<"weights_fourthConv SIZE = "<<weights_fourthConv.size()<<" "<<weights_fourthConv[0].size()<<" "<<
        weights_fourthConv[0][0].size()<<" "<<weights_fourthConv[0][0][0].size()<<endl;
        for (int i = 0; i < M8; ++i) {
			for (int k = 0; k < N8; ++k) {
				for (int j = 0; j < C4; ++j) {
					for (int c = 0; c < L6; c++){
						kernel4_flattened[i * N8 * C4 * L6 + 
						k * C4 * L6 + j * L6 + c] = weights_fourthConv[i][k][j][c];
					}
				}
			}
		} 
        /*
        cout<<"TB DRIVER kernel4_flattened---------------------------------------------------\n";
        for (int i = 0; i < KER4; i++){
            cout<< kernel4_flattened[i] << "\n ";
            
        } /**/ 

        kernel4.write(0);
        kernel4_vld.write(0);

        //поэлементная передача данных на порты
        double kernel4_tmp;
        for (int i = 0; i < KER4; i++){
            kernel4_vld.write(1);
            kernel4_tmp=kernel4_flattened[i];
            kernel4.write(kernel4_tmp);
            do{
                wait(clk->posedge_event());
            }while(!kernel4_rdy.read());
            kernel4_vld.write(0);
        }
        kernel4.write(0);
        kernels_generated4 = sc_logic(1);
    }
    else{
        wait(clk->posedge_event());
    }
};

void tb_driver::generate_biases4(void){
    for (int i = 0; i < BIASES4; i++){
        biases4_flattened[i] = biases_fourthConv[i];
    }

    biases4.write(0);
    biases4_vld.write(0);
    
    double biases4_tmp;
    for (int i = 0 ;i < BIASES4;i++){
        biases4_vld.write(1);
        biases4_tmp=biases4_flattened[i];
        biases4.write(biases4_tmp);
        do{
            wait(clk->posedge_event());
        }while(!biases4_rdy.read());
        biases4_vld.write(0);
    }
    biases4.write(0);
};

void tb_driver::generate_coeff(void){
    cout<<"weights_firstDense SIZE = "<<weights_firstDense.size()<<" "<<weights_firstDense[0].size()<<endl;
    for (int j = 0; j < DENSE1_COEFF1; ++j) {
        for (int i = 0; i < DENSE1_COEFF2; i++){
            coeff_flattened[j*DENSE1_COEFF2 + i] = weights_firstDense[j][i];
        }
    }
    /*
    cout<<"-----------------------COEFF1 TB DRIVER-------------------------------------------"<<endl;
    for (int i = 0; i < DENSE1_COEFF; i++){
        cout<<"coeff_flattened["<<i<<"]="<<coeff_flattened[i]<<endl;
    }
    cout<<"------------------------------------------------------------------"<<endl;
    /**/
    double coeff_tmp;
    coeff.write(0);
    coeff_vld.write(0);
    for (int i = 0; i < DENSE1_COEFF; i++){
        coeff_vld.write(1);
        coeff_tmp=coeff_flattened[i];
        coeff.write(coeff_tmp);
        do{
            wait(clk->posedge_event());
        }while(!coeff_rdy.read());
        coeff_vld.write(0);
    }
    coeff.write(0);
    
};/**/

void tb_driver::generate_biases5(void){
    //cout<<"biases5_arr-----------------------------------------";
    for (int i = 0; i < BIASES5; i++){
        biases5_arr[i] = biases_firstDense[i];
        //cout<<"biases5_arr["<<i<<"]="<<biases5_arr[i]<<"\n";
    }
    //cout<<"----------------------------------------------------\n\n";

    biases5.write(0);
    biases5_vld.write(0);
    for (int i = 0; i < BIASES5; i++){
        biases5_vld.write(1);
        biases5.write(biases5_arr[i]);
        do{
            wait(clk->posedge_event());
        }while(!biases5_rdy.read());
        biases5_vld.write(0);
    }
};
/*
void tb_driver::dense1_sink(void){
    dense1_result_rdy.write(0);
    while(true){
        if(dense1_fetched == sc_logic(0)){
            for(int i = 0; i < DENSE1_OUT; i++){
                dense1_result_rdy.write(1);
                do{
                    wait(clk->posedge_event());
                }while (!dense1_result_vld.read());
                dense1_result_arr[i]=dense1_result.read();
                dense1_result_rdy.write(0);
            }
            cout<<"@" << sc_time_stamp() 
            <<" data from DENSE1 recieved"<<endl;
            #ifdef TB_OUTPUT
            cout<<"____________________________________"<<endl; 
            for(int i = 0; i < DENSE1_OUT; i++){
                cout<<std::setprecision(35)<<std::fixed
                <<dense1_result_arr[i]<<endl;
            }
            cout<<"____________________________________[DENSE1]"<<endl;
            #endif 
            dense1_fetched = sc_logic(1);
        }
        else{
            wait(clk->posedge_event());
        }
    }
};/**/
void tb_driver::generate_coeff2(void){
    cout<<"weights_labeller SIZE = "<<weights_labeller.size()<<" "<<weights_labeller[0].size()<<endl;
    for (int j = 0; j < DENSE2_COEFF1; ++j) {
        for (int i = 0; i < DENSE2_COEFF2; i++){
            coeff2_flattened[j*DENSE2_COEFF2 + i] = weights_labeller[j][i];
            cout<<"weights_labeller["<<j<<"]["<<i<<"]="<<weights_labeller[j][i]<<"\n";
        }
    }
    
    cout<<"-----------------------------TB_DRIVER COEFFS FOR secondDense-------------------------------------"<<endl;
    for (int i = 0; i < DENSE2_COEFF; i++){
        cout<<"coeff2_flattened["<<i<<"]="<<coeff2_flattened[i]<<endl;
    }
    cout<<"------------------------------------------------------------------"<<endl;
    /**/
    double coeff_tmp;
    coeff2.write(0);
    coeff2_vld.write(0);
    for (int i = 0; i < DENSE2_COEFF; i++){
        coeff2_vld.write(1);
        coeff_tmp=coeff2_flattened[i];
        coeff2.write(coeff_tmp);
        do{
            wait(clk->posedge_event());
        }while(!coeff2_rdy.read());
        coeff2_vld.write(0);
    }
    coeff2.write(0);
    
};/**/

void tb_driver::generate_biases6(void){
    for (int i = 0; i < BIASES6; i++){
        biases6_arr[i] = biases_labeller[i];
        
    }

    biases6.write(0);
    biases6_vld.write(0);
    for (int i = 0; i < BIASES6; i++){
        biases6_vld.write(1);
        biases6.write(biases6_arr[i]);
        do{
            wait(clk->posedge_event());
        }while(!biases6_rdy.read());
        biases6_vld.write(0);
    }
};
/**/
/*
void tb_driver::dense2_sink(void){
    dense2_result_rdy.write(0);
    while(true){
        if(dense2_fetched == sc_logic(0)){
            for(int i = 0; i < DENSE2_OUT; i++){
                dense2_result_rdy.write(1);
                do{
                    wait(clk->posedge_event());
                }while (!dense2_result_vld.read());
                dense2_result_arr[i]=dense2_result.read();
                dense2_result_rdy.write(0);
            }
            cout<<"@" << sc_time_stamp() 
            <<" data from DENSE2 recieved"<<endl;
            #ifdef TB_OUTPUT
            cout<<"____________________________________"<<endl; 
            for(int i = 0; i < DENSE2_OUT; i++){
                cout<<std::setprecision(64)<<std::fixed
                <<dense2_result_arr[i]<<endl;
            }
            cout<<"____________________________________[DENSE2]"<<endl;
            #endif 
            dense2_fetched = sc_logic(1);
        }
        else{
            wait(clk->posedge_event());
        }
    }
};/**/

