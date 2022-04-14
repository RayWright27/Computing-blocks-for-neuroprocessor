#define SC_INCLUDE_FX
#define SC_INCLUDE_DYNAMIC_PROCESSES
#include <vector>
#include <cstring>
#include <macro.h>
#include <systemc.h>
#include "weights.hpp"
#include <png.h>
#include <sysc/kernel/sc_boost.h>
#include <sysc/kernel/sc_spawn.h>
//#define sc_bind boost::bind
using std::vector;
 
SC_MODULE(tb_driver){ 
	sc_in<bool>     clk;
    sc_out<bool>    rst;
    static const int ker_port = L1; 
    sc_in<bool>     kernel_rdy[ker_port];
    sc_out<bool>    kernel_vld[ker_port];
    sc_in<bool>     image_rdy;
    sc_out<bool>    image_vld;
    sc_in<bool>     biases_rdy;
    sc_out<bool>    biases_vld;
    sc_out<sc_fixed<W_LEN_w, I_LEN_w>>  kernel;
    sc_out<sc_fixed<W_LEN_w, I_LEN_w>>  kernel_test[ker_port];
    sc_out<sc_fixed<W_LEN_i, I_LEN_i>>  image;
    sc_out<sc_fixed<W_LEN_w, I_LEN_w>>  biases;  
    

    sc_in<bool>     firstConv_result_vld;
    sc_out<bool>    firstConv_result_rdy;
    sc_in<sc_fixed<W_LEN_i, I_LEN_i>>   firstConv_result;
    

    sc_in<sc_fixed<W_LEN_i, I_LEN_i>>   firstMaxPool_result;
    sc_in<bool>     firstMaxPool_result_vld;
    sc_out<bool>    firstMaxPool_result_rdy;

    sc_out<sc_fixed<W_LEN_w, I_LEN_w>>  kernel2, biases2;
    sc_in<bool>     kernel2_rdy;
    sc_out<bool>    kernel2_vld;
    sc_in<bool>     biases2_rdy;
    sc_out<bool>    biases2_vld;

    sc_in<sc_fixed<W_LEN_i, I_LEN_i>>   secondConv_result;
    sc_in<bool>     secondConv_result_vld;
    sc_out<bool>    secondConv_result_rdy;

    sc_in<sc_fixed<W_LEN_i, I_LEN_i>>   secondMaxPool_result;
    sc_in<bool>     secondMaxPool_result_vld;
    sc_out<bool>    secondMaxPool_result_rdy;

    sc_out<sc_fixed<W_LEN_w, I_LEN_w>>  kernel3, biases3;
    sc_in<bool>     kernel3_rdy;
    sc_out<bool>    kernel3_vld;
    sc_in<bool>     biases3_rdy;
    sc_out<bool>    biases3_vld;

    sc_in<sc_fixed<W_LEN_i, I_LEN_i>>   thirdConv_result;
    sc_in<bool>     thirdConv_result_vld;
    sc_out<bool>    thirdConv_result_rdy;

    sc_in<sc_fixed<W_LEN_i, I_LEN_i>>   thirdMaxPool_result;
    sc_in<bool>     thirdMaxPool_result_vld;
    sc_out<bool>    thirdMaxPool_result_rdy;

    sc_out<sc_fixed<W_LEN_w, I_LEN_w>>  kernel4, biases4;
    sc_in<bool>     kernel4_rdy;
    sc_out<bool>    kernel4_vld;
    sc_in<bool>     biases4_rdy;
    sc_out<bool>    biases4_vld;

    sc_in<sc_fixed<W_LEN_i, I_LEN_i>>   fourthConv_result;
    sc_in<bool>     fourthConv_result_vld;
    sc_out<bool>    fourthConv_result_rdy;

    sc_in<sc_fixed<W_LEN_i, I_LEN_i>>   fourthMaxPool_result;
    sc_in<bool>     fourthMaxPool_result_vld;
    sc_out<bool>    fourthMaxPool_result_rdy;
 

    sc_out<sc_fixed<W_LEN_w, I_LEN_w>>  coeff;
    sc_in<bool>     coeff_rdy;
    sc_out<bool>    coeff_vld;
    sc_out<sc_fixed<W_LEN_w, I_LEN_w>>  biases5;
    sc_in<bool>     biases5_rdy;
    sc_out<bool>    biases5_vld;

    sc_in<sc_fixed<W_LEN_i, I_LEN_i>>   firstDense_result;
    sc_in<bool>     firstDense_result_vld;
    sc_out<bool>    firstDense_result_rdy;

    sc_out<sc_fixed<W_LEN_w, I_LEN_w>>  coeff2;
    sc_in<bool>     coeff2_rdy;
    sc_out<bool>    coeff2_vld;
    sc_out<sc_fixed<W_LEN_w, I_LEN_w>>  biases6;
    sc_in<bool>     biases6_rdy;
    sc_out<bool>    biases6_vld;

    sc_in<sc_fixed<W_LEN_i, I_LEN_i>>   secondDense_result;
    sc_in<bool>     secondDense_result_vld;
    sc_out<bool>    secondDense_result_rdy;

    //--------------------------------------------------------------------------------

    sc_fixed<W_LEN_w, I_LEN_w>     biases_tmp;  
    sc_fixed<W_LEN_i, I_LEN_i>     image_flattened[IMG];
	sc_fixed<W_LEN_w, I_LEN_w>     biases_flattened[BIASES];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem1[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem2[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem3[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem4[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem5[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem6[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem7[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem8[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem9[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem10[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem11[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem12[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem13[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem14[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem15[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem16[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem17[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem18[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem19[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem20[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem21[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem22[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem23[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem24[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem25[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem26[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem27[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem28[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem29[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem30[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem31[KER/L1];
    sc_fixed<W_LEN_w, I_LEN_w>     kernel_flattened_mem32[KER/L1];

    
    sc_fixed<W_LEN_w, I_LEN_w>*         kernel2_flattened;
    sc_fixed<W_LEN_w, I_LEN_w>          biases2_flattened[BIASES2];

    sc_fixed<W_LEN_w, I_LEN_w>*         kernel3_flattened;
    sc_fixed<W_LEN_w, I_LEN_w>          biases3_flattened[BIASES3];

    double*         lmao; //тестовый массив вместо kernel3_flattened
    
    sc_fixed<W_LEN_w, I_LEN_w>*         kernel4_flattened;
    sc_fixed<W_LEN_w, I_LEN_w>          biases4_flattened[BIASES4];

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

    sc_fixed<W_LEN_w, I_LEN_w>*         coeff_flattened;
    sc_fixed<W_LEN_w, I_LEN_w>          biases5_arr[BIASES5];
    sc_fixed<W_LEN_w, I_LEN_w>*         dense1_result_arr;

    sc_fixed<W_LEN_w, I_LEN_w>*         coeff2_flattened;
    sc_fixed<W_LEN_w, I_LEN_w>          biases6_arr[BIASES6];
    sc_fixed<W_LEN_w, I_LEN_w>*         dense2_result_arr;
    
    const char*     imagefile = "tulip1.txt";

    sc_logic        kernels_generated1[ker_port];
   
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
    void generate_kernel(int c, sc_fixed<W_LEN_w, I_LEN_w>* kernel_flattened_mem);

    //функция, служащая для динамического создания потоков generate_kernel, в которые можно подавать параметры
    void kernel_wrapper(){
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 0, kernel_flattened_mem1));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 1, kernel_flattened_mem2));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 2, kernel_flattened_mem3));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 3, kernel_flattened_mem4));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 4, kernel_flattened_mem5));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 5, kernel_flattened_mem6));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 6, kernel_flattened_mem7));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 7, kernel_flattened_mem8));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 8, kernel_flattened_mem9));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 9, kernel_flattened_mem10));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 10, kernel_flattened_mem11));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 11, kernel_flattened_mem12));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 12, kernel_flattened_mem13));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 13, kernel_flattened_mem14));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 14, kernel_flattened_mem15));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 15, kernel_flattened_mem16));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 16, kernel_flattened_mem17));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 17, kernel_flattened_mem18));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 18, kernel_flattened_mem19));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 19, kernel_flattened_mem20));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 20, kernel_flattened_mem21));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 21, kernel_flattened_mem22));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 22, kernel_flattened_mem23));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 23, kernel_flattened_mem24));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 24, kernel_flattened_mem25));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 25, kernel_flattened_mem26));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 26, kernel_flattened_mem27));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 27, kernel_flattened_mem28));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 28, kernel_flattened_mem29));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 29, kernel_flattened_mem30));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 30, kernel_flattened_mem31));
        sc_spawn(sc_bind(&tb_driver::generate_kernel, this, 31, kernel_flattened_mem32));
    }
    
    //--------------------------------------------------------------------------------------------------------
    void generate_image(void);
    void generate_biases(void);
