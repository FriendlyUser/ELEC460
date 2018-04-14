%% ELEC 460 Final Exam Prep
%
format compact
%%
% Final Exam Topics
%%
% Good Textbooks to Use 
%%
% 
% * Digital Control Systems Phillips
% * Nise Control Systems Chapter 13
% * 4559_digital_control_engineering_2nd_edition
% * Digital Control Systems: Theoretical Problems and Simulation Tools
% * Dorf Control System Last Chapter

%% Digital Control Systems Phillips
% (Always Learning) Chakrabortty, Aranya_ Nagle, H. Troy_ Phillips, Charles L-Digital Control System Analysis & Design_ Global Edition-Pearson Education Limited (2015)
% Chapters of interest from this textbook are:
%%
% # Chapter 9, go through examples
%%
% Example 9.3
% Compute the plant’s discrete state-space matrices
Ac=[0 1;0 -1]; Bc=[0;1]; Cc=[1 0]; Dc=0;
Sysc=ss(Ac,Bc,Cc,Dc); T=0.1; Sysd=c2d(Sysc,T);
[A,B,C,D]=ssdata(Sysd);
% Set tau and zeta for desired alphac roots
tau = 1.0; zeta = 0.47462;
r = exp(-T/tau), theta = sqrt(log(r)^2*(1/zeta^2-1))
alphac = [1 -2*r*cos(theta) r^2], roots_alphac=roots(alphac)
P = roots(alphac) % P specifies the acker desired roots
K = acker(A,B,P) % Ackermann computation
% Set tau and zeta for desired alphae roots
tau = 0.5, zeta = 1
r = exp(-T/tau), theta = sqrt(log(r)^2*(1/zeta^2-1))
alphae =[1 -2*r*cos(theta) r^2],
roots_alphae=roots(alphae)
Perr = roots(alphae) % Perr specifies the acker desired roots
G =(acker(A',C',Perr))' % Ackermann computation

% Example 9.4 Append
% Append this code to the program for Example 9.3
Aq = A-B*K-G*C, Bq = G, Cq = -K
[NUMce, DENce]=ss2tf(Aq,Bq,Cq,0);
Dce=tf(-NUMce, DENce,0.1);
Dce=zpk(Dce)


%% 
% Example 9.7
A =[1 0.095163; 0 0.904837]; B=[0.0048374; 0.095163];
alphae =[1 -0.818731];
Aaa = A(1,1); Aab = A(1,2); Aba = A(2,1); Abb = A(2,2);
Ba=B(1,1); Bb=B(2,1);
Perr = -alphae(2)
G =(acker(Abb',Aab',Perr))' % Substitute Abb-->A and Aab-->C
%%
%
%%
%
A=[-0.2 0;-1 0.8]; B=[1; 1]; C=[-1 1]; D=[1];
T=1; %Choose any sampling interval
Sysd=ss(A,B,C,D,T)
S_control=[B A*B]
Rank_S_control=rank(S_control)
S_observe=[C; C*A]
rank_S_observe=rank(S_observe)
Yz_over_Xz = tf(Sysd)


%%
% Example 9.3 ( Always learning)
% Original Part
% Example 9.3
% Compute the plant’s discrete state-space matrices
Ac=[0 1;0 -1]; Bc=[0;1]; Cc=[1 0]; Dc=0;
Sysc=ss(Ac,Bc,Cc,Dc); T=0.1; Sysd=c2d(Sysc,T);
[A,B,C,D]=ssdata(Sysd);
% Set tau and zeta for desired alphac roots
tau = 1.0; zeta = 0.47462;
r = exp(-T/tau), theta = sqrt(log(r)^2*(1/zeta^2-1))
alphac = [1 -2*r*cos(theta) r^2], roots_alphac=roots(alphac)
P = roots(alphac) % P specifies the acker desired roots
K = acker(A,B,P) % Ackermann computation
% Set tau and zeta for desired alphae roots
tau = 0.5, zeta = 1
r = exp(-T/tau), theta = sqrt(log(r)^2*(1/zeta^2-1))
alphae =[1 -2*r*cos(theta) r^2],
roots_alphae=roots(alphae)
Perr = roots(alphae) % Perr specifies the acker desired roots
G =(acker(A',C',Perr))' % Ackermann computation
% Alternative method using (9-51)
% Store this NICE function
syms z 
Dce=K*inv((z*eye(2)-A+B*K+G*C))*G;
[num,den]=nice(Dce,z);
Dce=tf(num,den,T); Dce=zpk(Dce)

%% Digital Control Systems: Theoretical Problems and Simulation Tools
%
%%
% Pages of Interest
%%
%
% * *CHAPTER 3 Pages to Read*
% * p.54 (Do Block Diagram) /...
% * p.65-72 (Do Example, Discreting Block Diagram)
% * p.81-88

%%
%
% Problems
% Calculation of denominator’s roots
A=[1 5 2 -8];
riz=roots(A);
% Calculation of numerators of the partial fractions
syms z
X =(z^2 +3*z +1)/(z^3 +5*z^2 +2*z-8);
c1 =limit((z-riz(1))*X,z,riz(1))
c2 =limit((z-riz(2))*X,z,riz(2))
c3 =limit((z-riz(3))*X,z,riz(3))
%%
% Prefer to use residue method
% Define the coefficients of numerator and denominator
num=[ 1 3 1];
den =[ 1 0 -3 2]
% Use of residue command
[R,P,K] =residue(num,den)
%% Nise Textbook
% 
A=[0 1 0
0 0 1
0 -36 -15]
B=[0;0;1]
poles=[-3+5j,...
-3-5j,-10]
K=acker(A,B,poles)
%%
% Try-it 12.2
A=[-1 1 2
0 -1 5
0 3 -4]
B=[2;1;1]
Cm=ctrb(A,B)
Rank=rank(Cm)
%%
% Try-it 12.4
A = [ -2 -1 -3
0 -2 1
-7 -8 -9]
C=[ 4 6 8]
Om=obsv(A,C)
Rank=rank(Om)
%%
% Example 9.3 ( Always learning) functions

%%
% Examples
function [nr2,dr2]= nice(old,z)
% NICE takes the original expression and makes it look nice
% Input: (a*z^2 + b*z + c)/(d*z^2 + e*z + f)
% Output: (a1*z^2 + b1*z + c1)/(z^2 + e1*z + f1)
% old contains symbol of z
% rearrange the expression to collect coefficients
new = collect(old,z);
% obtain the coefficients of numerator and denominator
dr = fliplr(coeffs(feval(symengine,'denom',new)));
nr = fliplr(coeffs(feval(symengine,'numer',new)));
% normalize the coefficients with the coeff of dr z^2 term
dr2 = double(dr/dr(1)); nr2 = double(nr/dr(1));
end