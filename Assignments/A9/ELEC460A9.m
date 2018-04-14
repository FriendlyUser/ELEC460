A = [1 0; 1 1]
c = [ 1 1]
G = [0 1; -0.16 -1]
O = [c;
    c*G]
a = [1 0.16]
alpha = 0*eye(2)

ke = inv(O)*inv(A)*(-a)'