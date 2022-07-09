# SystemC-Flowers-neuralnet
This is a version of convolution and maxpooling blocks for neuroprocessor. Blocks are based on https://github.com/RayWright27/SystemC-CNN-test-model.git model.
Loops are unrolled along kernels, hence exploiting Intra-Kernel Parralellsim.
Some parametrization was made regarding CNN parameters. Other parametrization regarding RTL architecture, especially loop unrolling, is still to be done.
