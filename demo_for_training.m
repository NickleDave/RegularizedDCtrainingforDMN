clc, clear all, close all, addpath('Regularized_D&Ctraining_for_DMN')
% Author: Erik Zamora, ezamora1981@gmail.com, see License.txt

load('Datasets/B.mat')
 plot(P(1,1:500),P(2,1:500),'r.',P(1,501:1000),P(2,501:1000),'g.',...
    P(1,1001:1500),P(2,1001:1500),'b.'),  hold on

%% Regularized Divide and Conquer Training

global L tol L0 E0
tol = 1e-10;    % Tolerance to avoid numerical errors
L = 0;          % The depth in recursions

% Adjustable parameters for training
E0 = 0.0;       % The tolerated error rate inside an hyperbox [0.0,1.0]
L0 = inf;       % The limit recursion depth [0,1,2,...)
M = 0.1;        % The margen of initial hyperbox [0.0,+inf)

H0 = generate_initial_hyperbox(P,M);
[ListH, ListC] = DivideAndConquer(H0,P,T,0);
Etrain = dmneuron_errorrate(P,T,ListH,ListC)
Etest = dmneuron_errorrate(Ptest,Ttest,ListH,ListC)

%% Animation
zoom = 1.2;
color = {'r','g','b','k'};
axis(zoom*[H0(1) H0(3) H0(2) H0(4)])
title('Divide and Conquer Training'), xlabel('x_1'), ylabel('x_2')
N = size(ListH,2)/2;
for i=1:size(ListH,1)
    Pm = ListH(i,1:N);
    Px = ListH(i,N+1:2*N);
    rectangle('Position',[Pm abs(Px-Pm)],'EdgeColor',color{ListC(i)}),
    pause(0.01)
end


%% Decision boundaries
disp('Wait, decision boundaries are computed...')
x1 = linspace(zoom*H0(1),zoom*H0(3),100);
x2 = linspace(zoom*H0(2),zoom*H0(4),100);
for i=1:length(x1)
    for j=1:length(x2)
        y = dmneuron([x1(i); x2(j)],ListH,ListC);
        Y(i,j) = y(1);
    end
end
[X1, X2] = meshgrid(x1,x2);
figure, mesh(X1,X2,Y')
view(0, 90); 
title('Decision boundaries'), xlabel('x_1'), ylabel('x_2')
rmpath('Regularized_D&Ctraining_for_DMN')

