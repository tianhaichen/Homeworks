syms omega
global stiffnessMtr massMtr dampingMtr
a=stiffnessMtr%+i*dampingMtr
dynstiff=a-omega^2*massMtr;
z=inv(a-omega^2*massMtr);
mobility=-j*omega*z;
akselerans=-omega*omega*z;

omega=0:0.001:70;
for i=1:7
    for j=1:7
        if(i~=j)
        zval=eval(z(i,i));
        if(length(zval)==1)
            zval=zval*eye(1,length(omega)) ;
            plot((omega),20*log10(abs(zval)));
       else
           plot((omega),20*log10(abs(zval)));
    %       text(2500+100*i,-20*log10(abs(zval(round(length(zval)/2)))),strcat('\bf z(',num2str(i),',',num2str(j),')'),'Fontsize',10);
       end
       hold on
    xlabel('frekans[rad/s]')
    ylabel('|\alpha(\omega)| [dB]')
        end
    end
end
% figure();
% for i=1:7
%     for j=1:7
%         dynstiffval=eval(dynstiff(i,j));
%         if(length(dynstiffval)==1)
%            dynstiffval=dynstiffval*eye(1,length(omega)) ;
%            plot(omega,((dynstiffval)));
%         else
%           plot(omega,((dynstiffval)));
%           text(50+5*i,(dynstiffval(round(length(dynstiffval)/2)))-j,strcat('\bf z(',num2str(i),',',num2str(j),')'),'Fontsize',10);
%         end
%         hold on
%     end
% end

