syms x1 x2 alpha d1 d2
f=x1^2+2*x2^2-4*x1-2*x1*x2;
x1=x1+alpha*d1;x2=x2+alpha*d2;
fd=eval(f);
x1=x1-alpha*d1;x2=x2-alpha*d2;


A=eye(2,2);

g=gradient(f);
h=hessian(f);
%step1
x1=1;x2=1;
geval1=eval(g);
deltax=-inv(A)*geval1;

d1=-deltax(1);
d2=-deltax(2);
fd1=eval(fd);
%format short;
%digits(1);
%vpa(fd1);
sol=solve(diff(fd1),alpha);
x1=x1+sol*d1;x2=x2+sol*d2;
svec=sol*[d1 ;d2];
geval2=eval(g);
yvec=geval2-geval1;
z=A*yvec;
B=(svec*svec')/(dot(svec,yvec));
C=(-z*z')/(dot(yvec,z));
A=A+B+C;

%step 2
geval1=eval(g);
deltax=-inv(A)*geval1;

d1=-deltax(1);
d2=-deltax(2);
fd1=eval(fd);
%format short;
%digits(1);
%vpa(fd1);
sol=solve(diff(fd1),alpha);
x1=x1+sol*d1;x2=x2+sol*d2;
svec=sol*[d1 ;d2];
geval2=eval(g);
yvec=geval2-geval1;
z=A*yvec;
B=(svec*svec')/(dot(svec,yvec));
C=(-z*z')/(dot(yvec,z));
A=A+B+C;
