

%  lag_c.m

%  This program designs and analyses the
%  performance of a lag compensator
%  for a type 1 system

%  Prepared for ELEC360/460
%  Revised Feb. 2015


% Enter the tr. fuct. of the plant 

disp('Enter the vectors of the numerator (numo) and denominator (denum) pol.')
disp('Start with the highest order term. Ex: [1 2 3] corr. (s^2 + 2 s + 3)')
disp('Both vectors should have the same length')
numo=input('Enter numo: ')
deno=input('Enter deno: ')
nn=size(deno,2);

disp(' OPEN-LOOP SYSTEM (without Compensator): ')
printsys(numo,deno);


% Start the loop

decision=1;
while decision > 0, 

% Enter Design Specifications

Kv=input('Enter desired Kv: ')
kvstr=num2str(Kv);

% Bode diagram

gain=Kv*deno(nn-1)/numo(nn);
gainstr=num2str(gain);
margin(numo*gain,deno)
grid on
string=['Freq. Resp.  G(s)=numo/deno' ]; 
title(string)
%print lag_c_f1.ps
[Gm,Pm,Wcg,Wcp] = margin(numo*gain,deno);
disp([' Phase margin "Pm" at the Gain crossover frq. "Wcp" '])
Pm, Wcp
disp([' Gain margin "Gm" in dB at the  Phase crossover frq " Wcg" '])
Gm=20*log10(Gm), Wcg

%  Closed-loop poles

disp('Zeros and poles of closed-loop system without compensator:' )
denoc=numo*gain+deno;
zeros=roots(numo)
rdenoc=roots(denoc);
poles=rdenoc
disp(' Settling time "sett" and zeta "zeta" of same closed-loop system:' )
sett=4./(-real(rdenoc(1)))
zeta=-real(rdenoc(1))/(sqrt(real(rdenoc(1))^2+imag(rdenoc(1))^2))

% Step Responce

clear tt
tt=[0:0.02:10*sett];
yyo=step(numo*gain,denoc,tt);
disp(' Press CR to continue')
pause
plot(tt,yyo)
grid on
string=['Step Resp.  G(s)=(gain*numo)/(gain*numo+deno)' ]; 
title(string)
%print lag_c_f2.ps

%  Ramp responce

yyr=step(numo*gain,[denoc 0],tt);
disp(' Press CR to continue')
pause
plot(tt,tt,tt,yyr)
grid on
string=['Ramp Resp.  G(s)=(gain*numo)/(gain*numo+deno)' ];
title(string)
%print lag_c_f3.ps


%  Location of the zero of the Compensator

%  and now gain crossover

[mag,phase,w] = bode(numo*gain,deno);
clear phase_tmp;
resp='y';

while (resp == 'y')
  degree = input('Desired Phase margin in degrees (include an allowance for the effect of lag compensator): ');
  phase_tmp=phase-degree;
  [Gm,Pm,Wcg,Wcp] = imargin(mag,phase_tmp,w);
  disp([' Phase margin is "degree" degrees at w = "Wcg".'])
  degree
  Wcg
  resp = input('Try another Phase margin? (y/n): ','s');
end

wc = input('Enter wc, new gain crossover frequency: ')
Tt = input('Location of the zero of the compensator: ');

beta=1/abs(polyval(deno,sqrt(-1)*wc)/(gain*polyval(numo,sqrt(-1)*wc)))

% Calculate compensator pole and gain

bTt = Tt/beta
Kc=gain/beta

% PERFORMANCE ANALYSIS of DESIGN. 

% Open-loop compensated system

disp(' Compensator: ')
printsys([ 1 Tt],[1 bTt])
disp(' Compensator gain Kc: ')
Kc
num1 = Kc*conv([1 Tt],numo);
den1 = conv([1 bTt],deno);
disp([' Compensated Open-Loop trsf. function;'])

printsys(num1,den1);

% Bode diagrams

margin(num1,den1);
grid on
string=['Freq. Resp.  G(s)=Gc(s)*[numo/deno]  Gc(s): Compensator 1 '];
title(string)
%print lag_c_f4.ps
[Gm,Pm,Wcg,Wcp] = margin(num1,den1);
disp([' Phase margin "Pm" at the Gain crossover frq. "Wcp" '])
Pm, Wcp
disp([' Gain margin "Gm" in dB at the  Phase crossover frq " Wcg" '])
Gm=20*log10(Gm), Wcg

% Closed-loop compensated system

den1c = num1 + den1;
disp(' Zeros and poles of Closed-loop system with compensator:')
zeros=roots(num1)
rden1c=roots(den1c);
poles=rden1c
disp(' Settling time "sett" and zeta "zeta" of compens. closed-loop system:' )
sett=4./(-real(rden1c(2)))
zeta=-real(rden1c(2))/(sqrt(real(rden1c(2))^2+imag(rden1c(2))^2))

% Step Responces on closed-loop system.

clear tt
tt=[0:0.02:2.2*sett];
yy1=step(num1,den1c,tt);
disp(' Press CR to continue')
pause
plot(tt,yy1)
grid on
string=['Step Resp of compensated closed loop system'];
title(string)
%print lag_c_f5.ps

% Ramp Responces on closed-loop system.

yyr1=step(num1,[den1c 0],tt);
disp(' Press CR to continue')
pause
plot(tt,tt,tt,yyr1)
grid on
string=['Ramp Resp of compensated closed loop system'];
title(string)
%print lag_c_f6.ps


decision=input( ' Enter decision ( >0 to continue) :')
end

