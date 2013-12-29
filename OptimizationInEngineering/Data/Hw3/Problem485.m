[x y]=meshgrid(-10:0.1:30,-20:0.1:30);
fxy=-pi*x.^2.*y;
g1=x-20;
g2=y-20;
g3=5-x;
g4=-x;
g5=2*pi*x.*y-900;
contourf(x,y,(g1),[0 0]);
hold on;

contourf(x,y,(g2),[0 0]);
contourf(x,y,(g3),[0 0]);
contourf(x,y,(g4),[0 0]);
contourf(x,y,(g5),[0 0]);
contour(x,y,fxy,50);


gradfxy=[-2*pi*20.*7.162 -2*pi*20.^2*7.162];
solpoint=[20,7.162];
endp1=solpoint+gradfxy*0.001
line([solpoint(1) endp1(1)],[solpoint(2) endp1(2)])
gradg1=[1 0];
endp2=solpoint+gradg1*5;
line([solpoint(1) endp2(1)],[solpoint(2) endp2(2)])
gradg5=[2*pi*7.162 2*pi*20];
endp3=solpoint+gradg5*0.1;
line([solpoint(1) endp3(1)],[solpoint(2) endp3(2)])