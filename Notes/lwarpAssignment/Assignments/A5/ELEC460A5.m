%% Ogata Digital Control Systems B-4-10
% See Example B-4-8
% eta = 0.5, at least eight samples per cycle of damped sinusoidal
% oscillation
% T = 0.2
pid(1,1,1,0,1) % showing how to use pid command in matlab
%%
% 
% 
% <<Ogata410Sol.png>>
% 
%%
% 
% 
% <<Ogata410.png>>
% 
%%
wdOws = 1/10; % samples per cycle
T = 0.2 % sampling period
zeta = 0.5 % damping ratio
G1 = zpk([],[-1,-5],10)
G1dsc = c2d(G1,T,'ZOH')
polezMag = exp(-2*pi*zeta/sqrt(1-zeta^2)*wdOws)
polezPhase = 360*wdOws
[x,y] = pol2cart(deg2rad(polezPhase),polezMag)
zeval=x+j*y
%%
%

picontroller = pid(1,1,0,0,0.2)
syms Ki Kp z
Gz = 0.13711*(z+0.6714)/ ((z-0.8187)*(z-0.3679)) % latex(vpa(Gz))
PIsym = (Kp + Ki)*(z-Kp/(Kp+Ki))/(z-1) 
Gtot = Gz*PIsym
subs(Gtot,z,zeval)
%%
% 
% 
% $$\frac{402 \pi \left(z + \frac{240 \pi}{1123}\right)}{9211 \left(z - \frac{547 \pi}{2099}\right) \left(z - \frac{484 \pi}{4133}\right)}$$
% 
%%
% 
% $$\frac{1}{z - 1} \left(Ki + Kp\right) \left(- \frac{Kp}{Ki + Kp} + z\right)$$
% 

%%
% Find angle defiency, when z = 0.5629 + 0.4090i
% compute angle for pole z+0.6714 at z of interest
zero1 = subs(z+0.6714,z,zeval);
angle1 = angle(zero1)
%vpa(rad2deg(angle1),10)
(vpa(angle1,10))
% compute angle for pole 1/(z-0.8187) at z of interest
pole1 = subs(1/(z-0.8187),z,zeval);
angle2 = angle(pole1)
%vpa(rad2deg(angle2),10)
% compute angle for pole 1/(z-0.3679) at z of interest
(vpa(angle2,10))
pole2  = subs(1/(z-0.3679),z,zeval);
angle3 = angle(pole2)
%vpa(rad2deg(angle3),10)
(vpa(angle3,10))
pole3  = subs(1/(z-1),z,zeval);
% compute angle for pole 1/(z-1) at z of interest
angle4 =angle(pole3)
(vpa(angle4,10))

%% Compute angle defiency
% octave:36> vpa(angle1,10)
% ans = (sym) 0.3199752649

% octave:37> vpa(angle2,10)
% ans = (sym) -2.129703542
% octave:38> vpa(angle3,10)
% ans = (sym) -1.125903183
% octave:39> vpa(angle4,10)
% ans = (sym) -2.389393736
phi = pi +0.3199752649 -2.129703542 -1.125903183 -2.389393736;
angleContribution = rad2deg(phi);
% the angle should contriubtion 125.1015 degrees
% https://www.wolframalpha.com/input/?i=tan(0.4090%2F(0.5629%2Bw))%3D+125.1015%5Eo,
% evalulating the expression when n = 0
% 0.0001*(-2334.4566)/(1.1413140294029025)
% -0.2045 = 
% https://www.wolframalpha.com/input/?i=0.4090%2F(0.5629%2Bw)%3D+tan(125.1015%5Eo)
% lawl

%%
% know that kp/(kp+ki)=0.2045
% solving for kp and ki
syms Ki Kp
EQN1 = Kp/(Ki+Kp) == 0.850366
eqn2express = subs((Kp+Ki)*abs(0.13711*(z-0.2045)*(z+0.6714)/((z-0.8187)*(z-0.3679))),z,zeval)
EQN2 = eqn2express == 1
Answer = solve([EQN1,EQN2],[Ki,Kp])
Kinum = vpa(Answer.Ki,15)
Kpnum = vpa(Answer.Kp,15)

%%
% 
syms z w
tfFunc = 0.004918*(z+0.9835)/((z-1)*(z-0.9512))
tfFunction = subs(tfFunc,z,(1+0.05*w)/(1-0.05*w))
simplify(tfFunction)
top = [-0.0000207941 0.0495782 0.999882]
bot = [1 0.500205 0]
transFunc = tf(top,bot)
bode(transFunc)
%%
diary on
diary Ogata4-15.txt
ass_5
diary off