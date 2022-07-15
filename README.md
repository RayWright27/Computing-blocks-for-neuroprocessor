# Computing blocks for neuroprocessor
Root folder contains full workung unrolled CNN model written in SystemC.
Verilog folder contains convolution and maxpooling blocks for neuroprocessor. Blocks are based on https://github.com/RayWright27/SystemC-CNN-test-model.git model.
Loops are unrolled along kernels, hence exploiting Intra-Kernel Parralellsim.
Some parametrization was made regarding CNN parameters. Other parametrization regarding RTL architecture, especially loop unrolling, is still to be done.
