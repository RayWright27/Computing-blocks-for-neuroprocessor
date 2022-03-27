#define DT_LENGTH 32 

//#define TB_OUTPUT 

//для firstConv 
#define C1 3//число изображений (число каналов входного изображения)
#define M1 3//число строк КЕРНЕЛА1 
#define N1 3//число столбцов КЕРНЕЛА1
#define L1 32//число кернелов и выходных изображений соответственно
#define KER M1*N1*L1*C1 //длина вектора кернела

#define M2 128//число строк ИЗОБРАЖЕНИЯ
#define N2 128//число столбцов ИЗОБРАЖЕНИЯ
#define IMG M2*N2*C1 //длина вектора изображения

#define STRIDE 1
#define ZERO_PAD 1
#define M3 ((M2-M1+2*ZERO_PAD)/STRIDE+1)//вычисляем размеры выходной матрицы conv_2d_1
#define N3 ((N2-N1+2*ZERO_PAD)/STRIDE+1)
#define L3 L1 // количество выходных изображений из conv_2d_1 = количество кернелов (после свёртки столько же матриц(изображений), сколько кернелов)
#define CONV_ED M3*N3*L1//длина вектора после свёртки
#define BIASES 32
 
//для firstMaxPool
#define P1 2//число строк КЕРНЕЛА(POOL) 
#define P2 2//число столбцов КЕРНЕЛА(POOL)
#define F_M1 M3//строки входной на POOL
#define F_M2 N3//столбцы входной на POOL
#define F_M3 L3//число входных на POOL матриц
#define POOL_STRIDE 2//
#define POOL_IN F_M1*F_M2*F_M3
#define POOLOUT1 ((F_M1-P1)/POOL_STRIDE +1)
#define POOLOUT2 ((F_M2-P2)/POOL_STRIDE +1)
#define POOLOUT3 F_M3
#define POOL_ED POOLOUT1*POOLOUT2*POOLOUT3

//для secondConv
#define STRIDE2 1
#define ZERO_PAD2 1
#define C2 F_M3// количество входных изображений
#define M4 3//число строк КЕРНЕЛА2
#define N4 3//число столбцов КЕРНЕЛА2
#define L4 16//число кернелов и выходных изображений соответственно
#define KER2 M4*N4*L4*C2//длина вектора кернела2
#define M5 ((POOLOUT1-M4+2*ZERO_PAD2)/STRIDE2+1)
#define N5 ((POOLOUT2-N4+2*ZERO_PAD2)/STRIDE2+1)
#define CONV_ED2 M5*N5*L4
#define BIASES2 16

//для secondMaxPool
#define P11 2//число строк КЕРНЕЛА(POOL) 
#define P22 2//число столбцов КЕРНЕЛА(POOL)
#define F_M11 M5//строки входной на POOL
#define F_M22 N5//столбцы входной на POOL
#define F_M33 L4//число входных на POOL матриц
#define POOL_STRIDE2 2//
#define POOL_IN2 F_M11*F_M22*F_M33
#define POOLOUT11 ((F_M11-P11)/POOL_STRIDE2 +1)
#define POOLOUT22 ((F_M22-P22)/POOL_STRIDE2 +1)
#define POOLOUT33 F_M33
#define POOL_ED2 POOLOUT11*POOLOUT22*POOLOUT33

//для thridConv
#define STRIDE3 1
#define ZERO_PAD3 1
#define C3 F_M33// количество входных изображений
#define M6 3//число строк КЕРНЕЛА2
#define N6 3//число столбцов КЕРНЕЛА2
#define L5 16//число кернелов и выходных изображений соответственно
#define KER3 M6*N6*L4*C2//длина вектора кернела2
#define M7 ((POOLOUT11-M6+2*ZERO_PAD3)/STRIDE3+1)
#define N7 ((POOLOUT22-N6+2*ZERO_PAD3)/STRIDE3+1)
#define CONV_ED2 M6*N6*L5
#define BIASES3 16

//для thridMaxPool
#define P111 2//число строк КЕРНЕЛА(POOL) 
#define P222 2//число столбцов КЕРНЕЛА(POOL)
#define F_M111 M7//строки входной на POOL
#define F_M222 N7//столбцы входной на POOL
#define F_M333 L5//число входных на POOL матриц
#define POOL_STRIDE3 2//
#define POOL_IN3 F_M111*F_M222*F_M333
#define POOLOUT111 ((F_M111-P111)/POOL_STRIDE3 +1)
#define POOLOUT222 ((F_M221-P222)/POOL_STRIDE3 +1)
#define POOLOUT333 F_M333
#define POOL_ED3 POOLOUT111*POOLOUT222*POOLOUT333

//для fourthConv
#define STRIDE4 1
#define ZERO_PAD4 1
#define C4 F_M333// количество входных изображений
#define M8 3//число строк КЕРНЕЛА2
#define N8 3//число столбцов КЕРНЕЛА2
#define L6 8//число кернелов и выходных изображений соответственно
#define KER4 M8*N8*L6*C4//длина вектора кернела2
#define M9 ((POOLOUT111-M8+2*ZERO_PAD4)/STRIDE4+1)
#define N9 ((POOLOUT222-N8+2*ZERO_PAD4)/STRIDE4+1)
#define CONV_ED2 M9*N9*L6
#define BIASES2 8

//для fourthMaxPool
#define P1111 2//число строк КЕРНЕЛА(POOL) 
#define P2222 2//число столбцов КЕРНЕЛА(POOL)
#define F_M1111 M9//строки входной на POOL
#define F_M2222 N9//столбцы входной на POOL
#define F_M3333 L6//число входных на POOL матриц
#define POOL_STRIDE4 2//
#define POOL_IN4 F_M1111*F_M2222*F_M3333
#define POOLOUT1111 ((F_M1111-P1111)/POOL_STRIDE4 +1)
#define POOLOUT2222 ((F_M2222-P2222)/POOL_STRIDE4 +1)
#define POOLOUT3333 F_M3333
#define POOL_ED4 POOLOUT1111*POOLOUT2222*POOLOUT3333

//firstDense
#define DENSE1_COEFF1 POOL_ED4
#define DENSE1_COEFF2 256
#define DENSE1_COEFF DENSE1_COEFF1*DENSE1_COEFF2
#define BIASES3 256
#define DENSE1_OUT 256 

//labeller (secondDense)
#define DENSE2_COEFF1 DENSE1_OUT
#define DENSE2_COEFF2 5
#define DENSE2_COEFF DENSE2_COEFF1*DENSE2_COEFF2
#define BIASES4 5
#define DENSE2_OUT 5 


