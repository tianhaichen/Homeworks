function ydot=solve_model(t,y)

massMtr=[1000 0 0 0 0 0 0;
         0 2300 0 0 0 0 0;
         0 0 5300 0 0 0 0;
         0 0 0 45 0 0 0;
         0 0 0 0 45 0 0;
         0 0 0 0 0 45 0;
         0 0 0 0 0 0 45;];

stiffnessMtr=[64000 0 0 -16000 -16000 -16000 -16000;...
              0 -64000 0 16000 16000 -16000 -16000;...
              0 0 -160000 -32000 32000 32000 -32000;...
              -16000 16000 -32000 176000 0 0 0; ...
              -16000 16000 32000 0 176000 0 0; ...             
              -16000 -16000 32000 0 0 176000 0;...
              -16000 -16000 -32000 0 0 0 176000; ...                                         
              ];
dampingMtr=[4000 0 0 -1000 -1000 -1000 -1000;...
              0 -4000 0 1000 1000 -1000 -1000;...
              0 0 -16000 -2000 2000 2000 -2000;...
              -1000 1000 -2000 1000 0 0 0; ...
              -1000 1000 2000 0 1000 0 0; ...                           
              -1000 -1000 2000 0 0 1000 0; ...                           
              -1000 -1000 -2000 0 0 0 1000; ...                                                 
              ];

%F=[10000*1*sin( 16.1933*t);0;0;0;10000*0.1*sin(49190*t)*(0);10000*(0);10000*(0)];
z=y(1:7);
z(4:7)=z(4:7); %fix tyres
zprime=y(8:14);
zprime(4:7)=zprime(4:7); %fix tyres

ydot(1:7,1)=zprime;
ydot(8:14)=inv(massMtr)*(-dampingMtr*zprime-stiffnessMtr*z+F);
%ydot(11:14)=0*ydot(11:14);

end