clc, clear all, close all, addpath('Regularized_D&Ctraining_for_DMN')
% Author: Erik Zamora, ezamora1981@gmail.com, see License.txt

% Important Notes: 
%   P and T must be double (real) values
%   P must have no duplicate training samples (use delete_duplicates.m function)
%   P and T must have no NaN values
%   Classes are numbered from 1 to infinity (natural numbers)
%   The global variable "tol" avoids infinity recursions due to possible
%       small numerical errors 

% HERE YOU CAN CHANGE DATASET
load('Datasets/liver.mat');
% Dataset filenames
% A, B, iris, liver, glass, pageblocks, letterrecognition, miceprotein
% MNIST_1000, CIFAR10_1000

global L tol L0 E0
tol = 1e-10;    % Tolerance to avoid numerical errors
L = 0;          % The depth in recursions

% Adjustable parameters for training
E0 = 0.0;       % The tolerated error rate inside an hyperbox [0.0,1.0]
L0 = inf;       % The limit recursion depth [0,1,2,...)
M = 0.1;        % The margen of initial hyperbox [0.0,+inf)

% Regularized Divide and Conquer Training
H0 = generate_initial_hyperbox(P,M);
[ListH, ListC] = DivideAndConquer(H0,P,T,0);

% Validation
NH = size(ListH,1)
L
Etrain = dmneuron_errorrate(P,T,ListH,ListC)
Etest = dmneuron_errorrate(Ptest,Ttest,ListH,ListC)
NH_Qtrain = NH/size(P,2)

rmpath('Regularized_D&Ctraining_for_DMN')
