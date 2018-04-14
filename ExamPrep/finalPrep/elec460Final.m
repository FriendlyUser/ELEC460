%% 
% 
% 
% 
% 
% 

A = [0 1 3; ...
    3 5 6; ...
    5 6 7]
[V,W,eigVal] = eig(A)

latex(sym(A))
%% Ogata Modern Control System Examples
% 
%%
% 10.6
A = [0 20.6; 1 0]
B = [0; 1]
C = [0 1]
O = det([C; C*A])
O1 =[C; C*A]
Atitl = [1 0; 0 1]
WN = inv(O1)*(inv(Atitl))
alpha = [100; 20]
a = [-20.6; 0]
ke = alpha -a
% Ackermann's forumla
Ke = [A^2+20*A+100*eye(2)]*[0 1; 1 0]*B
%% 
% Another example 10.7

% hmm
syms s
simplify((s+1.8-j*2.4)*(s+1.8+j*2.4))
%% ELEC 460 April 2015 Final
%%
% Find the z-transform of:
syms k z
fk = heaviside(k)-heaviside(k-10)+ ...
    (k-11)*exp(-2*(k-11))
Fk = ztrans(fk,z)
% See https://www.wolframalpha.com/input/?i=ztransform+(heaviside(t)-+heaviside(t-10)%2B(t-10)exp(-2(t-10))*heaviside(t-11))
%% 
% 

% Find the inverse z-transform of
F2b = (z+2)/(z^2-1)
iztrans(F2b,k)
% https://www.wolframalpha.com/input/?i=inverse+z-transform+((z%2B2)%2F(z%5E2-1))
%% 
% Find w(k) for a system described by:
% 
% 0.1w(k)+0.3w(k+1)-w(k+2)=0, w(0)=2, w(1)=0
%%
Wz = (2*z-0.6)/((z-0.5)*(z+0.2))
partfrac(Wz)
iztrans(Wz,k)
%% 
% Root locus of Question 3

Gs = tf([0.4 2.8],[1 2 0 ])
Gz = c2d(Gs,0.1,'ZOH')
rlocus(Gz)
%%
symsFun = (z^2-1.8187*z+0.8187)/(0.04935*(z-0.4857))
testing = vpa(diff(symsFun,z),5)
simpleFrac = vpa(simplifyFraction(testing),5)
eqn1 = testing == 0
% Finding breakaway, break in points    
solve(eqn1,z)
%%
pz = [1 -0.7 0.1 -0.35]
[P, L] = jury(pz,15)
%%
% last question lol
syms s t
A = [-1 1; ...
     0 2]
Atest = s*eye(2)-A
b = [0; 2]
T = 1/2
G = ilaplace([inv(Atest)])
H = int(G*b,0,T)
% lazy answer
K = [-2.0118 -0.1965]* [1 2.118; 0 1]*[0 1.40783; 2 2*exp(1)]
% tracking signal part
c = [1 0]
h = 1/(c*inv(((eye(2)-vpa(G,5)+vpa(H,5)*K)))*vpa(H,5))
h = subs(t,0.5)

%% APRIL 2011 ELEC 460 Final Exam
%%
GR = 0.68*z/((z-1)^2*(z-0.8)*(z-+0.7))
y = iztrans(GR,k)
%%
A = [-1 1; 1 -2]
B = [1; 0]
C = [0 1]
Ts = 0.1
sys = ss(A,B,C,0)
sysCTS = ss(A,B,C,0)
sysDis = c2d(sysCTS,Ts)
[num,den] = ss2tf(A,B,C,0)
g5CTS = tf(num,den)
g5Discrete = c2d(g5CTS,Ts)
%%

check = partfrac(-1/(s*(s^2+3*s+1)))
transCheck = ilaplace(check)
animeCheck = ztrans(transCheck)

%%
A = [s+1 1; 1 s+2]
G6 = ilaplace(inv(A))
G6fin = subs(G6,t,0.1)
G6fin = vpa(G6fin,8)
testmore = -1/(s^2+3*s+1)
betterWork = subs(testmore,s,2/Ts*(z-1)/(z+1))
simplify(betterWork)

%%
gfinalRL = g5Discrete*zpk([0],[1],1,0.1)
rlocus(gfinalRL)
%%
syms z
Yz = z*(z-1)/(z^2-z+0.7)
y =iztrans(Yz)
%%
figure
RL7= zpk([0,-0.8],[0.8,0.3,1],1,1)
rlocus(RL7)
%%
% Discrete CTS model
syms s t
A6 =[s+2 6; ...
        -1 s+2]
phit = ilaplace(inv(A6))
T = 1/10 % sampling period
Gsym = phit
G = subs(phit,t,T)
b = [2; 0];
H = int(Gsym,0,T)*b
vpa(H)
%%
Guse = vpa(G,5)
Huse = vpa(H,5)
C = [Huse Guse*Huse]
a = [-1.5886 0.63091]
alpha = [-3 4.5]
Atil = [1 0; a(1) 1]
Ke = (alpha-a)*inv(Atil')*inv(C)
c = [0 1];
h = -1/(c*inv(Guse-Huse*Ke)*Huse)
%%
% test
syms z
test = z*exp(2)/(z*exp(1)-1)^2-0-1*exp(-1)*exp(2)-2*exp(-2)*exp(2)
test = simplify(test)
vpa(test,5)
%%
%
inveZ= (-z^2-z+0.6*z)/(z^2+0.6*z-0.4)
iztrans(inveZ)
%%
% root locus
G54 = zpk([0],[0.5,-0.2,1],1,1)
rlocus(G54)
test = diff(-(z-1)*(z-0.5)*(z+0.2)/(0.8*z))
test5 = vpa(solve(test==0,z),3)
%%
syms K
polyKstable = (z-1)*(z-0.5)*(z+0.8)
poly2sym = sym2poly(polyKstable)
kpoly = [1.0000   -0.7000   -0.7000    0.4000+0.8*K 0]
[P,L]=jury(kpoly,8)
vpa(simplify(P),5)
vpa(simplify(L),5)
%%
% getting lazy again
Atitled = [1 0 0; 4 1 0; 3 4 1]
Atitle = inv(Atitled)'

Hmeme = [-1 1 0; 0 -3 0; -0.1 0 0]
memer = [0; 1; 0]
Cmeme = [memer Hmeme*memer Hmeme^2*memer]
a = [4 3 0]
alpha = [-1.6072 0.672835 0]
Ke = (alpha - a)*Atitle*inv(Cmeme)
%%
G = [-1 1; 0 -3]
H = [0; 1]
c = [1 0]
stateAnime = [G-H*Ke(1) -H*Ke(2); ...
             -c           0]