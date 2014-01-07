function ydot=odefunc(t,y)
global i;
global tval;
kt=200000;
a=30/100;
b=5/100;
V=60000/3600;
halfperiod=a/V;
y1=0;
global y2val;
y2=b*sin(pi*t/halfperiod)*(t<halfperiod);
i=i+1;
y2val(i)=y2*kt;
tval(i)=t;
F1=[0; 0 ; y1*kt;y2*kt];
M=[420 0 0 0;0 820 0 0;0 0 53 0;0 0 0 53;];
K=[20000 -500 -10000 -10000;-500 35525 -7000 7500;-10000 -7000 210000 0;-10000 7500 0 210000;];
C=[400 -10 -200 -200;-10 210.5 -140 150;-200 -140 200 0;-200 150 0 200;];
disp=y(1:4);
vel=y(5:8);
ydot(1:4)=vel';
ydot(5:8)=(inv(M))*(-C*vel-K*disp+F1);
ydot=ydot';
end