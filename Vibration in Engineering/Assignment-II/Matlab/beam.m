syms E I rho A lambda L M omega m x;

a=0.01;
b=0.02;
E=210e9;
I=b*a^3/12;
A=a*b;
m=rho*A*L;
rho=7800;
M=2*m;
L=1;
omega=sqrt(lambda^4*E*I/(rho*A));
detlambda=E*I*((sinh(lambda*L)-sin(lambda*L))-((cosh(lambda*L)+cos(lambda*L))/((sinh(lambda*L)+sin(lambda*L))))*(cosh(lambda*L)+cos(lambda*L)))-...
    M*omega^2*((cosh(lambda*L)-cos(lambda*L))-((cosh(lambda*L)+cos(lambda*L))/((sinh(lambda*L)+sin(lambda*L))))*(sinh(lambda*L)-sin(lambda*L)));

U=cosh(lambda*x)-((cosh(lambda*L)+cos(lambda*L))/((sinh(lambda*L)+sin(lambda*L))))*sinh(lambda*x)-...
    cos(lambda*x)+((cosh(lambda*L)+cos(lambda*L))/((sinh(lambda*L)+sin(lambda*L))))*sin(lambda*x);

f=@(lambda) 350*sinh(lambda) - 350*sin(lambda) - (350*(cos(lambda) + cosh(lambda))^2)/(sin(lambda) + sinh(lambda)) - (6157265115545601*lambda^4*(cosh(lambda) - cos(lambda) + ((sin(lambda) - sinh(lambda))*(cos(lambda) + cosh(lambda)))/(sin(lambda) + sinh(lambda))))/8796093022208;

j=3;

freq=zeros(2,1);
freq(1)=fzero(f,3);
lambda=freq(1);
ezplot(eval(U),[0 1]);
hold on;
for i=2:5;
    syms lambda;
    for k=1:100
    rootj=fzero(f,j);
    if(abs((freq(i-1)-rootj))>1e-3)
    freq(i)=rootj;
    lambda=rootj;
    ezplot(eval(U),[0 1]);
    break;
    end
    j=j+1;
    end
    
end





