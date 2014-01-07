


t=0;
time=0;
tend=0;
for j=1:1000000
   tic;
   time=time+tend;
      clf;
      subplot(2,2,1);
      
   plot([1 2 3 4],uvec(1,:)*sin(6.5173*2*pi*time/10));
   
   xlim([1 4]);
   ylim([-1 1]);     
   subplot(2,2,2);
   plot([1 2 3 4],uvec(2,:)*sin(6.7495*2*pi*time/10));
   
   xlim([1 4]);
   ylim([-1 1]);     
   subplot(2,2,3);
   plot([1 2 3 4],uvec(3,:)*sin(62.9514*2*pi*time/10));
   
   xlim([1 4]);
   ylim([-1 1]);     
   subplot(2,2,4);
        
   plot([1 2 3 4],uvec(4,:)*sin( 62.9647*2*pi*time/10));
   xlim([1 4]);
   ylim([-1 1]);
   hold on;
   pause(1/30);
   
   tend=toc;
    
end