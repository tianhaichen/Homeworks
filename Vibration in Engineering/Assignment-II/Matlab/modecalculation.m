syms lambda

M=[420 0 0 0;0 820 0 0;0 0 53 0;0 0 0 53;];
K=[20000 -500 -10000 -10000;-500 35525 -7000 7500;-10000 -7000 210000 0;-10000 7500 0 210000;];
C=[400 -10 -200 -200;-10 210.500000000000 -140 150;-200 -140 200 0;-200 150 0 200;];
eq=det(lambda^2*M-K);
solution=sortrows(solve(eq),-1);
solution=solution(1:4);
syms u_1 u_2 u_3 u_4 ;
eqns=(lambda^2*M-K)*([u_1;u_2;u_3;u_4]);


for i=1:4
u_1=1;lambda=solution(i);
sols=(solve(eval(eqns(2:4))));
uvec(i,:)=[1;sols.u_2;sols.u_3;sols.u_4];
uvec(i,:)=uvec(i,:)/norm(uvec(i,:));
end


subplot(2,2,1);
plot([1 2 3 4],uvec(:,1));
subplot(2,2,2);
plot([1 2 3 4],uvec(:,2));
subplot(2,2,3);
plot([1 2 3 4],uvec(:,3));
subplot(2,2,4);
plot([1 2 3 4],uvec(:,4));





