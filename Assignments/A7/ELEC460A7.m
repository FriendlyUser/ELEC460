%% ELEC 460 Assignment 7
% State-Space Model
format compact
syms z k
warning off
%%
% Consider the discrete-time state equation

%%
% 
% $$
% \begin{bmatrix} 
% x_1(k+1) \\
% x_2(k+1)
% \end{bmatrix} = \begin{bmatrix}
% 0     &  1 \\
% -0.24 & -1 
% \end{bmatrix}\begin{bmatrix}
% x_1(k) \\
% x_2(k)
% \end{bmatrix}
% $$
% 
%%
% Obtain the state transition matrix $\Psi(k)$
%%
% Since $\displaystyle \psi(k)=G^k= \mathcal{Z}^{-1} \left\{z[zI-G]^{-1}\right\}$, and 
%%
%%
% 
% $$ 
% A=\begin{bmatrix}
% a     &  b \\
% c &  d 
% \end{bmatrix}^{-1}= \frac{1}{ad-bc}\begin{bmatrix}
% d     &  -b \\
% -c &  a 
% \end{bmatrix}
% $$
%%
% $$
% \begin{align}
% & \mathcal{Z}^{-1} \left\{z[zI-G]^{-1}\right\} = z \begin{bmatrix}
% z     &  -1 \\
% 0.24 & z+1
% \end{bmatrix}^{-1}= \mathcal{Z}^{-1} \left\{\frac{z}{z^2+z-(-1)(0.24)}\begin{bmatrix}
% z+1     &  1 \\
% -0.24 & z
% \end{bmatrix} \right\} \\
% & \frac{F(z)}{z}=\mathcal{Z}^{-1} \left\{\frac{1}{(z+0.4)(z-0.6)}\begin{bmatrix}
% z+1     &  1 \\
% -0.24 & z
% \end{bmatrix} \right\} 
% \end{align}
% $$
% 

%% B-5-18
% Ignore all the previous matlab based errors, doesn't support advanced
% latex, or just matrices in latex

F1 =  1/((z+0.6)*(z+0.4))
%F1 = partfrac(F1)
F2 = [z+1   1; ...
      -0.24 z;]
F = F1*F2
F = partfrac(F)
F = z*F
fk = iztrans(F,k)

%% B-5-22
% 
G = [1 3 0; ...
    -3 -2 -3; ...
    1 0 0;]
% eig(TestG), not needed
TestG = z*eye(3)-G
% Characteristic polynomial
charPoly = det(TestG)
vpa(root(charPoly),4)
% Another approch si to use jury marden table
%% B-6-1
% Complete State Controllability
syms a b c d
G = [a b; ...
     c d]
H =[1; 1]
test = [H G*H]
rank(test)

% Complete State Observability
C = [1 0]
D = 0
cso = [C; C*G]

% acker(G,H,[2,1])