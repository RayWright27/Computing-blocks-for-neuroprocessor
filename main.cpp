#include <systemc.h>
#include "tb_driver.h"
#include "conv.h"
#include "max_pooling.h"
#include "dense.h"

//------------------------------------------------
// Передача параметров слоя в конструктор модуля слоя происходит в том же порядке, 
//в котором эти параметры расположены в файле macro.h
//------------------------------------------------

//------------------------------------------------
//ИСПРАВИТЬ ПЕРЕДАЧУ ДАННЫХ ИЗ MAX_POOLING!
//


SC_MODULE(TOP){//топ-модуль нейросетевого ускорителя 
    //объявление модулей
    
    tb_driver   *DRI_TB;
    conv        *firstConv;
    max_pool    *firstMaxPool;  
    conv        *secondConv;
    max_pool    *secondMaxPool;/*
    dense       *DENSE1; 
    dense       *DENSE2;
    /**/
    // сигналы
    sc_clock clk;//("clk", 10, SC_NS);
    
    sc_signal<bool>   rst;
    sc_signal<bool>   kernel_rdy_sig;//готовность приёма/передачи данных кернела
    sc_signal<bool>   kernel_vld_sig;//=1 когда данные кернела видны для считывания 
    sc_signal<bool>   image_rdy_sig;
    sc_signal<bool>   image_vld_sig;
    sc_signal<bool>   biases_rdy_sig;
    sc_signal<bool>   biases_vld_sig;
    sc_signal<bool>   firstConv_result_vld_sig_1;
    sc_signal<bool>   firstConv_result_vld_sig_2;
    sc_signal<bool>   firstConv_result_rdy_sig_1;
    sc_signal<bool>   firstConv_result_rdy_sig_2;
    sc_signal<double> kernel_sig, image_sig, biases_sig;
    sc_signal<double> firstConv_result_sig_1;
    sc_signal<double> firstConv_result_sig_2;

    sc_signal<bool>   firstMaxPool_result_vld_sig_1;
    sc_signal<bool>   firstMaxPool_result_vld_sig_2;
    sc_signal<bool>   firstMaxPool_result_rdy_sig_1;
    sc_signal<bool>   firstMaxPool_result_rdy_sig_2;
    sc_signal<double> firstMaxPool_result_sig_1;
    sc_signal<double> firstMaxPool_result_sig_2;

    sc_signal<bool>   kernel2_rdy_sig;
    sc_signal<bool>   kernel2_vld_sig;
    sc_signal<bool>   biases2_rdy_sig;
    sc_signal<bool>   biases2_vld_sig;
    sc_signal<double> kernel2_sig, biases2_sig;
    sc_signal<bool>   secondConv_result_vld_sig_1;
    sc_signal<bool>   secondConv_result_vld_sig_2;
    sc_signal<bool>   secondConv_result_rdy_sig_1;
    sc_signal<bool>   secondConv_result_rdy_sig_2;
    sc_signal<double> secondConv_result_sig_1;
    sc_signal<double> secondConv_result_sig_2;    

    sc_signal<bool>   secondMaxPool_result_vld_sig_1;
    sc_signal<bool>   secondMaxPool_result_vld_sig_2;
    sc_signal<bool>   secondMaxPool_result_rdy_sig_1;
    sc_signal<bool>   secondMaxPool_result_rdy_sig_2;
    sc_signal<double> secondMaxPool_result_sig_1;
    sc_signal<double> secondMaxPool_result_sig_2;

    
    SC_CTOR(TOP):clk("clk",sc_time(2,SC_NS)){//конструктор копирования clk_sig
        //инстанциируем модули и соединения сигналами
        DRI_TB = new tb_driver("tb");
        DRI_TB->clk(clk);
        DRI_TB->rst(rst);
        DRI_TB->kernel(kernel_sig);
        DRI_TB->image(image_sig);
        DRI_TB->biases(biases_sig);
        DRI_TB->kernel_rdy(kernel_rdy_sig);
        DRI_TB->kernel_vld(kernel_vld_sig);
        DRI_TB->image_rdy(image_rdy_sig);
        DRI_TB->image_vld(image_vld_sig);
        DRI_TB->biases_rdy(biases_rdy_sig);
        DRI_TB->biases_vld(biases_vld_sig);
        DRI_TB->firstConv_result(firstConv_result_sig_1);
        DRI_TB->firstConv_result_vld(firstConv_result_vld_sig_1);
        DRI_TB->firstConv_result_rdy(firstConv_result_rdy_sig_1);

        DRI_TB->firstMaxPool_result(firstMaxPool_result_sig_1);
        DRI_TB->firstMaxPool_result_vld(firstMaxPool_result_vld_sig_1);
        DRI_TB->firstMaxPool_result_rdy(firstMaxPool_result_rdy_sig_1);

        DRI_TB->kernel2(kernel2_sig);
        DRI_TB->kernel2_rdy(kernel2_rdy_sig);
        DRI_TB->kernel2_vld(kernel2_vld_sig);
        DRI_TB->biases2(biases2_sig);
        DRI_TB->biases2_rdy(biases2_rdy_sig);
        DRI_TB->biases2_vld(biases2_vld_sig);
        DRI_TB->secondConv_result(secondConv_result_sig_1);
        DRI_TB->secondConv_result_vld(secondConv_result_vld_sig_1);
        DRI_TB->secondConv_result_rdy(secondConv_result_rdy_sig_1);

        DRI_TB->secondMaxPool_result(secondMaxPool_result_sig_1);
        DRI_TB->secondMaxPool_result_vld(secondMaxPool_result_vld_sig_1);
        DRI_TB->secondMaxPool_result_rdy(secondMaxPool_result_rdy_sig_1);
/*
        DRI_TB->coeff(coeff_sig);
        DRI_TB->coeff_rdy(coeff_rdy_sig);
        DRI_TB->coeff_vld(coeff_vld_sig);
        DRI_TB->biases3(biases3_sig);
        DRI_TB->biases3_rdy(biases3_rdy_sig);
        DRI_TB->biases3_vld(biases3_vld_sig);
        DRI_TB->dense1_result(dense1_result_tb_sig);
        DRI_TB->dense1_result_vld(dense1_result_vld_tb_sig);
        DRI_TB->dense1_result_rdy(dense1_result_rdy_tb_sig);

        DRI_TB->coeff2(coeff2_sig);
        DRI_TB->coeff2_rdy(coeff2_rdy_sig);
        DRI_TB->coeff2_vld(coeff2_vld_sig);
        DRI_TB->biases4(biases4_sig);
        DRI_TB->biases4_rdy(biases4_rdy_sig);
        DRI_TB->biases4_vld(biases4_vld_sig);
        DRI_TB->dense2_result(dense2_result_tb_sig);
        DRI_TB->dense2_result_vld(dense2_result_vld_tb_sig);
        DRI_TB->dense2_result_rdy(dense2_result_rdy_tb_sig);
*/
        /*auto  firstConv = std::make_unique<conv>("firstConv", M1, N1, L1, KER, M2, N2, C1, IMG, M3, N3, L3, 
        CONV_ED, BIASES, 0, 1);*/
        firstConv = new conv("firstConv", M1, N1, L1, KER, M2, N2, C1, IMG, M3, N3, L3, 
        CONV_ED, BIASES, ZERO_PAD, 0, 1);
        firstConv->clk(clk);
        firstConv->rst(rst);
        firstConv->kernel(kernel_sig);
        firstConv->image(image_sig);
        firstConv->biases(biases_sig); 
        firstConv->kernel_vld(kernel_vld_sig);
        firstConv->kernel_rdy(kernel_rdy_sig);
        firstConv->image_vld(image_vld_sig);
        firstConv->image_rdy(image_rdy_sig);
        firstConv->biases_vld(biases_vld_sig);
        firstConv->biases_rdy(biases_rdy_sig);
        firstConv->conv_2d_result_tb(firstConv_result_sig_1);
        firstConv->conv_2d_result_next(firstConv_result_sig_2);
        firstConv->conv_2d_result_rdy_tb(firstConv_result_rdy_sig_1);
        firstConv->conv_2d_result_rdy_next(firstConv_result_rdy_sig_2);
        firstConv->conv_2d_result_vld_tb(firstConv_result_vld_sig_1);
        firstConv->conv_2d_result_vld_next(firstConv_result_vld_sig_2);
        
        firstMaxPool = new max_pool("firstMaxPool", P1, P2, F_M1, F_M2, F_M3, POOL_IN, 
                                     POOLOUT1, POOLOUT2, POOLOUT3, POOL_ED);
        firstMaxPool->clk(clk);
        firstMaxPool->rst(rst);
        firstMaxPool->image(firstConv_result_sig_2);
        firstMaxPool->image_vld(firstConv_result_vld_sig_2);
        firstMaxPool->image_rdy(firstConv_result_rdy_sig_2);
        firstMaxPool->max_pool_result_tb(firstMaxPool_result_sig_1);
        firstMaxPool->max_pool_result_next(firstMaxPool_result_sig_2);
        firstMaxPool->max_pool_result_rdy_tb(firstMaxPool_result_rdy_sig_1);
        firstMaxPool->max_pool_result_rdy_next(firstMaxPool_result_rdy_sig_2);
        firstMaxPool->max_pool_result_vld_tb(firstMaxPool_result_vld_sig_1);
        firstMaxPool->max_pool_result_vld_next(firstMaxPool_result_vld_sig_2);

        secondConv = new conv("secondConv", M4, N4, L4, KER2, POOLOUT1, POOLOUT2, POOLOUT3,
                              POOL_ED, M5, N5, L4, CONV_ED2, BIASES2, ZERO_PAD2, 0, 1);
        secondConv->clk(clk);
        secondConv->rst(rst); 
        secondConv->kernel(kernel2_sig);
        secondConv->image(firstMaxPool_result_sig_2);
        secondConv->biases(biases2_sig);
        secondConv->kernel_vld(kernel2_vld_sig);
        secondConv->kernel_rdy(kernel2_rdy_sig);
        secondConv->image_vld(firstMaxPool_result_vld_sig_2);
        secondConv->image_rdy(firstMaxPool_result_rdy_sig_2);
        secondConv->biases_vld(biases2_vld_sig);
        secondConv->biases_rdy(biases2_rdy_sig);
        secondConv->conv_2d_result_tb(secondConv_result_sig_1);
        secondConv->conv_2d_result_next(secondConv_result_sig_2);
        secondConv->conv_2d_result_rdy_tb(secondConv_result_rdy_sig_1);
        secondConv->conv_2d_result_rdy_next(secondConv_result_rdy_sig_2);
        secondConv->conv_2d_result_vld_tb(secondConv_result_vld_sig_1); 
        secondConv->conv_2d_result_vld_next(secondConv_result_vld_sig_2); 
        /**/ 
        secondMaxPool = new max_pool("secondMaxPool", P11, P22, F_M11, F_M22, F_M33, POOL_IN2, 
                                     POOLOUT11, POOLOUT22, POOLOUT33, POOL_ED2);
        secondMaxPool->clk(clk);
        secondMaxPool->rst(rst);
        secondMaxPool->image(secondConv_result_sig_2);
        secondMaxPool->image_vld(secondConv_result_vld_sig_2);
        secondMaxPool->image_rdy(secondConv_result_rdy_sig_2);
        secondMaxPool->max_pool_result_tb(secondMaxPool_result_sig_1);
        secondMaxPool->max_pool_result_next(secondMaxPool_result_sig_2);
        secondMaxPool->max_pool_result_rdy_tb(secondMaxPool_result_rdy_sig_1);
        secondMaxPool->max_pool_result_rdy_next(secondMaxPool_result_rdy_sig_2);
        secondMaxPool->max_pool_result_vld_tb(secondMaxPool_result_vld_sig_1);
        secondMaxPool->max_pool_result_vld_next(secondMaxPool_result_vld_sig_2);
/*
        MAX_POOL_2D_1 = new max_pool("max_pool_2d_1", P1, P2, F_M1, F_M2, F_M3, POOL_IN, 
                                      POOLOUT1, POOLOUT2, POOLOUT3, POOL_ED);
        MAX_POOL_2D_1->clk(clk);
        MAX_POOL_2D_1->rst(rst);
        MAX_POOL_2D_1->image(secondConv_result_sig_2);
        MAX_POOL_2D_1->image_vld(secondConv_result_vld_sig_2);
        MAX_POOL_2D_1->image_rdy(secondConv_result_rdy_sig_2);
        MAX_POOL_2D_1->max_pool_result_tb(result_max_pool_sig_1);
        MAX_POOL_2D_1->max_pool_result_next(result_max_pool_sig_2);
        MAX_POOL_2D_1->max_pool_result_rdy_tb(max_pool_result_rdy_sig_1);
        MAX_POOL_2D_1->max_pool_result_rdy_next(max_pool_result_rdy_sig_2);
        MAX_POOL_2D_1->max_pool_result_vld_tb(max_pool_result_vld_sig_1);
        MAX_POOL_2D_1->max_pool_result_vld_next(max_pool_result_vld_sig_2);
        
        DENSE1 = new dense("dense1", POOL_ED, DENSE1_COEFF1, 
                            DENSE1_COEFF2, DENSE1_COEFF, BIASES3, DENSE1_OUT, 1);
        DENSE1->clk(clk);
        DENSE1->rst(rst);
        DENSE1->input(result_max_pool_sig_2);
        DENSE1->input_vld(max_pool_result_vld_sig_2);
        DENSE1->input_rdy(max_pool_result_rdy_sig_2);
        DENSE1->biases(biases3_sig);
        DENSE1->biases_vld(biases3_vld_sig);
        DENSE1->biases_rdy(biases3_rdy_sig);
        DENSE1->coeff(coeff_sig);
        DENSE1->coeff_vld(coeff_vld_sig);
        DENSE1->coeff_rdy(coeff_rdy_sig);
        DENSE1->dense_result_tb(dense1_result_tb_sig);
        DENSE1->dense_result_next(dense1_result_next_sig);
        DENSE1->dense_result_rdy_tb(dense1_result_rdy_tb_sig);
        DENSE1->dense_result_rdy_next(dense1_result_rdy_next_sig);
        DENSE1->dense_result_vld_tb(dense1_result_vld_tb_sig);
        DENSE1->dense_result_vld_next(dense1_result_vld_next_sig);

        DENSE2 = new dense("dense2", DENSE1_OUT, DENSE2_COEFF1, 
                            DENSE2_COEFF2, DENSE2_COEFF, BIASES4, DENSE2_OUT, 2);
        DENSE2->clk(clk);
        DENSE2->rst(rst);
        DENSE2->input(dense1_result_next_sig);
        DENSE2->input_vld(dense1_result_vld_next_sig);
        DENSE2->input_rdy(dense1_result_rdy_next_sig);
        DENSE2->biases(biases4_sig);
        DENSE2->biases_vld(biases4_vld_sig);
        DENSE2->biases_rdy(biases4_rdy_sig);
        DENSE2->coeff(coeff2_sig);
        DENSE2->coeff_vld(coeff2_vld_sig);
        DENSE2->coeff_rdy(coeff2_rdy_sig);
        DENSE2->dense_result_tb(dense2_result_tb_sig);
        DENSE2->dense_result_next(dense2_result_next_sig);
        DENSE2->dense_result_rdy_tb(dense2_result_rdy_tb_sig); 
        DENSE2->dense_result_rdy_next(dense2_result_rdy_next_sig);
        DENSE2->dense_result_vld_tb(dense2_result_vld_tb_sig);
        DENSE2->dense_result_vld_next(dense2_result_vld_next_sig);
/**/
    } 
    //деструктор
    ~TOP(){
        delete DRI_TB;
        delete firstConv;
        delete firstMaxPool;
        delete secondConv;
        delete secondMaxPool;
        /*       
        delete DENSE1;
        delete DENSE2;
        /**/
    }
}; 

