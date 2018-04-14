%% ELEC 460 Assignment 4

%% Question 1
K =1;
Gcont = zpk([],[-1],K)
% GClosed = feedback(Gcont,1)
c2d(Gcont,0.2,'ZOH')
Gcont50 = zpk([],[-1,0],K)
c2d(Gcont50,0.2)
%% Question 2 
G2 = zpk([],[0,-1],1)
G2Discrete = c2d(G2,1,'ZOH')
syms z K
Pz = (z-1)*(z-exp(-1))+K*[z*exp(-1)+(1-2*exp(-1))]
vpa(expand(Pz),10)
%equation = [0.2642411177*K - 1.367879441*z + 0.3678794412*K*z + z^2 + 0.3678794412]
juryStab = [1 0.3679*K-1.368 0.2642*K+0.3679]
[M,L]=jury(juryStab)

%% Question 3
z = tf('z',0.1);
H = (z + 1) / ((z-1)*(z-0.6065));
kval = 0:0.005:10;
% append k =0.500
% Get more data points for k bewteen 0.591 and 0.0693
kstart = k(1:15);
kend = k(16:65);
kmid = kstart(15):0.00025:kend(1); 
% Create new gain vector
kuse = [kstart kmid kend ]
rlocus(H,kuse)
axis([-3.5 1.25 -2 2])
roots([1 -1.5419 0.5419])
%%
% Compute z when K = 0.0646
pole = 0.771+j*0.277
poleAng = rad2deg(angle(pole))
poleMag = abs(pole)
% axis([XMIN XMAX YMIN YMAX]) sets scaling for the x- and y-axes
       % on the current plot.
%zgrid()
print('Diagrams/B-4-8Rlocus2.png','-dpng','-r600')
% Data to plot root locus in latex
[r,k] = rlocus(H); % Get the data without plotting
mydata = []; % To populate the data
for i=1:2 % changed 5 to 2
    mydata(:,2*i -1) = (real(r(i,:))).'; % CL eig Real Part
    mydata(:,2*i)    = (imag(r(i,:))).'; % CL eig Imag Part
end
mydata(:,5) = k'; % The gain array, changed to 5
% Use format compact and mydata to print data
% Need to format string better and then print line by line to text file.
%fileID = fopen('exp.txt','w');
%fprintf(fileID,'%s \n',mydata);

%% Question 4
%
syms s 
G3 = 1/s^3
partfrac(G3,s)
complexTest =  (0.7701-1+i*0.2780)^-2
phi1 = rad2deg(angle(complexTest))

atan(0.2780/(0.7701-0.7719))+pi

%% 
% Question 4 Answering Questions
syms x Kp Kd
eqn2 =  (Kp+Kd)*abs((x-0.770149)/x * (0.005) * (x+1)/(x-1)^2)==1
eqn2 = subs(eqn2,x,0.7701+j*0.2780)
eqn1 = Kd/(Kp+Kd)==0.770149
sol =solve([eqn1, eqn2],[Kp Kd])
portSol = vpa(sol.Kp,10)
dervSol = vpa(sol.Kd,10)