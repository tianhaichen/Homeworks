function [massMtr dampingMtr stiffnessMtr F Fr]=carmodel(width,length,height,mass,masst,damp,ksusp,kt)

syms z theta phi z_1 z_2 z_3 z_4

syms w l m m_u1 m_u2 m_u3 m_u4 k_1 k_2 k_3 k_4 k_t1 k_t2 k_t3 k_t4 b_1 b_2 b_3 b_4
syms Ixx Iyy

Ax=sym(zeros(3,3));Ax=[1 0 0 ; 0 cos(phi) -sin(phi);0 sin(phi) cos(phi)];
Ay=sym(zeros(3,3));Ay=[cos(theta) 0 sin(theta) ; 0 1 0;-sin(theta) 0 cos(theta)];

Ax =[1 0 0; 0 1 -phi; 0 phi 1];
Ay =[1 0 theta; 0 1 0;-theta 0 1];

A=[ 1,0, theta; 0, 1,  -phi;-theta,       phi,     1];


%Position of the mounting points of the suspension on the body wrt. fixed
%frame that initialy coincides with the body frame 

syms r_1 r_2 r_3 r_4 v_1 v_2 v_3 v_4
syms u_x u_y

r_1 =z*[0; 0 ;1]+A*[u_x; u_y; 0];
r_2 =z*[0; 0 ;1]+A*[-u_x; u_y; 0];
r_3 =z*[0; 0 ;1]+A*[-u_x; -u_y; 0];
r_4 =z*[0; 0 ;1]+A*[u_x; -u_y; 0];

%Displacement of the mounting points of the suspension on the body
syms u_1 u_2 u_3 u_4

u_1 =r_1 -[u_x ;u_y ;0];
u_2 =r_2 -[-u_x ;u_y ;0];
u_3 =r_3 -[-u_x ;-u_y ;0];
u_4 =r_4 -[u_x ;-u_y ;0];

%velocity of the mounting points
syms udot_1 udot_2 udot_3 udot_4 zdot thetadot phidot

Adot=[1 0 thetadot;0 1 -phidot;-thetadot phidot 1];
udot_1 =zdot*[0; 0; 1] +Adot*[u_x ;u_y ;0];
udot_2 =zdot*[0; 0 ;1] +Adot*[-u_x ;u_y ;0];
udot_3 =zdot*[0; 0; 1] +Adot*[-u_x ;-u_y ;0];
udot_4 =zdot*[0; 0; 1] +Adot*[u_x ;-u_y ;0];

%angular velocity of the body
syms alphalocal thetaddot phiddot
alphalocal=[phiddot;thetaddot;0];


%Forces on the body from spring and dashpot
syms u_t1 u_t2 u_t3 u_t4 udot_t1 udot_t2 udot_t3 udot_t4 zr_1 zr_2 zr_3 zr_4
syms k b;
k=k_1;
k_t=k_t1;
b=b_1;
F_1=[0;0;-k*(u_1(3)-u_t1)-b*(udot_1(3)-udot_t1)];
F_2=[0;0;-k*(u_2(3)-u_t2)-b*(udot_2(3)-udot_t2)];
F_3=[0;0;-k*(u_3(3)-u_t3)-b*(udot_3(3)-udot_t3)];
F_4=[0;0;-k*(u_4(3)-u_t4)-b*(udot_4(3)-udot_t4)];

%Moments on the body from spring and dashpot

M_1=transpose(A)*cross(r_1,F_1);M_1(3)=0;
M_2=transpose(A)*cross(r_2,F_2);M_2(3)=0;
M_3=transpose(A)*cross(r_3,F_3);M_3(3)=0;
M_4=transpose(A)*cross(r_4,F_4);M_4(3)=0;

%Total force and moment on the body
TotalMoment=M_1+M_2+M_3+M_4;
TotalMoment=TotalMoment(1:2);
TotalForce=F_1+F_2+F_3+F_4;
%All the forces of the system with respect to coordinates
Fr=sym([TotalForce(3);TotalMoment;-F_1(3)+k_t*zr_1; -F_2(3)+k_t*zr_2; -F_3(3)+k_t*zr_3; -F_4(3)+k_t*zr_4]);

massMtr=sym(eye(7));
massMtr(1,1)=m;
massMtr(2,2)=Ixx;
massMtr(3,3)=Iyy;
massMtr(4,4)=m_u1;
massMtr(5,5)=m_u2;
massMtr(6,6)=m_u3;
massMtr(7,7)=m_u4;

