#include <systemc.h>
#include "tb_driver.h"
#include "conv.h"
#include "max_pooling.h"
#include "dense.h"

//------------------------------------------------
// Передача параметров слоя в конструктор модуля слоя происходит в том же порядке, 
//в котором эти параметры расположены в файле macro.h
//------------------------------------------------

SC_MODULE(TOP){//топ-модуль нейросетевого ускорителя 
    //объявление модулей
    
    tb_driver   *DRI_TB;
    conv        *firstConv;/*
    max_pool    *firstMaxPool;  
    conv        *secondConv;
    max_pool    *secondMaxPool;
    conv        *thirdConv;
    max_pool    *thirdMaxPool;
    conv        *fourthConv;
    max_pool    *fourthMaxPool;
    dense       *firstDense; 
    dense       *secondDense;
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
    sc_signal<double> kernel_sig, image_sig, biases_sig;

    sc_signal<bool>   firstConv_result_vld_sig_1;
    sc_signal<bool>   firstConv_result_vld_sig_2;
    sc_signal<bool>   firstConv_result_rdy_sig_1;
    sc_signal<bool>   firstConv_result_rdy_sig_2;
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

    sc_signal<bool>   kernel3_rdy_sig;
    sc_signal<bool>   kernel3_vld_sig;
    sc_signal<bool>   biases3_rdy_sig;
    sc_signal<bool>   biases3_vld_sig;
    sc_signal<double> kernel3_sig, biases3_sig;

    sc_signal<bool>   thirdConv_result_vld_sig_1;
    sc_signal<bool>   thirdConv_result_vld_sig_2;
    sc_signal<bool>   thirdConv_result_rdy_sig_1;
    sc_signal<bool>   thirdConv_result_rdy_sig_2;
    sc_signal<double> thirdConv_result_sig_1;
    sc_signal<double> thirdConv_result_sig_2;    

    sc_signal<bool>   thirdMaxPool_result_vld_sig_1;
    sc_signal<bool>   thirdMaxPool_result_vld_sig_2;
    sc_signal<bool>   thirdMaxPool_result_rdy_sig_1;
    sc_signal<bool>   thirdMaxPool_result_rdy_sig_2;
    sc_signal<double> thirdMaxPool_result_sig_1;
    sc_signal<double> thirdMaxPool_result_sig_2;

    sc_signal<bool>   kernel4_rdy_sig;
    sc_signal<bool>   kernel4_vld_sig;
    sc_signal<bool>   biases4_rdy_sig;
    sc_signal<bool>   biases4_vld_sig;
    sc_signal<double> kernel4_sig, biases4_sig;

    sc_signal<bool>   fourthConv_result_vld_sig_1;
    sc_signal<bool>   fourthConv_result_vld_sig_2;
    sc_signal<bool>   fourthConv_result_rdy_sig_1;
    sc_signal<bool>   fourthConv_result_rdy_sig_2;
    sc_signal<double> fourthConv_result_sig_1;
    sc_signal<double> fourthConv_result_sig_2;    

    sc_signal<bool>   fourthMaxPool_result_vld_sig_1;
    sc_signal<bool>   fourthMaxPool_result_vld_sig_2;
    sc_signal<bool>   fourthMaxPool_result_rdy_sig_1;
    sc_signal<bool>   fourthMaxPool_result_rdy_sig_2;
    sc_signal<double> fourthMaxPool_result_sig_1;
    sc_signal<double> fourthMaxPool_result_sig_2;

    sc_signal<double> coeff_sig;
    sc_signal<bool>   coeff_rdy_sig;
    sc_signal<bool>   coeff_vld_sig;

    sc_signal<double>  biases5_sig;
    sc_signal<bool>    biases5_rdy_sig;
    sc_signal<bool>    biases5_vld_sig;

    sc_signal<double>  firstDense_result_sig_1;
    sc_signal<bool>    firstDense_result_vld_sig_1;
    sc_signal<bool>    firstDense_result_rdy_sig_1;
    sc_signal<double>  firstDense_result_sig_2;
    sc_signal<bool>    firstDense_result_vld_sig_2;
    sc_signal<bool>    firstDense_result_rdy_sig_2;

    sc_signal<double> coeff2_sig;
    sc_signal<bool>   coeff2_rdy_sig;
    sc_signal<bool>   coeff2_vld_sig;

    sc_signal<double>  biases6_sig;
    sc_signal<bool>    biases6_rdy_sig;
    sc_signal<bool>    biases6_vld_sig;

    sc_signal<double>  secondDense_result_sig_1;
    sc_signal<bool>    secondDense_result_vld_sig_1;
    sc_signal<bool>    secondDense_result_rdy_sig_1;
    sc_signal<double>  secondDense_result_sig_2;
    sc_signal<bool>    secondDense_result_vld_sig_2;
    sc_signal<bool>    secondDense_result_rdy_sig_2;
    
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

        DRI_TB->kernel3(kernel3_sig);
        DRI_TB->kernel3_rdy(kernel3_rdy_sig);
        DRI_TB->kernel3_vld(kernel3_vld_sig);
        DRI_TB->biases3(biases3_sig);
        DRI_TB->biases3_rdy(biases3_rdy_sig);
        DRI_TB->biases3_vld(biases3_vld_sig);

        DRI_TB->thirdConv_result(thirdConv_result_sig_1);
        DRI_TB->thirdConv_result_vld(thirdConv_result_vld_sig_1);
        DRI_TB->thirdConv_result_rdy(thirdConv_result_rdy_sig_1);

        DRI_TB->thirdMaxPool_result(thirdMaxPool_result_sig_1);
        DRI_TB->thirdMaxPool_result_vld(thirdMaxPool_result_vld_sig_1);
        DRI_TB->thirdMaxPool_result_rdy(thirdMaxPool_result_rdy_sig_1);

        DRI_TB->kernel4(kernel4_sig);
        DRI_TB->kernel4_rdy(kernel4_rdy_sig);
        DRI_TB->kernel4_vld(kernel4_vld_sig);
        DRI_TB->biases4(biases4_sig);
        DRI_TB->biases4_rdy(biases4_rdy_sig);
        DRI_TB->biases4_vld(biases4_vld_sig);

        DRI_TB->fourthConv_result(fourthConv_result_sig_1);
        DRI_TB->fourthConv_result_vld(fourthConv_result_vld_sig_1);
        DRI_TB->fourthConv_result_rdy(fourthConv_result_rdy_sig_1);

        DRI_TB->fourthMaxPool_result(fourthMaxPool_result_sig_1);
        DRI_TB->fourthMaxPool_result_vld(fourthMaxPool_result_vld_sig_1);
        DRI_TB->fourthMaxPool_result_rdy(fourthMaxPool_result_rdy_sig_1);

        DRI_TB->coeff(coeff_sig);
        DRI_TB->coeff_rdy(coeff_rdy_sig);
        DRI_TB->coeff_vld(coeff_vld_sig);
        DRI_TB->biases5(biases5_sig);
        DRI_TB->biases5_rdy(biases5_rdy_sig);
        DRI_TB->biases5_vld(biases5_vld_sig);

        DRI_TB->firstDense_result(firstDense_result_sig_1);
        DRI_TB->firstDense_result_vld(firstDense_result_vld_sig_1);
        DRI_TB->firstDense_result_rdy(firstDense_result_rdy_sig_1);

        DRI_TB->coeff2(coeff2_sig);
        DRI_TB->coeff2_rdy(coeff2_rdy_sig);
        DRI_TB->coeff2_vld(coeff2_vld_sig);
        DRI_TB->biases6(biases6_sig);
        DRI_TB->biases6_rdy(biases6_rdy_sig);
        DRI_TB->biases6_vld(biases6_vld_sig);

        DRI_TB->secondDense_result(secondDense_result_sig_1);
        DRI_TB->secondDense_result_vld(secondDense_result_vld_sig_1);
        DRI_TB->secondDense_result_rdy(secondDense_result_rdy_sig_1);

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
        /*
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

        thirdConv = new conv("thirdConv", M6, N6, L5, KER3, POOLOUT11, POOLOUT22, POOLOUT33,
                              POOL_ED2, M7, N7, L5, CONV_ED3, BIASES3, ZERO_PAD3, 0, 1);
        thirdConv->clk(clk);
        thirdConv->rst(rst); 
        thirdConv->kernel(kernel3_sig);
        thirdConv->image(secondMaxPool_result_sig_2);
        thirdConv->biases(biases3_sig);
        thirdConv->kernel_vld(kernel3_vld_sig);
        thirdConv->kernel_rdy(kernel3_rdy_sig);
        thirdConv->image_vld(secondMaxPool_result_vld_sig_2);
        thirdConv->image_rdy(secondMaxPool_result_rdy_sig_2);
        thirdConv->biases_vld(biases3_vld_sig);
        thirdConv->biases_rdy(biases3_rdy_sig);
        thirdConv->conv_2d_result_tb(thirdConv_result_sig_1);
        thirdConv->conv_2d_result_next(thirdConv_result_sig_2);
        thirdConv->conv_2d_result_rdy_tb(thirdConv_result_rdy_sig_1);
        thirdConv->conv_2d_result_rdy_next(thirdConv_result_rdy_sig_2);
        thirdConv->conv_2d_result_vld_tb(thirdConv_result_vld_sig_1); 
        thirdConv->conv_2d_result_vld_next(thirdConv_result_vld_sig_2); 
        
        thirdMaxPool = new max_pool("thirdMaxPool", P111, P222, F_M111, F_M222, F_M333, POOL_IN3, 
                                     POOLOUT111, POOLOUT222, POOLOUT333, POOL_ED3);
        thirdMaxPool->clk(clk);
        thirdMaxPool->rst(rst);
        thirdMaxPool->image(thirdConv_result_sig_2);
        thirdMaxPool->image_vld(thirdConv_result_vld_sig_2);
        thirdMaxPool->image_rdy(thirdConv_result_rdy_sig_2);
        thirdMaxPool->max_pool_result_tb(thirdMaxPool_result_sig_1);
        thirdMaxPool->max_pool_result_next(thirdMaxPool_result_sig_2);
        thirdMaxPool->max_pool_result_rdy_tb(thirdMaxPool_result_rdy_sig_1);
        thirdMaxPool->max_pool_result_rdy_next(thirdMaxPool_result_rdy_sig_2);
        thirdMaxPool->max_pool_result_vld_tb(thirdMaxPool_result_vld_sig_1);
        thirdMaxPool->max_pool_result_vld_next(thirdMaxPool_result_vld_sig_2);

        fourthConv = new conv("fourthConv", M8, N8, L6, KER4, POOLOUT111, POOLOUT222, POOLOUT333,
                              POOL_ED3, M9, N9, L6, CONV_ED4, BIASES4, ZERO_PAD4, 0, 1);
        fourthConv->clk(clk);
        fourthConv->rst(rst); 
        fourthConv->kernel(kernel4_sig);
        fourthConv->image(thirdMaxPool_result_sig_2);
        fourthConv->biases(biases4_sig);
        fourthConv->kernel_vld(kernel4_vld_sig);
        fourthConv->kernel_rdy(kernel4_rdy_sig);
        fourthConv->image_vld(thirdMaxPool_result_vld_sig_2);
        fourthConv->image_rdy(thirdMaxPool_result_rdy_sig_2);
        fourthConv->biases_vld(biases4_vld_sig);
        fourthConv->biases_rdy(biases4_rdy_sig);
        fourthConv->conv_2d_result_tb(fourthConv_result_sig_1);
        fourthConv->conv_2d_result_next(fourthConv_result_sig_2);
        fourthConv->conv_2d_result_rdy_tb(fourthConv_result_rdy_sig_1);
        fourthConv->conv_2d_result_rdy_next(fourthConv_result_rdy_sig_2);
        fourthConv->conv_2d_result_vld_tb(fourthConv_result_vld_sig_1); 
        fourthConv->conv_2d_result_vld_next(fourthConv_result_vld_sig_2); 
        /**/ /*
        fourthMaxPool = new max_pool("fourthMaxPool", P1111, P2222, F_M1111, F_M2222, F_M3333, POOL_IN4, 
                                     POOLOUT1111, POOLOUT2222, POOLOUT3333, POOL_ED4);
        fourthMaxPool->clk(clk);
        fourthMaxPool->rst(rst);
        fourthMaxPool->image(fourthConv_result_sig_2);
        fourthMaxPool->image_vld(fourthConv_result_vld_sig_2);
        fourthMaxPool->image_rdy(fourthConv_result_rdy_sig_2);
        fourthMaxPool->max_pool_result_tb(fourthMaxPool_result_sig_1);
        fourthMaxPool->max_pool_result_next(fourthMaxPool_result_sig_2);
        fourthMaxPool->max_pool_result_rdy_tb(fourthMaxPool_result_rdy_sig_1);
        fourthMaxPool->max_pool_result_rdy_next(fourthMaxPool_result_rdy_sig_2);
        fourthMaxPool->max_pool_result_vld_tb(fourthMaxPool_result_vld_sig_1);
        fourthMaxPool->max_pool_result_vld_next(fourthMaxPool_result_vld_sig_2);
        
        firstDense = new dense("firstDense", POOL_ED4, DENSE1_COEFF1, 
                            DENSE1_COEFF2, DENSE1_COEFF, BIASES5, DENSE1_OUT, 1);
        firstDense->clk(clk);
        firstDense->rst(rst);
        firstDense->input(fourthMaxPool_result_sig_2);
        firstDense->input_vld(fourthMaxPool_result_vld_sig_2);
        firstDense->input_rdy(fourthMaxPool_result_rdy_sig_2);
        firstDense->biases(biases5_sig);
        firstDense->biases_vld(biases5_vld_sig);
        firstDense->biases_rdy(biases5_rdy_sig);
        firstDense->coeff(coeff_sig);
        firstDense->coeff_vld(coeff_vld_sig);
        firstDense->coeff_rdy(coeff_rdy_sig);
        firstDense->dense_result_tb(firstDense_result_sig_1);
        firstDense->dense_result_next(firstDense_result_sig_2);
        firstDense->dense_result_rdy_tb(firstDense_result_rdy_sig_1);
        firstDense->dense_result_rdy_next(firstDense_result_rdy_sig_2);
        firstDense->dense_result_vld_tb(firstDense_result_vld_sig_1);
        firstDense->dense_result_vld_next(firstDense_result_vld_sig_2);

        secondDense = new dense("secondDense", DENSE1_OUT, DENSE2_COEFF1, 
                            DENSE2_COEFF2, DENSE2_COEFF, BIASES6, DENSE2_OUT, 2);
        secondDense->clk(clk);
        secondDense->rst(rst);
        secondDense->input(firstDense_result_sig_2);
        secondDense->input_vld(firstDense_result_vld_sig_2);
        secondDense->input_rdy(firstDense_result_rdy_sig_2);
        secondDense->biases(biases6_sig);
        secondDense->biases_vld(biases6_vld_sig);
        secondDense->biases_rdy(biases6_rdy_sig);
        secondDense->coeff(coeff2_sig);
        secondDense->coeff_vld(coeff2_vld_sig);
        secondDense->coeff_rdy(coeff2_rdy_sig);
        secondDense->dense_result_tb(secondDense_result_sig_1);
        secondDense->dense_result_next(secondDense_result_sig_2);
        secondDense->dense_result_rdy_tb(secondDense_result_rdy_sig_1);
        secondDense->dense_result_rdy_next(secondDense_result_rdy_sig_2);
        secondDense->dense_result_vld_tb(secondDense_result_vld_sig_1);
        secondDense->dense_result_vld_next(secondDense_result_vld_sig_2);
/**/
    } 
    //деструктор
    ~TOP(){
        delete DRI_TB;
        delete firstConv;/*
        delete firstMaxPool;
        delete secondConv;
        delete secondMaxPool;
        delete thirdConv;
        delete thirdMaxPool;
        delete fourthConv;
        delete fourthMaxPool;      
        delete firstDense;
        delete secondDense;
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
        sc_start(10000000,SC_NS);
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