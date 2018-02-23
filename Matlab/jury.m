function [M, L] = jury(P,N)
% [M, L] = jury(P,N)
% This function gives the Jury's array from a numerical or SYMBOLIC polynomial and 
% includes the two special cases: (1) the first  element of the second row of a block is
% zero; (b) a row of zeros (when there are roots on unit circle or reciprocal roots like
% (r,1/r). The symbolic results can be used to solve inequalities and obtain the stability 
% intervals of symbolic vaiables.
%
% P     Numerical or symbolic array of coeficients. In the case of symbolic variables it is 
%        necesarry to define them in workspace as: >> syms a b c ...
% N     Digits to be considered zero a number. E.g, for N=5, 10^(-5) is considered a zero. 
%         By default, N=10
% M    Jury's array without any simplification (e.g., with epsilon notation)
% L      Simplified coefficients of first column and second row of each Jury's block (e.g., 
%         using the limit when epsilon tends to zero) that determines the place of roots: the 
%         number of roots outside the unit circle is equal to negative values in L
%
% Examples:
% 1. syms z; P1=(z-1)*(z-2)*(z-0.3)*(z^2+1); P=sym2poly(P1);  [M,L]=jury(P);
% 2. syms z; P1=(z-0.1)*(z-0.2)*(z-0.3)*(z^2+1); P=sym2poly(P1);  [M,L]=jury(P);
% 3. syms a b; P=[1 a b 0.1]; [M,L]=jury(P);
% 4. syms a; P=[1 a 1 0.1]; [M,L]=jury(P);
% 5. P=[1 2 -1 -1 2 1]; [M,L]=jury(P);
% 6. P=[ -1.21,   -0.063,  5.3, -0.063, -1.21]; [M,L]=jury(P);
% 7. syms z; P1=(z+1/2)*(z+2)*(z+0.5)*(z-0.8); P=sym2poly(P1);  [M,L]=jury(P);
% 8.  P=[0.1 -0.3 0.67 0.92 0.3 -0.1]; [M,L]=jury(P);
%
% Developed by Carlos M. Vlez S., cmvelez@eafit.edu.co
% http://sistemascontrol.wordpress.com/
% EAFIT University, http://www.eafit.edu.co
% Medelln, Antioquia, Colombia
% November 29th 2011

if nargin <2
    N=10;
end
P=P(1)/abs(P(1))*P;
P=sym(P);
n=length(P);
M=sym(zeros(2*n,n));
M(1,:)=P(n:-1:1);
M(2,:)=P(1:1:n);
syms epsilon
for i=1:n-1
    for j=1:n-i
        M(2*i+1,j)=det( [M(2*i-1,1) M(2*i-1,j+1);M(2*i,1) M(2*i,j+1)] )/(-M(2*i,1));
        M(2*i+2,n-i+1-j)=M(2*i+1,j);
    end
    if isempty(symvar(M(2*i+2,1))) == 1 % There is a special case only if the first element is not a variable
        if isempty(symvar(M(2*i+2,:))) == 1 % Special cases when all values are numbers
            if sum(abs(double(M(2*i+1,:)))) < 10^(-N) % Special case of a row of zeros
                disp(['Row of zeros: ' num2str(2*i+1) ',  ' num2str(2*i+2) '. Order of auxiliar polynomial: ' num2str(n-i) ]);
                for j=1:n-i
                    M(2*i+1,j)=M(2*i-1,j+1)*j; % Derivative of auxiliar polynomial
                    M(2*i+2,n-i+1-j)=M(2*i+1,j);
                end
                sig=M(2*i+1,n-i)/abs(M(2*i+1,n-i)); % Sign change of auxiliar polynomial
                M(2*i+1,:)=sig*M(2*i+1,:);
                M(2*i+2,:)=sig*M(2*i+2,:);
            elseif abs(double(M(2*i+2,1)))<10^(-N)  && sum(abs(double(M(2*i,2:n)))) > 10^(-N) % Special case when the first element of the row iz zero and the others are values
                M(2*i+2,1)=epsilon;
                M(2*i+1,n-i)=epsilon;
            end
        elseif abs(double(M(2*i+2,1)))<10^(-N) % Special case when the first element of the row iz zero and some other elements are variables
            M(2*i+2,1)=epsilon;
            M(2*i+1,n-i)=epsilon;
        end
    end
end
M=vpa(M);
M1=limit(M,epsilon,0,'right'); % RD_NINF = -inf, RD_INF = inf
M1=vpa(M1);
for i=1:n-1
    L(i,1)=M1(2*i+2,1);
end