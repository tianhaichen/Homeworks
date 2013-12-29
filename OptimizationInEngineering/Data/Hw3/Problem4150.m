syms P_u P_v P theta x_1 x_2
f=2*sqrt(2)*x_1+x_2;
syms g_1 g_2 g_3
P_u=P*cos(theta);P_v=P*sin(theta);
g_1=1/sqrt(2)*(P_u/x_1+P_v/(x_1+sqrt(2)*x_2))-20000;
g_2=(sqrt(2)*P_v)/(x_1+sqrt(2)*x_2)-20000;
g_3=-x_1;
g_4=-x_2;

hf=hessian(f  ,[x_1 x_2]);hf= simplify(hf);
h1=hessian(g_1,[x_1 x_2]); h1=simplify(h1);
h2=hessian(g_2,[x_1 x_2]);h2= simplify(h2);
h3=hessian(g_3,[x_1 x_2]); h3=simplify(h3);
h4=hessian(g_4,[x_1 x_2]);h4= simplify(h4);

eig1=eig(h1);
eig2=eig(h2);
eig3=eig(h3);
eig4=eig(h4);
P=10;
theta=pi/3;
h1=eval(h1);
h2=eval(h2);
h3=eval(h3);
h4=eval(h4);