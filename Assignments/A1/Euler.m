function [t,v] = Euler(m,k,g,t0,v0,tn,n)
h=(tn-t0)/n;
t = zeros(1,n+1);
v = zeros(1,n+1);

t(1) = t0;
v(1) = v0;

for i=1:n
    v(i+1) = v(i)+(g-k/m*v(i)*v(i))*h;
    t(i+1) = t(i)+h;
end