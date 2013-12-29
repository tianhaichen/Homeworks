syms x1 x2 alpha d1 d2
f=9*x1^2+9*x2^2-100*sqrt(x1^2+x2^2-20*x2+100)+80*sqrt(x1^2+x2^2+20*x2+100)-5*x1-41*x2;
x1=x1+alpha*d1;x2=x2+alpha*d2;
fd=eval(f);
x1=x1-alpha*d1;x2=x2-alpha*d2;



g=gradient(f);

%step1
x1=5;x2=2;
geval=eval(g);
d1=-geval(1);
d2=-geval(2);
fd1=eval(fd);
%format short;
%digits(1);
%vpa(fd1);
sol=solve(diff(fd1),alpha);

%step2
x1=x1+sol*d1;x2=x2+sol*d2;
geval=eval(g);
d1=-geval(1);
d2=-geval(2);
fd1=eval(fd);
format short;

sol=solve(diff(fd1),alpha);
x1=x1+sol*d1;x2=x2+sol*d2;
