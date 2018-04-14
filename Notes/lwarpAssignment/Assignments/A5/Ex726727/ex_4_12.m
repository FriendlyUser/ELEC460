
%  ex_4.12.m


%  This program designs  a lead compensator and analyses the
%  performance of the closed-loop system. Example 4.12 in Ogata 

%  Based on lead_c.m prepared for ELEC360/460
%  Revised Feb. 2015

% Tts is the sampling period

Tts=.2

% Enter the discrete tr. fuct. of the plant and ZOH 

n0d=0.01873*[0 1 0.9356]
d0d=[1 -1.8187 0.8187]

% Apply the bilinear transformation

[att,btt,ctt,dtt]=tf2ss(n0d,d0d);
[adt,bdt,cdt,ddt]=d2cm(att,btt,ctt,dtt,Tts,'tustin');
[n1,d1]=ss2tf(adt,bdt,cdt,ddt)


% Design the lead compensator using transfer function [n1,d1]

lead_c

% Save lead compensator and compensated open-loop transfer function

le_c_n=Kc*[ 1 Tt];
le_c_d=[1 aTt];
n2=num1
d2=den1

% Apply the bilinear transformation to the lead compensator

[att,btt,ctt,dtt]=tf2ss(le_c_n,le_c_d);
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
tarc=[0:0.01:18];
y1=step(n2,(n2+d2),tarc);
tard=[0:0.2:18];
%y2=dstep(n4,(n4+d4),tard);
y2=filter(n4,(n4+d4),ones([1,length(tard)]));
plot(tarc,y1,tard,y2,'*')
grid on
string=['Step Resp.  of continuous and discrete systems '];
title(string)

%print ex_4_12a.ps
disp(' Press CR to continue')
pause

% Ramp responce of continuous and discrete closed loop systems

y3=step(n2,[(n2+d2) 0],tarc);
%y4=dstep(Tts*[n4 0],conv([ 1 -1],(n4+d4)),tard);
y4=filter(Tts*[n4 0],conv([ 1 -1],(n4+d4)),ones([1,length(tard)]));
plot(tarc,y3,tard,y4,'*')
grid on
string=['Ramp Resp.  of continuous and discrete systems '];
title(string)
%print ex_4_12b.ps

