
% demo_sfn.m

% ELEC 460 Demo

% Part II (new) State feedback control;  Pan

% System Input values

disp('  ELEC 460 Demo; Part II (new) State Feedback. ')

k=2.65
a=3.4
k2=13.71
ts=1./18.2

% Generate strings

kstr=num2str(k);
astr=num2str(a);
k2str=num2str(k2);
tsstr=num2str(ts);

% Continous  state-space model

disp(' Continuous model {ac,bc,cc}, eigenvalues controllability and observ.: ')
ac=[0 k2
    0 -a]
bc=[0 k*a]'
cc=[1 0]

eig(ac)
contc=[bc ac*bc]
determ=det(contc)
obsc=[cc' ac'*cc']'
determ=det(obsc)

% Discrete  state-space model 

disp(' Discrete model {ad,bd,cd}, eigenvalues controllability and observ.: ')
[ad, bd]=c2d(ac,bc,ts)
cd=[1 0]

eigenvalues=eig(ad)
contd=[bd ad*bd]
determ=det(contd)
obsd=[cd' ad'*cd']'
determ=det(obsd)

% Transfer function of open loop system

disp(' Open loop transfer function: ')
[onum,oden]=ss2tf(ad,bd,cd,0,1);
printsys(onum,oden,'z')
tfzeros=roots(onum)
tfpoles=roots(oden)

% Compare step responces input -> speed

tt=[0:ts:5];
ttn=size(tt,2);
yyc=step(ac,bc,[0 1],0,1,tt);
yyd=dstep(ad,bd,[0 1],0,1,ttn);
plot(tt,yyc,tt,yyd,'*')
grid on
string=['Step Resp. G(s)=Ka/(s+a): --cont, *disc; K=' kstr ', a=' astr];
title(string)
print 460_demo_sfn_f1.ps


% Start the loop

decision=1
while decision > 0,

% Controller input values

zeta=input(' Enter zeta for closed loop poles: ')
tset=input(' Enter settling time for closed loop poles: ')
addp=input(' Enter additional pole for integral feedback control: ')

% Generate strings

zetastr=num2str(zeta);
tsetstr=num2str(tset);
addpstr=num2str(addp);

% State feedback controller

disp(' LINEAR FEEDBACK CONTROL ')
disp(' Given: Char. polynomial and poles of uncontrolled system: ')
chpg=poly(ad)
eigenvalues=roots(chpg)

% Desired char. pol. from zeta and tset

disp(' Desired : Omega.m, pole locations and char. polynomial: ')
j = sqrt( -1 );
wn = 4.0 / (zeta * tset)
tmp = exp(-ts * zeta * wn);
poles(1) = tmp * (exp( j * ts * wn * sqrt(1 - zeta * zeta)));
poles(2) = conj(poles(1))
chpd=poly(poles)

% Compute state feedback gains kk

disp(' Compute state feedback gains kk=alpha*inv(AA)^t*inv(contd) ')
alpha=-[chpg(2)-chpd(2) chpg(3)-chpd(3)]
AA=[1 0;chpg(2) 1]
kk=alpha*inv(AA)'*inv(contd)

% Closed loop system

disp(' Closed loop system matrix, new eigenvalues and input gain hh: ')
adcl=ad-bd*kk
eigenvalues=eig(adcl)
hh=1./(cd*inv(eye(2)-adcl)*bd)

% Transfer function and Step responce of closed loop system

disp(' Closed loop transfer function: ')
[clnum,clden]=ss2tf(adcl,hh*bd,cd,0,1);
printsys(clnum,clden,'z')
tfzeros=roots(clnum)
tfpoles=roots(clden)

[ysf,xsf]=dstep(adcl,hh*bd,cd,0,1,91);
td=ts*[0:1:90];
plot(td,xsf,'*',td,[-kk(1)*xsf(:,1)-kk(2)*xsf(:,2)+hh],'+')
grid on
string=['State Feedback Regulator:    zeta=' zetastr ', Tset=' tsetstr ...
', Ts=' tsstr];
title(string)
xlab=['K=' kstr ',  a=' astr ',  K2=' k2str ';    k1=' num2str(kk(1)) ...
',  k2=' num2str(kk(2)) ',  hh=' num2str(hh)];
xlabel(xlab)
print 460_demo_sfn_f2.ps


% Integral feedback controllers

disp('  ')
disp(' INTEGRAL FEEDBACK CONTROL 1: ')
disp(' q(k+1) = q(k) + Ts * (r(k) - y(k)) ')
disp(' Extended model 1 {adi,bdi,cdi}, eigenvalues and controlability : ')
zz=[0 0]';
adi1=[ad zz; -ts*cd 1]
bdi1=[bd',0]'
cdi=[cd 0]

eigenvalues=eig(adi1)
contri= ctrb(adi1,bdi1)
determ=det(contri)

% Transfer function of open  loop system 1

disp(' Open loop transfer function system 1: ')
[oi1num,oi1den]=ss2tf(adi1,bdi1,cdi,0);
printsys(oi1num,oi1den,'z')
tfzeros=roots(oi1num)
tfpoles=roots(oi1den)

disp(' Desired characteristic polynomials and state feedback gains 1: ')
ppp=[poles  addp];
chpid=poly(ppp)
kki1=place(adi1,bdi1,ppp)

% Closed loop system 1

disp(' Closed loop system matrix 1 and new eigenvalues: ')
adic1=adi1-bdi1*kki1
eigenvalues=eig(adic1)

% Transfer function and Step responce of closed loop system 1

disp(' Closed loop transfer function 1: ')
[clinum,cliden]=ss2tf(adic1,[0 0 ts]',cdi,0);
printsys(clinum,cliden,'z')
tfzeros=roots(clinum)
tfpoles=roots(cliden)

[yif,xif]=dstep(adic1,[0 0 ts]',cdi,0,1,91);
plot(td,xif,'*',td,[-kki1(1)*xif(:,1)-kki1(2)*xif(:,2)-kki1(3)*xif(:,3)],'+')
grid on
string=['Integral Feedback Regulator 1:   zeta=' zetastr ', Tset=' tsetstr ...
', Ts=' tsstr ', addp=' addpstr];
title(string)
xlab=['K=' kstr ',  a=' astr ',  K2=' k2str ';   k1=' num2str(kki1(1)) ...
',   k2=' num2str(kki1(2)) ',   k3=' num2str(kki1(3))];
xlabel(xlab) 
print 460_demo_sfn_f3.ps


disp('  ')
disp(' INTEGRAL FEEDBACK CONTROL 2:')
disp(' q(k) = q(k-1) + Ts * (r(k) - y(k)) ')
disp(' Extended model 2 {adi,bdi,cdi}, eigenvalues and controlability : ')
adi2=[ad zz; -ts*cd*ad 1]
bdi2=[bd', -ts*cd*bd]'

eigenvalues=eig(adi2)
contri= ctrb(adi2,bdi2)
determ=det(contri)

% Transfer function of open  loop system 2

disp(' Open loop transfer function system 2: ')
[oi2num,oi2den]=ss2tf(adi2,bdi2,cdi,0);
oi2num=[oi2num(2:4) 0]
printsys(oi2num,oi2den,'z')
tfzeros=roots(oi2num)
tfpoles=roots(oi2den)

disp(' Desired characteristic polynomials and state feedback gains 2: ')
ppp=[poles  addp];
chpid=poly(ppp)
kki2=place(adi2,bdi2,ppp)

% Closed loop system 2

disp(' Closed loop system matrix 2 and new eigenvalues: ')
adic2=adi2-bdi2*kki2
eigenvalues=eig(adic2)

% Transfer function and Step responce of closed loop system 2

disp(' Closed loop transfer function 2: ')
[clinum,cliden]=ss2tf(adic2,[0 0 ts]',cdi,0,1);
clinum=[clinum(2:4) 0];
printsys(clinum,cliden,'z')
tfzeros=roots(clinum)
tfpoles=roots(cliden)

[yif,xif]=dstep(adic2,[0 0 ts]',cdi,0,1,92);
yif=yif(2:92);
xif=xif(2:92,1:3);
plot(td,xif,'*',td,[-kki2(1)*xif(:,1)-kki2(2)*xif(:,2)-kki2(3)*xif(:,3)],'+')
grid on
string=['Integral Feedback Regulator 2:   zeta=' zetastr ', Tset=' tsetstr ...
', Ts=' tsstr ', addp=' addpstr];
title(string)
xlab=['K=' kstr ',  a=' astr ',  K2=' k2str ';   k1=' num2str(kki2(1)) ...
',   k2=' num2str(kki2(2)) ',   k3=' num2str(kki2(3))];
xlabel(xlab)
print 460_demo_sfn_f4.ps

decision=input(' Enter decision ( > 0 to continue): ' )
end



