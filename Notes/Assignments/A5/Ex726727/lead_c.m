
%  lead_c.m

%  This program designs and analyses the
%  performance of a lead compensator
%  for a type 1 system

%  Prepared for ELEC360/460
%  Revised Feb. 2015



% Enter the tr. fuct. of the plant 

disp('Enter the vectors of the numerator (numo) and denominator (denum) pol.')
disp('Start with the highest order term. Ex: [1 2 3] corr. (s^2 + 2 s + 3)')

numo=input('Enter numo: ')
deno=input('Enter deno: ')

% Make both vectors of the same length

nn=size(numo,2);
nd=size(deno,2);
for i=1:1:nn,
   numo(nd+1-i)=numo(nn+1-i); end;
for i=1:1:(nd-nn),
   numo(nd-nn+1-i)=0; end;

disp(' OPEN-LOOP SYSTEM (without Compensator): ')
syso=tf(numo,deno)
nn=nd;


% Start the loop

decision=1;
while decision > 0, 

% Enter Design Specifications

Kv=input('Enter desired Kv: ')
kvstr=num2str(Kv);

% Bode diagram

gain=Kv*deno(nn-1)/numo(nn);
gainstr=num2str(gain);
figure;
margin(numo*gain,deno);
grid
string=['Freq. Resp.  G(s)=numo/deno' ]; 
title(string)
%print -djpeg lead_c_f1.jpeg
[Gm,Pm,Wcg,Wcp] = margin(numo*gain,deno);
string=[' Phase margin: ',num2str(Pm), ' at the Gain crossover frq: ', num2str(Wcp) ];
disp(string)
string=[' Gain margin: ',num2str(20*log10(Gm)),  ' in dB at the  Phase crossover frq:',num2str(Wcg)]; 
disp(string)

%  Closed-loop poles

disp('Zeros and poles of closed-loop system without compensator:' )
denoc=numo*gain+deno;
zeros=roots(numo)
rdenoc=roots(denoc);
poles=rdenoc
[rpart,ii]=sort(real(poles));
if real(poles(ii(size(ii,1))))>=0 disp('Closed-loop System is unstable'); 
elseif imag(poles(ii(size(ii,1))))==0
   disp('Closed loop system has a real dominant pole');
else 
   zeta=-real(poles(ii(size(ii,1))))/abs(poles(ii(size(ii,1))));
   sett=-4./real(poles(ii(size(ii,1))));
   Mp=exp(pi*real(poles(ii(size(ii,1))))/abs(imag(poles(ii(size(ii,1))))));
   string=['Damping: ',num2str(zeta),', Overshoot: ',num2str(Mp),', Settling time: ',num2str(sett)];
   disp(string)
end

% Step Responce

tt=[0:0.02:1.7*sett];
yyo=step(numo*gain,denoc,tt);
disp(' Press CR to continue')
pause
figure;
plot(tt,yyo)
grid on
string=['Step Resp.  G(s)=(gain*numo)/(gain*numo+deno)' ]; 
title(string)
%print -djpeg lead_c_f2.jpeg

% Ramp Responce

yyr=step(numo*gain,[denoc 0],tt);
disp(' Press CR to continue')
pause
figure;
plot(tt,tt,tt,yyr)
grid on
string=['Ramp Resp.  G(s)=(gain*numo)/(gain*numo+deno)' ];
title(string)
%print -djpeg lead_c_f3.jpeg

% Calculate a and Kc

degree = input('Phase lead in degrees: ');
x = sin ((degree*pi)/180. );
a = (1-x)/(1+x)
Kc = gain/a
astr=num2str(a);

% Shift bode to get crossover

figure;
margin(numo*gain*(1/sqrt(a)),deno)
grid on
string=['Freq. Resp.  G(s)=(1./sqrt(a))*gain*[numo/deno]  gain=' ... 
gainstr ',  a=' astr ]; 
title(string)
%print -djpeg lead_c_f4.jpeg
[Gm,Pm,Wcg,Wcp] = margin(numo*gain*(1/sqrt(a)),deno);
string=['At wc= ', num2str(Wcp), ' the gain of the transfer function is equal to sqrt(a).'];
disp(string)
disp( 'Use this frequency as the new gain crossover frequency wc')
wc = input('Enter wc, the new gain crossover frequency : ');

% Calculate compensator pole and zero

Tt = sqrt(a)*wc;
aTt = wc/sqrt(a);

% PERFORMANCE ANALYSIS of DESIGN. 

% Open-loop compensated system

disp(' Compensator: ')
printsys([ 1 Tt],[1 aTt])
string=['Compensator gain: ',num2str(Kc)];
disp(string)
num1 = Kc*conv([1 Tt],numo);
den1 = conv([1 aTt],deno);
disp([' Compensated Open-Loop trsf. function;'])
printsys(num1,den1);

% Bode diagrams

margin(num1,den1);
grid on
string=['Freq. Resp.  G(s)=Gc(s)*[numo/deno]  Gc(s): Compensator '];
title(string)
%print -djpeg lead_c_f5.jpeg
[Gm,Pm,Wcg,Wcp] = margin(num1,den1);
string=[' Phase margin: ',num2str(Pm), ' at the Gain crossover frq: ', num2str(Wcp) ];
disp(string)
string=[' Gain margin: ',num2str(20*log10(Gm)),  ' in dB at the  Phase crossover frq:',num2str(Wcg)]; 
disp(string)

% Closed-loop compensated system

den1c = num1 + den1;
disp(' Zeros and poles of Closed-loop system with compensator:')
zeros=roots(num1)
poles=roots(den1c)
[rpart,ii]=sort(real(poles));
if real(poles(ii(size(ii,1))))>=0 disp('Closed-loop System is unstable'); 
elseif imag(poles(ii(size(ii,1))))==0
   disp('Closed loop system has a real dominant pole');
else 
   zeta=-real(poles(ii(size(ii,1))))/abs(poles(ii(size(ii,1))));
   sett=-4./real(poles(ii(size(ii,1))));
   Mp=exp(pi*real(poles(ii(size(ii,1))))/abs(imag(poles(ii(size(ii,1))))));
   string=['Damping: ',num2str(zeta),', Overshoot: ',num2str(Mp),', Settling time: ',num2str(sett)]
   disp(string)
end

% Step Responces of closed-loop system.

yy1=step(num1,den1c,tt);
disp(' Press CR to continue')
pause
figure;
plot(tt,yyo,tt,yy1,'--')
grid on
string=['Step Resp: Original (solid) and  Compensated (dashed)'];
title(string)
%print -djpeg lead_c_f6.jpeg

% Ramp Responces of closed-loop system.

yyr1=step(num1,[den1c 0],tt);
disp(' Press CR to continue')
pause
figure;
plot(tt,tt,tt,yyr,tt,yyr1,'--')
grid on
string=['Ramp Resp: Original (solid) and  Compensated (dashed)' ];
title(string)
%print -djpeg lead_c_f7.jpeg

decision=input( ' Enter >0 to continue) :')
end