dampingMtr=sym(zeros(7,7));
dampingMtr(1,:)=[b_1+b_2+b_3+b_4 (l/2)*(-b_1 +b_2 +b_3 -b_4) (w/2)*(-b_1-b_2+b_3+b_4) -b_1 -b_2 -b_3 -b_4];
dampingMtr(2,:)=[(w/2)*(b_1+b_2-b_3-b_4) (w/2)*(l/2)*(-b_1 +b_2 -b_3 +b_4) (w/2)*(w/2)*(b_1+b_2+b_3+b_4) -(w/2)*b_1 -(w/2)*b_2 (w/2)*b_3 (w/2)*b_4];
dampingMtr(3,:)=[(l/2)*(-b_1+b_2+b_3-b_4) (l/2)*(l/2)*(b_1 +b_2 +b_3 +b_4) (l/2)*(w/2)*(-b_1+b_2-b_3+b_4) (l/2)*b_1 (l/2)*b_2 -(l/2)*b_3 -(l/2)*b_4];
dampingMtr(4,:)=[-b_1 (l/2)*b_1 -(w/2)*b_1 b_1 0 0 0];
dampingMtr(5,:)=[-b_2 -(l/2)*b_2 -(w/2)*b_2 0 b_2 0 0];
dampingMtr(6,:)=[-b_3 -(l/2)*b_3 (w/2)*b_3 0 0 b_3 0];
dampingMtr(7,:)=[-b_4 (l/2)*b_4 (w/2)*b_4 0 0 0 b_4];

stiffnessMtr=sym(zeros(7,7));
stiffnessMtr(1,:)=[k_1+k_2+k_3+k_4 (l/2)*(-k_1 +k_2 +k_3 -k_4) (w/2)*(k_1+k_2-k_3-k_4) -k_1 -k_2 -k_3 -k_4];
stiffnessMtr(2,:)=[(w/2)*(k_1+k_2-k_3-k_4) (w/2)*(l/2)*(-k_1 +k_2 -k_3 +k_4) (w/2)*(w/2)*(k_1+k_2+k_3+k_4) -(w/2)*k_1 -(w/2)*k_2 (w/2)*k_3 (w/2)*k_4];
stiffnessMtr(3,:)=[(l/2)*(-k_1+k_2+k_3-k_4) (l/2)*(l/2)*(k_1 +k_2 +k_3 +k_4) (l/2)*(w/2)*(-k_1+k_2-k_3+k_4) (l/2)*k_1 (l/2)*k_2 -(l/2)*k_3 -(l/2)*k_4];
stiffnessMtr(4,:)=[-k_1 (l/2)*k_1 -(w/2)*k_1 k_1+k_t1 0 0 0];
stiffnessMtr(5,:)=[-k_2 -(l/2)*k_2 -(w/2)*k_2 0 k_2+k_t2 0 0];
stiffnessMtr(6,:)=[-k_3 -(l/2)*k_3 (w/2)*k_3 0 0 k_3+k_t3 0];
stiffnessMtr(7,:)=[-k_4 (l/2)*k_4 (w/2)*k_4 0 0 0 k_4+k_t4];
F=0;
if(isempty(width)||isempty(length)||isempty(mass)||isempty(masst)||isempty(damp)||isempty(ksusp)||isempty(kt))
else
    w=width;
    l=length;
    
    u_x=length/2;
    u_y=width/2;
    
    rho=mass/(width*length*height);
    Ixx=rho*(2*width*height)*(2*length^3)/3;
    Iyy=rho*(2*length*height)*(2*width^3)/3;
    m=mass;
    
    m_u1=masst(1);
    m_u2=masst(1);
    m_u3=masst(1); 
    m_u4=masst(1);
        
    b_1=damp(1);
    b_2=damp(2);
    b_3=damp(3);
    b_4=damp(4);
    
    k_1=ksusp(1);
    k_2=ksusp(2);
    k_3=ksusp(3);
    k_4=ksusp(4);

    k_t1=kt(1);
    k_t2=kt(2);
    k_t3=kt(3);
    k_t4=kt(4);

    massMtr=eval(massMtr);
    dampingMtr=eval(dampingMtr);
    stiffnessMtr=eval(stiffnessMtr);
    Fr=eval(Fr);
end


end