/*
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
/**/
	SC_CTOR(tb_driver) {
        firstConv_result_flattened = new double[CONV_ED];
        firstMaxPool_result_flattened = new double[POOL_ED];

        kernel2_flattened = new sc_fixed<W_LEN_w, I_LEN_w>[KER2];

        secondConv_result_flattened = new double[CONV_ED2];
        secondMaxPool_result_flattened = new double[POOL_ED2];

        kernel3_flattened = new sc_fixed<W_LEN_w, I_LEN_w>[KER3];
        lmao = new double[KER3];
        
        thirdConv_result_flattened = new double[CONV_ED3];
        thirdMaxPool_result_flattened = new double[POOL_ED3];

        kernel4_flattened = new sc_fixed<W_LEN_w, I_LEN_w>[KER4];

        fourthConv_result_flattened = new double[CONV_ED4];
        fourthMaxPool_result_flattened = new double[POOL_ED4];

        coeff_flattened = new sc_fixed<W_LEN_w, I_LEN_w>[DENSE1_COEFF];
        dense1_result_arr = new sc_fixed<W_LEN_w, I_LEN_w>[DENSE1_OUT];
        coeff2_flattened = new sc_fixed<W_LEN_w, I_LEN_w>[DENSE2_COEFF];
        dense2_result_arr = new sc_fixed<W_LEN_w, I_LEN_w>[DENSE2_OUT];

        for(int i = 0; i < ker_port; i++){
            kernels_generated1[i] = sc_logic(0);
        }

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
        SC_THREAD(kernel_wrapper);
        SC_THREAD(generate_image); 
        SC_THREAD(generate_biases);
//        SC_METHOD(generate_biases);
//        sensitive<<clk.pos();
/*
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
        delete[] kernel3_flattened;
        delete[] lmao;
        delete[] kernel4_flattened;
        delete[] firstConv_result_flattened;  
        delete[] firstMaxPool_result_flattened; 
        delete[] secondConv_result_flattened;
        delete[] secondMaxPool_result_flattened; 
        delete[] thirdConv_result_flattened;
        delete[] thirdMaxPool_result_flattened; 
        delete[] fourthConv_result_flattened;
        delete[] fourthMaxPool_result_flattened; 

        delete[] coeff_flattened; 
        delete[] coeff2_flattened;
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