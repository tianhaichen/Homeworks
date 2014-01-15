syms E I rho A lambda L M omega m x;

a=0.01;
b=0.02;
E=210e9;
I=b*a^3/12;
A=a*b;
m=rho*A*L;
rho=7800;
M=0;
L=1;
omega=sqrt(lambda^4*E*I/(rho*A));
detlambda=E*I*lambda^3*((sinh(lambda*L)-sin(lambda*L))-((cosh(lambda*L)+cos(lambda*L))/((sinh(lambda*L)+sin(lambda*L))))*(cosh(lambda*L)+cos(lambda*L)))-...
    M*omega^2*((cosh(lambda*L)-cos(lambda*L))-((cosh(lambda*L)+cos(lambda*L))/((sinh(lambda*L)+sin(lambda*L))))*(sinh(lambda*L)-sin(lambda*L)));

U=cosh(lambda*x)-((cosh(lambda*L)+cos(lambda*L))/((sinh(lambda*L)+sin(lambda*L))))*sinh(lambda*x)-...
    cos(lambda*x)+((cosh(lambda*L)+cos(lambda*L))/((sinh(lambda*L)+sin(lambda*L))))*sin(lambda*x);

f=@(lambda) -350*lambda^3*(sin(lambda) - sinh(lambda) + (cos(lambda) + cosh(lambda))^2/(sin(lambda) + sinh(lambda)));









j=3;

freq=zeros(1,1);
freq(1)=fzero(f,3);
lambda=freq(1);
%ezplot(eval(U),[0 1]);
%hold on;
for i=2:36;
    syms lambda;
    for k=1:100
    rootj=fzero(f,j);
    if(abs((freq(i-1)-rootj))>1e-3)
    freq(i)=rootj;
    lambda=rootj;
    intuu=int(eval(U)*eval(U));
    x=0;
    a=eval(intuu);
    x=L;
    b=eval(intuu);
    
    l=sqrt(b-a);
    syms x;
  %  ezplot(eval(U)/l,[0 1]);
    break;
    end
    j=j+1;
    end
     hold on
end
syms f_0 x L t T tau lambda;
force=f_0*dirac(x-L)*dirac(t);

x=L;
L=1;
sum=0;
syms T;
time=5;
f_0=10;

syms x lambda;
modalmasseq=int(U*U*rho*A,x);
omegasquare=int(U*diff(U,4)*E*I,x);



for i=1:length(freq)
    syms x;
    x=L;
    UL=eval(U);
    lambda=freq(i);
    Fr=UL*f_0;
    mass_modal=eval(modalmasseq);
    omega_modal=sqrt(eval(omegasquare)/mass_modal);
    Fr_modal=(Fr/mass_modal);
    
    syms x;
    ev=eval((Fr_modal/omega_modal)*sin(omega_modal*time)*U);
    sum=sum+ev;

end
figure(1);

ezplot(sum,[0 1]);
    hold on;