TOP *top = NULL;//чтобы не указывало на какой-то случайный участок памяти

int sc_main(int argc, char* argv[]) {
    sc_core::sc_report_handler::set_actions("/IEEE_Std_1666/deprecated", sc_core::SC_DO_NOTHING);//suppress warning due to set_time_resolution
    //sc_set_time_resolution(1, SC_NS);
    top = new TOP("top_module");
    //начинаем симуляцию 
    
        int sim_step=1;
        sc_start(100000000,SC_NS);
/*
        for (int i = 0; i <100000; i++){
            
            sc_start(sim_step, SC_NS);
            
            cout << "clk = "<<top->clk<<"  @ "<<sc_time_stamp()<<endl;


            cout<<" kernel_rdy = "<<top->kernel_rdy_sig<<"| ";
            cout<<" kernel_vld = "<<top->kernel_vld_sig<<"| ";
            cout<<" kernel_sig = "<<top->kernel_sig<<endl;
            cout<<" image_rdy = "<<top->image_rdy_sig<<" | "; 
            cout<<" image_vld = "<<top->image_vld_sig<<" | ";
            cout<<" image_sig =  "<<top->image_sig<<endl;
            cout<<" biases_rdy = "<<top->biases_rdy_sig<<"| ";
            cout<<" biases_vld = "<<top->biases_vld_sig<<"| ";
            cout<<" biases_sig = "<<top->biases_sig<<endl;
               cout<<sc_time_stamp()<<" ";
                cout<<" biases_recieved = "<<top->DENSE1->biases_recieved;
                cout<<" coeff_recieved = "<<top->DENSE1->coeff_recieved;
                cout<<" input_recieved = "<<top->DENSE1->input_recieved<<endl<<endl; 
            sc_stop();
        } */
    return 0;
}