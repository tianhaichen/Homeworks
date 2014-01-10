%% Defining boundary conditions
syms x L lambda A B C D;
syms rho Abar M E I;
X=A*cosh((lambda/L)*x)+B*sinh((lambda/L)*x)+C*cos((lambda/L)*x)+D*sin((lambda/L)*x);
syms xder
xder(1,:)=X;%Zero displacement at x=0
xder(2,:)=simplify(diff(X,x,1));%Zero slope at x=0
xder(3,:)=simplify(E*I*diff(X,x,3)-(M*lambda^4*(E*I)/(rho*Abar*L*L^4))*X);%Shear force equilibrium at x=L
xder(4,:)=simplify(diff(X,x,2));%Moment equilibrium at x=L

x=0;
xd=eval(xder);
xder(1:2,:)=xd(1:2);
x=L;
xd=eval(xder);
xder(3:4,:)=xd(3:4);

%% Describing problem specific variables
% 
L=1;
a=0.02;
b=0.01;
E=210e9;
rho=7800;
Abar=a*b;
M=2*Abar*L*rho;
I=a*b^3/12;
%% Finding Mode Shapes
xderval=eval(xder);
[mtr,b] = equationsToMatrix(xderval,[A B C D]);
U=[A; B ;C ;D];
detx=det(mtr);
shapefrequencies=[3.86148294520820 7.03164303944519 10.185020605487303 13.3327 16.477957140207227;]
emtr=eval(mtr);
newB=eval(b-emtr(:,3));
sol=inv(mtr([1 2 4],[1 2 4]))*newB([1 2 4]);

lambda=shapefrequencies(1);
sol(:,1)=eval(sol);
%one relative ratios is sufficient
% lambda=shapefrequencies(2);
% sol(:,2)=eval(sol);
% lambda=shapefrequencies(3);
% sol(:,3)=eval(sol);
% lambda=shapefrequencies(4);
% sol(:,4)=eval(sol);
consts=[sol(1),sol(2),1,sol(3)];
consts=consts;

syms D;
A=C*consts(1);
B=C*consts(2);
D=C*consts(4);

%% Plotting the results
for i=1:5
syms x;
Xeval=eval(X);
lambda=shapefrequencies(i);
C=consts(3);
Xeval=eval(Xeval);
ezplot(Xeval,[0 1]);
hold on;
end
