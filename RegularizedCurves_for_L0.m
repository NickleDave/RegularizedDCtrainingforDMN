clc, clear all, close all, addpath('Regularized_D&Ctraining_for_DMN')
% Author: Erik Zamora, ezamora1981@gmail.com, see License.txt

% HERE YOU CAN CHANGE DATASET
name = 'iris';
load(['Datasets/' name '.mat']);
% Dataset filenames
% A, B, iris, liver, glass, pageblocks, letterrecognition, miceprotein
% MNIST_1000, CIFAR10_1000

global L tol L0 E0
E0 = 0; 
tol = 1e-10; 
M = 0.1;     
Lrange = 0:11;
for i=1:length(Lrange)
    L0 = Lrange(i);
    L = 0;  
    H0 = generate_initial_hyperbox(P,M);
    [ListH, ListC] = DivideAndConquer(H0,P,T,0);
    Etrain(i) = dmneuron_errorrate(P,T,ListH,ListC);
    Etest(i) = dmneuron_errorrate(Ptest,Ttest,ListH,ListC);
    NH_Qtrain(i) = size(ListH,1)/size(P,2);
    i
end

plot(Lrange,Etrain,'r',Lrange,Etest,'b',Lrange,NH_Qtrain,'g')
axis([0 max(Lrange) 0 1])
legend('E_t_r_a_i_n','E_t_e_s_t','N_H/Q_t_r_a_i_n')
xlabel('L_0')

savefig([name '_RegularizedL0'])

rmpath('Regularized_D&Ctraining_for_DMN')