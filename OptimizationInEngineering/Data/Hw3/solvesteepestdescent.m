function x=solvesteepestdescent(x0,gradientfunc,tol)

x=x0;
upsilon=1e99;
alphau=-100;
alphal=100;
while(1)
       c=gradientfunc(x0);
       upsilon=norm(c);
       if(upsilon<tol)
           break;
       end
       
       
       
end

end