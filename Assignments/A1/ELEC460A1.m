%% ELEC 460 Assignment 1
clear all
close all
%% 1. Sketch the root locus
G1 = zpk([],[0,-1,-20],20) % create transfer function
figure(1); rlocus(G1) % Plot root locus
%% 2. Find Kv.
syms s ;Kv = limit(s*20/(s*(s+1)*(s+20)),s,0)% compute Kv using limits
%% 3. Sketch Bode and Nyquist plots.
figure(2);bode(G1)
figure(3); nyquist(G1)
%% 4. Find K so that zeta=sqrt(2)/2 for the closed loop system.
zeta = sqrt(2)/2
figure(4);
gains = -1:0.00125:1;
rlocus(G1,gains); sgrid; K = 0.476; 
% Plot test box with results onto plot
gainString = ['Gain: ' num2str(K)];text(-0.25,0.5,gainString);
fprintf('Using the root locus the value K at which zeta is 0.7071 is: %0.3f. \n', K )
%% 5. Find phase and gain margins for this K.
G1new = zpk([],[0,-1,-20],20*K)
figure(5); margin(G1new)
%% 6. Sketch the step and ramp responces of the closed loop system for this K
G1tfnew = tf(G1new)
subplot(2,1,1); step(G1tfnew); %% create subplot for step function
ramps = tf([1,0],[1]); 
subplot(2,1,2); step(G1tfnew/ramps); %% create subplot for ramp function
%% 7. Discuss the connection between Kv, zeta, margins and the response of the closed loop system. 
multiline = sprintf([ ... 
    'The value of Kv is 1, so the steady state velocity error is constant. Additionally \n' ...
    'the system is stable because of a positive phase and gain margin. Finally, the value of \n' ...
    'zeta = 0.7071 corresponds to a gain of 0.427'
    ])