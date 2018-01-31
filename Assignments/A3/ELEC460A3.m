%% ELEC 460 Assignment 3
% Textbook Questions from Ogata
% B-3-4, B-3-6, B-3-7, B-3-15, B-3-19 from the textbook.

%%
% Pulse transfer function relates Z-transform of 
% the output at the sampling instants to the Z- transform of the sampled input.
%% B-3-4
% Consider a transfer function system
%%
% $$ X(s)=\frac{s+3}{(s+1)(s+2)}$$
%%
% Obtain the pulse transfer function by two different methods
syms s z 
B34Xs = (s+3)/((s+1)*(s+2))
% First answer, ignore
% B34XzA1 = subs(B34Xs ,s,z)
% First answer, get the CTS function and convert that
% to the Z-domain,
XsTemp = ilaplace(B34Xs)
B34XzA2 = ztrans(XsTemp)
% Second Answer, convert from laplace domain to z domain using tables
% will need to use partial fractions
Xs2 = partfrac(B34Xs)
% Using the tables 
% Answer is the same
%%
% Doing partial fractions the idiot way using paper
A = [1 1; 2 1]
b = [1,3]'
x = A\b %% Solves Ax = b
%%
% $$\mathcal{Z} \left\{\frac{1}{s+a} \right\} \rightarrow \frac{1}{1-e^{-at}z^{-1}} $$
%%  B-3-6
% Obtain the z transform of
%%
% $$X(s)=\frac{1-e^{-Ts}}{s}\frac{1}{(s+a)^2}$$
syms T a
Xs36 = -exp(-T*s)/s*(1)/(s+a)^2+ 1/s*(1)/(s+a)^2
testxt = subs(Xs36,T,1)
testxt = ilaplace(testxt)
Xspartfrac = partfrac(Xs36)
%%
% Probably just use table
%% B-3-7
% Consider the difference equation system
%%
% $$ y(k+1)+0.5y(k)=x(k)$$
%%
% where y(0)=0. Obtain the response y(k) when the input x(k)
% is a unit-step sequence. Also, obtain the MATLAB Solution.
num = [0, 1]; den = [1, 0.5]; 
n = 45; x = ones(1,n);
v = [0,n-1,0 1.2]; axis(v);
k = 0:n-1;
y = filter(num,den,x); plot(k,y,'--ro'); grid;
title('Problem B-3-7 Unit Step Response');
xlabel('k'); ylabel('y_k');
print('PB-3-7.png','-dpng','-r300')
%% B-3-15
% Obtain the closed-loop pulse transfer function of the system shown in the
% figure below.
%%
% 
% 
% <<OgataB-3-15.png>>
% 

%% B-3-17
%
%%
% 
% <<OgataB-3-17.png>>
% 
