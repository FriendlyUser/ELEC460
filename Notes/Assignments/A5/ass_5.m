
%  ass_5.m

%  This program designs  a lead-lag
%  (l-l) compensator and analyses the
%  performance of the closed-loop system 
%  for  question B-4-15

%  Based on lead_c_15.m and lag_c_15.m, prepared for ELEC360/460
%  Revised Feb. 2015

% Tts is the sampling period

Tts=.1

% Enter the discrete tr. fuct. of the plant and ZOH 

n0d=0.004918*[0 1 0.9835]
d0d=poly([1 0.9512])

% Apply the bilinear transformation

[att,btt,ctt,dtt]=tf2ss(n0d,d0d);
[adt,bdt,cdt,ddt]=d2cm(att,btt,ctt,dtt,Tts,'tustin');
[n1,d1]=ss2tf(adt,bdt,cdt,ddt)
%Test = tf(n1,d1)

% Design the lead part of the l-l compensator using tr. fuct. [n1,d1]

lead_c

% Save lead compensator and compensated open-loop transfer function

le_c_n=Kc*[ 1 Tt];
le_c_d=[1 aTt];
n2=num1
d2=den1

% Step responce of compensated closed-loop system

step(n2,(n2+d2))
grid

% Design the  lag part of the l-l compensator using tr. fct. [n2,d2]

lag_c

% Save lag compensator and compensated open-loop transfer function

la_c_n=Kc*[ 1 Tt];
la_c_d=[1 bTt];
n3=num1
d3=den1

% Step responce of compensated closed-loop system

step(n3,(n3+d3))
grid

% Apply the bilinear transformation to the l-l compensator

c_n=conv(le_c_n,la_c_n);
c_d=conv(le_c_d,la_c_d);
[att,btt,ctt,dtt]=tf2ss(c_n,c_d);
[adt,bdt,cdt,ddt]=c2dm(att,btt,ctt,dtt,Tts,'tustin');
[c_nd,c_dd]=ss2tf(adt,bdt,cdt,ddt);

disp(' Discrete Compensator): ')
printsys(c_nd,c_dd,'z')

disp('Open loop compensated discrete system transfer function')
n4=conv(n0d,c_nd);
d4=conv(d0d,c_dd);
printsys(n4,d4,'z')

% Zeros and poles of the discrete closed-loop system

disp('Closed loop zeros and poles of discrete system')
zeros=roots(n4)
poles=roots(d4+n4)

disp('Number of samples per cycle:')
2*pi/max(abs(angle(poles)))

% Step responce of continuous and discrete closed loop systems

figure
tarc=[0:0.01:2];
y1=step(n3,(n3+d3),tarc);
tard=[0:0.1:2];
%y2=dstep(n4,(n4+d4),tard);
y2=filter(n4,(n4+d4),ones([1,length(tard)]));
plot(tarc,y1,tard,y2,'*')
grid on
string=['Step Resp.  of continuous and discrete systems '];
title(string)