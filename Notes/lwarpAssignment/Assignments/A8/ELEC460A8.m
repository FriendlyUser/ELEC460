%% ELEC 460 -- Control Theory II
%
%%  B-6-11
%
%% 
% Finding the rank of the controlability matrix
syms T
G = [1 T; 0 1]; H = [T^2/2; T]
test = [H G*H]
%%
syms u1 u2
J = [u1 0; ...
     0  u2;]
% p =  CHARPOLY(J)
%%  B-6-12
%

%%
% Last question quick check
u1 = 0.787592+j*0.238241
u2 = 0.787592-j*0.238241
T  = 0.1
K = [1/T^2*(1-u1-u2+u1*u2) 1/(2*T)*(3-u1-u2-u1*u2)]
% testing = zpk([],[],1), can't figure out how to plot to verify, need open
% loop transfer function