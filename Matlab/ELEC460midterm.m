%% ELEC 460 Midterms
clear all
close all
format compact
format short
%% Nise Chapter 13 -- Digital Control Systems
%
syms z k
% 3 a)
Q3aF = z*(z+3)*(z+5)/((z-0.1)*(z-0.5)*(z-0.7))
Q3af = iztrans(Q3aF,k)
% 3 b)
Q3bF = (z+0.2)*(z+0.4)/((z-0.1)*(z-0.5)*(z-0.9))
Q3bf = iztrans(Q3bF,k)
% 3 c)
Q3cF = (z+1)*(z+0.3)*(z+0.4)/(z*(z-0.2)*(z-0.5)*(z-0.7))
Q3cf = iztrans(Q3cF,k)

%% 
% Question 6, Nise
% The general format to solve these questions in matlab is
% to:
% 
% # symbolically enter the given expression in the laplace domain
% # use partial fraction expansion.
% # inverse laplace transform to the time domain, 
% #  transform to z-domain
%%
% 
% $$\frac{s+4}{\left(s+2\right)\,\left(s+5\right)}$$
% 
% a)

syms s 
Q6a = (s+4)/((s+2)*(s+5))
Q6afrac = partfrac(Q6a)
Q6atime = ilaplace(Q6afrac)
Q6azdo = ztrans(Q6atime)

%%
% 
% $$\frac{\left(s+1\right)\,\left(s+2\right)}{s\,\left(s+3\right)\,\left(s+4\right)}$$
% 
% b)

Q6b = (s+1)*(s+2)/(s*(s+3)*(s+4))
Q6bfrac = partfrac(Q6b)
Q6btime = ilaplace(Q6bfrac)
Q6bzdo = ztrans(Q6btime)
%%
% 
% $$\frac{20}{\left(s+3\right)\,\left(s^2+6\,s+25\right)}$$
% 
% c)

Q6c = 20/((s+3)*(s^2+6*s+25))
Q6cfrac = partfrac(Q6c)
Q6ctime = ilaplace(Q6cfrac)
Q6czdo  = ztrans(Q6ctime)
%%
% 
% $$\frac{15}{s\,\left(s+1\right)\,\left(s^2+10\,s+81\right)}$$
% 
% d)

Q6d = 15/(s*(s+1)*(s^2+10*s+81))
Q6dfrac = partfrac(Q6d)
Q6dtime = ilaplace(Q6dfrac)
Q6dzdo = ztrans(Q6dtime)

%%
% Nise 13.14
Q13G2 = 3/(s^2*(s+4))
Q13g2t = ilaplace(Q13G2)
Q13Z2 = ztrans(Q13g2t)

theta = 0:pi/100:2*pi;
r = 1;
z = r*cos(theta) + i*r*sin(theta);
% Plot data
plot(z);
hold on
TestingQApprox = zpk([-0.767],[1,0.4493],1) %0.0467
rlocus(TestingQApprox) % Plot root locus.
%zgrid([],[]) % Add unit circle to root locus.


title (['z-Plane Root Locus ']) % Add title to root locus.
%[K,p]=rlocfind(TestingQApprox) % Allows input of K by selecting
% point on graphic.
%figure

%% Dorf questions
% https://www.mathworks.com/help/control/examples/creating-discrete-time-models.html
%%
% E 13.12
num = [ 1  0.5];
den = [1 -1 0];
H = tf(num,den,1)
rlocus(H)
%%
% E 13.14
E1314Q = 1/(s*(s+3))
% Check
E1314Z = 1/6*(1/(z-1))-1/9+1/(9*(z-1)*(z-exp(-1.5)))

%%
% P 13.17
% Create continuous time model
Gp = zpk([],[-0.75,0],1)
% Discretize the model using c2d
Gz = c2d(Gp,1,'ZOH')
%zgrid([],[]) % Add unit circle to root locus.
%hold on
rlocus(Gz)
%hold off
% Computing the stability of the function requires using |a2| < |a0|
syms K; P=[1 -1.4724+0.39532*K 0.47237+0.30819*K]; [M,L]=jury(P);
testing=subs(L,K,1.72) % Unstable
testing=subs(L,K,1.71) % Stable 

%%
% AP13.1
a = 10
Gplant = tf([a 1],[1 0 0])
Gzplant = c2d(Gplant,1,'ZOH')
%%
% https://www.wolframalpha.com/input/?i=simplify(0.05%2F(z-1)-1%2F12%2B1%2F12*(z-1)%2F(z-exp(-0.6)))
% AP13.3
G13Plant = tf([12],[1 12 0])
G13zplant = c2d(G13Plant,0.05,'ZOH')
rlocus(G13zplant)
%%
% AP13.5
G15Plant = zpk([],[0,-3],1)
G15zplant = c2d(G15Plant,0.1,'ZOH')
rlocus(G15zplant)
% Get P(z) Polynomial
P15z =(z-1)*(z-0.7408)+K*0.0045354*(z+0.9049);
vpa(expand(P15z),10)
P15Jury = [1 0.0045354*K-1.7408 0.00410408346*K+0.7408];
[M,L] = jury(P15Jury)
Test = subs(L,K,62.5)
% Answer is K=63.1 

%%
% Examples from class
Jurynum = [1 -1.2 0.07 0.3 -0.08]
% polytosym
[Mstar,Lstar] = jury(Jurynum)
%% Nise Examples Matlab


'(ch13p7) Example 13.10' % Display label.
clf % Clear graph.
numgz=[11]; % Define numerator of G(z).
dengz=poly([1 0.5]); % Define denominator of G(z).
'G(z)' % Display label.
Gz=tf(numgz,dengz,[]); % Create and display G(z).
rlocus(Gz) % Plot root locus.
zgrid([],[]) % Add unit circle to root locus.
title (['z-Plane Root Locus ']) % Add title to root locus.
[K,p]=rlocfind(Gz) % Allows input of K by selecting
% point on graphic.
figure

'(ch13p8) Example 13.11' % Display label.
clf % Clear graph.
numgz=[11]; % Define numerator of G(z).
dengz=poly([1 0.5]); % Define denominator of G(z).
'G(z)' % Display label.
Gz=tf(numgz,dengz,[]);  % Create and display G(z).
rlocus(Gz) % Plot root locus.
axis([0,1,-1,1]) % Create close-up view.
zgrid % Add damping ratio curves to root
% locus.
title(['z-Plane Root Locus']) % Add title to root locus.
[K,p]=rlocfind(Gz) % Allows input of K by selecting
% point on graphic.
figure
'T(z)' % Display label.
Tz=feedback(K*Gz,1) % Find T(z).
step(Tz) % Find step response of gain-
% compensated system.
title (['Gain Compensated Step Response '])
% Add title to step response of
% gain-compensated system.