%% ELEC 460 Control Systems II
% Note that all questions are taken from Title : Discrete Time Control Systems, 
% 2nd Edition Author : K. Ogata Publisher : Prentice-Hall Year : 1995
%% Problem 2-7

syms z t
func = 1/3*(t-2)*(heaviside(t-2)-heaviside(t-5))+heaviside(t-5)
functest = 1/3*((t-2)*heaviside(t-2)-(t-5)*heaviside(t-5))
zfunc = ztrans(func,z)
zfunc2 = ztrans(functest,z)
zFunction=simplify(zfunc2)
%% Problem 2-12

func2 = z^{-3}/((1-z^{-1})*(1-0.2*z^{-1}))
func2pf = partfrac(func2)

%% Problem 2-17

func3 = heaviside(t)
ztrans(func3)
simplifed = partfrac(z^2/((z-1)*(z-0.5)^2))
timexk = iztrans(simplifed)
% check
4*z*(z-0.5)^2-3*z*(z-0.5)*(z-1)-0.5*z*(z-1)
% solve system of equations
A = [1 1 1; ...
    -1 -1.5 1; ....
    0.25 0.5 -1]
b = [1; ...
     0; ....
     0; ...
     ]
 X = linsolve(A,b) % note that I probably messed that 
 % up, need half that value
 %% Include in Assignment
 numerator = [1 0 0]; % z^3
 denomiator = [1 -1 0.25];
 u = ones(1,51);
 k = 0:50;
 xk = filter(numerator,denomiator,u)
 plot(k,xk,'-ro');grid;
 v = [0 50 0 5]; axis(v);
 xlabel('k');ylabel('x(k)')
 title('Unit-Step Response');
 print('B-2-17-matlab.png','-dpng','-r300')
