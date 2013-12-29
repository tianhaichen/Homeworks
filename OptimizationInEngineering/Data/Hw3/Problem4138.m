syms x_1 x_2 lambda

f=5*x_1-1/16*(x_1)^2*(x_2)^2+2*(x_2)^2+5*(x_1)^2+3*(x_2);;
h=hessian(f);
sol=solve(det(h-lambda*eye(2,2)),lambda)