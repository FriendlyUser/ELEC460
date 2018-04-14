%% ElEC 460
% Assignment 6
format compact
syms s
%% B-5-4
%Obtain a state-space representation of the system described by the equation.

%%
%
% $$y(k+2)+y(k+1)+0.16 y(k) = u (k+1) + 2u(k)$$

b = [0 1 2];
a = [1 1 0.16]
[A,B,C,D] = tf2ss(b,a)
% Remember to tranpose the result.
%% Example
%b = [0 2 3; 1 2 1];
%a = [1 0.4 1];
%[A,B,C,D] = tf2ss(b,a)