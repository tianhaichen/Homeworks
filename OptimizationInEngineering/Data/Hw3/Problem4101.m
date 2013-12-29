[x1 x2]=meshgrid(-5:0.1:3,-4:0.1:4);
f=9*x1.^2+18*x1.*x2+13*x2.^2-4;
h=x1.^2+x2.^2+2*x1-16;
contour(x1,x2,f);
hold on
contour(x1,x2,h,[0 0]);
contour(x1,x2,f,[15.24 15.24]);