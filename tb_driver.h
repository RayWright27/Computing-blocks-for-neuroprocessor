#include <vector>
#include <cstring>
#include <macro.h>
#include <systemc.h>
#include "weights.hpp"
#include <png.h>
using std::vector;


SC_MODULE(tb_driver){
	sc_in<bool>     clk;
    sc_out<bool>    rst; 
    sc_in<bool>     kernel_rdy;
    sc_out<bool>    kernel_vld;
    sc_in<bool>     image_rdy;
    sc_out<bool>    image_vld;
    sc_in<bool>     biases_rdy;
    sc_out<bool>    biases_vld;
    sc_in<bool>     firstConv_result_vld;
    sc_out<bool>    firstConv_result_rdy;
    sc_in<double>   firstConv_result;
    sc_out<double>  kernel, image, biases;

    sc_in<double>   firstMaxPool_result;
    sc_in<bool>     firstMaxPool_result_vld;
    sc_out<bool>    firstMaxPool_result_rdy;

    sc_out<double>  kernel2, biases2;
    sc_in<bool>     kernel2_rdy;
    sc_out<bool>    kernel2_vld;
    sc_in<bool>     biases2_rdy;
    sc_out<bool>    biases2_vld;

    sc_in<double>   secondConv_result;
    sc_in<bool>     secondConv_result_vld;
    sc_out<bool>    secondConv_result_rdy;

    sc_in<double>   secondMaxPool_result;
    sc_in<bool>     secondMaxPool_result_vld;
    sc_out<bool>    secondMaxPool_result_rdy;

    sc_out<double>  kernel3, biases3;
    sc_in<bool>     kernel3_rdy;
    sc_out<bool>    kernel3_vld;
    sc_in<bool>     biases3_rdy;
    sc_out<bool>    biases3_vld;

    sc_in<double>   thirdConv_result;
    sc_in<bool>     thirdConv_result_vld;
    sc_out<bool>    thirdConv_result_rdy;

    sc_in<double>   thirdMaxPool_result;
    sc_in<bool>     thirdMaxPool_result_vld;
    sc_out<bool>    thirdMaxPool_result_rdy;

    sc_out<double>  kernel4, biases4;
    sc_in<bool>     kernel4_rdy;
    sc_out<bool>    kernel4_vld;
    sc_in<bool>     biases4_rdy;
    sc_out<bool>    biases4_vld;

    sc_in<double>   fourthConv_result;
    sc_in<bool>     fourthConv_result_vld;
    sc_out<bool>    fourthConv_result_rdy;

    sc_in<double>   fourthMaxPool_result;
    sc_in<bool>     fourthMaxPool_result_vld;
    sc_out<bool>    fourthMaxPool_result_rdy;
 

    sc_out<double>  coeff;
    sc_in<bool>     coeff_rdy;
    sc_out<bool>    coeff_vld;
    sc_out<double>  biases5;
    sc_in<bool>     biases5_rdy;
    sc_out<bool>    biases5_vld;

    sc_in<double>   firstDense_result;
    sc_in<bool>     firstDense_result_vld;
    sc_out<bool>    firstDense_result_rdy;

    sc_out<double>  coeff2;
    sc_in<bool>     coeff2_rdy;
    sc_out<bool>    coeff2_vld;
    sc_out<double>  biases6;
    sc_in<bool>     biases6_rdy;
    sc_out<bool>    biases6_vld;

    sc_in<double>   secondDense_result;
    sc_in<bool>     secondDense_result_vld;
    sc_out<bool>    secondDense_result_rdy;

    double          biases_tmp;  
    double          image_flattened[IMG];
    double          kernel_flattened[KER];
	double          biases_flattened[BIASES];
    
    double*         kernel2_flattened;
    double          biases2_flattened[BIASES2];

    double*         kernel3_flattened;
    double          biases3_flattened[BIASES3];
    
    double*         kernel4_flattened;
    double          biases4_flattened[BIASES4];

    double*         firstConv_result_flattened;
    double***       firstConv_result_arr;

    double***       firstMaxPool_result_arr;
    double*         firstMaxPool_result_flattened;

    double***       secondConv_result_arr;
    double*         secondConv_result_flattened;

    double***       secondMaxPool_result_arr;
    double*         secondMaxPool_result_flattened;

    double***       thirdConv_result_arr;
    double*         thirdConv_result_flattened;

    double***       thirdMaxPool_result_arr;
    double*         thirdMaxPool_result_flattened;

    double***       fourthConv_result_arr;
    double*         fourthConv_result_flattened;

    double***       fourthMaxPool_result_arr;
    double*         fourthMaxPool_result_flattened;

    double*         coeff_flattened;
    double          biases5_arr[BIASES5];
    double*         dense1_result_arr;

    double*         coeff2_flattened;
    double          biases6_arr[BIASES6];
    double*         dense2_result_arr;
    
    const char*     imagefile = "tulip1.txt";

    sc_logic        kernels_generated1 = sc_logic(0);
    sc_logic        biases_generated1 = sc_logic(0);
    sc_logic        image_generated = sc_logic(0);

    sc_logic        firstConv_fetched = sc_logic(0);
    sc_logic        firstMaxPool_fetched = sc_logic(0);

    sc_logic        kernels_generated2 = sc_logic(0);
    sc_logic        biases_generated2 = sc_logic(0);

    sc_logic        secondConv_fetched = sc_logic(0);
    sc_logic        secondMaxPool_fetched = sc_logic(0);

    sc_logic        kernels_generated3 = sc_logic(0);
    sc_logic        biases_generated3 = sc_logic(0);

    sc_logic        thirdConv_fetched = sc_logic(0);
    sc_logic        thirdMaxPool_fetched = sc_logic(0);

    sc_logic        kernels_generated4 = sc_logic(0);
    sc_logic        biases_generated4 = sc_logic(0);

    sc_logic        fourthConv_fetched = sc_logic(0);
    sc_logic        fourthMaxPool_fetched = sc_logic(0);

    sc_logic        dense1_coeff_generated = sc_logic(0);
    sc_logic        dense1_biases_generated = sc_logic(0);
    sc_logic        dense1_fetched = sc_logic(0);

    sc_logic        dense2_coeff_generated = sc_logic(0);
    sc_logic        dense2_biases_generated = sc_logic(0);
    sc_logic        dense2_fetched = sc_logic(0);

    vector<vector<vector<float>>>read_image(std::string filename);

    void generate_reset(void);
    void generate_kernel(void);
    void generate_image(void);
    void generate_biases(void);

    void firstConv_sink(void);
    void firstMaxPool_sink(void);

    void generate_kernel2(void);
    void generate_biases2(void);

    void secondConv_sink(void);
    void secondMaxPool_sink(void);

    void generate_kernel3(void);
    void generate_biases3(void);

    void thirdConv_sink(void);

    void generate_kernel4(void);
    void generate_biases4(void);

   
    void generate_coeff(void);
    void generate_biases5(void);
    void firstDense_sink(void);

    void generate_coeff2(void);
    void generate_biases6(void);
    void secondDense_sink(void); 

	SC_CTOR(tb_driver) {
        firstConv_result_flattened = new double[CONV_ED];
        firstMaxPool_result_flattened = new double[POOL_ED];

        kernel2_flattened = new double[KER2];

        secondConv_result_flattened = new double[CONV_ED2];
        secondMaxPool_result_flattened = new double[POOL_ED2];

        kernel3_flattened = new double[KER3];
        
        thirdConv_result_flattened = new double[CONV_ED3];
        thirdMaxPool_result_flattened = new double[POOL_ED3];

        kernel4_flattened = new double[KER4];

        fourthConv_result_flattened = new double[CONV_ED4];
        fourthMaxPool_result_flattened = new double[POOL_ED4];

        coeff_flattened = new double[DENSE1_COEFF];
        dense1_result_arr = new double[DENSE1_OUT];
        coeff2_flattened = new double[DENSE2_COEFF];
        dense2_result_arr = new double[DENSE2_OUT];

    /* Поскольку в SystemC есть ограничение по выделяемой памти создаём динамические 
    массивы*/
        firstConv_result_arr = new double**[N3];
        for (int i=0; i<N3;i++){
            firstConv_result_arr[i] = new double*[M3];
            for (int j=0;j<M3;j++){
                firstConv_result_arr[i][j] = new double[L3];
            }
        }

        firstMaxPool_result_arr = new double**[POOLOUT1];
        for (int i=0; i<POOLOUT1;i++){
            firstMaxPool_result_arr[i] = new double*[POOLOUT2];
            for (int j=0;j<POOLOUT2;j++){
                firstMaxPool_result_arr[i][j] = new double[POOLOUT3];
            }
        }

        secondConv_result_arr = new double**[N5];
        for (int i=0; i<N5;i++){
            secondConv_result_arr[i] = new double*[M5];
            for (int j=0;j<M5;j++){
                secondConv_result_arr[i][j] = new double[L4];
            }
        }

        secondMaxPool_result_arr = new double**[POOLOUT11];
        for (int i=0; i<POOLOUT11;i++){
            secondMaxPool_result_arr[i] = new double*[POOLOUT22];
            for (int j=0;j<POOLOUT22;j++){
                secondMaxPool_result_arr[i][j] = new double[POOLOUT33];
            }
        }

        thirdConv_result_arr = new double**[N6];
        for (int i=0; i<N6;i++){
            thirdConv_result_arr[i] = new double*[M6];
            for (int j=0;j<M6;j++){
                thirdConv_result_arr[i][j] = new double[L5];
            }
        }

        thirdMaxPool_result_arr = new double**[POOLOUT111];
        for (int i=0; i<POOLOUT111;i++){
            thirdMaxPool_result_arr[i] = new double*[POOLOUT222];
            for (int j=0;j<POOLOUT222;j++){
                thirdMaxPool_result_arr[i][j] = new double[POOLOUT333];
            }
        }

        fourthConv_result_arr = new double**[N8];
        for (int i=0; i<N8;i++){
            fourthConv_result_arr[i] = new double*[M8];
            for (int j=0;j<M8;j++){
                fourthConv_result_arr[i][j] = new double[L6];
            }
        }

        fourthMaxPool_result_arr = new double**[POOLOUT1111];
        for (int i=0; i<POOLOUT1111;i++){
            fourthMaxPool_result_arr[i] = new double*[POOLOUT2222];
            for (int j=0;j<POOLOUT2222;j++){
                fourthMaxPool_result_arr[i][j] = new double[POOLOUT3333];
            }
        }

        SC_THREAD(generate_reset);
//        sensitive<<clk.pos();
        SC_THREAD(generate_kernel);
        SC_THREAD(generate_image); 
        SC_THREAD(generate_biases);
//        SC_METHOD(generate_biases);
//        sensitive<<clk.pos();

        SC_THREAD(firstConv_sink);
        SC_THREAD(firstMaxPool_sink);

        SC_THREAD(generate_kernel2);
        SC_THREAD(generate_biases2);

    //    SC_THREAD(secondConv_sink);
    //    SC_THREAD(secondMaxPool_sink);

        SC_THREAD(generate_kernel3);
        SC_THREAD(generate_biases3);

    //    SC_THREAD(thirdConv_sink);
        //SC_THREAD(thirdMaxPool_sink);

        SC_THREAD(generate_kernel4);
        SC_THREAD(generate_biases4);

        SC_THREAD(generate_coeff);
        SC_THREAD(generate_biases5);
//        SC_THREAD(firstDense_sink);
        
        SC_THREAD(generate_coeff2);
        SC_THREAD(generate_biases6);/*
        SC_THREAD(secondDense_sink);/**/
    };

    ~tb_driver(){
        delete[] kernel2_flattened;
        delete[] firstConv_result_flattened;  
        delete[] firstMaxPool_result_flattened; 
        delete[] secondConv_result_flattened;
        delete[] secondMaxPool_result_flattened; 
        delete[] thirdConv_result_flattened;
        delete[] thirdMaxPool_result_flattened; 
        delete[] fourthConv_result_flattened;
        delete[] fourthMaxPool_result_flattened; 

        delete[] coeff_flattened; 
        delete[] dense1_result_arr;
        delete   imagefile;


        for (int i = 0; i < N3; i++) {
            for (int j = 0; j < M3; j++) {               
                delete[] firstConv_result_arr[i][j];
            }
            delete[] firstConv_result_arr[i];
		}
        delete[] firstConv_result_arr; 

        for (int i = 0; i < POOLOUT1; i++) {
            for (int j = 0; j < POOLOUT2; j++) {               
                delete[] firstMaxPool_result_arr[i][j];
            }
            delete[] firstMaxPool_result_arr[i];
		}
        delete[] firstMaxPool_result_arr;  

        for (int i = 0; i < N5; i++) {
            for (int j = 0; j < M5; j++) {               
                delete[] secondConv_result_arr[i][j];
            }
            delete[] secondConv_result_arr[i];
		}
        delete[] secondConv_result_arr;

        for (int i = 0; i < POOLOUT11; i++) {
            for (int j = 0; j < POOLOUT22; j++) {               
                delete[] secondMaxPool_result_arr[i][j];
            }
            delete[] secondMaxPool_result_arr[i];
		}
        delete[] secondMaxPool_result_arr;

        for (int i = 0; i < N6; i++) {
            for (int j = 0; j < M6; j++) {               
                delete[] thirdConv_result_arr[i][j];
            }
            delete[] thirdConv_result_arr[i];
		}
        delete[] thirdConv_result_arr;

        for (int i = 0; i < POOLOUT111; i++) {
            for (int j = 0; j < POOLOUT222; j++) {               
                delete[] thirdMaxPool_result_arr[i][j];
            }
            delete[] thirdMaxPool_result_arr[i];
		}
        delete[] thirdMaxPool_result_arr; 

        for (int i = 0; i < N8; i++) {
            for (int j = 0; j < M8; j++) {               
                delete[] fourthConv_result_arr[i][j];
            }
            delete[] fourthConv_result_arr[i];
		}
        delete[] fourthConv_result_arr;

        for (int i = 0; i < POOLOUT1111; i++) {
            for (int j = 0; j < POOLOUT2222; j++) {               
                delete[] fourthMaxPool_result_arr[i][j];
            }
            delete[] fourthMaxPool_result_arr[i];
		}
        delete[] fourthMaxPool_result_arr;       
    }
};